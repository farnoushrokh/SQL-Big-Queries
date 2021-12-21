select * from (select C.contest_id, C.hacker_id, C.name, sum(ST.SUM_SUB) as SUM_SUB,
sum(ST.SUM_TA_SUB) as SUM_TA_SUB,
sum(ST.SUM_TV) as SUM_TV, sum(ST.SUM_TUV) as SUM_TUV from Contests C
join (select CO.contest_id, FT.challenge_id, FT.college_id, FT.SUM_SUB, FT.SUM_TA_SUB, FT.SUM_TV, FT.SUM_TUV
from Colleges CO
      join (select C.challenge_id, C.college_id, S.total_submissions SUM_SUB, S.total_accepted_submissions SUM_TA_SUB,
      W.total_views SUM_TV, W.total_unique_views SUM_TUV from challenges C
            join Submission_Stats S on C.challenge_id = s.challenge_id join View_Stats W
            on C.challenge_id = W.challenge_id) FT
            on CO.college_id = FT.college_id) ST on C.contest_id = ST.contest_id
group by C.contest_id, C.hacker_id, C.name order by C.contest_id) ab
where SUM_SUB+SUM_TA_SUB+SUM_TV+SUM_TUV>0;


select con.contest_id,
        con.hacker_id,
        con.name,
        sum(total_submissions),
        sum(total_accepted_submissions),
        sum(total_views), sum(total_unique_views)
from contests con
join colleges col on con.contest_id = col.contest_id
join challenges cha on  col.college_id = cha.college_id
left join
(select challenge_id, sum(total_views) as total_views, sum(total_unique_views) as total_unique_views
from view_stats group by challenge_id) vs on cha.challenge_id = vs.challenge_id
left join
(select challenge_id, sum(total_submissions) as total_submissions,
sum(total_accepted_submissions) as total_accepted_submissions from submission_stats group by challenge_id) ss
on cha.challenge_id = ss.challenge_id
    group by con.contest_id, con.hacker_id, con.name
        having sum(total_submissions)!=0 or
                sum(total_accepted_submissions)!=0 or
                sum(total_views)!=0 or
                sum(total_unique_views)!=0
            order by contest_id;