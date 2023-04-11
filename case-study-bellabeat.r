{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "e59e85f8",
   "metadata": {
    "papermill": {
     "duration": 0.009304,
     "end_time": "2023-04-11T20:25:11.399221",
     "exception": false,
     "start_time": "2023-04-11T20:25:11.389917",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Case Study: How Can a Wellness Technology Company Play It Smart?\n",
    "\n",
    "Bellabeat is a company that offers services and products focused on women’s wellness and health. They collect users’ data through wearable smart devices. Using available data from Fitbit, the current analysis will offer insights to guide Bellabeat in its marketing strategy. \n",
    "\n",
    "The following questions will direct this process to deliver effective guidelines for Bellabeat’s marketing team. \n",
    "* What are some trends in Fitbit smart device usage?\n",
    "* How could these trends apply to Bellabeat customers?\n",
    "* How could these trends help influence Bellabeat's marketing strategy?\n",
    "\n",
    "The stakeholders of this analysis are Urška Sršen (Bellabeat’s cofounder and current Chief People Officer), Sandro Mur (Bellabeat’s cofounder and current Chief Executive Officer), and Bellabeat's marketing analytics team.\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "18adde76",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:11.420997Z",
     "iopub.status.busy": "2023-04-11T20:25:11.417562Z",
     "iopub.status.idle": "2023-04-11T20:25:12.739033Z",
     "shell.execute_reply": "2023-04-11T20:25:12.737146Z"
    },
    "papermill": {
     "duration": 1.334615,
     "end_time": "2023-04-11T20:25:12.741908",
     "exception": false,
     "start_time": "2023-04-11T20:25:11.407293",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.0     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.1     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.1.8\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.2     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.1     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    }
   ],
   "source": [
    "# Notebook developed on Kaggle where the R environment comes with the analytics packages I used already installed\n",
    "# In the case you need to install the package run the following command:\n",
    "# install.packages('tidyverse')\n",
    "# install.packages('visdat')\n",
    "\n",
    "# Load packages\n",
    "library(tidyverse) \n",
    "library(visdat)\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1d4ae376",
   "metadata": {
    "papermill": {
     "duration": 0.008557,
     "end_time": "2023-04-11T20:25:12.759310",
     "exception": false,
     "start_time": "2023-04-11T20:25:12.750753",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Data Gathering\n",
    "\n",
    "> The dataset Fitbit Fitness Tracker Data used in this analysis is on [Kaggle](https://www.kaggle.com/datasets/arashnic/fitbit). It was made available by Mobius and comprises the data of 30 Fitbit users. We will be working with daily activity, heart rate, and sleep data. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "3d44572b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:12.811349Z",
     "iopub.status.busy": "2023-04-11T20:25:12.779430Z",
     "iopub.status.idle": "2023-04-11T20:25:20.529358Z",
     "shell.execute_reply": "2023-04-11T20:25:20.527192Z"
    },
    "papermill": {
     "duration": 7.765594,
     "end_time": "2023-04-11T20:25:20.533477",
     "exception": false,
     "start_time": "2023-04-11T20:25:12.767883",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Load the data set into dataframes\n",
    "daily_activity <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv\")\n",
    "sleep_day <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv\")\n",
    "hourly_cal <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlyCalories_merged.csv\")\n",
    "hourly_intensity <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlyIntensities_merged.csv\")\n",
    "hourly_step <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlySteps_merged.csv\")\n",
    "heart_rate <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/heartrate_seconds_merged.csv\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7dd15e0a",
   "metadata": {
    "papermill": {
     "duration": 0.00897,
     "end_time": "2023-04-11T20:25:20.550706",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.541736",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Data Assessment\n",
    "\n",
    "> I will assess each data frame in order to point out the issues to be solved in the cleaning stage."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "99c4b079",
   "metadata": {
    "papermill": {
     "duration": 0.008574,
     "end_time": "2023-04-11T20:25:20.567923",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.559349",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### 1º Data Frame: daily_activity\n",
    "\n",
    "The first one contains data on daily activities."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "71e9a2bc",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:20.587957Z",
     "iopub.status.busy": "2023-04-11T20:25:20.586344Z",
     "iopub.status.idle": "2023-04-11T20:25:20.642427Z",
     "shell.execute_reply": "2023-04-11T20:25:20.640418Z"
    },
    "papermill": {
     "duration": 0.069547,
     "end_time": "2023-04-11T20:25:20.645581",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.576034",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDate</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 15\n",
       "\\begin{tabular}{r|lllllllllllllll}\n",
       "  & Id & ActivityDate & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985\\\\\n",
       "\t2 & 1503960366 & 4/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797\\\\\n",
       "\t3 & 1503960366 & 4/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776\\\\\n",
       "\t4 & 1503960366 & 4/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745\\\\\n",
       "\t5 & 1503960366 & 4/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863\\\\\n",
       "\t6 & 1503960366 & 4/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 15\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDate &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 |\n",
       "| 2 | 1503960366 | 4/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 |\n",
       "| 3 | 1503960366 | 4/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 |\n",
       "| 4 | 1503960366 | 4/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 |\n",
       "| 5 | 1503960366 | 4/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 |\n",
       "| 6 | 1503960366 | 4/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDate TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 4/12/2016    13162      8.50          8.50           \n",
       "2 1503960366 4/13/2016    10735      6.97          6.97           \n",
       "3 1503960366 4/14/2016    10460      6.74          6.74           \n",
       "4 1503960366 4/15/2016     9762      6.28          6.28           \n",
       "5 1503960366 4/16/2016    12669      8.16          8.16           \n",
       "6 1503960366 4/17/2016     9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance VeryActiveMinutes\n",
       "1 6.06                0                       25               \n",
       "2 4.71                0                       21               \n",
       "3 3.91                0                       30               \n",
       "4 2.83                0                       29               \n",
       "5 5.04                0                       36               \n",
       "6 2.51                0                       38               \n",
       "  FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories\n",
       "1 13                  328                   728             1985    \n",
       "2 19                  217                   776             1797    \n",
       "3 11                  181                  1218             1776    \n",
       "4 34                  209                   726             1745    \n",
       "5 10                  221                   773             1863    \n",
       "6 20                  164                   539             1728    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows:  940 \n",
      "Columns:  15"
     ]
    }
   ],
   "source": [
    "# Assess daily_activity data frame\n",
    "head(daily_activity)\n",
    "\n",
    "# Number of rows and columns\n",
    "rows <- nrow(daily_activity)\n",
    "cols <- ncol(daily_activity)\n",
    "cat(\"Rows: \", rows, \"\\n\")\n",
    "cat(\"Columns: \", cols)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "65958336",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:20.666380Z",
     "iopub.status.busy": "2023-04-11T20:25:20.664832Z",
     "iopub.status.idle": "2023-04-11T20:25:20.738005Z",
     "shell.execute_reply": "2023-04-11T20:25:20.735883Z"
    },
    "papermill": {
     "duration": 0.087303,
     "end_time": "2023-04-11T20:25:20.741391",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.654088",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   TotalSteps    TotalDistance    SedentaryMinutes    Calories   \n",
       " Min.   :    0   Min.   : 0.000   Min.   :   0.0   Min.   :   0  \n",
       " 1st Qu.: 3790   1st Qu.: 2.620   1st Qu.: 729.8   1st Qu.:1828  \n",
       " Median : 7406   Median : 5.245   Median :1057.5   Median :2134  \n",
       " Mean   : 7638   Mean   : 5.490   Mean   : 991.2   Mean   :2304  \n",
       " 3rd Qu.:10727   3rd Qu.: 7.713   3rd Qu.:1229.5   3rd Qu.:2793  \n",
       " Max.   :36019   Max.   :28.030   Max.   :1440.0   Max.   :4900  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Summary statistics\n",
    "daily_activity %>%  \n",
    "  select(TotalSteps,\n",
    "         TotalDistance,\n",
    "         SedentaryMinutes,\n",
    "         Calories) %>%\n",
    "  summary()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c6df075e",
   "metadata": {
    "papermill": {
     "duration": 0.008848,
     "end_time": "2023-04-11T20:25:20.759024",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.750176",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### 2º Data Frame: sleep_day\n",
    "\n",
    "This data frame contains data on the users' daily amount of sleep."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "3ba61fc3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:20.782033Z",
     "iopub.status.busy": "2023-04-11T20:25:20.780058Z",
     "iopub.status.idle": "2023-04-11T20:25:20.837936Z",
     "shell.execute_reply": "2023-04-11T20:25:20.835720Z"
    },
    "papermill": {
     "duration": 0.073148,
     "end_time": "2023-04-11T20:25:20.841648",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.768500",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 5</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>SleepDay</th><th scope=col>TotalSleepRecords</th><th scope=col>TotalMinutesAsleep</th><th scope=col>TotalTimeInBed</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>1</td><td>327</td><td>346</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/13/2016 12:00:00 AM</td><td>2</td><td>384</td><td>407</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/15/2016 12:00:00 AM</td><td>1</td><td>412</td><td>442</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/16/2016 12:00:00 AM</td><td>2</td><td>340</td><td>367</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/17/2016 12:00:00 AM</td><td>1</td><td>700</td><td>712</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/19/2016 12:00:00 AM</td><td>1</td><td>304</td><td>320</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 5\n",
       "\\begin{tabular}{r|lllll}\n",
       "  & Id & SleepDay & TotalSleepRecords & TotalMinutesAsleep & TotalTimeInBed\\\\\n",
       "  & <dbl> & <chr> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 1 & 327 & 346\\\\\n",
       "\t2 & 1503960366 & 4/13/2016 12:00:00 AM & 2 & 384 & 407\\\\\n",
       "\t3 & 1503960366 & 4/15/2016 12:00:00 AM & 1 & 412 & 442\\\\\n",
       "\t4 & 1503960366 & 4/16/2016 12:00:00 AM & 2 & 340 & 367\\\\\n",
       "\t5 & 1503960366 & 4/17/2016 12:00:00 AM & 1 & 700 & 712\\\\\n",
       "\t6 & 1503960366 & 4/19/2016 12:00:00 AM & 1 & 304 & 320\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 5\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | SleepDay &lt;chr&gt; | TotalSleepRecords &lt;int&gt; | TotalMinutesAsleep &lt;int&gt; | TotalTimeInBed &lt;int&gt; |\n",
       "|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 1 | 327 | 346 |\n",
       "| 2 | 1503960366 | 4/13/2016 12:00:00 AM | 2 | 384 | 407 |\n",
       "| 3 | 1503960366 | 4/15/2016 12:00:00 AM | 1 | 412 | 442 |\n",
       "| 4 | 1503960366 | 4/16/2016 12:00:00 AM | 2 | 340 | 367 |\n",
       "| 5 | 1503960366 | 4/17/2016 12:00:00 AM | 1 | 700 | 712 |\n",
       "| 6 | 1503960366 | 4/19/2016 12:00:00 AM | 1 | 304 | 320 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         SleepDay              TotalSleepRecords TotalMinutesAsleep\n",
       "1 1503960366 4/12/2016 12:00:00 AM 1                 327               \n",
       "2 1503960366 4/13/2016 12:00:00 AM 2                 384               \n",
       "3 1503960366 4/15/2016 12:00:00 AM 1                 412               \n",
       "4 1503960366 4/16/2016 12:00:00 AM 2                 340               \n",
       "5 1503960366 4/17/2016 12:00:00 AM 1                 700               \n",
       "6 1503960366 4/19/2016 12:00:00 AM 1                 304               \n",
       "  TotalTimeInBed\n",
       "1 346           \n",
       "2 407           \n",
       "3 442           \n",
       "4 367           \n",
       "5 712           \n",
       "6 320           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows:  413 \n",
      "Columns:  5"
     ]
    }
   ],
   "source": [
    "# Assess sleep_day data frame\n",
    "head(sleep_day)\n",
    "\n",
    "# Number of rows and columns\n",
    "rows <- nrow(sleep_day)\n",
    "cols <- ncol(sleep_day)\n",
    "cat(\"Rows: \", rows, \"\\n\")\n",
    "cat(\"Columns: \", cols)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "51072e00",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:20.865674Z",
     "iopub.status.busy": "2023-04-11T20:25:20.863364Z",
     "iopub.status.idle": "2023-04-11T20:25:20.895996Z",
     "shell.execute_reply": "2023-04-11T20:25:20.893529Z"
    },
    "papermill": {
     "duration": 0.048411,
     "end_time": "2023-04-11T20:25:20.899661",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.851250",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       " TotalMinutesAsleep TotalTimeInBed \n",
       " Min.   : 58.0      Min.   : 61.0  \n",
       " 1st Qu.:361.0      1st Qu.:403.0  \n",
       " Median :433.0      Median :463.0  \n",
       " Mean   :419.5      Mean   :458.6  \n",
       " 3rd Qu.:490.0      3rd Qu.:526.0  \n",
       " Max.   :796.0      Max.   :961.0  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Summary statistics\n",
    "sleep_day %>%  \n",
    "  select(TotalMinutesAsleep,\n",
    "         TotalTimeInBed) %>%\n",
    "  summary()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4b032fb5",
   "metadata": {
    "papermill": {
     "duration": 0.010117,
     "end_time": "2023-04-11T20:25:20.919059",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.908942",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### 3º Data Frame: hourly_cal\n",
    "\n",
    "This data frame describes the users' amount of calories burned per hour."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "420147c6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:20.943066Z",
     "iopub.status.busy": "2023-04-11T20:25:20.940292Z",
     "iopub.status.idle": "2023-04-11T20:25:21.081517Z",
     "shell.execute_reply": "2023-04-11T20:25:21.079675Z"
    },
    "papermill": {
     "duration": 0.155414,
     "end_time": "2023-04-11T20:25:21.083892",
     "exception": false,
     "start_time": "2023-04-11T20:25:20.928478",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>Calories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>81</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 1:00:00 AM </td><td>61</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 2:00:00 AM </td><td>59</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 3:00:00 AM </td><td>47</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 4:00:00 AM </td><td>48</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 5:00:00 AM </td><td>48</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityHour & Calories\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 81\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 1:00:00 AM  & 61\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 2:00:00 AM  & 59\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 3:00:00 AM  & 47\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 4:00:00 AM  & 48\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 5:00:00 AM  & 48\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | Calories &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 81 |\n",
       "| 2 | 1503960366 | 4/12/2016 1:00:00 AM  | 61 |\n",
       "| 3 | 1503960366 | 4/12/2016 2:00:00 AM  | 59 |\n",
       "| 4 | 1503960366 | 4/12/2016 3:00:00 AM  | 47 |\n",
       "| 5 | 1503960366 | 4/12/2016 4:00:00 AM  | 48 |\n",
       "| 6 | 1503960366 | 4/12/2016 5:00:00 AM  | 48 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour          Calories\n",
       "1 1503960366 4/12/2016 12:00:00 AM 81      \n",
       "2 1503960366 4/12/2016 1:00:00 AM  61      \n",
       "3 1503960366 4/12/2016 2:00:00 AM  59      \n",
       "4 1503960366 4/12/2016 3:00:00 AM  47      \n",
       "5 1503960366 4/12/2016 4:00:00 AM  48      \n",
       "6 1503960366 4/12/2016 5:00:00 AM  48      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows:  22099 \n",
      "Columns:  3"
     ]
    }
   ],
   "source": [
    "# Assess hourly_cal data frame\n",
    "head(hourly_cal)\n",
    "\n",
    "# Number of rows and columns\n",
    "rows <- nrow(hourly_cal)\n",
    "cols <- ncol(hourly_cal)\n",
    "cat(\"Rows: \", rows, \"\\n\")\n",
    "cat(\"Columns: \", cols)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "750dbbc6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.106952Z",
     "iopub.status.busy": "2023-04-11T20:25:21.105372Z",
     "iopub.status.idle": "2023-04-11T20:25:21.129235Z",
     "shell.execute_reply": "2023-04-11T20:25:21.127038Z"
    },
    "papermill": {
     "duration": 0.038827,
     "end_time": "2023-04-11T20:25:21.132417",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.093590",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "    Calories     \n",
       " Min.   : 42.00  \n",
       " 1st Qu.: 63.00  \n",
       " Median : 83.00  \n",
       " Mean   : 97.39  \n",
       " 3rd Qu.:108.00  \n",
       " Max.   :948.00  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Summary statistics\n",
    "hourly_cal %>%  \n",
    "  select(Calories) %>%\n",
    "  summary()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ef13e8e0",
   "metadata": {
    "papermill": {
     "duration": 0.009782,
     "end_time": "2023-04-11T20:25:21.152092",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.142310",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### 4º Data Frame: hourly_intensity\n",
    "\n",
    "This data frame contains data on the intensity of users' activities on an hourly basis."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "3364f946",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.175845Z",
     "iopub.status.busy": "2023-04-11T20:25:21.174203Z",
     "iopub.status.idle": "2023-04-11T20:25:21.216381Z",
     "shell.execute_reply": "2023-04-11T20:25:21.214398Z"
    },
    "papermill": {
     "duration": 0.057655,
     "end_time": "2023-04-11T20:25:21.219629",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.161974",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>TotalIntensity</th><th scope=col>AverageIntensity</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>20</td><td>0.333333</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 1:00:00 AM </td><td> 8</td><td>0.133333</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 2:00:00 AM </td><td> 7</td><td>0.116667</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 3:00:00 AM </td><td> 0</td><td>0.000000</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 4:00:00 AM </td><td> 0</td><td>0.000000</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 5:00:00 AM </td><td> 0</td><td>0.000000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 4\n",
       "\\begin{tabular}{r|llll}\n",
       "  & Id & ActivityHour & TotalIntensity & AverageIntensity\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 20 & 0.333333\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 1:00:00 AM  &  8 & 0.133333\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 2:00:00 AM  &  7 & 0.116667\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 3:00:00 AM  &  0 & 0.000000\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 4:00:00 AM  &  0 & 0.000000\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 5:00:00 AM  &  0 & 0.000000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 4\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | TotalIntensity &lt;int&gt; | AverageIntensity &lt;dbl&gt; |\n",
       "|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 20 | 0.333333 |\n",
       "| 2 | 1503960366 | 4/12/2016 1:00:00 AM  |  8 | 0.133333 |\n",
       "| 3 | 1503960366 | 4/12/2016 2:00:00 AM  |  7 | 0.116667 |\n",
       "| 4 | 1503960366 | 4/12/2016 3:00:00 AM  |  0 | 0.000000 |\n",
       "| 5 | 1503960366 | 4/12/2016 4:00:00 AM  |  0 | 0.000000 |\n",
       "| 6 | 1503960366 | 4/12/2016 5:00:00 AM  |  0 | 0.000000 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour          TotalIntensity AverageIntensity\n",
       "1 1503960366 4/12/2016 12:00:00 AM 20             0.333333        \n",
       "2 1503960366 4/12/2016 1:00:00 AM   8             0.133333        \n",
       "3 1503960366 4/12/2016 2:00:00 AM   7             0.116667        \n",
       "4 1503960366 4/12/2016 3:00:00 AM   0             0.000000        \n",
       "5 1503960366 4/12/2016 4:00:00 AM   0             0.000000        \n",
       "6 1503960366 4/12/2016 5:00:00 AM   0             0.000000        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows:  22099 \n",
      "Columns:  4"
     ]
    }
   ],
   "source": [
    "# Assess hourly_intensity data frame\n",
    "head(hourly_intensity)\n",
    "\n",
    "# number of rows and columns\n",
    "rows <- nrow(hourly_intensity)\n",
    "cols <- ncol(hourly_intensity)\n",
    "cat(\"Rows: \", rows, \"\\n\")\n",
    "cat(\"Columns: \", cols)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "b0d43625",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.244185Z",
     "iopub.status.busy": "2023-04-11T20:25:21.242647Z",
     "iopub.status.idle": "2023-04-11T20:25:21.269028Z",
     "shell.execute_reply": "2023-04-11T20:25:21.266763Z"
    },
    "papermill": {
     "duration": 0.041829,
     "end_time": "2023-04-11T20:25:21.272203",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.230374",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       " TotalIntensity   AverageIntensity\n",
       " Min.   :  0.00   Min.   :0.0000  \n",
       " 1st Qu.:  0.00   1st Qu.:0.0000  \n",
       " Median :  3.00   Median :0.0500  \n",
       " Mean   : 12.04   Mean   :0.2006  \n",
       " 3rd Qu.: 16.00   3rd Qu.:0.2667  \n",
       " Max.   :180.00   Max.   :3.0000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Summary statistics\n",
    "hourly_intensity %>%  \n",
    "  select(TotalIntensity,\n",
    "         AverageIntensity) %>%\n",
    "  summary()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d00b8b30",
   "metadata": {
    "papermill": {
     "duration": 0.010695,
     "end_time": "2023-04-11T20:25:21.293344",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.282649",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### 5º Data Frame: hourly_step\n",
    "\n",
    "This data frame contains data on the users' amount of steps per hour."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "7a0802c8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.318315Z",
     "iopub.status.busy": "2023-04-11T20:25:21.316729Z",
     "iopub.status.idle": "2023-04-11T20:25:21.358198Z",
     "shell.execute_reply": "2023-04-11T20:25:21.356191Z"
    },
    "papermill": {
     "duration": 0.057518,
     "end_time": "2023-04-11T20:25:21.361437",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.303919",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>StepTotal</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>373</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 1:00:00 AM </td><td>160</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 2:00:00 AM </td><td>151</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 3:00:00 AM </td><td>  0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 4:00:00 AM </td><td>  0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 5:00:00 AM </td><td>  0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityHour & StepTotal\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 373\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 1:00:00 AM  & 160\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 2:00:00 AM  & 151\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 3:00:00 AM  &   0\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 4:00:00 AM  &   0\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 5:00:00 AM  &   0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | StepTotal &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 373 |\n",
       "| 2 | 1503960366 | 4/12/2016 1:00:00 AM  | 160 |\n",
       "| 3 | 1503960366 | 4/12/2016 2:00:00 AM  | 151 |\n",
       "| 4 | 1503960366 | 4/12/2016 3:00:00 AM  |   0 |\n",
       "| 5 | 1503960366 | 4/12/2016 4:00:00 AM  |   0 |\n",
       "| 6 | 1503960366 | 4/12/2016 5:00:00 AM  |   0 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour          StepTotal\n",
       "1 1503960366 4/12/2016 12:00:00 AM 373      \n",
       "2 1503960366 4/12/2016 1:00:00 AM  160      \n",
       "3 1503960366 4/12/2016 2:00:00 AM  151      \n",
       "4 1503960366 4/12/2016 3:00:00 AM    0      \n",
       "5 1503960366 4/12/2016 4:00:00 AM    0      \n",
       "6 1503960366 4/12/2016 5:00:00 AM    0      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows:  22099 \n",
      "Columns:  3"
     ]
    }
   ],
   "source": [
    "# Assess hourly_step data frame\n",
    "head(hourly_step)\n",
    "\n",
    "# Number of rows and columns\n",
    "rows <- nrow(hourly_step)\n",
    "cols <- ncol(hourly_step)\n",
    "cat(\"Rows: \", rows, \"\\n\")\n",
    "cat(\"Columns: \", cols)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "d69b9d1f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.386846Z",
     "iopub.status.busy": "2023-04-11T20:25:21.384908Z",
     "iopub.status.idle": "2023-04-11T20:25:21.407765Z",
     "shell.execute_reply": "2023-04-11T20:25:21.405850Z"
    },
    "papermill": {
     "duration": 0.038142,
     "end_time": "2023-04-11T20:25:21.410259",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.372117",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   StepTotal      \n",
       " Min.   :    0.0  \n",
       " 1st Qu.:    0.0  \n",
       " Median :   40.0  \n",
       " Mean   :  320.2  \n",
       " 3rd Qu.:  357.0  \n",
       " Max.   :10554.0  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Summary statistics\n",
    "hourly_step %>%  \n",
    "  select(StepTotal) %>%\n",
    "  summary()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f5b0496a",
   "metadata": {
    "papermill": {
     "duration": 0.011518,
     "end_time": "2023-04-11T20:25:21.432813",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.421295",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### 6º Data Frame: heart_rate\n",
    "\n",
    "This data frame describes data on the users' heart rate."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "8085e5f4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.460244Z",
     "iopub.status.busy": "2023-04-11T20:25:21.458161Z",
     "iopub.status.idle": "2023-04-11T20:25:21.561284Z",
     "shell.execute_reply": "2023-04-11T20:25:21.559322Z"
    },
    "papermill": {
     "duration": 0.119904,
     "end_time": "2023-04-11T20:25:21.563921",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.444017",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>Time</th><th scope=col>Value</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>2022484408</td><td>4/12/2016 7:21:00 AM</td><td> 97</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2022484408</td><td>4/12/2016 7:21:05 AM</td><td>102</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>2022484408</td><td>4/12/2016 7:21:10 AM</td><td>105</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2022484408</td><td>4/12/2016 7:21:20 AM</td><td>103</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>2022484408</td><td>4/12/2016 7:21:25 AM</td><td>101</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2022484408</td><td>4/12/2016 7:22:05 AM</td><td> 95</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & Time & Value\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 2022484408 & 4/12/2016 7:21:00 AM &  97\\\\\n",
       "\t2 & 2022484408 & 4/12/2016 7:21:05 AM & 102\\\\\n",
       "\t3 & 2022484408 & 4/12/2016 7:21:10 AM & 105\\\\\n",
       "\t4 & 2022484408 & 4/12/2016 7:21:20 AM & 103\\\\\n",
       "\t5 & 2022484408 & 4/12/2016 7:21:25 AM & 101\\\\\n",
       "\t6 & 2022484408 & 4/12/2016 7:22:05 AM &  95\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | Time &lt;chr&gt; | Value &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 2022484408 | 4/12/2016 7:21:00 AM |  97 |\n",
       "| 2 | 2022484408 | 4/12/2016 7:21:05 AM | 102 |\n",
       "| 3 | 2022484408 | 4/12/2016 7:21:10 AM | 105 |\n",
       "| 4 | 2022484408 | 4/12/2016 7:21:20 AM | 103 |\n",
       "| 5 | 2022484408 | 4/12/2016 7:21:25 AM | 101 |\n",
       "| 6 | 2022484408 | 4/12/2016 7:22:05 AM |  95 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         Time                 Value\n",
       "1 2022484408 4/12/2016 7:21:00 AM  97  \n",
       "2 2022484408 4/12/2016 7:21:05 AM 102  \n",
       "3 2022484408 4/12/2016 7:21:10 AM 105  \n",
       "4 2022484408 4/12/2016 7:21:20 AM 103  \n",
       "5 2022484408 4/12/2016 7:21:25 AM 101  \n",
       "6 2022484408 4/12/2016 7:22:05 AM  95  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows:  2483658 \n",
      "Columns:  3"
     ]
    }
   ],
   "source": [
    "# Assess heart_rate data frame\n",
    "head(heart_rate)\n",
    "\n",
    "# Number of rows and columns\n",
    "rows <- nrow(heart_rate)\n",
    "cols <- ncol(heart_rate)\n",
    "cat(\"Rows: \", rows, \"\\n\")\n",
    "cat(\"Columns: \", cols)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "73cfa161",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.590842Z",
     "iopub.status.busy": "2023-04-11T20:25:21.589320Z",
     "iopub.status.idle": "2023-04-11T20:25:21.757652Z",
     "shell.execute_reply": "2023-04-11T20:25:21.755726Z"
    },
    "papermill": {
     "duration": 0.184033,
     "end_time": "2023-04-11T20:25:21.760142",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.576109",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "     Value       \n",
       " Min.   : 36.00  \n",
       " 1st Qu.: 63.00  \n",
       " Median : 73.00  \n",
       " Mean   : 77.33  \n",
       " 3rd Qu.: 88.00  \n",
       " Max.   :203.00  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Summary statistics\n",
    "heart_rate %>%  \n",
    "  select(Value) %>%\n",
    "  summary()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cf17c7e5",
   "metadata": {
    "papermill": {
     "duration": 0.011275,
     "end_time": "2023-04-11T20:25:21.782863",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.771588",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Data Issues \n",
    "\n",
    "> **Issue 1:** in all dataframes, the columns containing date and time are in the `character` data type.\n",
    ">\n",
    "> **Issue 2:** the observations in the `heart_rate` data frame were registered every few seconds. It is not suitable to compare it in this format with the other data frames that present time data on a daily or an hourly basis.\n",
    ">\n",
    "> **Issue 3:** data spread out in multiple data frames\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f26d8f27",
   "metadata": {
    "papermill": {
     "duration": 0.011317,
     "end_time": "2023-04-11T20:25:21.805552",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.794235",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Data Cleaning\n",
    "\n",
    "> Here I will document the cleaning process with define-code-test framework. At first, I determine how I can solve the issue. Following that, I apply the coding solution and test to verify the results."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8972d7cd",
   "metadata": {
    "papermill": {
     "duration": 0.011716,
     "end_time": "2023-04-11T20:25:21.828551",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.816835",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Issue 1\n",
    "> In all data frames, the columns containing date and time are in the `character` data type.\n",
    "\n",
    "**Define:** convert these columns from character data type to date and time data types using `mdy()` and `mdy_hms()` functions from `lubridate` package.\n",
    "\n",
    "**Code:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "80f2e1b6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.855773Z",
     "iopub.status.busy": "2023-04-11T20:25:21.854001Z",
     "iopub.status.idle": "2023-04-11T20:25:21.881022Z",
     "shell.execute_reply": "2023-04-11T20:25:21.879085Z"
    },
    "papermill": {
     "duration": 0.043429,
     "end_time": "2023-04-11T20:25:21.884039",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.840610",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Convert from character to date data type column 'ActivityDate' from 'daily_activity' data frame\n",
    "daily_activity$ActivityDate <- mdy(daily_activity$ActivityDate)\n",
    "\n",
    "# Rename 'ActivityDate' column to 'date'\n",
    "names(daily_activity)[names(daily_activity) == 'ActivityDate'] <- 'date'"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "d6b55667",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.911293Z",
     "iopub.status.busy": "2023-04-11T20:25:21.909674Z",
     "iopub.status.idle": "2023-04-11T20:25:21.937054Z",
     "shell.execute_reply": "2023-04-11T20:25:21.935142Z"
    },
    "papermill": {
     "duration": 0.043743,
     "end_time": "2023-04-11T20:25:21.939848",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.896105",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Split the column 'SleepDay' from 'sleep_day' data frame and get just the date\n",
    "sleep_day$SleepDay <- map(strsplit(sleep_day$SleepDay, split=\" \"), 1)\n",
    "\n",
    "# Convert from character to date data type 'SleepDay' column and assign to 'date' column\n",
    "sleep_day$date <- mdy(sleep_day$SleepDay)\n",
    "\n",
    "# Drop SleepDay column\n",
    "sleep_day$SleepDay <- NULL"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "1ba02164",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:21.967563Z",
     "iopub.status.busy": "2023-04-11T20:25:21.965993Z",
     "iopub.status.idle": "2023-04-11T20:25:23.790416Z",
     "shell.execute_reply": "2023-04-11T20:25:23.788686Z"
    },
    "papermill": {
     "duration": 1.841059,
     "end_time": "2023-04-11T20:25:23.792946",
     "exception": false,
     "start_time": "2023-04-11T20:25:21.951887",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Convert from character to datetime data type 'ActivityHour' column from 'hourly_cal' data frame\n",
    "hourly_cal$ActivityHour <- mdy_hms(hourly_cal$ActivityHour)\n",
    "\n",
    "# Convert from character to datetime data type 'ActivityHour' column from 'hourly_intensity' data frame\n",
    "hourly_intensity$ActivityHour <- mdy_hms(hourly_intensity$ActivityHour)\n",
    "\n",
    "# Convert from character to datetime data type 'ActivityHour' column from 'hourly_step' data frame\n",
    "hourly_step$ActivityHour <- mdy_hms(hourly_step$ActivityHour)\n",
    "\n",
    "# Convert from character to datetime data type 'Time' column from 'heart_rate' data frame\n",
    "heart_rate$Time <- mdy_hms(heart_rate$Time)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c64594dd",
   "metadata": {
    "papermill": {
     "duration": 0.011497,
     "end_time": "2023-04-11T20:25:23.815811",
     "exception": false,
     "start_time": "2023-04-11T20:25:23.804314",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Test:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "b21a66c5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:23.843283Z",
     "iopub.status.busy": "2023-04-11T20:25:23.841763Z",
     "iopub.status.idle": "2023-04-11T20:25:23.864399Z",
     "shell.execute_reply": "2023-04-11T20:25:23.862669Z"
    },
    "papermill": {
     "duration": 0.039549,
     "end_time": "2023-04-11T20:25:23.866830",
     "exception": false,
     "start_time": "2023-04-11T20:25:23.827281",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " Date[1:940], format: \"2016-04-12\" \"2016-04-13\" \"2016-04-14\" \"2016-04-15\" \"2016-04-16\" ...\n"
     ]
    }
   ],
   "source": [
    "# Check the data type for the column 'date' of the 'daily_activity' data frame\n",
    "glimpse(daily_activity$date)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "5af4e16f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:23.893575Z",
     "iopub.status.busy": "2023-04-11T20:25:23.891938Z",
     "iopub.status.idle": "2023-04-11T20:25:23.910159Z",
     "shell.execute_reply": "2023-04-11T20:25:23.908502Z"
    },
    "papermill": {
     "duration": 0.0343,
     "end_time": "2023-04-11T20:25:23.912699",
     "exception": false,
     "start_time": "2023-04-11T20:25:23.878399",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " Date[1:413], format: \"2016-04-12\" \"2016-04-13\" \"2016-04-15\" \"2016-04-16\" \"2016-04-17\" ...\n"
     ]
    }
   ],
   "source": [
    "# Check the data type for the column 'date' of the 'sleep_day' data frame\n",
    "glimpse(sleep_day$date)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "0840784f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:23.941277Z",
     "iopub.status.busy": "2023-04-11T20:25:23.939717Z",
     "iopub.status.idle": "2023-04-11T20:25:23.960448Z",
     "shell.execute_reply": "2023-04-11T20:25:23.958740Z"
    },
    "papermill": {
     "duration": 0.038223,
     "end_time": "2023-04-11T20:25:23.963068",
     "exception": false,
     "start_time": "2023-04-11T20:25:23.924845",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " POSIXct[1:22099], format: \"2016-04-12 00:00:00\" \"2016-04-12 01:00:00\" \"2016-04-12 02:00:00\" ...\n"
     ]
    }
   ],
   "source": [
    "# Check the data type for the column 'ActivityHour' of the 'hourly_cal' data frame\n",
    "glimpse(hourly_cal$ActivityHour)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "c5bfa3cb",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:23.990720Z",
     "iopub.status.busy": "2023-04-11T20:25:23.989239Z",
     "iopub.status.idle": "2023-04-11T20:25:24.009241Z",
     "shell.execute_reply": "2023-04-11T20:25:24.007499Z"
    },
    "papermill": {
     "duration": 0.036192,
     "end_time": "2023-04-11T20:25:24.011715",
     "exception": false,
     "start_time": "2023-04-11T20:25:23.975523",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " POSIXct[1:22099], format: \"2016-04-12 00:00:00\" \"2016-04-12 01:00:00\" \"2016-04-12 02:00:00\" ...\n"
     ]
    }
   ],
   "source": [
    "# Check the data type for the column 'ActivityHour' of the 'hourly_intensity' data frame\n",
    "glimpse(hourly_intensity$ActivityHour)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "961296f4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:24.040320Z",
     "iopub.status.busy": "2023-04-11T20:25:24.038511Z",
     "iopub.status.idle": "2023-04-11T20:25:24.061269Z",
     "shell.execute_reply": "2023-04-11T20:25:24.059083Z"
    },
    "papermill": {
     "duration": 0.040396,
     "end_time": "2023-04-11T20:25:24.064367",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.023971",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " POSIXct[1:22099], format: \"2016-04-12 00:00:00\" \"2016-04-12 01:00:00\" \"2016-04-12 02:00:00\" ...\n"
     ]
    }
   ],
   "source": [
    "# Check the data type for the column 'ActivityHour' of the 'hourly_step' data frame\n",
    "glimpse(hourly_step$ActivityHour)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "9f6f64bf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:24.134480Z",
     "iopub.status.busy": "2023-04-11T20:25:24.132827Z",
     "iopub.status.idle": "2023-04-11T20:25:24.158283Z",
     "shell.execute_reply": "2023-04-11T20:25:24.155768Z"
    },
    "papermill": {
     "duration": 0.085309,
     "end_time": "2023-04-11T20:25:24.161592",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.076283",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " POSIXct[1:2483658], format: \"2016-04-12 07:21:00\" \"2016-04-12 07:21:05\" \"2016-04-12 07:21:10\" ...\n"
     ]
    }
   ],
   "source": [
    "# Check the data type for the column 'Time' of the 'heart_rate' data frame\n",
    "glimpse(heart_rate$Time)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a723e640",
   "metadata": {
    "papermill": {
     "duration": 0.01189,
     "end_time": "2023-04-11T20:25:24.185512",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.173622",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Issue 2\n",
    "> The observations in the `heart_rate` data frame were registered every few seconds. It is not suitable to compare it in this format with the other data frames that present time data on a daily or an hourly basis.\n",
    "\n",
    "**Define:** group the observartions by hour and get the mean of each hour\n",
    "\n",
    "**Code:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "19b14cd7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:24.213827Z",
     "iopub.status.busy": "2023-04-11T20:25:24.212212Z",
     "iopub.status.idle": "2023-04-11T20:25:24.227421Z",
     "shell.execute_reply": "2023-04-11T20:25:24.225431Z"
    },
    "papermill": {
     "duration": 0.032306,
     "end_time": "2023-04-11T20:25:24.230382",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.198076",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "test <- heart_rate"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "da117f8c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:24.258549Z",
     "iopub.status.busy": "2023-04-11T20:25:24.256925Z",
     "iopub.status.idle": "2023-04-11T20:25:24.327270Z",
     "shell.execute_reply": "2023-04-11T20:25:24.325419Z"
    },
    "papermill": {
     "duration": 0.087188,
     "end_time": "2023-04-11T20:25:24.329894",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.242706",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2483658 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>Time</th><th scope=col>Value</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:00</td><td> 97</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:05</td><td>102</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:10</td><td>105</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:20</td><td>103</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:25</td><td>101</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:05</td><td> 95</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:10</td><td> 91</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:15</td><td> 93</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:20</td><td> 94</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:25</td><td> 93</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:35</td><td> 92</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:40</td><td> 89</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:50</td><td> 83</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:55</td><td> 61</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:00</td><td> 60</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:10</td><td> 61</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:25</td><td> 61</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:30</td><td> 57</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:40</td><td> 54</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:50</td><td> 55</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:00</td><td> 58</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:10</td><td> 60</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:20</td><td> 59</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:30</td><td> 57</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:40</td><td> 56</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:50</td><td> 58</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:05</td><td> 57</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:10</td><td> 58</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:15</td><td> 60</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:20</td><td> 60</td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:23</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:33</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:38</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:43</td><td>58</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:48</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:53</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:58</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:13</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:18</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:28</td><td>62</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:38</td><td>60</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:43</td><td>59</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:48</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:58</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:03</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:08</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:13</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:28</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:33</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:43</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:58</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:13</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:18</td><td>58</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:23</td><td>59</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:38</td><td>58</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:53</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:58</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:44:03</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:44:18</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:44:28</td><td>56</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2483658 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & Time & Value\\\\\n",
       " <dbl> & <dttm> & <int>\\\\\n",
       "\\hline\n",
       "\t 2022484408 & 2016-04-12 07:21:00 &  97\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:05 & 102\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:10 & 105\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:20 & 103\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:25 & 101\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:05 &  95\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:10 &  91\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:15 &  93\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:20 &  94\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:25 &  93\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:35 &  92\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:40 &  89\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:50 &  83\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:55 &  61\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:00 &  60\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:10 &  61\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:25 &  61\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:30 &  57\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:40 &  54\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:50 &  55\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:00 &  58\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:10 &  60\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:20 &  59\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:30 &  57\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:40 &  56\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:50 &  58\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:05 &  57\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:10 &  58\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:15 &  60\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:20 &  60\\\\\n",
       "\t ⋮ & ⋮ & ⋮\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:23 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:33 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:38 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:43 & 58\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:48 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:53 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:58 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:13 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:18 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:28 & 62\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:38 & 60\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:43 & 59\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:48 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:58 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:03 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:08 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:13 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:28 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:33 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:43 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:58 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:13 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:18 & 58\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:23 & 59\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:38 & 58\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:53 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:58 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:44:03 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:44:18 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:44:28 & 56\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2483658 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | Time &lt;dttm&gt; | Value &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| 2022484408 | 2016-04-12 07:21:00 |  97 |\n",
       "| 2022484408 | 2016-04-12 07:21:05 | 102 |\n",
       "| 2022484408 | 2016-04-12 07:21:10 | 105 |\n",
       "| 2022484408 | 2016-04-12 07:21:20 | 103 |\n",
       "| 2022484408 | 2016-04-12 07:21:25 | 101 |\n",
       "| 2022484408 | 2016-04-12 07:22:05 |  95 |\n",
       "| 2022484408 | 2016-04-12 07:22:10 |  91 |\n",
       "| 2022484408 | 2016-04-12 07:22:15 |  93 |\n",
       "| 2022484408 | 2016-04-12 07:22:20 |  94 |\n",
       "| 2022484408 | 2016-04-12 07:22:25 |  93 |\n",
       "| 2022484408 | 2016-04-12 07:22:35 |  92 |\n",
       "| 2022484408 | 2016-04-12 07:22:40 |  89 |\n",
       "| 2022484408 | 2016-04-12 07:22:50 |  83 |\n",
       "| 2022484408 | 2016-04-12 07:22:55 |  61 |\n",
       "| 2022484408 | 2016-04-12 07:23:00 |  60 |\n",
       "| 2022484408 | 2016-04-12 07:23:10 |  61 |\n",
       "| 2022484408 | 2016-04-12 07:23:25 |  61 |\n",
       "| 2022484408 | 2016-04-12 07:23:30 |  57 |\n",
       "| 2022484408 | 2016-04-12 07:23:40 |  54 |\n",
       "| 2022484408 | 2016-04-12 07:23:50 |  55 |\n",
       "| 2022484408 | 2016-04-12 07:24:00 |  58 |\n",
       "| 2022484408 | 2016-04-12 07:24:10 |  60 |\n",
       "| 2022484408 | 2016-04-12 07:24:20 |  59 |\n",
       "| 2022484408 | 2016-04-12 07:24:30 |  57 |\n",
       "| 2022484408 | 2016-04-12 07:24:40 |  56 |\n",
       "| 2022484408 | 2016-04-12 07:24:50 |  58 |\n",
       "| 2022484408 | 2016-04-12 07:25:05 |  57 |\n",
       "| 2022484408 | 2016-04-12 07:25:10 |  58 |\n",
       "| 2022484408 | 2016-04-12 07:25:15 |  60 |\n",
       "| 2022484408 | 2016-04-12 07:25:20 |  60 |\n",
       "| ⋮ | ⋮ | ⋮ |\n",
       "| 8877689391 | 2016-05-12 14:40:23 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:40:33 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:40:38 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:40:43 | 58 |\n",
       "| 8877689391 | 2016-05-12 14:40:48 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:40:53 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:40:58 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:41:13 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:41:18 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:41:28 | 62 |\n",
       "| 8877689391 | 2016-05-12 14:41:38 | 60 |\n",
       "| 8877689391 | 2016-05-12 14:41:43 | 59 |\n",
       "| 8877689391 | 2016-05-12 14:41:48 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:41:58 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:42:03 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:42:08 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:42:13 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:42:28 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:42:33 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:42:43 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:42:58 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:43:13 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:43:18 | 58 |\n",
       "| 8877689391 | 2016-05-12 14:43:23 | 59 |\n",
       "| 8877689391 | 2016-05-12 14:43:38 | 58 |\n",
       "| 8877689391 | 2016-05-12 14:43:53 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:43:58 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:44:03 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:44:18 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:44:28 | 56 |\n",
       "\n"
      ],
      "text/plain": [
       "        Id         Time                Value\n",
       "1       2022484408 2016-04-12 07:21:00  97  \n",
       "2       2022484408 2016-04-12 07:21:05 102  \n",
       "3       2022484408 2016-04-12 07:21:10 105  \n",
       "4       2022484408 2016-04-12 07:21:20 103  \n",
       "5       2022484408 2016-04-12 07:21:25 101  \n",
       "6       2022484408 2016-04-12 07:22:05  95  \n",
       "7       2022484408 2016-04-12 07:22:10  91  \n",
       "8       2022484408 2016-04-12 07:22:15  93  \n",
       "9       2022484408 2016-04-12 07:22:20  94  \n",
       "10      2022484408 2016-04-12 07:22:25  93  \n",
       "11      2022484408 2016-04-12 07:22:35  92  \n",
       "12      2022484408 2016-04-12 07:22:40  89  \n",
       "13      2022484408 2016-04-12 07:22:50  83  \n",
       "14      2022484408 2016-04-12 07:22:55  61  \n",
       "15      2022484408 2016-04-12 07:23:00  60  \n",
       "16      2022484408 2016-04-12 07:23:10  61  \n",
       "17      2022484408 2016-04-12 07:23:25  61  \n",
       "18      2022484408 2016-04-12 07:23:30  57  \n",
       "19      2022484408 2016-04-12 07:23:40  54  \n",
       "20      2022484408 2016-04-12 07:23:50  55  \n",
       "21      2022484408 2016-04-12 07:24:00  58  \n",
       "22      2022484408 2016-04-12 07:24:10  60  \n",
       "23      2022484408 2016-04-12 07:24:20  59  \n",
       "24      2022484408 2016-04-12 07:24:30  57  \n",
       "25      2022484408 2016-04-12 07:24:40  56  \n",
       "26      2022484408 2016-04-12 07:24:50  58  \n",
       "27      2022484408 2016-04-12 07:25:05  57  \n",
       "28      2022484408 2016-04-12 07:25:10  58  \n",
       "29      2022484408 2016-04-12 07:25:15  60  \n",
       "30      2022484408 2016-04-12 07:25:20  60  \n",
       "⋮       ⋮          ⋮                   ⋮    \n",
       "2483629 8877689391 2016-05-12 14:40:23 56   \n",
       "2483630 8877689391 2016-05-12 14:40:33 57   \n",
       "2483631 8877689391 2016-05-12 14:40:38 56   \n",
       "2483632 8877689391 2016-05-12 14:40:43 58   \n",
       "2483633 8877689391 2016-05-12 14:40:48 56   \n",
       "2483634 8877689391 2016-05-12 14:40:53 55   \n",
       "2483635 8877689391 2016-05-12 14:40:58 55   \n",
       "2483636 8877689391 2016-05-12 14:41:13 55   \n",
       "2483637 8877689391 2016-05-12 14:41:18 56   \n",
       "2483638 8877689391 2016-05-12 14:41:28 62   \n",
       "2483639 8877689391 2016-05-12 14:41:38 60   \n",
       "2483640 8877689391 2016-05-12 14:41:43 59   \n",
       "2483641 8877689391 2016-05-12 14:41:48 57   \n",
       "2483642 8877689391 2016-05-12 14:41:58 56   \n",
       "2483643 8877689391 2016-05-12 14:42:03 57   \n",
       "2483644 8877689391 2016-05-12 14:42:08 55   \n",
       "2483645 8877689391 2016-05-12 14:42:13 55   \n",
       "2483646 8877689391 2016-05-12 14:42:28 55   \n",
       "2483647 8877689391 2016-05-12 14:42:33 56   \n",
       "2483648 8877689391 2016-05-12 14:42:43 57   \n",
       "2483649 8877689391 2016-05-12 14:42:58 57   \n",
       "2483650 8877689391 2016-05-12 14:43:13 57   \n",
       "2483651 8877689391 2016-05-12 14:43:18 58   \n",
       "2483652 8877689391 2016-05-12 14:43:23 59   \n",
       "2483653 8877689391 2016-05-12 14:43:38 58   \n",
       "2483654 8877689391 2016-05-12 14:43:53 57   \n",
       "2483655 8877689391 2016-05-12 14:43:58 56   \n",
       "2483656 8877689391 2016-05-12 14:44:03 55   \n",
       "2483657 8877689391 2016-05-12 14:44:18 55   \n",
       "2483658 8877689391 2016-05-12 14:44:28 56   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# group by Time and define the mean of each hour\n",
    "heart_rate %>%\n",
    "  group_by()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "b45ace07",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:24.359182Z",
     "iopub.status.busy": "2023-04-11T20:25:24.357548Z",
     "iopub.status.idle": "2023-04-11T20:25:24.414396Z",
     "shell.execute_reply": "2023-04-11T20:25:24.412582Z"
    },
    "papermill": {
     "duration": 0.074034,
     "end_time": "2023-04-11T20:25:24.416921",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.342887",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2483658 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>Time</th><th scope=col>Value</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:00</td><td> 97</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:05</td><td>102</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:10</td><td>105</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:20</td><td>103</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:21:25</td><td>101</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:05</td><td> 95</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:10</td><td> 91</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:15</td><td> 93</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:20</td><td> 94</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:25</td><td> 93</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:35</td><td> 92</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:40</td><td> 89</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:50</td><td> 83</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:22:55</td><td> 61</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:00</td><td> 60</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:10</td><td> 61</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:25</td><td> 61</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:30</td><td> 57</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:40</td><td> 54</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:23:50</td><td> 55</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:00</td><td> 58</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:10</td><td> 60</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:20</td><td> 59</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:30</td><td> 57</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:40</td><td> 56</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:24:50</td><td> 58</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:05</td><td> 57</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:10</td><td> 58</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:15</td><td> 60</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:25:20</td><td> 60</td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:23</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:33</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:38</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:43</td><td>58</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:48</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:53</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:40:58</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:13</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:18</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:28</td><td>62</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:38</td><td>60</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:43</td><td>59</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:48</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:41:58</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:03</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:08</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:13</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:28</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:33</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:43</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:42:58</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:13</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:18</td><td>58</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:23</td><td>59</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:38</td><td>58</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:53</td><td>57</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:43:58</td><td>56</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:44:03</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:44:18</td><td>55</td></tr>\n",
       "\t<tr><td>8877689391</td><td>2016-05-12 14:44:28</td><td>56</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2483658 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & Time & Value\\\\\n",
       " <dbl> & <dttm> & <int>\\\\\n",
       "\\hline\n",
       "\t 2022484408 & 2016-04-12 07:21:00 &  97\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:05 & 102\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:10 & 105\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:20 & 103\\\\\n",
       "\t 2022484408 & 2016-04-12 07:21:25 & 101\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:05 &  95\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:10 &  91\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:15 &  93\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:20 &  94\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:25 &  93\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:35 &  92\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:40 &  89\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:50 &  83\\\\\n",
       "\t 2022484408 & 2016-04-12 07:22:55 &  61\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:00 &  60\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:10 &  61\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:25 &  61\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:30 &  57\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:40 &  54\\\\\n",
       "\t 2022484408 & 2016-04-12 07:23:50 &  55\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:00 &  58\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:10 &  60\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:20 &  59\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:30 &  57\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:40 &  56\\\\\n",
       "\t 2022484408 & 2016-04-12 07:24:50 &  58\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:05 &  57\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:10 &  58\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:15 &  60\\\\\n",
       "\t 2022484408 & 2016-04-12 07:25:20 &  60\\\\\n",
       "\t ⋮ & ⋮ & ⋮\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:23 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:33 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:38 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:43 & 58\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:48 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:53 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:40:58 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:13 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:18 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:28 & 62\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:38 & 60\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:43 & 59\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:48 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:41:58 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:03 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:08 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:13 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:28 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:33 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:43 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:42:58 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:13 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:18 & 58\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:23 & 59\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:38 & 58\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:53 & 57\\\\\n",
       "\t 8877689391 & 2016-05-12 14:43:58 & 56\\\\\n",
       "\t 8877689391 & 2016-05-12 14:44:03 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:44:18 & 55\\\\\n",
       "\t 8877689391 & 2016-05-12 14:44:28 & 56\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2483658 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | Time &lt;dttm&gt; | Value &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| 2022484408 | 2016-04-12 07:21:00 |  97 |\n",
       "| 2022484408 | 2016-04-12 07:21:05 | 102 |\n",
       "| 2022484408 | 2016-04-12 07:21:10 | 105 |\n",
       "| 2022484408 | 2016-04-12 07:21:20 | 103 |\n",
       "| 2022484408 | 2016-04-12 07:21:25 | 101 |\n",
       "| 2022484408 | 2016-04-12 07:22:05 |  95 |\n",
       "| 2022484408 | 2016-04-12 07:22:10 |  91 |\n",
       "| 2022484408 | 2016-04-12 07:22:15 |  93 |\n",
       "| 2022484408 | 2016-04-12 07:22:20 |  94 |\n",
       "| 2022484408 | 2016-04-12 07:22:25 |  93 |\n",
       "| 2022484408 | 2016-04-12 07:22:35 |  92 |\n",
       "| 2022484408 | 2016-04-12 07:22:40 |  89 |\n",
       "| 2022484408 | 2016-04-12 07:22:50 |  83 |\n",
       "| 2022484408 | 2016-04-12 07:22:55 |  61 |\n",
       "| 2022484408 | 2016-04-12 07:23:00 |  60 |\n",
       "| 2022484408 | 2016-04-12 07:23:10 |  61 |\n",
       "| 2022484408 | 2016-04-12 07:23:25 |  61 |\n",
       "| 2022484408 | 2016-04-12 07:23:30 |  57 |\n",
       "| 2022484408 | 2016-04-12 07:23:40 |  54 |\n",
       "| 2022484408 | 2016-04-12 07:23:50 |  55 |\n",
       "| 2022484408 | 2016-04-12 07:24:00 |  58 |\n",
       "| 2022484408 | 2016-04-12 07:24:10 |  60 |\n",
       "| 2022484408 | 2016-04-12 07:24:20 |  59 |\n",
       "| 2022484408 | 2016-04-12 07:24:30 |  57 |\n",
       "| 2022484408 | 2016-04-12 07:24:40 |  56 |\n",
       "| 2022484408 | 2016-04-12 07:24:50 |  58 |\n",
       "| 2022484408 | 2016-04-12 07:25:05 |  57 |\n",
       "| 2022484408 | 2016-04-12 07:25:10 |  58 |\n",
       "| 2022484408 | 2016-04-12 07:25:15 |  60 |\n",
       "| 2022484408 | 2016-04-12 07:25:20 |  60 |\n",
       "| ⋮ | ⋮ | ⋮ |\n",
       "| 8877689391 | 2016-05-12 14:40:23 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:40:33 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:40:38 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:40:43 | 58 |\n",
       "| 8877689391 | 2016-05-12 14:40:48 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:40:53 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:40:58 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:41:13 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:41:18 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:41:28 | 62 |\n",
       "| 8877689391 | 2016-05-12 14:41:38 | 60 |\n",
       "| 8877689391 | 2016-05-12 14:41:43 | 59 |\n",
       "| 8877689391 | 2016-05-12 14:41:48 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:41:58 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:42:03 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:42:08 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:42:13 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:42:28 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:42:33 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:42:43 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:42:58 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:43:13 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:43:18 | 58 |\n",
       "| 8877689391 | 2016-05-12 14:43:23 | 59 |\n",
       "| 8877689391 | 2016-05-12 14:43:38 | 58 |\n",
       "| 8877689391 | 2016-05-12 14:43:53 | 57 |\n",
       "| 8877689391 | 2016-05-12 14:43:58 | 56 |\n",
       "| 8877689391 | 2016-05-12 14:44:03 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:44:18 | 55 |\n",
       "| 8877689391 | 2016-05-12 14:44:28 | 56 |\n",
       "\n"
      ],
      "text/plain": [
       "        Id         Time                Value\n",
       "1       2022484408 2016-04-12 07:21:00  97  \n",
       "2       2022484408 2016-04-12 07:21:05 102  \n",
       "3       2022484408 2016-04-12 07:21:10 105  \n",
       "4       2022484408 2016-04-12 07:21:20 103  \n",
       "5       2022484408 2016-04-12 07:21:25 101  \n",
       "6       2022484408 2016-04-12 07:22:05  95  \n",
       "7       2022484408 2016-04-12 07:22:10  91  \n",
       "8       2022484408 2016-04-12 07:22:15  93  \n",
       "9       2022484408 2016-04-12 07:22:20  94  \n",
       "10      2022484408 2016-04-12 07:22:25  93  \n",
       "11      2022484408 2016-04-12 07:22:35  92  \n",
       "12      2022484408 2016-04-12 07:22:40  89  \n",
       "13      2022484408 2016-04-12 07:22:50  83  \n",
       "14      2022484408 2016-04-12 07:22:55  61  \n",
       "15      2022484408 2016-04-12 07:23:00  60  \n",
       "16      2022484408 2016-04-12 07:23:10  61  \n",
       "17      2022484408 2016-04-12 07:23:25  61  \n",
       "18      2022484408 2016-04-12 07:23:30  57  \n",
       "19      2022484408 2016-04-12 07:23:40  54  \n",
       "20      2022484408 2016-04-12 07:23:50  55  \n",
       "21      2022484408 2016-04-12 07:24:00  58  \n",
       "22      2022484408 2016-04-12 07:24:10  60  \n",
       "23      2022484408 2016-04-12 07:24:20  59  \n",
       "24      2022484408 2016-04-12 07:24:30  57  \n",
       "25      2022484408 2016-04-12 07:24:40  56  \n",
       "26      2022484408 2016-04-12 07:24:50  58  \n",
       "27      2022484408 2016-04-12 07:25:05  57  \n",
       "28      2022484408 2016-04-12 07:25:10  58  \n",
       "29      2022484408 2016-04-12 07:25:15  60  \n",
       "30      2022484408 2016-04-12 07:25:20  60  \n",
       "⋮       ⋮          ⋮                   ⋮    \n",
       "2483629 8877689391 2016-05-12 14:40:23 56   \n",
       "2483630 8877689391 2016-05-12 14:40:33 57   \n",
       "2483631 8877689391 2016-05-12 14:40:38 56   \n",
       "2483632 8877689391 2016-05-12 14:40:43 58   \n",
       "2483633 8877689391 2016-05-12 14:40:48 56   \n",
       "2483634 8877689391 2016-05-12 14:40:53 55   \n",
       "2483635 8877689391 2016-05-12 14:40:58 55   \n",
       "2483636 8877689391 2016-05-12 14:41:13 55   \n",
       "2483637 8877689391 2016-05-12 14:41:18 56   \n",
       "2483638 8877689391 2016-05-12 14:41:28 62   \n",
       "2483639 8877689391 2016-05-12 14:41:38 60   \n",
       "2483640 8877689391 2016-05-12 14:41:43 59   \n",
       "2483641 8877689391 2016-05-12 14:41:48 57   \n",
       "2483642 8877689391 2016-05-12 14:41:58 56   \n",
       "2483643 8877689391 2016-05-12 14:42:03 57   \n",
       "2483644 8877689391 2016-05-12 14:42:08 55   \n",
       "2483645 8877689391 2016-05-12 14:42:13 55   \n",
       "2483646 8877689391 2016-05-12 14:42:28 55   \n",
       "2483647 8877689391 2016-05-12 14:42:33 56   \n",
       "2483648 8877689391 2016-05-12 14:42:43 57   \n",
       "2483649 8877689391 2016-05-12 14:42:58 57   \n",
       "2483650 8877689391 2016-05-12 14:43:13 57   \n",
       "2483651 8877689391 2016-05-12 14:43:18 58   \n",
       "2483652 8877689391 2016-05-12 14:43:23 59   \n",
       "2483653 8877689391 2016-05-12 14:43:38 58   \n",
       "2483654 8877689391 2016-05-12 14:43:53 57   \n",
       "2483655 8877689391 2016-05-12 14:43:58 56   \n",
       "2483656 8877689391 2016-05-12 14:44:03 55   \n",
       "2483657 8877689391 2016-05-12 14:44:18 55   \n",
       "2483658 8877689391 2016-05-12 14:44:28 56   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_rate"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "76531d4f",
   "metadata": {
    "papermill": {
     "duration": 0.013416,
     "end_time": "2023-04-11T20:25:24.443787",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.430371",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Test:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "0941460b",
   "metadata": {
    "papermill": {
     "duration": 0.01399,
     "end_time": "2023-04-11T20:25:24.471033",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.457043",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "markdown",
   "id": "8095ea36",
   "metadata": {
    "papermill": {
     "duration": 0.014155,
     "end_time": "2023-04-11T20:25:24.499066",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.484911",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Issue 3\n",
    "> Data spread out in multiple data frames.\n",
    "\n",
    "**Define:** merge daily_activity and sleep_day data frames. Make another merge containing the hourly_cal, hourly_intensity, hourly_step and heart_rate data frames.\n",
    "**Code:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "06bc58fc",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-11T20:25:24.529375Z",
     "iopub.status.busy": "2023-04-11T20:25:24.527695Z",
     "iopub.status.idle": "2023-04-11T20:25:24.540517Z",
     "shell.execute_reply": "2023-04-11T20:25:24.538681Z"
    },
    "papermill": {
     "duration": 0.030614,
     "end_time": "2023-04-11T20:25:24.542942",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.512328",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "\n",
    "# Determine which data sets you can merge and merge them\n",
    "# you might merge sleep data with daily activity \n",
    "# you might merge heart rate with hourly data (make an analysis of the time)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "05ecd777",
   "metadata": {
    "papermill": {
     "duration": 0.013152,
     "end_time": "2023-04-11T20:25:24.570433",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.557281",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Test:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "1e2ea1a4",
   "metadata": {
    "papermill": {
     "duration": 0.013658,
     "end_time": "2023-04-11T20:25:24.597336",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.583678",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "markdown",
   "id": "a60f9c03",
   "metadata": {
    "papermill": {
     "duration": 0.013156,
     "end_time": "2023-04-11T20:25:24.623760",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.610604",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Analyzing and Visualizing Data\n",
    "\n",
    "> text"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "085db5df",
   "metadata": {
    "papermill": {
     "duration": 0.013312,
     "end_time": "2023-04-11T20:25:24.650327",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.637015",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "2fcb4ccc",
   "metadata": {
    "papermill": {
     "duration": 0.013166,
     "end_time": "2023-04-11T20:25:24.676873",
     "exception": false,
     "start_time": "2023-04-11T20:25:24.663707",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 17.292996,
   "end_time": "2023-04-11T20:25:24.811903",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-04-11T20:25:07.518907",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
