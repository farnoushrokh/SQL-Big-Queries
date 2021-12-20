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
where SUM_SUB!=0 and SUM_TA_SUB!=0 and SUM_TV != 0 and SUM_TUV!=0;