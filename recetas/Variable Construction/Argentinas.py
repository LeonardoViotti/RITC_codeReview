#!/usr/bin/env python
# coding: utf-8

# #### Variable constructions of Argentinas

# In[1]:


# import packages
get_ipython().run_line_magic('matplotlib', 'inline')
import ast
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import re
from deep_translator import GoogleTranslator
from fuzzywuzzy import fuzz
from fuzzywuzzy import process

from nltk import word_tokenize,Text,pos_tag 
import nltk
nltk.download('punkt')
nltk.download('averaged_perceptron_tagger')

from word2number import w2n


# In[3]:


# import dataset
Argentinas = pd.read_csv("/Users/xixi/Dropbox/food4thought/data/intermediate/Argentinas.csv")
Argentinas.drop(['Unnamed: 0'],axis=1,inplace=True)

Argentinas.head()


# In[4]:


Argentinas.shape


# ##### Drop recipes with missing values in ingredients or instructions

# In[5]:


# convert string repretention of list to a list
Argentinas['List of ingredients'] = Argentinas['List of ingredients'].apply(lambda x:ast.literal_eval(x))
Argentinas['List of instructions'] = Argentinas['List of instructions'].apply(lambda x:ast.literal_eval(x))

# drop thoes with missing values
Argentinas = Argentinas[Argentinas['List of ingredients'].map(lambda d: len(d)) > 0]
Argentinas = Argentinas[Argentinas['List of instructions'].map(lambda d: len(d)) > 0]
Argentinas.shape


# #### Total time

# In[4]:


# convert total time to number of mins
print(set(Argentinas['Total time']))

Argentinas['Total time'].replace({'+2 horas': 180,'1 hora': 60, '15 minutos': 15, '2 horas': 120, '30 minutos': 30},inplace=True)
Argentinas.head()


# #### Number of spices

# In[6]:


# translate ingredients to English
def transIngredient(content):
    """
    input: ingredient list of one recipe
    output: ingredient list of one recipe in English
    
    """
    
    ingredientEng = [GoogleTranslator(source='auto', target='english').translate(i) for i in content]
    return ingredientEng

Argentinas['List of ingredients_Eng'] = Argentinas['List of ingredients'].apply(lambda x:transIngredient(x))
Argentinas.head()


# In[41]:


# count the number of spices

# create a list to store all spice

# import spice data
spiceData = pd.ExcelFile("/Users/xixi/Dropbox/food4thought/data/intermediate/roster_spices_edited.xlsx")
spice = pd.read_excel(spiceData,'Spices')
mixes = pd.read_excel(spiceData,'Mixes')

# drop first row as it's empty
spice = spice.iloc[1:,:]
spice.head()

# add spice to list
spiceLst = []
for i in range(1,len(spice)+1):
    spiceLst.append(spice.loc[i,"Spice"])
    
# add mixes to list
for i in range(len(mixes)):
    spiceLst.append(mixes.loc[i,"Name"])
    
# converts all uppercase characters to lowercase characters
spiceLstLower = []
for i in spiceLst:
    spiceLstLower.append(i.lower())


# In[42]:


Argentinas['List of ingredients_Eng'] = Argentinas['List of ingredients_Eng'].apply(lambda x:ast.literal_eval(x))


# In[43]:


# count the number of spices
# algorithm: fuzzy match
def calFuzzScores(ingredient):
    """
    ingredient: one ingredient in English
    output: a list of fuzz scores for the ingredient, [a,b],
    where a is the fuzz scores for the full ingredient, b is the highest fuzz scores for splited ingredients
    
    """
    # initialize the output list
    fuzzScore = []
    
    # Step 1: compute partio ratio for the full ingredient
    fullScore = []
    for ele in spiceLstLower:
        fullScore.append(fuzz.partial_ratio(ingredient.lower(),ele))
    
    fuzzScore.append(max(fullScore))
    
    # exclude salt
    if "salt" == ingredient.lower() or "water" == ingredient.lower() or "lemon" == ingredient.lower():
        fuzzScore[0] = 0

    # Step 2: split ingredients into different parts, compute ratio for each part and return the highest one
    splitScore = []
    for i in ingredient.split(" "):
        tempScore = []
        for ele in spiceLstLower:
            tempScore.append(fuzz.ratio(i.lower(),ele))
        
        splitScore.append(max(tempScore))
        
    fuzzScore.append(max(splitScore))
    
    return fuzzScore   

def calNumSpices(content):
    """
    content: list of ingredients in English
    output: the number of spices
    
    """
        
    spiceDic = {}
    for i in content:
        # count the ingredient as spices if FuzzScore is larger than 90
        if calFuzzScores(i)[0]  >= 90 or calFuzzScores(i)[1] >= 90:
            spiceDic[i] = calFuzzScores(i) 
            
    # remove duplicated spices
    keyLst = []
    for key in spiceDic:
        keyLst.append(key)
    
    compareLst = keyLst

    for i in keyLst:
        count = 0
        for j in compareLst:
            if fuzz.partial_ratio(i.lower(),j.lower()) >= 90:
                count += 1
        if count > 1:
            compareLst.remove(i)
            del spiceDic[i]     
    
    return len(spiceDic)  


