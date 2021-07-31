# Section 4: Charts and APIs

This project is actually splitted into 3 parts. First part is data extraction via API and then, output to dashboard and lastly after we have POC-ed we need to automate/schedule it. Since time is limited and scheduling and database modelling has already been done at the previous section. We will only be discussing the third part.

## Data Extraction via Covid API
There is not much difficulty extracting information but I think information is not available as we're only using freeware rather premium. Hence, instead of doing only Singapore, I extracted from all the ASEAN countries to add a little of difficulty to it.

Transformation is pretty day-to-day problem but I would like to share regarding information that we extracted are cumulative and if we were to do that all our data will be wrong. 

Hence, I did data verification with other sites such as [Worldometers] 
(https://www.worldometers.info/coronavirus/country/singapore/)
and from here I know that we need to more transformation on the # of cases.

So basically we we need to difference by 1 period . Meaning if say
Day 1 is 0, Day 2 is 3 and Day 3 is 5.  The correct values are
0, 3 and 2 respectively. Since we use `.diff()` we need to change it to zero.

```sh
temp.set_index('Date')
temp['Cases'] = temp['Cases'].diff()
temp.Cases.fillna(0).sum()
```

After we extracted from all the ASEAN countries, we need to concat row wise and apply transformation to prep our data for Tableau for Dashboarding.

## Output to Dashboard

The Tableau dashboard is deployed [here](https://public.tableau.com/app/profile/andrew5817/viz/Singapore_16277352255500/Dashboard#1)

We will be using Public Tableau rather than [streamlit](http://3.131.82.107:8501/) *Shameless plug* as I'm fighting with time (48 hours).

Following is a simple dashboard that I've designed based on the limited data that we have. We do not have access to other data rather than `# of cases` . 

We can observe that we are using divergent color for countries. Meaning red ones are hot spot. The Divergent Color Scale is most useful for visualizations where you’re showing a transition from (a) one extreme, through a (b) neutral middle, and finally to a (c) opposite extreme.

![](https://i2.wp.com/css-tricks.com/wp-content/uploads/2018/12/whats-in-a-color-palette-01.png "Title")

![](https://i.imgur.com/bfjAYGV.png "Title")

![](https://i.imgur.com/vDHvNWH.png "Title")
I have also used action as a filter meaning. When you click on the country it help to filter the corresponding chart at the bottom which actually tell us cases time series from last year untill now.

## POC and suggestions moving forward

So in order to automate the daily data retrieval, we can still apply the cron concept in Section 1 and run the python script . And from Tableau side, we can just leave the connection as LIVE and refresh the CSV file. Or altenatively we can use python to ingest directly to a SQL server and Tableau will directly query the server. I think this is fair balance betwen simplicty for us developers and also stake holders who are more geared with GUI driven app such as Tableau.

But to take it on to another level , we would probably comboing it with Kafka and dashboard driven by d3.js. But this story is for another day...