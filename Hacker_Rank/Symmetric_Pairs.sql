select FT.X, FT.Y from Functions FT join Functions ST on FT.X = ST.Y and FT.Y= ST.X  group by FT.X, FT.Y
having count(FT.X)> 1 or FT.X < FT.Y order by FT.X;