# In[44]:


# count the number of spices
Argentinas['Number of spices'] = Argentinas['List of ingredients_Eng'].apply(lambda x: calNumSpices(x))
Argentinas.head()                                                          


# #### Number of ingredients

# In[6]:


def getCoreIngredient(Ingredient):
    """
    input: ingredients string
    output: core ingredients string
    
    """
    # if "," is in the ingredient, split and keep the first part
    if "," in Ingredient:
        Ingredient = Ingredient.split(",")[0]
        
    # split the string to text parts
    textLst = re.findall(r'([a-zA-Z]+)',Ingredient)

    # get the text part
    text = ""
    for i in textLst:
        text += i
        text += " "
    
    text = text[:-1]
    
    # split the string by "kg"
    if "kg " in text:
        text = text.split("kg ")[1]
        
    if "gr " in text:
        text = text.split("gr ")[1]

    # if “of” is in the ingredient, split the ingredient by “of” and keep the second part
    if "of " in text:
        text = text.split("of ")[1]
        

    # Apply natural language processing, keep the part that is noun
    coreIngredient = text
    
    tokens = word_tokenize(text) 
    tags = pos_tag(Text(tokens))

    for pairs in tags:
        if pairs[1] == "NN":
            coreIngredient = pairs[0]
    
    
            
    return coreIngredient

def calNumIngredients(IngredientLst):
    """
    input: ingredient list in English
    output: the number of ingredients removing duplicates
    
    """
    coreLst = [getCoreIngredient(i) for i in IngredientLst]
    
    # remove duplicated ingredients
    compareLst = []
    compareLst.extend(coreLst)
    
    for i in coreLst:
        count = 0
        for j in compareLst:
            if fuzz.ratio(i.lower(),j.lower()) >= 90:
                count += 1
        if count > 1:
            compareLst.remove(i)
            
        
    return len(compareLst)
        


# In[13]:


# count the number of ingredients
Argentinas['Number of ingredients'] = Argentinas['List of ingredients_Eng'].apply(lambda x: calNumIngredients(x))

Argentinas.head()


# #### Active cooking time

# In[7]:


def fractionToFloat(fraction):

    """
    input: fraction in string
    output: float
    
    """
    num = 0
    mult = 1

    if fraction[:1] == "-":
        fraction = fraction[1:]     
        mult = -1

    if " " in fraction:
        a = fraction.split(" ")
        num = float(a[0])
        toSplit = a[1]
    else:
        toSplit = fraction

    frac = toSplit.split("/")
    num += float(frac[0]) / float(frac[1])

    return num * mult


# In[50]:


def extractTime(instruction):
    """
    input: instruction with minutes/hours in English
    output: the number of minutes before the time
    
    """
    
    # convert all uppercase characters to lowercase characters
    instructionLow = instruction.lower()
    
    # remove punctuations in the sentence
    ## replace "-" with to
    instructionLow = instructionLow.replace("-", " to ")
    
    ## define punctuations
    punctuations = '''!()-[]{};:'"\,<>.?@#$%^&*_~'''
    
    ## remove punctuation from the instruction
    instructionNoPunct = ""
    for char in instructionLow:
        if char not in punctuations:
            instructionNoPunct += char
            
    # split instructions to words list
    splitInstruction = instructionNoPunct.split()
    
    # extract number of minutes before minutes/hours
    inactiveMin = np.nan
    
    if "minutes" in instructionNoPunct:
        index = splitInstruction.index("minutes") - 1
        
        # numbers before minutes directly
        if splitInstruction[index].isdigit():
            inactiveMin = float(splitInstruction[index])
        
        # numbers in words
        else:
            try: 
                inactiveMin = w2n.word_to_num(splitInstruction[index])
            except:
                inactiveMin = np.nan
            
    elif "minute" in instructionNoPunct:
        index = splitInstruction.index("minute") - 1
        
        # numbers before minutes directly
        if splitInstruction[index].isdigit():
            inactiveMin = float(splitInstruction[index])
            
        # numbers in words
        else:
            try: 
                inactiveMin = w2n.word_to_num(splitInstruction[index])
            except:
                inactiveMin = np.nan
        
    elif "hours" in instructionNoPunct:
        index = splitInstruction.index("hours") - 1
        
        # numbers before hours directly
        if splitInstruction[index].isdigit():
            inactiveMin = float(splitInstruction[index])*60
                
         # numbers in words
        else:
            try: 
                inactiveMin = w2n.word_to_num(splitInstruction[index])
            except:
                # numbers in fraction
                try: 
                    inactiveMin = fractionToFloat(splitInstruction[index])* 60
                except:
                    inactiveMin = np.nan
    
    elif "hour" in instructionNoPunct:
        index = splitInstruction.index("hour") - 1
        
        # numbers before hours directly
        if splitInstruction[index].isdigit():
            inactiveMin = float(splitInstruction[index])*60
            
        # words directly, like an, another, one, half an hour
        elif splitInstruction[index-1] in ["half"]:
                inactiveMin = 30
                
        elif splitInstruction[index] in ["an","another","one"] and splitInstruction[index-1] not in ["half"]:
                inactiveMin = 60
                
        elif splitInstruction[index] in ["half"]:
                inactiveMin = 30
                
        # numbers in words
        else:
            try: 
                inactiveMin = w2n.word_to_num(splitInstruction[index])
            except:
                # numbers in fraction
                try: 
                    inactiveMin = fractionToFloat(splitInstruction[index])* 60
                except:
                    inactiveMin = np.nan

            
    return inactiveMin 


