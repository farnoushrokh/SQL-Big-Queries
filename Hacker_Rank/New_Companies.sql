select L.founder, L.company_code, SM.Senior_Code, SM.employee_Code from Company L JOIN
(SELECT M.lead_manager_code,EM.company_code, count(M.senior_manager_code) Senior_Code,employee_Code
from
Senior_Manager M join
(select E.company_code, E.lead_manager_code, count(E.employee_code) employee_Code from Employee E join
Manager M on E.lead_manager_code= M.lead_manager_code
group by E.company_code, E.lead_manager_code,E.company_code) EM
on M.lead_manager_code = EM.lead_manager_code group by M.lead_manager_code) SM
on  L.company_code = SM.company_code