# Section_1

## Step 0
Copy python `cleaning_schedule_at_0100hrs.py` based on the following structure.

├───├
│   ├───python cleaning_schedule_at_0100hrs.py
│   ├───cleaned
│   └───upload

## Step 1
Go to terminal and input the following to create a new environment and install pandas
#(venv) will be prefix at the terminal prompt if the new environment is created
```sh
python3 -m venv venv
. venv/bin/activate 
pip install pandas
```

## Step 2
Go to [Crontab](https://crontab.guru/#01_01_*_*_*) to convert 0100hours daily.

> Note: `Use mac or linux` to perform the above else use windows task scheduler.

## Step 3
Go to terminal and input the following to schedule a cron job
```sh
crontab -e
```
## Step 4
Insert the following line.

```sh
01 01 * * * ~/pathto/venv/bin/python ~/pathto/python cleaning_schedule_at_0100hrs.py
```
Finally , save and exit!

## Step 5
Confirm cron is done correctly
```sh
crontab -l
```

:v: