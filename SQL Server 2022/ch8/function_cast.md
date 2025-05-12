# `CAST()` 函數的詳細說明與應用範例**：


## **一、CAST() 核心功能**
### **定義**  
`CAST()` 用於將 **表達式** 轉換為指定的資料類型，屬於 **顯式類型轉換**。  
**語法**：  
```sql
CAST(expression AS target_data_type [ (length) ])
```
- **expression**：待轉換的值（如欄位、變數或字面量）  
- **target_data_type**：目標資料類型（如 `VARCHAR`、`INT`）  
- **length**（可選）：指定字串或二進位類型的長度  

---

## **二、跨資料庫支援**
| 資料庫        | 支援程度 | 特殊限制 |  
|---------------|----------|----------|  
| **SQL Server** | 完全支援 | 可轉換為 `datetime`、`money` 等特有類型 |  
| **MySQL**      | 支援基礎類型轉換 | 目標類型限 `DATE`、`SIGNED`、`CHAR` 等 |  
| **PostgreSQL** | 完全支援 | 需注意類型相容性（如 `TEXT` 轉 `JSON`） |  
| **Oracle**     | 使用 `TO_CHAR()` 等替代函數 | 無直接 `CAST()` 但語法兼容 |  

---

## **三、實務範例**
### **1. 基本類型轉換**
```sql
-- 將整數轉為 VARCHAR(10)
SELECT CAST(12345 AS VARCHAR(10)) AS string_value;  -- 輸出 '12345'

-- 將字串轉為 INT
SELECT CAST('987' AS INT) AS integer_value;  -- 輸出 987

-- 將浮點數轉為 DECIMAL(5,2)
SELECT CAST(123.4567 AS DECIMAL(5,2)) AS decimal_value;  -- 輸出 123.46
```

### **2. 日期與時間處理**
```sql
-- 字串轉 DATETIME（SQL Server）
SELECT CAST('2025-04-20 21:00:00' AS DATETIME) AS datetime_value;

-- UNIX 時間戳轉 DATE（MySQL）
SELECT CAST(FROM_UNIXTIME(1745197200) AS DATE) AS date_value;  -- 輸出 '2025-04-20'
```

### **3. 進階應用**
```sql
-- 動態拼接查詢結果（需顯式轉換）
SELECT '訂單編號: ' + CAST(OrderID AS VARCHAR(10)) AS order_info 
FROM Orders;

-- 處理 NULL 值（搭配 ISNULL）
SELECT CAST(ISNULL(NullableColumn, 0) AS INT) AS safe_int 
FROM TableName;
```

---

## **四、與 CONVERT() 的差異**
| 特性          | CAST() | CONVERT() |  
|---------------|--------|-----------|  
| **標準化**    | ANSI SQL 標準 | SQL Server 擴充功能 |  
| **樣式參數**  | 不支援 | 支援（如日期格式 `CONVERT(VARCHAR, GETDATE(), 112)`） |  
| **可讀性**    | 語法簡潔 | 需記憶樣式代碼 |  

---

## **五、錯誤處理與注意事項**
1. **類型相容性**：  
   ```sql
   SELECT CAST('ABC' AS INT);  -- 錯誤：轉換失敗
   ```
   **解決方案**：  
   ```sql
   SELECT TRY_CAST('ABC' AS INT);  -- SQL Server 返回 NULL 而非錯誤
   ```

2. **長度截斷**：  
   ```sql
   SELECT CAST('HelloWorld' AS VARCHAR(5));  -- 輸出 'Hello'
   ```

3. **隱含轉換風險**：  
   ```sql
   SELECT 1 + '2';  -- 可能成功（依資料庫設定）
   ```
   **建議寫法**：  
   ```sql
   SELECT 1 + CAST('2' AS INT);  -- 顯式轉換確保安全
   ```

---

## **六、效能最佳化**
1. **索引使用**：  
   ```sql
   -- 避免對 CAST 欄位直接建立索引
   CREATE INDEX idx_name ON TableName(CAST(column AS VARCHAR(10)));  -- 不推薦

   -- 改用持久化計算欄位
   ALTER TABLE TableName ADD column_varchar AS CAST(column AS VARCHAR(10));
   CREATE INDEX idx_name ON TableName(column_varchar);
   ```

2. **批次轉換**：  
   ```sql
   -- 修改資料表欄位類型（SQL Server）
   ALTER TABLE TableName 
   ALTER COLUMN ColumnName VARCHAR(20) NOT NULL;
   ```