# In[9]:


def extractVerb(instruction):
    """
    input: instruction in English
    output: the verb in the instruction
    
    """
    splitInstruction = ''
    
    # split the instruction by minutes/hours
    for word in ["minute","minutes","hour","hours"]:
        if word in instruction:
            splitInstruction = instruction.split(word)[0]+word
        
    # apply natural language processing to analyze the sentence
    tokens = word_tokenize(splitInstruction) 
    text = Text(tokens) 
    tags = pos_tag(text) 
    
    # extract verbs
    verb = ""
    verb_tag = 0
    # if there is verb in the sentence
    for pairs in tags: 
        if pairs[1] == 'VB' or pairs[1] =='VBP' or pairs[1] == 'VBN' or pairs[1] =='VBG':
            verb = pairs[0]
            verb_tag = 1
            
    if verb_tag == 0:
        for pairs in tags:
            if pairs[1] == 'NNP':
                verb = pairs[0]
    
    return verb.lower()


# In[10]:


# initialize the verbs list that could last for a long time
verbLst = ["marinate","marinating","marinated","boil","boiled","boiling","rest","resting","baked","bake","baking","baken","place","placed","placing",
           "leave","left","leaving","soak","soaked","soaking","put","putting","settle","settling","settled"," refrigerate"," refrigerated"," refrigerating",
          "bake","baked","baken","cook","cooking","dry","keep","kept","keeping","set","setting","store","stored","storing","cover","covered",'covering',
          "steam","steaming","steamed","freeze","freezing","freezed","take","taking","taken","cool","cooling","cooled","rise","bloom"]


# In[38]:


def calInactiveTime(instructionLst):
    """
    input: instruction list in Spanish
    output: inactive cooking time in minutes
    
    """
    
    # step 1: find sentences with "minutos" or "horas", store them to a new list 
    # initialize the list to store instructions with "minutos" or "horas"
    timeInstruction = []
    
    for instruction in instructionLst:
        if "minutos" in instruction or "horas" in instruction or "minuto" in instruction or "hora" in instruction:
            timeInstruction.append(instruction)
            
    # step 1: translate instructions related to time to English
    timeInstructionEng = [GoogleTranslator(source='auto', target='english').translate(i) for i in timeInstruction]
    
    # step 2: Initialize a dictionary to store minutes and actions
    inactiveDic = {}
    
    # step 2: nitialize a list to store every key instruction(i.e. Having actions with time)
    timeSentence = []
    
    # step 2: initialize totalIncativeMin to record total minutes of inactive cooking time
    totalInactiveMin = 0
    
    # step 3: For each instruction, split the instruction by “. ” or “, ” or “+” 
    for instruction in timeInstructionEng:
        splitSentence = re.split('[,.+]',instruction)
        
        for i in splitSentence:
            if "minutes" in i or "hours" in i or "minute" in i or "hour" in i:
                timeSentence.append(i)
                
    # step 4: for each part, extract the action and time
    for sentence in timeSentence:
        if "oven" in sentence:
            inactiveDic["oven"] = extractTime(sentence)
        elif "grill" in sentence:
            inactiveDic["grill"] = extractTime(sentence)
        elif "simmer" in sentence:
            inactiveDic["simmer"] = extractTime(sentence)
        elif "microwave" in sentence:
            inactiveDic["microwave"] = extractTime(sentence)
        else:
            inactiveDic[extractVerb(sentence)] = extractTime(sentence)
        
       
    # step 5: Initialize inactive verb list. Go over the dictionary, if the verb is in the inactive list or is “oven” or “grill”, keep it as inactive time.

    for key in inactiveDic:
        if key in verbLst:
            totalInactiveMin += inactiveDic[key]
        elif key == "oven" or key == "grill" or key =="simmer" or key=="microwave":
            totalInactiveMin += inactiveDic[key]
                        
    return totalInactiveMin     


# In[51]:


# calculate inactive cooking time for each recipe
Argentinas["Inactive cooking time"] = Argentinas['List of instructions'].apply(lambda x: calInactiveTime(x))
Argentinas.head()


# In[52]:


def calActiveTime(recipe):
    """
    input: one recipe row
    output: active cooking time in minutes
    
    """
    if recipe['Total time'] > recipe['Inactive cooking time']:
        return recipe['Total time'] - recipe['Inactive cooking time']
    else:
        return recipe['Total time']
    
Argentinas["Active cooking time"] = [calActiveTime(Argentinas.iloc[i]) for i in range(len(Argentinas))]
Argentinas.head()


# #### Save the data

# In[53]:


Argentinas.to_csv("/Users/xixi/Dropbox/food4thought/data/intermediate/Argentinas.csv")

