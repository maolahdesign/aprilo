USE 教務系統;

SELECT 身份證字號, 姓名, 電話, 薪水
FROM 員工
WHERE 薪水 > 50000 AND 姓名 LIKE '陳%';
