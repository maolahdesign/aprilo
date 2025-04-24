
-- 創建資料庫
CREATE DATABASE Electronics3CStore;
GO

USE Electronics3CStore;
GO

-- 創建產品類別表
CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX)
);

-- 創建產品表
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name NVARCHAR(200) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    description NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 創建客戶表
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(20),
    address NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

-- 創建員工表
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(20),
    hire_date DATETIME DEFAULT GETDATE()
);

-- 創建訂單表
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    employee_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(12, 2) DEFAULT 0,
    status NVARCHAR(20) DEFAULT N'處理中',
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT FK_Orders_Employees FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- 創建訂單明細表
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal AS (quantity * unit_price) PERSISTED,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 創建產品品牌
CREATE TABLE Brands (
    boand_id INT PRIMARY KEY IDENTITY(1,1),
    boand_name NVARCHAR(100) NOT NULL
);

INSERT INTO Brands (boand_name)
VALUES 
('Acer'),('HUAWEI'),('HP'),('BenQ'),('LG'),('Apple'),('Lenovo'),('MSI'),('OPPO'),('Xiaomi'),('Asus'),('Samsung');

-- 插入產品類別
INSERT INTO Categories (category_name, description)
VALUES 
(N'筆記型電腦', N'各品牌筆記型電腦產品'),
(N'智慧型手機', N'各品牌智慧型手機產品'),
(N'平板電腦', N'各品牌平板電腦產品'),
(N'桌上型電腦', N'各品牌桌上型電腦產品'),
(N'顯示器', N'各品牌顯示器產品');

-- 插入產品資料
INSERT INTO Products (product_name, category_id, price, stock, description)
VALUES
-- 筆記型電腦
(N'ASUS VivoBook 15', 1, 22900.00, 15, N'15.6吋FHD/i5-1135G7/8G/512G PCIe SSD'),
(N'Acer Swift 3', 1, 25900.00, 10, N'14吋FHD/Ryzen 5 5500U/8G/512G PCIe SSD'),
(N'MSI Modern 14', 1, 21900.00, 8, N'14吋FHD/i5-1135G7/8G/512G PCIe SSD'),
(N'Apple MacBook Air M2', 1, 39900.00, 12, N'13.6吋/M2晶片/8G/256G SSD'),


-- 智慧型手機
(N'Apple iPhone 14', 2, 27900.00, 20, N'6.1吋/A15晶片/128G儲存空間'),
(N'Samsung Galaxy S23', 2, 25900.00, 15, N'6.1吋/高通驍龍8 Gen2/8G/256G'),
(N'OPPO Find X5', 2, 19900.00, 10, N'6.55吋/高通驍龍888/12G/256G'),
(N'Xiaomi 13', 2, 23900.00, 12, N'6.36吋/高通驍龍8 Gen2/8G/256G'),

-- 平板電腦
(N'Apple iPad Air', 3, 19900.00, 8, N'10.9吋/M1晶片/64G'),
(N'Samsung Galaxy Tab S8', 3, 21900.00, 6, N'11吋/高通驍龍8 Gen1/8G/128G'),
(N'Lenovo Tab P12 Pro', 3, 17900.00, 5, N'12.6吋/高通驍龍870/8G/256G'),
(N'HUAWEI MatePad Pro', 3, 15900.00, 7, N'10.8吋/麒麟990/8G/256G'),

-- 桌上型電腦
(N'ASUS ROG Gaming PC', 4, 42900.00, 4, N'i7-12700K/RTX 3070/32G/1TB SSD'),
(N'Acer Aspire TC', 4, 25900.00, 6, N'i5-12400/16G/512G SSD'),
(N'HP Pavilion Desktop', 4, 23900.00, 5, N'i5-12400/16G/512G SSD'),
(N'Apple Mac Mini M2', 4, 19900.00, 8, N'M2晶片/8G/256G SSD'),

-- 顯示器
(N'ASUS ProArt PA278CV', 5, 12900.00, 10, N'27吋/2K/IPS/專業色彩校準'),
(N'LG UltraGear 27GN800', 5, 9900.00, 12, N'27吋/2K/144Hz/1ms/電競螢幕'),
(N'BenQ PD2705Q', 5, 13900.00, 8, N'27吋/2K/IPS/設計專用'),
(N'Samsung Odyssey G5', 5, 10900.00, 9, N'32吋/2K/144Hz/1ms/曲面電競螢幕');

