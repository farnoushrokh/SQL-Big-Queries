# BigQuery examples
## Finding number of videos published
```sql
select channel_id,count(distinct(video_id)) as Number_Video,
extract(year from DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published)))) as year,
extract(month from DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published)))) as month
from `yourproject.yourDataBase.yourTable` 
where DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published))) between '2019-01-01' and '2021-11-18' 
group by channel_id, year, month;
```
```sql
select * from 
(select distinct video_id as video_id, channel_id, sum(views) as Number_Views_Before2021, date 
from `ourproject.yourDataBase.yourTable1` group by channel_id, video_id,date) W 
left join 
(select distinct video_id as video_id, channel_id, DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S', time_published))) 
as time_published from `ourproject.yourDataBase.yourTable2` 
group by channel_id, video_id, time_published) P 
on W.video_id = P.video_id where time_published >= '2021-01-01'
```


```sql
SELECT * FROM(
(select distinct video_id as video_id, channel_id, sum(views) as Number_Views_Before2021, date 
from `ourproject.yourDataBase.yourTable1` group by channel_id, video_id,date) W 
left join 
(select distinct video_id as video_id, channel_id, DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S', time_published))) 
as time_published from `ourproject.yourDataBase.yourTable1` 
group by channel_id, video_id, time_published) P 
on W.video_id = P.video_id) where time_published < '2021-01-01')
```

```sql

SELECT t1.channel_id AS channel_id, t1.Monthly_Total_Views AS Monthly_Total_Views_Under2021, IFNULL(t2.Monthly_Total_Views, 0) AS Monthly_Total_Views_Over2021,
IFNULL(t1.Monthly_Total_Views/NULLIF((t1.Monthly_Total_Views+IFNULL(t2.Monthly_Total_Views,0)),0),0) AS Ratio_Under_2021,
IFNULL(t2.Monthly_Total_Views/NULLIF((t1.Monthly_Total_Views+IFNULL(t2.Monthly_Total_Views,0)),0),0) AS Ratio_Over_2021,
 t1.Month AS Month, t1.Year AS Year
 FROM
(SELECT SUM(Month_total_views) AS Monthly_Total_Views, Month, Year, channel_id from
(SELECT video_id, SUM(Each_day_total_views) AS Month_total_views, EXTRACT(MONTH FROM DATE(TIMESTAMP(PARSE_DATETIME('%Y%m%d',date)))) AS Month,
EXTRACT(YEAR FROM DATE(TIMESTAMP(PARSE_DATETIME('%Y%m%d',date)))) AS Year,
channel_id, publish_date FROM
(SELECT video_id, total_views AS Each_day_total_views, date, channel_id, publish_date FROM
(SELECT * FROM (SELECT DISTINCT video_id AS video_id, sum(views) as total_views, date, channel_id
FROM ourproject.yourDataBase.yourTable1 GROUP BY video_id, channel_id, date)
AS d1 LEFT JOIN
(SELECT DISTINCT video_id AS id_of_video, DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published)))
AS publish_date from `ourproject.yourDataBase.yourTable1`
GROUP BY video_id, channel_id, publish_date) AS d2 ON d1.video_id = d2.id_of_video))
WHERE EXTRACT(YEAR FROM DATE(TIMESTAMP(PARSE_DATETIME('%Y%m%d',date))))=2021 AND
publish_date IS NOT NULL
GROUP BY Year, Month, video_id, channel_id, publish_date)
WHERE publish_date<'2021-01-01'
GROUP BY channel_id, Month, Year) AS t1 LEFT JOIN
(SELECT SUM(Month_total_views) AS Monthly_Total_Views, Month, Year, channel_id from
(SELECT video_id, SUM(Each_day_total_views) AS Month_total_views, EXTRACT(MONTH FROM DATE(TIMESTAMP(PARSE_DATETIME('%Y%m%d',date)))) AS Month,
EXTRACT(YEAR FROM DATE(TIMESTAMP(PARSE_DATETIME('%Y%m%d',date)))) AS Year,
channel_id, publish_date FROM
(SELECT video_id, total_views AS Each_day_total_views, date, channel_id, publish_date FROM
(SELECT * FROM (SELECT DISTINCT video_id AS video_id, sum(views) as total_views, date, channel_id
FROM ourproject.yourDataBase.yourTable1 GROUP BY video_id, channel_id, date)
AS d1 LEFT JOIN
(SELECT DISTINCT video_id AS id_of_video, DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published)))
AS publish_date from `ourproject.yourDataBase.yourTable1`
GROUP BY video_id, channel_id, publish_date) AS d2 ON d1.video_id = d2.id_of_video))
WHERE EXTRACT(YEAR FROM DATE(TIMESTAMP(PARSE_DATETIME('%Y%m%d',date))))=2021 AND
publish_date IS NOT NULL
GROUP BY Year, Month, video_id, channel_id, publish_date)
WHERE publish_date>'2021-01-01'
GROUP BY channel_id, Month, Year) AS t2 ON t1.channel_id = t2.channel_id AND t1.Month = t2.Month AND t1.Year = t2.Year
ORDER BY t1.Month DESC, t1.Year DESC
```
