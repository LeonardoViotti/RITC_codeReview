# Scrapping

You should avoid causing DoS on the website.  
 - Set up a HTTP header?
 - 

Coding best practices:
 - Hardcoded file paths. These make it a lot harder for someone else (or yourself if your folder structure changes) to run your code. There are several alternatives to do this, what I would suggest is making sure your project sets up a folder structure with relative file paths within the project folder. At the very least create a variables in the beginning of each script to store file paths so it is easy to change.