-- 插入客戶資料
INSERT INTO Customers (name, email, phone, address)
VALUES
(N'王小明', N'wang@example.com', N'0912345678', N'台北市信義區信義路5段7號'),
(N'李大華', N'li@example.com', N'0923456789', N'新北市板橋區文化路一段25號'),
(N'張美玲', N'chang@example.com', N'0934567890', N'台中市西區美村路一段22號'),
(N'陳志明', N'chen@example.com', N'0945678901', N'高雄市鼓山區美術館路80號'),
(N'林小芬', N'lin@example.com', N'0956789012', N'台南市東區大學路一段89號');

-- 插入員工資料
INSERT INTO Employees (name, email, phone)
VALUES
(N'黃經理', N'manager.huang@3cstore.com', N'0912123123'),
(N'吳專員', N'wu@3cstore.com', N'0923234234'),
(N'趙銷售', N'chao@3cstore.com', N'0934345345');

-- 插入訂單資料
INSERT INTO Orders (customer_id, employee_id, order_date, status)
VALUES
(1, 3, DATEADD(DAY, -10, GETDATE()), N'完成'),
(2, 2, DATEADD(DAY, -8, GETDATE()), N'完成'),
(3, 3, DATEADD(DAY, -6, GETDATE()), N'完成'),
(4, 1, DATEADD(DAY, -5, GETDATE()), N'完成'),
(5, 2, DATEADD(DAY, -4, GETDATE()), N'完成'),
(1, 3, DATEADD(DAY, -3, GETDATE()), N'完成'),
(2, 1, DATEADD(DAY, -2, GETDATE()), N'處理中'),
(3, 2, DATEADD(DAY, -1, GETDATE()), N'處理中'),
(4, 3, GETDATE(), N'處理中'),
(5, 1, GETDATE(), N'處理中');

-- 插入訂單明細資料
INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price)
VALUES
-- 訂單1
(1, 2, 1, 25900.00),
(1, 18, 1, 9900.00),

-- 訂單2
(2, 4, 1, 39900.00),
(2, 9, 1, 19900.00),

-- 訂單3
(3, 5, 1, 27900.00),
(3, 19, 1, 13900.00),

-- 訂單4
(4, 13, 1, 42900.00),
(4, 17, 1, 12900.00),
(4, 18, 1, 9900.00),

-- 訂單5
(5, 7, 1, 19900.00),
(5, 11, 1, 17900.00),

-- 訂單6
(6, 8, 1, 23900.00),
(6, 20, 1, 10900.00),

-- 訂單7
(7, 3, 1, 21900.00),
(7, 20, 1, 10900.00),

-- 訂單8
(8, 6, 1, 25900.00),

-- 訂單9
(9, 10, 1, 21900.00),
(9, 12, 1, 15900.00),

-- 訂單10
(10, 16, 1, 19900.00);

-- 平均一天賣 4 支 iPhone 14 幾天後會缺貨
SELECT stock/4 as 第幾天 FROM products where product_id=5

-- 庫存清單依格式呈現結果:ASUS VivoBook 15還有15個庫存
SELECT (product_name+'還有'+CAST(stock AS VARCHAR(10))+'個庫存') AS 庫存清單 FROM products;

-- 列出全部庫存產品(產品名稱，庫存年)
SELECT product_name as 產品名稱, DATEDIFF(yy,created_at,GETDATE()) as 庫存年 FROM products;

-- 列出所有的產品價格，排除重複的
SELECT distinct price FROM products

-- 列出前三名最貴的產品
SELECT top 3 * FROM products order by price desc

-- 列出庫存時間一年以上的產品(產品名稱，庫存年)
SELECT product_name as 產品名稱, DATEDIFF(yy,created_at,GETDATE()) as 庫存年 
FROM products 
where DATEDIFF(yy,created_at,GETDATE())>=1;

-- 列出庫存時間 2024 年以前及以後的產品(產品名稱，庫存年 ex 2023)
SELECT product_name as 產品名稱,  YEAR(created_at) as  庫存年  
FROM products 
where DATEDIFF(yy,created_at,GETDATE())!=1 ;

-- 列出庫存時間 2024 年以前及以後的產品(產品名稱，庫存年 ex 2023，使用邏輯運算子)
-- 列出庫存時間 2024 年以前即以後的產品(產品名稱，庫存年 ex 2023，使用邏輯運算子 not)
SELECT product_name as 產品名稱,  YEAR(created_at) as  庫存年  FROM products where not YEAR(created_at) = '2024';

-- 查詢所有產品名稱以 a 開頭的產品(產品名稱)
SELECT * FROM products where product_name like 'a%';

-- 查詢所有產品名稱第三個字是 e 的產品(產品名稱)
SELECT * FROM products where product_name like '__e%';

