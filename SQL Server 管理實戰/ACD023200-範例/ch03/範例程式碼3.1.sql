--�ҥάd�ߦs���
USE [Northwind]
GO

--�إߴ��ո�ƪ�
CREATE TABLE tbQueryStore (C1 INT, C2  CHAR(10))
go

--�s�W���ո��
INSERT INTO tbQueryStore 
select [value], CAST([value] AS CHAR(10)) from generate_series(1,10000) --sql 2022 �s�W�����
go

--�إ߯���
CREATE INDEX idx_C1 on tbQueryStore (C1)
go

--�إ߹w�x�{��
CREATE OR ALTER PROC sp_QueryStore @v1 int
AS
BEGIN
	SELECT * FROM tbQueryStore WHERE C1 < @v1
END
go

--�M�� query store �w�g�s�񪺰���p�e
ALTER DATABASE CURRENT SET QUERY_STORE CLEAR ALL;

--���IO�έp���
SET STATISTICS IO ON
go

--�Ĥ@������w�x�{��select�j�q��ơA����p�e�ϥ�"��ƪ��y"
EXEC sp_QueryStore 10000 

/*(9999 �Ӹ�ƦC����v�T)
��ƪ� 'tbQueryStore'�C���y�p�� 1�A�޿�Ū�� 29�A����Ū�� 0�A�������A��Ū�� 0�AŪ���eŪ�� 29�A�������A��Ū���eŪ�� 0�ALOB �޿�Ū�� 0�ALOB ����Ū�� 0�ALOB �������A��Ū�� 0�ALOB Ū���eŪ�� 0�ALOB �������A��Ū���eŪ�� 0�C
*/

--�ĤG������w�x�{��select�ֶq��ơA����p�e���ϥ�"��ƪ��y"
EXEC sp_QueryStore 10

/*(9 �Ӹ�ƦC����v�T)
��ƪ� 'tbQueryStore'�C���y�p�� 1�A�޿�Ū�� 30�A����Ū�� 0�A�������A��Ū�� 0�AŪ���eŪ�� 0�A�������A��Ū���eŪ�� 0�ALOB �޿�Ū�� 0�ALOB ����Ū�� 0�ALOB �������A��Ū�� 0�ALOB Ū���eŪ�� 0�ALOB �������A��Ū���eŪ�� 0�C
*/

--�M���p�e�֨�
DBCC FREEPROCCACHE

--�M���p�e�֨���A�Ĥ@������w�x�{��select�ֶq��ơA����p�e�ϥ�"���޷j�M"
EXEC sp_QueryStore 10

/*
(9 �Ӹ�ƦC����v�T)
��ƪ� 'tbQueryStore'�C���y�p�� 1�A�޿�Ū�� 11�A����Ū�� 0�A�������A��Ū�� 0�AŪ���eŪ�� 0�A�������A��Ū���eŪ�� 0�ALOB �޿�Ū�� 0�ALOB ����Ū�� 0�ALOB �������A��Ū�� 0�ALOB Ū���eŪ�� 0�ALOB �������A��Ū���eŪ�� 0�C
*/

--�M���p�e�֨���A�ĤG������w�x�{��select�j�q��ơA����p�e�ϥ�"���޷j�M"�C
--�]������p�e���~�A�y���j�q���޿�Ū��
EXEC sp_QueryStore 10000 
/*
(9999 �Ӹ�ƦC����v�T)
��ƪ� 'tbQueryStore'�C���y�p�� 1�A�޿�Ū�� 10024�A����Ū�� 0�A�������A��Ū�� 0�AŪ���eŪ�� 0�A�������A��Ū���eŪ�� 0�ALOB �޿�Ū�� 0�ALOB ����Ū�� 0�ALOB �������A��Ū�� 0�ALOB Ū���eŪ�� 0�ALOB �������A��Ū���eŪ�� 0�C
*/

--�d�ߤw�g�^��������p�e
select * from sys.query_store_plan
