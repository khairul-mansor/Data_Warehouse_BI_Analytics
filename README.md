# Data_Warehouse_BI_Analytics

## Introduction

The dataset are provided from a solid waste management company. The company collects and recycles solid waste across major cities in the country of Brazil. The company operates hundreds of trucks of different types to collect and transport solid waste. The company would like to create a data warehouse so that it can create reports like:

    total waste collected per year per city
    total waste collected per month per city
    total waste collected per quarter per city
    total waste collected per year per trucktype
    total waste collected per trucktype per city
    total waste collected per trucktype per station per city

## Objectives

    Design a Data Warehouse
    Load data into Data Warehouse
    Write aggregation queries
    Create MQTs
    Create a Dashboard



## Prerequisites

Access to a cloud instance of IBM DB2.

Access to Cognos Analytics.


## Design a Data Warehouse

The solid waste management company has provied the sample data they wish to collect.

![solid-waste-trips-new](https://user-images.githubusercontent.com/63607240/182415888-91c26d3e-185c-4ebb-a26a-722363cef242.png)


I started my project by designing a Star Schema warehouse by identifying the columns for the various dimension and fact tables in the schema.

### Design the dimension table MyDimDate

Write down the fields in the MyDimDate table in text editor one field per line. The company is looking at a granularity of day. Which means they would like to have the ability to generate the report on yearly, monthly, daily, and weekday basis.

Here is a partial list of fields to serve as an example:

    dateid
    month
    monthname
    ...
    ...


### Design the dimension table MyDimWaste

Write down the fields in the MyDimWaste table in text editor one field per line.


### Design the dimension table MyDimZone

Write down the fields in the MyDimZone table in text editor one field per line.


### Design the fact table MyFactTrips

Write down the fields in the MyFactTrips table in text editor one field per line.


## Create schema for Data Warehouse on DB2

I created the tables that I have designed previously.

### Create the dimension table MyDimDate

Create the MyDimDate table using SQL statement.

### Create the dimension table MyDimWaste

Create the MyDimWaste table using SQL statement.

### Create the dimension table MyDimZone

Create the MyDimZone table using SQL statement.

### Create the fact table MyFactTrips

Create the MyFactTrips table using SQL statement.


## Load data into the Data Warehouse

I loaded the data provided by the company in csv format.

### Load data into the dimension table DimDate

Load the data into DimDate table.

Using SQL statement to check the first 5 rows in the table DimDate.



### Load data into the dimension table DimTruck


Load the data into DimTruck table.

Using SQL statement to check the first 5 rows in the table DimTruck.


### Load data into the dimension table DimStation


Load the data into DimStation table.

Using SQL statement to check the first 5 rows in the table DimStation.


### Load data into the fact table FactTrips


Load the data into FactTrips table.

Using SQL statement to check the first 5 rows in the table FactTrips.


## Write aggregation queries and create MQTs

I queried the data I have loaded using SQL statement.

### Create a grouping sets query

Create a grouping sets query using the columns stationid, trucktype, total waste collected.


### Create a rollup query

Create a rollup query using the columns year, city, stationid, and total waste collected.


### Create a cube query

Create a cube query using the columns year, city, stationid, and average waste collected.


### Create an MQT

Create an MQT named max_waste_stats using the columns city, stationid, trucktype, and max waste collected.


## Create a dashboard using Cognos Analytics


Use the DataForCognos.csv file to generate the following charts.

### Create a pie chart in the dashboard

Create a pie chart that shows the waste collected by truck type.


### Create a bar chart in the dashboard

Create a bar chart that shows the waste collected station wise.


### Create a line chart in the dashboard

Create a line chart that shows the waste collected by date wise.



### Create a pie chart in the dashboard

Create a pie chart that shows the waste collected by city.