-- 筆電有哪些選擇?不要14吋的
SELECT * FROM products where category_id = 1 and product_name like '%[^4]'

-- 找出 2023-4-1 到 2024-7-1 期間上架的商品
SELECT * FROM products where created_at between '2023-4-1' and '2024-7-1'

-- 預算 20000 到 26000 的手機有哪些選擇
SELECT * FROM products where category_id = 2 and price between 20000 and 26000

-- 我想買手機跟桌上型電腦，有哪些建議?
SELECT * FROM products where category_id in (2,4)

-- 我想買十台電腦，預算不能超過25萬，有哪些推薦?
SELECT * FROM products where category_id in (1,4) and (price*10)<250000

-- 總共有多少電腦商品
SELECT count(*) FROM products where category_id in (1,4)

-- 總共有幾個產品分類
SELECT count(distinct category_id)  FROM products

-- 平板電腦平均售價是多少
SELECT AVG(price) as 平均售價 FROM products where category_id in (2)

-- 最貴的平板電腦跟最便宜的差多少錢
SELECT max(price)-min(price) as 差價 FROM products where category_id in (2)

-- 全部的筆電都買掉總收入是多少
SELECT sum(price * stock) FROM products where category_id=1

-- 各分類產品總金額是多少
SELECT sum(price * stock) FROM products group by category_id

-- 計算各分類產品總數
SELECT category_id,count(*) FROM products group by category_id 


-- 為每個分類建立群組
select category_id as 分類
from products
group by category_id 

-- 計算每個群組內有多少產品
select category_id as 分類,count(*) as 數量
from products
group by category_id 


-- apple 在每個分類各有多少產品
-- select category_id,brand_id
-- from products

-- select category_id,brand_id
-- from products
-- where brand_id=6

-- select category_id,brand_id
-- from products
-- group by category_id,brand_id
-- where brand_id=6

-- select category_id,brand_id,count(*) -- count(*) 計算重複發生次數
-- from products
-- group by category_id,brand_id
-- having brand_id=6

-- select category_id,brand_id,count(*)
-- from products
-- group by brand_id ,category_id 
-- having brand_id = 6

-- 哪幾個品牌手機有一支以上的選擇
-- 1.列出所有的手機產品
select brand_id
from products
where category_id = 2

-- 2.為每個手機品牌建立群組
select brand_id
from products
where category_id = 2
group by brand_id  -- 建立群組

-- 3.加入每個品牌手機數量計算
select brand_id,count(*) as 數量 -- 手機數量計算
from products
where category_id = 2
group by brand_id  

-- 4.加入限制條件
select brand_id,count(*)
from products
where category_id = 2
group by brand_id  
having count(*)>1 --一支以上選擇

-- 各分類的各品牌庫存及合計庫存
SELECT 
    brand_id, 
    category_id, 
    SUM(stock) AS TotalStock
FROM products
GROUP BY category_id, brand_id
WITH ROLLUP;

--各品牌的各產品庫存
SELECT 
    brand_id, 
    category_id, 
    SUM(stock) AS TotalStock
FROM products
GROUP BY brand_id,category_id
WITH ROLLUP;

SELECT 
    brand_id, 
    category_id, 
    SUM(stock) AS TotalStock
FROM products
GROUP BY GROUPING SETS (
    (brand_id, category_id),  -- 原始分組
    (brand_id),               -- brand_id 小計
    ()                        -- 總計
);



-- 查詢所有產品(產品編號，產品名稱，產品類別，價格，庫存)
SELECT p.product_id, p.product_name, c.category_name, p.price, p.stock 
FROM Products p
JOIN Categories c ON p.category_id = c.category_id;

-- 查詢所有訂單及總金額(訂單編號，客戶名稱，業務員，訂單日期，總數量，訂單狀態)
SELECT o.order_id, c.name AS customer_name, e.name AS employee_name, 
       o.order_date, o.total_amount, o.status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Employees e ON o.employee_id = e.employee_id;

-- 查詢訂單明細(訂單編號，產品名稱，數量 quantity，單價 unit_price，小計 subtota)
SELECT od.order_id, p.product_name, od.quantity, od.unit_price, od.subtotal
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
ORDER BY od.order_id;

-- 計算每個產品類別的銷售總額(產品類別，銷售總額)
SELECT c.category_name, SUM(od.subtotal) AS total_sales
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_sales DESC;

-- 查找最暢銷的產品前五名(產品名稱，總數量，銷售總額)
SELECT TOP 5 p.product_name, SUM(od.quantity) AS total_quantity, 
       SUM(od.subtotal) AS total_sales
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;