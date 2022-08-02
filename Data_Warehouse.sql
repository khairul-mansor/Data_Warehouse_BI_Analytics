

## Create schema for Data Warehouse on DB2

I created the tables that I have designed previously.

### Create the dimension table MyDimDate

Create the MyDimDate table using SQL statement.

CREATE TABLE MYDIMDATE (
	DATEID INT,
	DATE DATE,
	YEAR INT,
	QUARTER INT,
	QUARTERNAME VARCHAR(20),
	MONTH INT,
	MONTHNAME VARCHAR(20),
	DAY INT,
	WEEKDAY INT,
	WEEKDAYNAME VARCHAR(20)
);


### Create the dimension table MyDimWaste

Create the MyDimWaste table using SQL statement.

CREATE TABLE MYDIMWASTE (
WASTEID INT,
WASTETYPE VARCHAR(20),
WASTENAME VARCHAR(20)
);

### Create the dimension table MyDimZone

Create the MyDimZone table using SQL statement.

CREATE TABLE MYDIMZONE (
COLLECTIONZONEID INT,
COLLECTIONZONENAME VARCHAR(20),
CITYID INT,
CITYNAME VARCHAR(20)

### Create the fact table MyFactTrips

Create the MyFactTrips table using SQL statement.


CREATE TABLE MYFACTTRIPS (
TRIPID INT,
DATEID INT,
STATIONID INT,
TRUCKID INT,
WASTECOLLECTED DECIMAL
);

## Load data into the Data Warehouse

I loaded the data provided by the company in csv format.

### Load data into the dimension table DimDate

Load the data into DimDate table.

Using SQL statement to check the first 5 rows in the table DimDate.

SELECT * FROM DIMDATE LIMIT 5

### Load data into the dimension table DimTruck


Load the data into DimTruck table.

Using SQL statement to check the first 5 rows in the table DimTruck.


SELECT * FROM DIMTRUCK LIMIT 5

### Load data into the dimension table DimStation


Load the data into DimStation table.

Using SQL statement to check the first 5 rows in the table DimStation.


SELECT * FROM DIMSTATION LIMIT 5

### Load data into the fact table FactTrips


Load the data into FactTrips table.

Using SQL statement to check the first 5 rows in the table FactTrips.

SELECT * FROM FACTTRIPS LIMIT 5


## Write aggregation queries and create MQTs

I queried the data I have loaded using SQL statement.

### Create a grouping sets query

Create a grouping sets query using the columns stationid, trucktype, total waste collected.


select STATIONID,TRUCKTYPE, sum(WASTECOLLECTED) as TOTALWASTECOLLECTED
from FACTTRIPS
left join DIMTRUCK
on FACTTRIPS.TRUCKID = DIMTRUCK.TRUCKID
group by grouping sets(STATIONID,TRUCKTYPE)
order by STATIONID, TRUCKTYPE

### Create a rollup query

Create a rollup query using the columns year, city, stationid, and total waste collected.

select DIMDATE.YEAR,DIMSTATION.CITY,FACTTRIPS.STATIONID, sum(FACTTRIPS.WASTECOLLECTED) as TOTALWASTECOLLECTED
from FACTTRIPS
left join DIMDATE
on FACTTRIPS.DATEID = DIMDATE.DATEID
left join DIMSTATION
on FACTTRIPS.STATIONID = DIMSTATION.STATIONID
group by rollup(DIMDATE.YEAR,DIMSTATION.CITY,FACTTRIPS.STATIONID)
order by DIMDATE.YEAR,DIMSTATION.CITY,FACTTRIPS.STATIONID


### Create a cube query

Create a cube query using the columns year, city, stationid, and average waste collected.

select DIMDATE.YEAR, DIMSTATION.CITY, FACTTRIPS.STATIONID, avg(FACTTRIPS.WASTECOLLECTED) as TOTALWASTECOLLECTED
from FACTTRIPS
left join DIMDATE
on FACTTRIPS.DATEID = DIMDATE.DATEID
left join DIMSTATION
on FACTTRIPS.STATIONID = DIMSTATION.STATIONID
group by cube(DIMDATE.YEAR, DIMSTATION.CITY, FACTTRIPS.STATIONID)
order by DIMDATE.YEAR, DIMSTATION.CITY, FACTTRIPS.STATIONID

### Create an MQT

Create an MQT named max_waste_stats using the columns city, stationid, trucktype, and max waste collected.

CREATE TABLE max_waste_stats (CITY, STATIONID, TRUCKTYPE, MAXWASTECOLLECTED) AS
  (select DIMSTATION.CITY, FACTTRIPS.STATIONID, DIMTRUCK.TRUCKTYPE, max(FACTTRIPS.WASTECOLLECTED)
from FACTTRIPS
left join DIMSTATION
on FACTTRIPS.STATIONID = DIMSTATION.STATIONID
left join DIMTRUCK
on FACTTRIPS.TRUCKID = DIMTRUCK.TRUCKID
group by DIMSTATION.CITY, FACTTRIPS.STATIONID, DIMTRUCK.TRUCKTYPE)
     DATA INITIALLY DEFERRED
     REFRESH DEFERRED
     MAINTAINED BY SYSTEM;


