select Name from (Students S join Friends F using (ID) join Packages P1 on
                  P1.ID = S.Id join Packages P2 on P2.Id = F.friend_id) where P2.salary > p1.salary
                  order by order by P2.salary;