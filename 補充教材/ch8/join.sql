-- INNER JOIN (內部連接)
-- 只返回兩個表中能夠匹配的資料。

SELECT e.name, d.dept_name
FROM Employees e
INNER JOIN Departments d ON e.dept_id = d.dept_id;

-- LEFT JOIN (左外部連接)
-- 返回左表中的所有資料，以及右表中匹配的資料。若右表無匹配，則結果中對應列為 NULL。

SELECT e.name, d.dept_name
FROM Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id;

-- RIGHT JOIN (右外部連接)
-- 返回右表中的所有資料，以及左表中匹配的資料。若左表無匹配，則結果中對應列為 NULL。

SELECT e.name, d.dept_name
FROM Employees e
RIGHT JOIN Departments d ON e.dept_id = d.dept_id;

-- FULL JOIN (全外部連接)
-- 返回兩個表中所有的資料。若某一方無匹配，則結果中對應列為 NULL。

SELECT e.name, d.dept_name
FROM Employees e
FULL JOIN Departments d ON e.dept_id = d.dept_id;

-- CROSS JOIN (交叉連接)
-- 將左表的每一行與右表的每一行進行組合，形成笛卡爾積。

SELECT e.name, d.dept_name
FROM Employees e
CROSS JOIN Departments d;
