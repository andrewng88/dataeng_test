#!/usr/bin/env python
# coding: utf-8

# In[1]:


import glob
import os
import pandas as pd #we need to pip install later
from datetime import datetime


# In[2]:


# we obtain the latest file
# no need to write checks on the running number
# hacked from https://stackoverflow.com/questions/39327032/how-to-get-the-latest-file-in-a-folder

list_of_files = glob.glob('upload/*.csv') # * check files that is *.csv
latest_file = max(list_of_files, key=os.path.getctime)


# In[3]:


# read_csv
df = pd.read_csv(latest_file)


# ## Identified sone of the Problematic fields by eyeballing
# <li>Ms. Stacey Wiley DDS
# <li>Melissa Johnson DDS
# <li>Mrs. Jennifer Rodriguez
# <li>Teresa Wright DVM
# <li>Justin Knox MD
# <li>Savannah Mendoza PhD
# <li>Dr. Thomas Campbell MD
# <li>Mrs. Carmen Clark
# <li>Mr. Scott Martinez
# <li>Mrs. Jessica Gibson DDS
# <li>Miss Monica Mcdonald
# <li>Preston Ferguson III

# In[4]:


#Delete any rows which do not have a name
df.dropna(subset = ["name"], inplace=True)


# In[5]:


#Split the name field into first_name, and last_name


# In[6]:


def replacement(cell):
    '''
    input cell from df
    
    this function helps to replace the list of words in to_replace with ''
    '''
    to_replace = ['Ms.','Mrs.','Dr.','Miss','Mr.','DDS','DVM','MD','III','PhD','Jr.','II','IV']
    lst =[]
    
    # cycle through the names to replace with ''
    for word in cell.split(' '):
        if word not in to_replace:
            lst.append(word)
    return " ".join(lst)

#run the function
df['name'] = df['name'].apply(lambda x : replacement(x))


# In[7]:


# concat back the files together
temp = df.name.str.split(expand=True)
df= pd.concat([temp,df],axis=1)

# delete the original column that is not useful
del df['name']

# rename the columns
df.columns = ['first_name','last_name','price']


# In[8]:


# Remove any zeros prepended to the price field
# convert to str so that we can lstrip ( strip leading whitespace)
# then we convert back to float(original)
df['price'] = df['price'].astype(str).str.lstrip().astype(float)


# In[9]:


# Create a new field named above_100, which is true if the price is strictly greater than 100
df['price'] = df['price'].apply(lambda x : 'true' if x >100 else '')


# In[10]:


# change the directory to 'cleaned'
latest_file.replace('upload','cleaned')


# In[11]:


# save to a new csv and not overwrite the original so that we can refer to it next time
latest_file= latest_file.replace('upload','cleaned')
df.to_csv(latest_file,index=False)


# In[12]:


# verbose
# datetime object containing current date and time
now = datetime.now()
 
# dd/mm/YY H:M:S
dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
print("File '{}' sanitized by Clorox on {}".format(latest_file,dt_string))

