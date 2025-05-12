CREATE TABLE Organization (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(50),
    Position NVARCHAR(50),
    Node hierarchyid  -- 儲存階層路徑
);

-- 建立索引以優化查詢
CREATE UNIQUE INDEX IX_Node ON Organization(Node);

-- 插入 CEO（根節點）
DECLARE @CEO hierarchyid = hierarchyid::GetRoot();
INSERT INTO Organization (EmployeeID, EmployeeName, Position, Node)
VALUES (1, 'Alice', 'CEO', @CEO);

-- 插入 CTO（CEO 的直接下屬）
DECLARE @CTO hierarchyid = @CEO.GetDescendant(NULL, NULL);
INSERT INTO Organization (EmployeeID, EmployeeName, Position, Node)
VALUES (2, 'Bob', 'CTO', @CTO);

-- 插入 CFO（與 CTO 同層級）
DECLARE @CFO hierarchyid = @CEO.GetDescendant(@CTO, NULL);
INSERT INTO Organization (EmployeeID, EmployeeName, Position, Node)
VALUES (3, 'Charlie', 'CFO', @CFO);

-- 插入 CTO 的團隊成員
DECLARE @DevLead hierarchyid = @CTO.GetDescendant(NULL, NULL);
INSERT INTO Organization (EmployeeID, EmployeeName, Position, Node)
VALUES (4, 'David', 'Development Lead', @DevLead);

-- 插入 CFO 的團隊成員
DECLARE @AccManager hierarchyid = @CFO.GetDescendant(NULL, NULL);
INSERT INTO Organization (EmployeeID, EmployeeName, Position, Node)
VALUES (5, 'Eve', 'Accounting Manager', @AccManager);

-- 查詢所有員工及其路徑（轉換為字串格式）
SELECT 
    EmployeeID, 
    EmployeeName, 
    Position, 
    Node.ToString() AS NodePath 
FROM Organization;

-- 查詢 CEO 的所有下屬
DECLARE @CEONode hierarchyid = (SELECT Node FROM Organization WHERE EmployeeID = 1);
SELECT * FROM Organization 
WHERE Node.IsDescendantOf(@CEONode) = 1;

-- 查詢 CTO 的直屬子節點
DECLARE @CTONode hierarchyid = (SELECT Node FROM Organization WHERE EmployeeID = 2);
SELECT * FROM Organization 
WHERE Node.GetAncestor(1) = @CTONode;
