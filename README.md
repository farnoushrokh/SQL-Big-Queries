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