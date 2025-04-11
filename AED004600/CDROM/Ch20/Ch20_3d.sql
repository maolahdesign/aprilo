SELECT 學生.學號, 學生.姓名, 班級.課程編號, 班級.教授編號, 課程.名稱, 課程.學分
FROM 學生
INNER JOIN 班級 ON 學生.學號 = 班級.學號
INNER JOIN 課程 ON 班級.課程編號 = 課程.課程編號
WHERE 學生.性別 = '男';
