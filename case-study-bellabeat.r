{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "476359fa",
   "metadata": {
    "papermill": {
     "duration": 0.012238,
     "end_time": "2023-04-13T22:07:21.675801",
     "exception": false,
     "start_time": "2023-04-13T22:07:21.663563",
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
   "id": "eebee4e5",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:21.701843Z",
     "iopub.status.busy": "2023-04-13T22:07:21.699780Z",
     "iopub.status.idle": "2023-04-13T22:07:22.809037Z",
     "shell.execute_reply": "2023-04-13T22:07:22.806856Z"
    },
    "papermill": {
     "duration": 1.124743,
     "end_time": "2023-04-13T22:07:22.811493",
     "exception": false,
     "start_time": "2023-04-13T22:07:21.686750",
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
   "id": "35dc2cc7",
   "metadata": {
    "papermill": {
     "duration": 0.011015,
     "end_time": "2023-04-13T22:07:22.834581",
     "exception": false,
     "start_time": "2023-04-13T22:07:22.823566",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Data Gathering\n",
    "\n",
    "The dataset Fitbit Fitness Tracker Data used in this analysis is on [Kaggle](https://www.kaggle.com/datasets/arashnic/fitbit). It was made available by Mobius and comprises the data of 30 Fitbit users. We will be working with daily activity, heart rate, and sleep data. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "02e44ea3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:22.888207Z",
     "iopub.status.busy": "2023-04-13T22:07:22.858682Z",
     "iopub.status.idle": "2023-04-13T22:07:30.243817Z",
     "shell.execute_reply": "2023-04-13T22:07:30.242078Z"
    },
    "papermill": {
     "duration": 7.400725,
     "end_time": "2023-04-13T22:07:30.246488",
     "exception": false,
     "start_time": "2023-04-13T22:07:22.845763",
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
   "id": "1b6190e7",
   "metadata": {
    "papermill": {
     "duration": 0.011154,
     "end_time": "2023-04-13T22:07:30.269282",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.258128",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Data Assessment\n",
    "\n",
    "I will assess each data frame in order to point out the issues to be solved in the cleaning stage."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0b9255cf",
   "metadata": {
    "papermill": {
     "duration": 0.01101,
     "end_time": "2023-04-13T22:07:30.291224",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.280214",
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
   "id": "15603e95",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.317064Z",
     "iopub.status.busy": "2023-04-13T22:07:30.315668Z",
     "iopub.status.idle": "2023-04-13T22:07:30.364027Z",
     "shell.execute_reply": "2023-04-13T22:07:30.362326Z"
    },
    "papermill": {
     "duration": 0.063878,
     "end_time": "2023-04-13T22:07:30.366210",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.302332",
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
   "id": "3221bef9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.392485Z",
     "iopub.status.busy": "2023-04-13T22:07:30.391057Z",
     "iopub.status.idle": "2023-04-13T22:07:30.455839Z",
     "shell.execute_reply": "2023-04-13T22:07:30.453832Z"
    },
    "papermill": {
     "duration": 0.08099,
     "end_time": "2023-04-13T22:07:30.458569",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.377579",
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
   "cell_type": "code",
   "execution_count": 5,
   "id": "7a91585e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.484985Z",
     "iopub.status.busy": "2023-04-13T22:07:30.483377Z",
     "iopub.status.idle": "2023-04-13T22:07:30.506423Z",
     "shell.execute_reply": "2023-04-13T22:07:30.504084Z"
    },
    "papermill": {
     "duration": 0.039786,
     "end_time": "2023-04-13T22:07:30.509784",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.469998",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "33"
      ],
      "text/latex": [
       "33"
      ],
      "text/markdown": [
       "33"
      ],
      "text/plain": [
       "[1] 33"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Number of dintinct Id's\n",
    "n_distinct(daily_activity$Id)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dd65c30e",
   "metadata": {
    "papermill": {
     "duration": 0.011381,
     "end_time": "2023-04-13T22:07:30.532645",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.521264",
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
   "execution_count": 6,
   "id": "0f65fc70",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.559677Z",
     "iopub.status.busy": "2023-04-13T22:07:30.557831Z",
     "iopub.status.idle": "2023-04-13T22:07:30.605786Z",
     "shell.execute_reply": "2023-04-13T22:07:30.603631Z"
    },
    "papermill": {
     "duration": 0.064682,
     "end_time": "2023-04-13T22:07:30.608815",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.544133",
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
   "execution_count": 7,
   "id": "e70c8373",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.637042Z",
     "iopub.status.busy": "2023-04-13T22:07:30.634753Z",
     "iopub.status.idle": "2023-04-13T22:07:30.749340Z",
     "shell.execute_reply": "2023-04-13T22:07:30.660279Z"
    },
    "papermill": {
     "duration": 0.131977,
     "end_time": "2023-04-13T22:07:30.752675",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.620698",
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
   "cell_type": "code",
   "execution_count": 8,
   "id": "c330f550",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.780145Z",
     "iopub.status.busy": "2023-04-13T22:07:30.778662Z",
     "iopub.status.idle": "2023-04-13T22:07:30.796588Z",
     "shell.execute_reply": "2023-04-13T22:07:30.794594Z"
    },
    "papermill": {
     "duration": 0.034535,
     "end_time": "2023-04-13T22:07:30.799257",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.764722",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "24"
      ],
      "text/latex": [
       "24"
      ],
      "text/markdown": [
       "24"
      ],
      "text/plain": [
       "[1] 24"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Number of dintinct Id's\n",
    "n_distinct(sleep_day$Id)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fdf1aeff",
   "metadata": {
    "papermill": {
     "duration": 0.012066,
     "end_time": "2023-04-13T22:07:30.823435",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.811369",
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
   "execution_count": 9,
   "id": "0284a1a7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.850807Z",
     "iopub.status.busy": "2023-04-13T22:07:30.849267Z",
     "iopub.status.idle": "2023-04-13T22:07:30.887281Z",
     "shell.execute_reply": "2023-04-13T22:07:30.885565Z"
    },
    "papermill": {
     "duration": 0.055342,
     "end_time": "2023-04-13T22:07:30.890759",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.835417",
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
   "execution_count": 10,
   "id": "b74bfbdf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.931464Z",
     "iopub.status.busy": "2023-04-13T22:07:30.928846Z",
     "iopub.status.idle": "2023-04-13T22:07:30.955634Z",
     "shell.execute_reply": "2023-04-13T22:07:30.953349Z"
    },
    "papermill": {
     "duration": 0.048452,
     "end_time": "2023-04-13T22:07:30.958344",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.909892",
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
   "cell_type": "code",
   "execution_count": 11,
   "id": "eefa5f77",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:30.992362Z",
     "iopub.status.busy": "2023-04-13T22:07:30.990798Z",
     "iopub.status.idle": "2023-04-13T22:07:31.008445Z",
     "shell.execute_reply": "2023-04-13T22:07:31.006845Z"
    },
    "papermill": {
     "duration": 0.034621,
     "end_time": "2023-04-13T22:07:31.010892",
     "exception": false,
     "start_time": "2023-04-13T22:07:30.976271",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "33"
      ],
      "text/latex": [
       "33"
      ],
      "text/markdown": [
       "33"
      ],
      "text/plain": [
       "[1] 33"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Number of dintinct Id's\n",
    "n_distinct(hourly_cal$Id)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4ed61df2",
   "metadata": {
    "papermill": {
     "duration": 0.012629,
     "end_time": "2023-04-13T22:07:31.036377",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.023748",
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
   "execution_count": 12,
   "id": "f15d7b6b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.065383Z",
     "iopub.status.busy": "2023-04-13T22:07:31.063904Z",
     "iopub.status.idle": "2023-04-13T22:07:31.098914Z",
     "shell.execute_reply": "2023-04-13T22:07:31.097274Z"
    },
    "papermill": {
     "duration": 0.052059,
     "end_time": "2023-04-13T22:07:31.101160",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.049101",
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
   "execution_count": 13,
   "id": "4601ecb3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.131498Z",
     "iopub.status.busy": "2023-04-13T22:07:31.129984Z",
     "iopub.status.idle": "2023-04-13T22:07:31.153877Z",
     "shell.execute_reply": "2023-04-13T22:07:31.152249Z"
    },
    "papermill": {
     "duration": 0.041283,
     "end_time": "2023-04-13T22:07:31.156213",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.114930",
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
   "id": "f3947705",
   "metadata": {
    "papermill": {
     "duration": 0.01344,
     "end_time": "2023-04-13T22:07:31.182976",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.169536",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The column `AverageIntensity` presents the `TotalIntensity` divided by 60, i.e. it computes the activity intensity per minute."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "43d0c468",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.213253Z",
     "iopub.status.busy": "2023-04-13T22:07:31.211749Z",
     "iopub.status.idle": "2023-04-13T22:07:31.231232Z",
     "shell.execute_reply": "2023-04-13T22:07:31.229120Z"
    },
    "papermill": {
     "duration": 0.037666,
     "end_time": "2023-04-13T22:07:31.234004",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.196338",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "33"
      ],
      "text/latex": [
       "33"
      ],
      "text/markdown": [
       "33"
      ],
      "text/plain": [
       "[1] 33"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Number of dintinct Id's\n",
    "n_distinct(hourly_intensity$Id)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6b009e67",
   "metadata": {
    "papermill": {
     "duration": 0.013324,
     "end_time": "2023-04-13T22:07:31.260782",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.247458",
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
   "execution_count": 15,
   "id": "1277d756",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.292037Z",
     "iopub.status.busy": "2023-04-13T22:07:31.290447Z",
     "iopub.status.idle": "2023-04-13T22:07:31.390916Z",
     "shell.execute_reply": "2023-04-13T22:07:31.389156Z"
    },
    "papermill": {
     "duration": 0.118633,
     "end_time": "2023-04-13T22:07:31.393557",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.274924",
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
   "execution_count": 16,
   "id": "62f3e581",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.425007Z",
     "iopub.status.busy": "2023-04-13T22:07:31.423522Z",
     "iopub.status.idle": "2023-04-13T22:07:31.446048Z",
     "shell.execute_reply": "2023-04-13T22:07:31.443769Z"
    },
    "papermill": {
     "duration": 0.041141,
     "end_time": "2023-04-13T22:07:31.448847",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.407706",
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
   "cell_type": "code",
   "execution_count": 17,
   "id": "0833d8b1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.479935Z",
     "iopub.status.busy": "2023-04-13T22:07:31.478446Z",
     "iopub.status.idle": "2023-04-13T22:07:31.497441Z",
     "shell.execute_reply": "2023-04-13T22:07:31.495382Z"
    },
    "papermill": {
     "duration": 0.037466,
     "end_time": "2023-04-13T22:07:31.500145",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.462679",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "33"
      ],
      "text/latex": [
       "33"
      ],
      "text/markdown": [
       "33"
      ],
      "text/plain": [
       "[1] 33"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Number of dintinct Id's\n",
    "n_distinct(hourly_step$Id)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "90915469",
   "metadata": {
    "papermill": {
     "duration": 0.048443,
     "end_time": "2023-04-13T22:07:31.562460",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.514017",
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
   "execution_count": 18,
   "id": "5cd0aec3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.593850Z",
     "iopub.status.busy": "2023-04-13T22:07:31.592332Z",
     "iopub.status.idle": "2023-04-13T22:07:31.629570Z",
     "shell.execute_reply": "2023-04-13T22:07:31.627795Z"
    },
    "papermill": {
     "duration": 0.055997,
     "end_time": "2023-04-13T22:07:31.632276",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.576279",
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
   "execution_count": 19,
   "id": "587899ac",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.664154Z",
     "iopub.status.busy": "2023-04-13T22:07:31.662650Z",
     "iopub.status.idle": "2023-04-13T22:07:31.818789Z",
     "shell.execute_reply": "2023-04-13T22:07:31.816652Z"
    },
    "papermill": {
     "duration": 0.175012,
     "end_time": "2023-04-13T22:07:31.821587",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.646575",
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
   "cell_type": "code",
   "execution_count": 20,
   "id": "102f7d72",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:31.853761Z",
     "iopub.status.busy": "2023-04-13T22:07:31.852274Z",
     "iopub.status.idle": "2023-04-13T22:07:32.009395Z",
     "shell.execute_reply": "2023-04-13T22:07:32.007232Z"
    },
    "papermill": {
     "duration": 0.176425,
     "end_time": "2023-04-13T22:07:32.012284",
     "exception": false,
     "start_time": "2023-04-13T22:07:31.835859",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "14"
      ],
      "text/latex": [
       "14"
      ],
      "text/markdown": [
       "14"
      ],
      "text/plain": [
       "[1] 14"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Number of dintinct Id's\n",
    "n_distinct(heart_rate$Id)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f0c1e15d",
   "metadata": {
    "papermill": {
     "duration": 0.014407,
     "end_time": "2023-04-13T22:07:32.041056",
     "exception": false,
     "start_time": "2023-04-13T22:07:32.026649",
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
    "> **Issue 3:** data spread out in multiple data frames when they could be combined in an hourly basis and a daily basis.\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "189fd70b",
   "metadata": {
    "papermill": {
     "duration": 0.014136,
     "end_time": "2023-04-13T22:07:32.069694",
     "exception": false,
     "start_time": "2023-04-13T22:07:32.055558",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Data Cleaning\n",
    "\n",
    "Here I will document the cleaning process with define-code-test framework. At first, I determine how I can solve the issue. Following that, I apply the coding solution and test to verify the results."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d1cc28b2",
   "metadata": {
    "papermill": {
     "duration": 0.014192,
     "end_time": "2023-04-13T22:07:32.098080",
     "exception": false,
     "start_time": "2023-04-13T22:07:32.083888",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Issue 1\n",
    "In all data frames, the columns containing date and time are in the `character` data type.\n",
    "\n",
    "**Define:** convert these columns from character data type to date and time data types using `mdy()` and `mdy_hms()` functions from `lubridate` package.\n",
    "\n",
    "**Code:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "fc1802bf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:32.130632Z",
     "iopub.status.busy": "2023-04-13T22:07:32.129134Z",
     "iopub.status.idle": "2023-04-13T22:07:32.154508Z",
     "shell.execute_reply": "2023-04-13T22:07:32.152821Z"
    },
    "papermill": {
     "duration": 0.044385,
     "end_time": "2023-04-13T22:07:32.156688",
     "exception": false,
     "start_time": "2023-04-13T22:07:32.112303",
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
   "execution_count": 22,
   "id": "39c13daa",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:32.188848Z",
     "iopub.status.busy": "2023-04-13T22:07:32.187376Z",
     "iopub.status.idle": "2023-04-13T22:07:32.210284Z",
     "shell.execute_reply": "2023-04-13T22:07:32.208581Z"
    },
    "papermill": {
     "duration": 0.041529,
     "end_time": "2023-04-13T22:07:32.212550",
     "exception": false,
     "start_time": "2023-04-13T22:07:32.171021",
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
   "execution_count": 23,
   "id": "9f32e687",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:32.245638Z",
     "iopub.status.busy": "2023-04-13T22:07:32.243921Z",
     "iopub.status.idle": "2023-04-13T22:07:33.827458Z",
     "shell.execute_reply": "2023-04-13T22:07:33.825448Z"
    },
    "papermill": {
     "duration": 1.602953,
     "end_time": "2023-04-13T22:07:33.829870",
     "exception": false,
     "start_time": "2023-04-13T22:07:32.226917",
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
   "id": "8285cb78",
   "metadata": {
    "papermill": {
     "duration": 0.014717,
     "end_time": "2023-04-13T22:07:33.859533",
     "exception": false,
     "start_time": "2023-04-13T22:07:33.844816",
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
   "execution_count": 24,
   "id": "78733c5d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:33.892233Z",
     "iopub.status.busy": "2023-04-13T22:07:33.890765Z",
     "iopub.status.idle": "2023-04-13T22:07:33.912890Z",
     "shell.execute_reply": "2023-04-13T22:07:33.910913Z"
    },
    "papermill": {
     "duration": 0.040856,
     "end_time": "2023-04-13T22:07:33.915115",
     "exception": false,
     "start_time": "2023-04-13T22:07:33.874259",
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
   "execution_count": 25,
   "id": "06229b4a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:33.947455Z",
     "iopub.status.busy": "2023-04-13T22:07:33.946052Z",
     "iopub.status.idle": "2023-04-13T22:07:33.963778Z",
     "shell.execute_reply": "2023-04-13T22:07:33.961611Z"
    },
    "papermill": {
     "duration": 0.036606,
     "end_time": "2023-04-13T22:07:33.966212",
     "exception": false,
     "start_time": "2023-04-13T22:07:33.929606",
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
   "execution_count": 26,
   "id": "e3e0b345",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:33.999139Z",
     "iopub.status.busy": "2023-04-13T22:07:33.997664Z",
     "iopub.status.idle": "2023-04-13T22:07:34.019709Z",
     "shell.execute_reply": "2023-04-13T22:07:34.017509Z"
    },
    "papermill": {
     "duration": 0.041453,
     "end_time": "2023-04-13T22:07:34.022460",
     "exception": false,
     "start_time": "2023-04-13T22:07:33.981007",
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
   "execution_count": 27,
   "id": "2e6d2dc0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:34.055798Z",
     "iopub.status.busy": "2023-04-13T22:07:34.054350Z",
     "iopub.status.idle": "2023-04-13T22:07:34.075412Z",
     "shell.execute_reply": "2023-04-13T22:07:34.073323Z"
    },
    "papermill": {
     "duration": 0.041034,
     "end_time": "2023-04-13T22:07:34.078291",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.037257",
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
   "execution_count": 28,
   "id": "5a1a84b3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:34.112612Z",
     "iopub.status.busy": "2023-04-13T22:07:34.111211Z",
     "iopub.status.idle": "2023-04-13T22:07:34.133306Z",
     "shell.execute_reply": "2023-04-13T22:07:34.131335Z"
    },
    "papermill": {
     "duration": 0.042142,
     "end_time": "2023-04-13T22:07:34.136151",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.094009",
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
   "execution_count": 29,
   "id": "9d8aded6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:34.170789Z",
     "iopub.status.busy": "2023-04-13T22:07:34.169230Z",
     "iopub.status.idle": "2023-04-13T22:07:34.191646Z",
     "shell.execute_reply": "2023-04-13T22:07:34.189477Z"
    },
    "papermill": {
     "duration": 0.042665,
     "end_time": "2023-04-13T22:07:34.194555",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.151890",
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
   "id": "cb1b5806",
   "metadata": {
    "papermill": {
     "duration": 0.014885,
     "end_time": "2023-04-13T22:07:34.224391",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.209506",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Issue 2\n",
    "The observations in the `heart_rate` data frame were registered every few seconds. It is not suitable to compare it in this format with the other data frames that present time data on a daily or an hourly basis.\n",
    "\n",
    "**Define:** group the observartions by hour and get the mean heart rate of each hour.\n",
    "\n",
    "**Code:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "f857a012",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:34.258107Z",
     "iopub.status.busy": "2023-04-13T22:07:34.256545Z",
     "iopub.status.idle": "2023-04-13T22:07:34.746533Z",
     "shell.execute_reply": "2023-04-13T22:07:34.744579Z"
    },
    "papermill": {
     "duration": 0.509467,
     "end_time": "2023-04-13T22:07:34.748983",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.239516",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    }
   ],
   "source": [
    "# Create a data frame with the users' mean heart rate per hour\n",
    "hourly_hrate <-\n",
    "  heart_rate %>%\n",
    "  group_by(Id, time=floor_date(Time, '1 hour')) %>%\n",
    "  summarize(mean_hrate=round(mean(Value)))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8d26b8db",
   "metadata": {
    "papermill": {
     "duration": 0.014964,
     "end_time": "2023-04-13T22:07:34.779111",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.764147",
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
   "execution_count": 31,
   "id": "7b45cfd8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:34.812586Z",
     "iopub.status.busy": "2023-04-13T22:07:34.810774Z",
     "iopub.status.idle": "2023-04-13T22:07:34.845601Z",
     "shell.execute_reply": "2023-04-13T22:07:34.843548Z"
    },
    "papermill": {
     "duration": 0.054057,
     "end_time": "2023-04-13T22:07:34.848149",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.794092",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>time</th><th scope=col>mean_hrate</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 07:00:00</td><td> 83</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 08:00:00</td><td> 69</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 09:00:00</td><td> 66</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 10:00:00</td><td>107</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 11:00:00</td><td> 68</td></tr>\n",
       "\t<tr><td>2022484408</td><td>2016-04-12 12:00:00</td><td> 66</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & time & mean\\_hrate\\\\\n",
       " <dbl> & <dttm> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2022484408 & 2016-04-12 07:00:00 &  83\\\\\n",
       "\t 2022484408 & 2016-04-12 08:00:00 &  69\\\\\n",
       "\t 2022484408 & 2016-04-12 09:00:00 &  66\\\\\n",
       "\t 2022484408 & 2016-04-12 10:00:00 & 107\\\\\n",
       "\t 2022484408 & 2016-04-12 11:00:00 &  68\\\\\n",
       "\t 2022484408 & 2016-04-12 12:00:00 &  66\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | time &lt;dttm&gt; | mean_hrate &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2022484408 | 2016-04-12 07:00:00 |  83 |\n",
       "| 2022484408 | 2016-04-12 08:00:00 |  69 |\n",
       "| 2022484408 | 2016-04-12 09:00:00 |  66 |\n",
       "| 2022484408 | 2016-04-12 10:00:00 | 107 |\n",
       "| 2022484408 | 2016-04-12 11:00:00 |  68 |\n",
       "| 2022484408 | 2016-04-12 12:00:00 |  66 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         time                mean_hrate\n",
       "1 2022484408 2016-04-12 07:00:00  83       \n",
       "2 2022484408 2016-04-12 08:00:00  69       \n",
       "3 2022484408 2016-04-12 09:00:00  66       \n",
       "4 2022484408 2016-04-12 10:00:00 107       \n",
       "5 2022484408 2016-04-12 11:00:00  68       \n",
       "6 2022484408 2016-04-12 12:00:00  66       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# the 'mean_rate' column contains the average heart rate per hour\n",
    "head(hourly_hrate)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "56d281c6",
   "metadata": {
    "papermill": {
     "duration": 0.015214,
     "end_time": "2023-04-13T22:07:34.878642",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.863428",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Issue 3\n",
    "Data spread out in multiple data frames when they could be combined in an hourly basis and a daily basis.\n",
    "\n",
    "**Define:** Combine daily_activity and sleep_day data frames. Make another combination containing the hourly_cal, hourly_intensity, hourly_step and heart_rate data frames.\n",
    "\n",
    "**Code:**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 32,
   "id": "ac1304d7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:34.914319Z",
     "iopub.status.busy": "2023-04-13T22:07:34.912416Z",
     "iopub.status.idle": "2023-04-13T22:07:34.960944Z",
     "shell.execute_reply": "2023-04-13T22:07:34.958375Z"
    },
    "papermill": {
     "duration": 0.069649,
     "end_time": "2023-04-13T22:07:34.963590",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.893941",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Combine 'daily_activity' and 'sleep_day' data frames\n",
    "daily_combined <- left_join(daily_activity, sleep_day, by=c(\"Id\"=\"Id\",\"date\"=\"date\"), multiple = \"all\")\n",
    "\n",
    "# Drop duplicates\n",
    "daily_combined <- unique(daily_combined)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "id": "031d5df3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:34.998761Z",
     "iopub.status.busy": "2023-04-13T22:07:34.996367Z",
     "iopub.status.idle": "2023-04-13T22:07:35.104994Z",
     "shell.execute_reply": "2023-04-13T22:07:35.103214Z"
    },
    "papermill": {
     "duration": 0.128406,
     "end_time": "2023-04-13T22:07:35.107261",
     "exception": false,
     "start_time": "2023-04-13T22:07:34.978855",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Merge 'hourly_cal', 'hourly_intensity' and 'hourly_step' data frames\n",
    "hourly_combined <- list(hourly_cal, hourly_intensity, hourly_step) \n",
    "hourly_combined <- hourly_combined %>% reduce(inner_join, by= c(\"Id\",\"ActivityHour\"))\n",
    "\n",
    "# Merge the resulting data frame 'hourly_combined' with the 'hourly_hrate'\n",
    "hourly_combined <- left_join(hourly_combined, hourly_hrate, by=c(\"Id\"=\"Id\",\"ActivityHour\"=\"time\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5cb8ecdb",
   "metadata": {
    "papermill": {
     "duration": 0.015526,
     "end_time": "2023-04-13T22:07:35.139208",
     "exception": false,
     "start_time": "2023-04-13T22:07:35.123682",
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
   "execution_count": 34,
   "id": "fab60d5a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:35.173777Z",
     "iopub.status.busy": "2023-04-13T22:07:35.172216Z",
     "iopub.status.idle": "2023-04-13T22:07:35.205382Z",
     "shell.execute_reply": "2023-04-13T22:07:35.203687Z"
    },
    "papermill": {
     "duration": 0.05304,
     "end_time": "2023-04-13T22:07:35.207517",
     "exception": false,
     "start_time": "2023-04-13T22:07:35.154477",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 18</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>date</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>TotalSleepRecords</th><th scope=col>TotalMinutesAsleep</th><th scope=col>TotalTimeInBed</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>2016-04-12</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td><td> 1</td><td>327</td><td>346</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>2016-04-13</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td><td> 2</td><td>384</td><td>407</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>2016-04-14</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td><td>NA</td><td> NA</td><td> NA</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>2016-04-15</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td><td> 1</td><td>412</td><td>442</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>2016-04-16</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td><td> 2</td><td>340</td><td>367</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>2016-04-17</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td><td> 1</td><td>700</td><td>712</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 18\n",
       "\\begin{tabular}{r|llllllllllllllllll}\n",
       "  & Id & date & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories & TotalSleepRecords & TotalMinutesAsleep & TotalTimeInBed\\\\\n",
       "  & <dbl> & <date> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 2016-04-12 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985 &  1 & 327 & 346\\\\\n",
       "\t2 & 1503960366 & 2016-04-13 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797 &  2 & 384 & 407\\\\\n",
       "\t3 & 1503960366 & 2016-04-14 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776 & NA &  NA &  NA\\\\\n",
       "\t4 & 1503960366 & 2016-04-15 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745 &  1 & 412 & 442\\\\\n",
       "\t5 & 1503960366 & 2016-04-16 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863 &  2 & 340 & 367\\\\\n",
       "\t6 & 1503960366 & 2016-04-17 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728 &  1 & 700 & 712\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 18\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | date &lt;date&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | TotalSleepRecords &lt;int&gt; | TotalMinutesAsleep &lt;int&gt; | TotalTimeInBed &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 2016-04-12 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 |  1 | 327 | 346 |\n",
       "| 2 | 1503960366 | 2016-04-13 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 |  2 | 384 | 407 |\n",
       "| 3 | 1503960366 | 2016-04-14 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 | NA |  NA |  NA |\n",
       "| 4 | 1503960366 | 2016-04-15 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 |  1 | 412 | 442 |\n",
       "| 5 | 1503960366 | 2016-04-16 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 |  2 | 340 | 367 |\n",
       "| 6 | 1503960366 | 2016-04-17 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 |  1 | 700 | 712 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         date       TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 2016-04-12 13162      8.50          8.50           \n",
       "2 1503960366 2016-04-13 10735      6.97          6.97           \n",
       "3 1503960366 2016-04-14 10460      6.74          6.74           \n",
       "4 1503960366 2016-04-15  9762      6.28          6.28           \n",
       "5 1503960366 2016-04-16 12669      8.16          8.16           \n",
       "6 1503960366 2016-04-17  9705      6.48          6.48           \n",
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
       "6 20                  164                   539             1728    \n",
       "  TotalSleepRecords TotalMinutesAsleep TotalTimeInBed\n",
       "1  1                327                346           \n",
       "2  2                384                407           \n",
       "3 NA                 NA                 NA           \n",
       "4  1                412                442           \n",
       "5  2                340                367           \n",
       "6  1                700                712           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(daily_combined)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 35,
   "id": "cdb6ecaf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:35.241807Z",
     "iopub.status.busy": "2023-04-13T22:07:35.240314Z",
     "iopub.status.idle": "2023-04-13T22:07:35.265748Z",
     "shell.execute_reply": "2023-04-13T22:07:35.264117Z"
    },
    "papermill": {
     "duration": 0.044808,
     "end_time": "2023-04-13T22:07:35.267901",
     "exception": false,
     "start_time": "2023-04-13T22:07:35.223093",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>Calories</th><th scope=col>TotalIntensity</th><th scope=col>AverageIntensity</th><th scope=col>StepTotal</th><th scope=col>mean_hrate</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>2016-04-12 00:00:00</td><td>81</td><td>20</td><td>0.333333</td><td>373</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>2016-04-12 01:00:00</td><td>61</td><td> 8</td><td>0.133333</td><td>160</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>2016-04-12 02:00:00</td><td>59</td><td> 7</td><td>0.116667</td><td>151</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>2016-04-12 03:00:00</td><td>47</td><td> 0</td><td>0.000000</td><td>  0</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>2016-04-12 04:00:00</td><td>48</td><td> 0</td><td>0.000000</td><td>  0</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>2016-04-12 05:00:00</td><td>48</td><td> 0</td><td>0.000000</td><td>  0</td><td>NA</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 7\n",
       "\\begin{tabular}{r|lllllll}\n",
       "  & Id & ActivityHour & Calories & TotalIntensity & AverageIntensity & StepTotal & mean\\_hrate\\\\\n",
       "  & <dbl> & <dttm> & <int> & <int> & <dbl> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 2016-04-12 00:00:00 & 81 & 20 & 0.333333 & 373 & NA\\\\\n",
       "\t2 & 1503960366 & 2016-04-12 01:00:00 & 61 &  8 & 0.133333 & 160 & NA\\\\\n",
       "\t3 & 1503960366 & 2016-04-12 02:00:00 & 59 &  7 & 0.116667 & 151 & NA\\\\\n",
       "\t4 & 1503960366 & 2016-04-12 03:00:00 & 47 &  0 & 0.000000 &   0 & NA\\\\\n",
       "\t5 & 1503960366 & 2016-04-12 04:00:00 & 48 &  0 & 0.000000 &   0 & NA\\\\\n",
       "\t6 & 1503960366 & 2016-04-12 05:00:00 & 48 &  0 & 0.000000 &   0 & NA\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 7\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;dttm&gt; | Calories &lt;int&gt; | TotalIntensity &lt;int&gt; | AverageIntensity &lt;dbl&gt; | StepTotal &lt;int&gt; | mean_hrate &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 2016-04-12 00:00:00 | 81 | 20 | 0.333333 | 373 | NA |\n",
       "| 2 | 1503960366 | 2016-04-12 01:00:00 | 61 |  8 | 0.133333 | 160 | NA |\n",
       "| 3 | 1503960366 | 2016-04-12 02:00:00 | 59 |  7 | 0.116667 | 151 | NA |\n",
       "| 4 | 1503960366 | 2016-04-12 03:00:00 | 47 |  0 | 0.000000 |   0 | NA |\n",
       "| 5 | 1503960366 | 2016-04-12 04:00:00 | 48 |  0 | 0.000000 |   0 | NA |\n",
       "| 6 | 1503960366 | 2016-04-12 05:00:00 | 48 |  0 | 0.000000 |   0 | NA |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour        Calories TotalIntensity AverageIntensity\n",
       "1 1503960366 2016-04-12 00:00:00 81       20             0.333333        \n",
       "2 1503960366 2016-04-12 01:00:00 61        8             0.133333        \n",
       "3 1503960366 2016-04-12 02:00:00 59        7             0.116667        \n",
       "4 1503960366 2016-04-12 03:00:00 47        0             0.000000        \n",
       "5 1503960366 2016-04-12 04:00:00 48        0             0.000000        \n",
       "6 1503960366 2016-04-12 05:00:00 48        0             0.000000        \n",
       "  StepTotal mean_hrate\n",
       "1 373       NA        \n",
       "2 160       NA        \n",
       "3 151       NA        \n",
       "4   0       NA        \n",
       "5   0       NA        \n",
       "6   0       NA        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(hourly_combined)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "32d669fc",
   "metadata": {
    "papermill": {
     "duration": 0.015864,
     "end_time": "2023-04-13T22:07:35.299284",
     "exception": false,
     "start_time": "2023-04-13T22:07:35.283420",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "___\n",
    "## Analyzing and Visualizing Data\n",
    "\n",
    "As you may notice in the chart below, **the `daily_combined` data frame presents missing values** in the columns related to the `sleep_day` data frame. That happened because there is a gap between the number of users in the `daily_activity` data frame (33 distinct Id's) and the `sleep_day` (24 distinct Id's). \n",
    "\n",
    "A similar condition affects the `hourly_combined` data frame. While `hourly_cal`, `hourly_intensity` and `hourly_step` data frames present the same number of users' Id (33), the `hourly_hrate` has data of only 14 users. This results in an even higher number of missing values. \n",
    "\n",
    "These facts will be carefully considered when analyzing the relationship among the variables in the data frames."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 36,
   "id": "7827fb4f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:35.333779Z",
     "iopub.status.busy": "2023-04-13T22:07:35.332111Z",
     "iopub.status.idle": "2023-04-13T22:07:36.393513Z",
     "shell.execute_reply": "2023-04-13T22:07:36.391630Z"
    },
    "papermill": {
     "duration": 1.081136,
     "end_time": "2023-04-13T22:07:36.395897",
     "exception": false,
     "start_time": "2023-04-13T22:07:35.314761",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\n+W26SwjJTn6QoyIvD870mrpffZP7a30XP3h6++kH2oPr9Ktj/Yh31anAqRKJbN2Z5/o/y0m9\nJBaLD39gsF+gKi95T3BBJ4V/3UHqay6hqEcgL/OOWCwOS8xiKDD7S88aXHXiLaRwN1pioBaV\nWelxOyQS6aXUnIRryyQSmcuweXH5xf7vry50HOJH+3RZ8GQvsVjs5O7k7DVhy4EITbmretJu\ny+MUojVXmvaRkSe+Silf6ec1cvq8+dNGOXv53UrPJYSo8pK93P3Ul5P59vGlcxH3X6QxEf36\n7nlisThg7y1CSE7qPX8v5+H+f6s7JKsUH9f9b5hUNvTPNevjshl769H7q6Ox3h8zdlCqWdl3\n/XBx+5bTib0d2psxWSWgxskxrAUEwiad2p/dG3QvSTnKb2TdisYis8pCAXVx6aY3rV0Gta2c\n9TZqzrrzvt7ejavSdgGaacJ6la2NK1S8umDCssvy/j2aW1et25nNI94pgV2H/pVTru/aFaw/\na0WUaSF7w1tIXJqY03c4W2EpjzcsWBnU1VFqKTKiKMq8avsnR/dfuvFy+Lx1Tq0KPq8LBIyc\nXqX+3UU9Ai+OLT99T/i/YY4MFcrUa5IRuu9wbsfBbatVsW/bzV5wO/xeRvbre6dPHIh8nGhZ\nw751oxomdJ+apZY/QxYWfitn0rJlvesYXTmyY+OuUynEvM330stBKz+2G9SqkqmofI2OTasz\ncQEc1itoaEqU3Ic4s1Ob9UWVIt3aNqQrLlF+PBW2/1zEpXc55WrXrtFtwPf1LETWDTr+ON7b\n1kxEUZTAyMz0wo57Hb9rYm5sXNGmTr26VfKXa+hVo0XPhtSTnTt3PqesTq5c9rbWgNULf7QU\nCiiKEhiVa+cwsFLOs5cVu4lb12IiusG/uk71K2Z/uExLvT8SOyjVBALjtr3a3j+0afupZy27\nd7Rh9BVW/7jrfj0dvhvA9GqUtqz4S1EZLQdUe7Nhy9m63XvVqmBMUZRxzo2QPSHX7t7esS2s\n+bDfvm9OZ3sXnSPefxzeRrvu0rxSTYaOeDd4LVxlNhRFmdm0e3g4+Lyi/cAWlSiKogRGjas+\nPnz5dUt3j6YVmcom9Rh4BD7c2ue3/EzXcUt6NWDqRE72l561Fax+HrrdZ6TPEEfnVjWEkcd3\nbdh5sbZ5blRkrou4LXPRXx+fu+ai5epNC7u3ap5xPzwmxW7S6P7ypFwLKxv1VT0Sdepur7s4\n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\nAc1GIk2QZUz5AAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Missing values in black\n",
    "vis_miss(daily_combined)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 37,
   "id": "59fa25ff",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:36.433970Z",
     "iopub.status.busy": "2023-04-13T22:07:36.432457Z",
     "iopub.status.idle": "2023-04-13T22:07:37.722584Z",
     "shell.execute_reply": "2023-04-13T22:07:37.720739Z"
    },
    "papermill": {
     "duration": 1.311541,
     "end_time": "2023-04-13T22:07:37.725106",
     "exception": false,
     "start_time": "2023-04-13T22:07:36.413565",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nvsugbbYZsvvee/Zbs572ZfQc3m/J350S8ZAM3z7/ZHab/ru2/yGddOh7bAgtN9gVrHbQ4/eP\nrP07u7DjBv36dMjLWnK01+F9a/+Y++GTyWTN9u3zlr62uHJKXb1U1/kh7BGW12lAczMVC7Ry\nsZwr9lrrX6c+H2rKT3ny6/3+MnC5Z8UTne5+4+v/PXfHXlt0++C5u4Zs2m33Pz1dT/sycouW\n/WdwTXlNCEslyFiL/ndy7eKJWltv3m/pVBdCaNvhh/W/2e3y44niBQt/Ztp7x9fVS3WdX/tt\nv+w0oLkJdkCrt/kFh33zn5M/nnzW1ND7gvU7LPec7/5z1YmnXtZnm1+fMPqS+554peSGXz13\n42n1tK/QGjtss3jhf5+d+8NzdXM/vLGpbieD2vU4Klk9b8z0xYU/KDj3t7se/fdP6+qlus7P\n9H3Aqss/p4BWr926Z2yRe9FvDrmt+27j8ur452ru6guuvfK82cVrHvObAbF5n9xw45R2659S\nT/sKtV/vkhEb3nbwrsfcefkxRYumnH/cUyGErBVe1rLldfjN1UO6njForzbXnTFwvfZP33bq\ntf+Z9vj96+R+v/xequv8+n8lKxYWfvbRt9/2XnPNTivjrmBVItgBrV8scdn+62x325QzJ2xZ\n1ynFvc994srvT7/h9O3Om91uje4Ddhz+wl//WE97CrJuePO/7Q8bduSeg5JrDrjqwXuf3niD\n1XNae7QLx/2rpPT4oy8+5oBvK3I32GyHuyc+NKR9bmhfZy8t//x6bXfSb0tPPWr9LQ+a98Vd\nzX9DsGqJJZMeZwUaa/PNN2+mb540aVIzfXMjVZV9OOb2Z/c+6g9dc+IhhEXTxxR1+8Ok+RX9\nf1xqulwlJSX1HE3bgAEDmuNrgVbHiB1AOuLZq99xxsnjprW996Q9sxd9ftFh53Xa9Oz6Ux1A\nc7N4AiAd8USHZ16/p8vLl2+y7ho9N/31+10Ofm7iWZkuCljVGbEDSFNxn/3GT9wv01UA/MSI\nHcCyFn73zbzqFT9//MID46ZX1qyEelo1vQQrk2AHtG5nb9n9wZllS7ectn7n879c8POzqu85\n/6hf9eletHqPXfY/4a15lfV84aJp/1y7e7fRn89b0vLk1aPW79ahuEvvIy+esKRx3sc37HPm\nq11y4j9edXe3bS5s9N00oyUdVVP5zTUn7rP+Wqvlt+/8q50OfuiDubUnVJV9es6Re/ZZe7W8\noo7b7H3Mm3PqfPXtO/f/Za8dNu9Q0Hb9zXa59fnptY2p9FJoDR0FrZpgB7RiXz4y7O9drvzd\navk/NtS8Oe6kK6Z+V/nz9f5vXbrTYRf+c+8/Xvf4nRe3f+vOHTc/trqOL0xWLxi57bDZi38a\nYZpZcubvLvzg2sdK3nnq5m+vO2zUcz/kmCv2Oe/Uf5675LTCrr+/oM2YEf/+ugnvrgkt3VFj\n99nqT2OnnXztP1546Patsl46YIvtvqioDqH6uF9tce0L1WffdP8LD92xwfcP7rTZ78uWN9D2\n9ROn9j/o3K57jHrkucdGbLNw5O5bvDCvIsVeCi2+o6C1s90J0AQytN1J8tA1izZ9/ZtT1y4K\nIXz+z/8bNPy+aXPKQwijP5934dptfzirprxf27Z5Z7w2aXT/EELpd/cVrnngmVPmXLRe8S+/\n8d+nbn7Yy1vOeP2mUR/PuaFncQjh9eP7HRm77b1rtwwhvHPR5vu+e+XH4wfP/O9Z/Y4u+G7S\nmUtfO3fqud13mL7g61vquZ0MbXfyU0cla0rb5BQNfOCTZ/ZeJ4SweOGbOUW/OujtmX8tvKJ9\n70vvnrbw0C6FIYSqsqlrt+8z5PlpYweuscx37dGx4LNDHp98/fYhhBCqD999t+JTxh78yK4p\n9lJIraOA9BixA1qr+Z9fNKFiy9pUF0JYc7szH3765ddfvn+Z00pn3jt50eIjj1i/9mPBGgfs\n0j7v8buX89qrmZMu3/vmRY88fvrSjWvtu+3n9138xldzF0x/+9Jbp245dJ0Qas7a98aLJhy3\nzOXFvc/ZYP5d10xb2CR314R+3lHJ6mQyUfDDRsqxrOJYLFZVk5zzzhvxrKLaVBdCSOT33rdT\nwX+un7LMV5XPevCx2WUjzliS47PGPvH0NTt3Tb2XQgvuKIgAwQ5orT766/0dNj5+yce8TusP\nGDCgf/9+y5xWPvfZEMKgdj+9DmGbtrkznp+xzGnV5R/vPeTskfc/tUVRztLtnQf/dcyR+Xv0\nWb1Dr53L97/y73utPe3ZYx7vdenwHwPlUrJOWq/473d90tgba2pLd1QsXnjH7/u+dOjwf778\n9ifvT7rkyN/kr7b9VX07tOm5Vk31gsdnl9eeVrN4xr9nl895+5tlvqps1r9CCOu+dOOgvt0K\n8tr13WLHm5/+JDSsl0KL7SiIAMEOaK2evO+LtQ9ab4WnVZXOCyF0W+plX91ysyrnLFrmtJsP\n3Pm73cZcvXv3X37D0AvHzVhQumjR9/+8bHgsWXH80Puv/8fvaw/VVP3saZYN9+n+6R0vNfRG\nmtsyHbXPlXf2q3hx320367XhFueO+/SEO27tnpvVqd/VO3bKP2znIx965pXXn3/8xL1+Na2y\nOlm9bC9VLZoZQvj9yPF7j77puWf/OXzL2DG79bnqgzmhIb0UWmpHQQQIdkBr9eK8inZ9263w\ntER+UQjhm8qf1ktMq6xOFOUvfc4XDx39x//0fH7soXV+SyyREwshhE/vP/SdwX/be7X82e/e\nO2TDtXJy89cfePBzM35Yltuub7uKuRPTuZnmtHRHVZV/vOP6g0r3O//Dr2eVz5/x1K2nXf3b\nfn9+5btYov2j7z6xd+cvjj1w5532/cOcra86d622iTadlvmqeE52COHQxx4/deheW22z08k3\nPDtijdwrR774w+HUeim01I6CCBDsgNaqrCaZVZC1wtNyi3cIIby24KctTt5cULn64NWXPueL\n8c+XzXpurbxELBbLyukcQrixV/v89jsv81XJ6nlHHPPS2Fv2TNaU7rndsH5njp+38NtL95i1\n//Zn156QVZiVrCkLLczSHTX9+WNem5v14pg/rt+1Q27RajsfcfHNG7a5fvijIYSCzoNvfezl\nr2eVLpz9xd1n7/PivIouu3db5qty2m4eQhi6UYclLb/t2bb0q6lLn7PCXgottaMgAgQ7oLXa\npDB7wUcLVnha4eq/752ffct9n9d+rJj79KOzynYd1nPpc/pf/OCkH73x2pMhhP0fev6VF/66\nzFd9MGbf7w/+x6C2OZXz//NGxRpXDx1YmF+8x0lXzZlyQ+0JCz9amF24ceNvrWkt3VGJgoJk\nsnLG4p/GL79ZtDhRWFBd/snuu+8+9psf5l4XfHXLY7PLDh+57Ex3Yeej18zJuu31mT98Tlbd\n89G8Dv37L33OCnsptNSOggjwSjGgtfrdlqs99a/pYTqhbXAAAAKbSURBVGivFZwXz/vHn7Ya\neNrud/Qav23nimuPHtqu1+GXbNA+hPDWX876x7zVL7/k+Dbr9huw7g+n1yz+NoSwer9NN+v5\ns/1Qqiu/Pvisz+77ersQQm677bYvnHnUmGcu2q/PM1cf23Gjk2vP+fqJ6WsO3q2J77PRlu6o\nNQbesHVx7+13Hn7TecPXblP18gNXn/lp2cWTdsnK67TRd5NO2nF4hzEnt5nz4UUjT1zr11ed\n0K1N7Tcs6ah4ouP9J2+x4967bHDLZduvm//UmDPunZM3/saBS34rlV4KLbWjIAKM2AGt1cZn\nDPr2xXtTOXPzs5+9+YRB5x+2S9+tf/vmGvs+++aY2onJKXfefP1N96X4c29dsk/uCeP7FiRC\nCCGW+8Ar98687bie3fpd8VqvR57/YQ/esW/O3P7UPg2/lea1dEdl5XR7+v3n9u/y1enD9h60\n+0F3vl59/WOT/7RZpxDCRROfPrzvl0fvte3vjjq74/4Xljx0wpJvWLqjBl384k3H9x9z0tBB\nuxzy4Gddb5/4/r5rFCw5M5VeCi21oyACbFAMNIGMbFCcrJrdr7jLdV/P26k4t65zVqby2Y8U\nr33ezLklRVmxus7JyAbFrbGjgPQYsQNaq1iiw9jjNzzt2smZLuQHb1929iZ/vK0FhhUdBasO\nI3ZAK1az+Lvd1tlpzCfvrJu34uWxzaqq9IMNe5/yny/+1SnREv/BrKNgFSHYAa3b/Kmvfrbm\n5psUZWe2jMq5/y2Z1Xtgz+W+aKFF0FGwKhDsAAAiwkg4AEBECHYAABEh2AEARIRgBwAQEYId\nAEBECHYAABEh2AEARIRgBwAQEYIdAEBECHYAABEh2AEARIRgBwAQEYIdAEBECHYAABEh2AEA\nRMT/AzkqGP+ryrpoAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Missing values in black\n",
    "vis_miss(hourly_combined)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "30a5e3b4",
   "metadata": {
    "papermill": {
     "duration": 0.017997,
     "end_time": "2023-04-13T22:07:37.761421",
     "exception": false,
     "start_time": "2023-04-13T22:07:37.743424",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "In both of the combined data frames, I will drop columns that present 0 values or won't be useful in my analysis. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 38,
   "id": "c16ab562",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:37.800987Z",
     "iopub.status.busy": "2023-04-13T22:07:37.799353Z",
     "iopub.status.idle": "2023-04-13T22:07:37.812536Z",
     "shell.execute_reply": "2023-04-13T22:07:37.810854Z"
    },
    "papermill": {
     "duration": 0.035914,
     "end_time": "2023-04-13T22:07:37.815316",
     "exception": false,
     "start_time": "2023-04-13T22:07:37.779402",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Drop columns in the 'daily_acitvity' data frame\n",
    "#sleep_day$SleepDay <- NULL"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5dfca6df",
   "metadata": {
    "papermill": {
     "duration": 0.017992,
     "end_time": "2023-04-13T22:07:37.851006",
     "exception": false,
     "start_time": "2023-04-13T22:07:37.833014",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### daily_combined data frame\n",
    "\n",
    "* Compare the active minutes proportion of each intensity with the amount of calories burned, for example, does a higher proportion of very active minutes translate into higher amount of calories burned? Or high amount of light active minutes play a more important role in calories burned? \n",
    "\n",
    "* Compare the active minutes per intensity with the amount of sleep\n",
    "* Compare the number steps with time asleep\n",
    "* Compare the sedentary minutes with the amount of sleep"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c2537cc6",
   "metadata": {
    "papermill": {
     "duration": 0.017622,
     "end_time": "2023-04-13T22:07:37.886316",
     "exception": false,
     "start_time": "2023-04-13T22:07:37.868694",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### hourly_combined\n",
    "\n",
    "Drop average Intensity because it represents intensity per minute.\n",
    "* Compare Calories with Intensity \n",
    "* Compare Calories with Steps\n",
    "* Compare Calories and Intensity with Heart rate"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 39,
   "id": "d5a58f45",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-04-13T22:07:37.925345Z",
     "iopub.status.busy": "2023-04-13T22:07:37.923677Z",
     "iopub.status.idle": "2023-04-13T22:07:37.936977Z",
     "shell.execute_reply": "2023-04-13T22:07:37.935237Z"
    },
    "papermill": {
     "duration": 0.035506,
     "end_time": "2023-04-13T22:07:37.939668",
     "exception": false,
     "start_time": "2023-04-13T22:07:37.904162",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#ggplot(data=daily_activity, aes(x=TotalSteps, y=SedentaryMinutes)) + geom_point()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "b8ac3ba1",
   "metadata": {
    "papermill": {
     "duration": 0.017594,
     "end_time": "2023-04-13T22:07:37.974849",
     "exception": false,
     "start_time": "2023-04-13T22:07:37.957255",
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
   "duration": 19.758514,
   "end_time": "2023-04-13T22:07:38.115838",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-04-13T22:07:18.357324",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
