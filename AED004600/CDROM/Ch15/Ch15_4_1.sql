USE 教務系統 
GO
ALTER FUNCTION fnProfessor
    (@tax money)
    RETURNS TABLE
RETURN (
  SELECT 教授.教授編號, 員工.姓名, 教授.科系,
         教授.職稱, 員工.薪水
  FROM 教授 INNER JOIN 員工 
  ON 教授.身份證字號 = 員工.身份證字號
  WHERE 員工.扣稅 >= @tax )
