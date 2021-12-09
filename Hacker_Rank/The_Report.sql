select case when G.grade>= 8 then S.name
else 'NULL'
end , G.grade, S.marks from students S join grades G on S.marks between
G.min_mark and G.max_mark order by G.grade desc, S.name asc