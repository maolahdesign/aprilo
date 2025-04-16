select c1,c2,
first_value(c2) ignore nulls over(order by c1 rows --取後一個非 null 值
					between current row and unbounded following) [後非 null],
last_value(c2) ignore nulls over(order by c1 ) [前非 null]--取前一個非 null 值
from 
(values(1,1),(2,null),(3,3),(4,null),(5,null),(6,6)) t(c1,c2)
