select C.company_code, C.founder, F.num_lead, F.num_sm, F.num_m, F.num_e from Company C JOIN
(select company_code, count(distinct lead_manager_code) num_lead, count(distinct senior_manager_code)
num_sm,
count(distinct manager_code) num_m, count(distinct employee_code) num_e
from Employee group by Company_Code) F on F.company_code = C.company_code group by C.Company_Code, C.Founder ORDER BY C.COMpany_Code asc;