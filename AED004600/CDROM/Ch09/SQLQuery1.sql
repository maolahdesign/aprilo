SELECT          員工.身份證字號, 員工.姓名 AS 教授姓名, 教授.職稱, 教授.科系
FROM              員工 INNER JOIN
                            教授 ON 員工.身份證字號 = 教授.身份證字號
ORDER BY   員工.身份證字號