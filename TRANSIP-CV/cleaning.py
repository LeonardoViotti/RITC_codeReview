#-------------------------------------------------------------------------------------
# Clean tabular data for tracked objects from video footage
#-------------------------------------------------------------------------------------

EXPORT = False


from fileinput import filename
import numpy as np
import pandas as pd
import os
import copy as cp
from tqdm import tqdm
tqdm.pandas()

import seaborn as sns
import matplotlib.pyplot as plt
import plotly.express as px

#-------------------------------------------------------------------------------------
# Create intermediary columns used for calculations

def create_vars(df):
    # # Calculate centroids
    # df['cx'] =  round(df['xi'] + (df['xj'] - df['xi'])/2).astype(int)
    # df['cy'] =  round(df['yi'] + (df['yj'] - df['yi'])/2).astype(int)
    
    # Lag points 
    df = df.sort_values(['obj_id', 'frame'])
    
    df['cx_l'] = df.groupby(['obj_id'])['cx'].shift(1)
    df['cy_l'] = df.groupby(['obj_id'])['cy'].shift(1)
    
    df['cx_f'] = df.groupby(['obj_id'])['cx'].shift(-1)
    df['cy_f'] = df.groupby(['obj_id'])['cy'].shift(-1)
    
    # Lag points to calculate angle
    
    df['cx_l5'] = df.groupby(['obj_id'])['cx'].shift(5)
    df['cy_l5'] = df.groupby(['obj_id'])['cy'].shift(5)
    
    df['cx_f5'] = df.groupby(['obj_id'])['cx'].shift(-5)
    df['cy_f5'] = df.groupby(['obj_id'])['cy'].shift(-5)
    
    # Test if there is movement between 3 points
    # df['stopepd'] = (df['cx'] == df['cx_l5']) & (df['cy'] == df['cy_l5']) | (df['cx_l5'] == df['cx_f5']) & (df['cy_l5'] == df['cy_f5'])
    # df['stopepd'] = df['stopepd'].astype(int)
    
    # Lag frame to test if lost tracking for long
    df['last_frame'] = df.groupby(['obj_id'])['frame'].shift(1)
    df['frame_diff'] = df['last_frame'] - df['frame']
    
   # Get pixel distance from last frame
    
    df['dist_l'] = np.sqrt((df.cx - df.cx_l) ** 2 + (df.cy - df.cy_l) ** 2).round()
    
    # Pixel distance to next frame
    df['dist_f'] = np.sqrt((df.cx - df.cx_f) ** 2 + (df.cy - df.cy_f) ** 2).round()
    
    return df

#-------------------------------------------------------------------------------------
# Trajectories splitting to solve obvious tracking issues.

"""
Split trajectories with sharp angles. This is useful to clean out problems with the
tracking algorithm when tracking jumps from one object to the other.

For example, if tracking jumps from one car going north to another going south

"""


def get_angle(df,
              p2_cols=['cx', 'cy'],
              p1_cols=['cx_l5', 'cy_l5'],
              p3_cols=['cx_f5', 'cy_f5']):
    """
    Calculate angle between 3 points vectorially.
    
    Formula source: 
    https://manivannan-ai.medium.com/find-the-angle-between-three-points-from-2d-using-python-348c513e2cd
    """
    
    # Get point columns in array format
    a = df[p1_cols].to_numpy()
    b = df[p2_cols].to_numpy()
    c = df[p3_cols].to_numpy()
    
    # Differences
    ba = a - b
    bc = c - b
    
    # Row-wise dot multiplication
    # https://stackoverflow.com/questions/15616742/vectorized-way-of-calculating-row-wise-dot-product-two-matrices-with-scipy
    row_wise_dot = np.sum(ba*bc, axis=1)
    
    # Row-wise L2 norm
    # https://stackoverflow.com/questions/7741878/how-to-apply-numpy-linalg-norm-to-each-row-of-a-matrix
    norm_ba = np.sum(np.abs(ba)**2,axis=-1)**(1./2)
    norm_bc = np.sum(np.abs(bc)**2,axis=-1)**(1./2)
    
    # Consine calc
    cosine_angle = row_wise_dot /(norm_ba * norm_bc)
    
    # Get angle from arc cosine
    angle = np.arccos(cosine_angle)
    
    # Convert to degrees 
    angle_degrees = np.degrees(angle)
    
    return angle_degrees

#------------------------------------------------------------------------------------
# Test splitting criteria


