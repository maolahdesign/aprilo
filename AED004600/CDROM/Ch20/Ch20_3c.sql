SELECT s.學號, s.姓名, c.課程編號, c.教授編號
FROM 學生 s
INNER JOIN 班級 c
ON s.學號 = c.學號;
