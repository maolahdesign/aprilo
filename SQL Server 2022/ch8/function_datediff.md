## DATEDIFF 函數說明

**`DATEDIFF()`** 是 SQL 中常用的日期與時間運算函數，用來計算兩個日期或時間之間的差異，並以指定的單位（如天、月、年、時、分、秒等）回傳整數結果。這對於計算年齡、事件持續時間、資料過期天數等場景非常實用[6][1][2][3][4][5][7][8]。

---

## 語法

### SQL Server
```sql
DATEDIFF(datepart, startdate, enddate)
```
- **datepart**：指定回傳差異的單位（如 YEAR、MONTH、DAY、HOUR、MINUTE、SECOND 等）。
- **startdate**、**enddate**：要比較的兩個日期或時間，結果為 `enddate - startdate`[6][1][2][3][4][5][7][8]。

### MySQL
```sql
DATEDIFF(enddate, startdate)
```
- 只支援「天」為單位，回傳天數差[6][5]。

### PostgreSQL
- 沒有 DATEDIFF 函數，可用 `AGE(enddate, startdate)` 或直接相減（回傳 interval 型別）[6][5]。

---

## 常見用法範例

### 1. 計算兩日期間的天數
```sql
SELECT DATEDIFF(DAY, '2025-04-01', '2025-04-20') AS DaysDiff;
-- 結果：19
```

### 2. 計算年齡
```sql
SELECT DATEDIFF(YEAR, '2000-04-20', '2025-04-20') AS Age;
-- 結果：25
```

### 3. 計算活動持續時間
```sql
SELECT event_name, start_date, end_date,
       DATEDIFF(DAY, start_date, end_date) AS duration_in_days
FROM events;
```
|event_name|start_date |end_date   |duration_in_days|
|----------|-----------|-----------|---------------|
|Event A   |2023-10-01 |2023-10-05 |4              |

### 4. 篩選資料（如：查詢 30 天內的訂單）
```sql
SELECT * FROM orders
WHERE DATEDIFF(DAY, order_date, GETDATE()) <= 30;
```

---

## 注意事項

- 結果僅回傳「完整單位」的差異（如 DATEDIFF(MONTH, '2025-01-31', '2025-02-01') 回傳 1，即使只差一天）[6][1][2][3][4][5][7][8]。
- SQL Server 的 DATEDIFF 支援多種單位，MySQL 只支援天數[6][5]。
- 跨資料庫語法略有不同，請參照各系統文件[6][5]。

---

## 常見 datepart 值（SQL Server）

| datepart | 說明      |
|----------|-----------|
| YEAR     | 年        |
| QUARTER  | 季        |
| MONTH    | 月        |
| DAY      | 天        |
| HOUR     | 小時      |
| MINUTE   | 分鐘      |
| SECOND   | 秒        |

---

## 應用場景
- 計算年齡、資歷
- 活動或訂單的持續時間
- 過期資料的篩選
- 報表中時間差異分析