def split_trajectories(df, angle = 60, dist_lag = 5):
    """
    angle: Minimum angle in degrees in trajectories to not be split
    dist_lag: Maximum pixel distance from last frame to not split trajectories if angle smaller than angle param
    """
    
    df['cut'] = ((df['angle'] < angle) & ((df['dist_l'] > dist_lag) | (df['dist_f'] > dist_lag)))
    
    df['cut_group'] = df.groupby('obj_id')['cut'].transform(pd.Series.cumsum)
    
    df['obj_id_new'] = 's' + df['obj_id'].astype(str) + df['cut_group'].astype(str)
    
    return df



#------------------------------------------------------------------------------------
# Other filters

# Trjectories that are too small

def filter_trajectories(df, min_length = 200):
    df['trj_size'] = df.groupby('obj_id_new')['obj_id_new'].transform(len)
    df = df[df['trj_size'] > min_length] 
    return df

# df.groupby('obj_id').size().describe()






#------------------------------------------------------------------------------------
# Explore trajectories to split

# Plot a specific or random trajectory for quality assurance 

# A few reference ids: 16, 197, 53 and 4

def plot_trajectory_points(df, obj_id_new = None):
    
    if obj_id_new is None:
        ids = df['obj_id_new'].unique()
        obj_id_new = np.random.choice(ids, 1).item()
    
    plot_df = df[df['obj_id_new'] == obj_id_new]
    
    fig = px.scatter(plot_df, x="cx", y="cy", 
                #  text="frame", 
                # color='cut',
                color='obj_id_new',
                log_x=True, 
                size_max=60,
                hover_data=['frame', 'class', 'angle', 'dist_l', 'dist_f', 'frame_diff', 'cut'])
    fig.show()


# ------------------------------------------------------------------------------------
# Interpolation DRAFT

def interpolate_trajectories(df):
    # Complete frames rows based on min and max of each obj_id. This is needed because 
    dfn = df\
        .groupby('obj_id_new')\
        .apply(lambda x: x.set_index('frame').reindex(np.arange(x['frame'].min(), x['frame'].max() + 1)))\
        .drop(columns='obj_id_new').reset_index()
    
    
    def interpolate(cols, df = dfn):
        df[cols] = df.groupby('obj_id_new')[cols].progress_apply(lambda group: group.interpolate(method='index'))

        # treat first and last values (if they're NA of each group)
        df[cols] = df.groupby('obj_id_new')[cols].progress_apply(lambda group: group.loc[:, cols].ffill().bfill())

        return df[cols].round().astype(int)

    # Linear interpolation of centroid values
    print('Interpolating centroids')
    dfn[['cx', 'cy']] = interpolate(['cx', 'cy'])

    # # Linear interpolation of bounding boxes
    print('Interpolating bounding boxes')
    dfn[['xi', 'yi']] = interpolate(['xi', 'yi'])
    dfn[['xj', 'yj']] = interpolate(['xj', 'yj'])

    # Interpolating other columns
    print('Interpolating obj_id, class, cx_l, cy_l, cx_f, cy_f, cx_l5, cy_l5, '
          'cx_f5, cy_f5, last_frame, frame_diff, dist_l, dist_f, angle, cut_group, trj_size')

    vars_to_interpolate = ['obj_id', 'class', 'cx_l', 'cy_l', 'cx_f', 'cy_f', 'cx_l5', 'cy_l5',
                           'cx_f5', 'cy_f5', 'last_frame', 'frame_diff', 'dist_l', 'dist_f',
                           'angle', 'cut_group', 'trj_size']

    dfn[vars_to_interpolate] = interpolate(vars_to_interpolate)

    return dfn

#------------------------------------------------------------------------------------
# Export data

# Export temp df with split trajectories for troubleshooting

def export_data(df, file_name):
    columns = ['frame', 'xi', 'yi', 'xj', 'yj', 'obj_id', 'class', 'cx', 'cy']
    df_export = df.copy()
    df_export['obj_id'] = df_export['obj_id_new']
    df_export = df_export[columns]
    df_export.to_csv(file_name, index = False)

#------------------------------------------------------------------------------------
# Cleaning pipeline


def clean_data(df):
    print('Running cleaning functions.')

    print('Create additional variables')
    df = create_vars(df)

    print('Splitting trajectories to address tracking errors...')
    df['angle'] = get_angle(df).round()
    df = split_trajectories(df)
    
    df = filter_trajectories(df)
    
    print('Interpolation of missing frames')
    df = interpolate_trajectories(df)

    return df


if __name__ == "__main__":
    df = pd.read_csv('../data/2-sample-30min.csv')
    
    # Calculate centroids
    df['cx'] =  round(df['xi'] + (df['xj'] - df['xi'])/2).astype(int)
    df['cy'] =  round(df['yi'] + (df['yj'] - df['yi'])/2).astype(int)
    
    
    df = clean_data(df)
    
    
    plot_trajectory_points(df)
    
    if EXPORT:
        export_data(df, 'data/2-sample-30min-CLEAN.csv')


