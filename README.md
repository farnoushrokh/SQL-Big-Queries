# BigQuery examples
## Finding number of videos published
```sql
select channel_id,count(distinct(video_id)) as Number_Video,
extract(year from DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published)))) as year,
extract(month from DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published)))) as month
from `yourproject.yourDataBase.yourTable` 
where DATE(TIMESTAMP(PARSE_DATETIME('%Y/%m/%d %H:%M:%S',time_published))) between '2019-01-01' and '2021-11-18' group by channel_id, year, month;
```