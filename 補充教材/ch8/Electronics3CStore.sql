
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