create database logistics_projrct;

use logistics_projrct;

select * from route_delay_summary;
select * from shipment_trend;
select * from warehouse_volume;


# Route Efficiency Analysis
  ----- # slowest routes ---------
  
SELECT *
FROM route_delay_summary
ORDER BY avg_delay DESC
LIMIT 5;

 ------  # Most efficient routes ---------
 
SELECT route_id,
       avg_delay
FROM route_delay_summary
ORDER BY avg_delay ASC
LIMIT 5;

# Warehouse Performance Analysis
 -------#Top 3 busiest warehouses-------
 
 SELECT warehouse_id,count
FROM warehouse_volume
ORDER BY count DESC
LIMIT 3;

-------- #Least busy warehouses ---------

SELECT warehouse_id,count
FROM warehouse_volume
ORDER BY count ASC
LIMIT 3;

#Shipment Demand Trend Analysis
 ----- # Highest shipment demand days ------
 
SELECT shipment_day,count
FROM shipment_trend
ORDER BY count DESC
LIMIT 5;

 ------ # lowest shipment demand days ------
SELECT shipment_day,count
FROM shipment_trend
ORDER BY count asc
LIMIT 5;


 ----- # Route Performance Classification ----
SELECT 
    route_id,avg_delay,
    CASE
        WHEN avg_delay < 0.5 THEN 'Efficient'
        WHEN avg_delay BETWEEN 0.5 AND 1 THEN 'Moderate'
        ELSE 'Poor Performance'
    END AS route_status
FROM route_delay_summary
ORDER BY avg_delay DESC;

# Warehouse Load Classification
SELECT 
    warehouse_id,
    count ,
    CASE
        WHEN count > 12000 THEN 'High Load'
        WHEN count BETWEEN 11000 AND 12000 THEN 'Medium Load'
        ELSE 'Low Load'
    END AS warehouse_category
FROM warehouse_volume
ORDER BY count DESC;

 # Shipment Demand Ranking
SELECT 
    shipment_day,count,
    RANK() OVER (order by count DESC) AS demand_rank
FROM shipment_trend;

