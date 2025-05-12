

# **資料倉儲簡介與實務應用**

## 目標
- 理解資料倉儲的定義、核心特點及其在企業中的角色。
- 認識資料倉儲與交易型資料庫（OLTP）的區別。
- 學習資料倉儲的運作流程（ETL）及其技術工具。
- 透過 `Electronics3CStore` 資料庫的實務範例，展示資料倉儲的建置與應用。
- 使用視覺化圖表（星型模型、ETL 流程）強化理解。


## 一、什麼是資料倉儲？

### 簡單定義
資料倉儲（Data Warehouse）是一個集中式儲存庫，**專為儲存、整合和管理大量歷史數據而設計**，支援商業分析、報表生成和決策制定。它就像一座「**數據博物館**」，將來自多個來源的數據整理成統一格式，方便企業挖掘洞見。

### 詳細定義
資料倉儲是一個專門用於**分析型處理**（OLAP）的系統，**儲存從多個來源**（例如交易資料庫、ERP、CRM、Excel）提取並整合的數據。它採用特定結構（如星型模型或雪花模型）組織數據，優化大規模查詢效能，與交易型資料庫（OLTP，如 `Electronics3CStore`）不同，後者注重即時交易處理。

![資料倉儲](image/data_warehouse_visualization.svg)

**總結：**  
OLTP 強調即時性與交易正確性，適合日常營運系統；OLAP 則著重於資料的多維分析與決策支援，適合資料倉儲與商業智慧應用。

## 二、資料倉儲的核心特點

1. **主題導向（Subject-Oriented）**  
   - 數據圍繞業務主題組織，例如銷售、客戶、庫存，而非應用程式或流程。
   - **範例**：`Electronics3CStore` 的資料倉儲可能聚焦「銷售分析」，包含 `Sales.Orders` 和 `Sales.OrderDetails` 的歷史數據。

2. **整合性（Integrated）**  
   - 將不同來源的數據統一格式、清理並整合，消除不一致性。
   - **範例**：整合 `Electronics3CStore` 的線上訂單（JSON 格式）與實體店 POS 資料（CSV 格式）。

3. **時間變異性（Time-Variant）**  
   - 儲存長期歷史數據，反映過去某個時間點的狀態。
   - **範例**：分析 `Electronics3CStore` 過去 5 年的銷售趨勢。

4. **非揮發性（Non-Volatile）**  
   - 數據一旦載入，通常只讀不改，保持穩定以供分析。
   - **範例**：`Electronics3CStore` 的訂單數據在倉儲中不允許修改，確保分析一致性。

## 三、資料倉儲與交易型資料庫的區別

OLTP（線上交易處理）與 OLAP（線上分析處理）是資料庫系統的兩種主要應用，兩者在設計目標、資料型態、查詢方式及應用場景上有明顯差異，整理如下：

| **項目**         | **OLTP（線上交易處理）**             | **OLAP（線上分析處理）**           |
|--------------|---------------------------------------|----------------------------------------|
| **主要目的**     | 處理大量即時交易（如訂單、庫存更新、帳戶管理） | 分析、彙總資料，支援決策與趨勢發現           |
| **資料型態**     | 當前、細節化、結構化的營運資料              | 歷史、彙總或多維度的分析資料                |
| **查詢類型**     | 高頻率、簡單、快速的查詢（如新增、修改、刪除） | 低頻率、複雜、需大量計算的查詢（如統計、報表）|
| **資料庫設計**  | 標準化（如第三正規化），強調一致性與效率      | 去正規化（如星型、雪花型），優化查詢效能      |
| **效能需求**     | 需極低延遲、高併發、即時回應                | 需高吞吐量、大量運算能力，允許較長查詢時間    |
| **硬體需求**     | 高可用性、低延遲、支援大量並發              | 大量記憶體、儲存空間，支援大數據運算          |
| **應用場景**     | 銀行交易、訂單處理、線上支付、庫存管理       | 銷售分析、財務報表、預測分析、資料挖掘        |


![資料倉儲 vs. OLTP](image/data_warehouse_vs_oltp.svg)

- **說明**：左側（OLTP）顯示 `Electronics3CStore` 的正規化表格（`Orders`, `OrderDetails`），右側（資料倉儲）顯示星型模型，包含事實表（銷售）與維度表（產品、時間、客戶）。


## 四、資料倉儲資料處理流程（ETL）

資料倉儲的資料處理遵循 **ETL（Extract, Transform, Load）** 流程。

### 1. 資料流入階段（Inflow）
#### 核心流程
- **資料萃取（Extraction）**  
  從異質來源（如OLTP系統、IoT設備、API）提取原始資料，需處理不同格式（CSV、JSON、資料庫表）與協定（ODBC、RESTful）。
- **資料淨化（Cleansing）**  
  處理缺失值、重複記錄、格式不一致問題，例如統一日期格式（YYYY-MM-DD）與貨幣單位（USD/TWD）。
- **資料載入（Loading）**  
  將清洗後資料存入暫存區（Staging Area），為後續轉換做準備，常用批量載入或增量更新（CDC技術）。

#### 工具與技術
- **ETL工具**：Apache NiFi（資料流管理）、AWS Glue（雲端自動化ETL）、FineDataLink（低程式碼整合）。
- **資料湖整合**：搭配Amazon S3或Azure Data Lake儲存原始資料，支援結構化與非結構化資料混合處理。

---

### 2. 資料加值階段（Upflow）
#### 核心流程
- **資料聚合（Summarizing）**  
  建立多層次彙總表（如日銷售報表→月區域分析），降低查詢複雜度。
- **維度建模（Packaging）**  
  轉換為星型/雪花模型，例如將交易表拆分為事實表（銷售金額）與維度表（產品、時間）。
- **資料散播（Distribution）**  
  將處理後資料分發至資料市集（Data Mart）或BI工具（如Tableau、Power BI）。

#### 工具與技術
- **轉換引擎**：dbt（SQL-based轉換）、Spark SQL（分散式處理）。
- **即時處理**：Kafka Streams或Flink實現流式聚合，用於庫存即時監控等場景。

---

### 3. 資料歸檔階段（Downflow）
#### 核心流程
- **資料典藏（Archiving）**  
  將歷史資料（如5年前交易記錄）遷移至低成本儲存（AWS Glacier、冷儲存資料庫）。
- **備份策略（Backup）**  
  採用差異備份（每日增量）與全量備份（每週完整快照），確保災難復原能力。

#### 工具與技術
- **雲端備份服務**：AWS Backup、Azure Backup。
- **壓縮技術**：Parquet/ORC格式降低儲存成本，提升查詢效率。

---

### 4. 資料輸出階段（Outflow）
#### 核心流程
- **報表生成**  
  透過OLAP工具（如SSAS、Power BI）建立多維度分析模型。
- **API服務**  
  以GraphQL/RESTful API提供資料服務，支援應用程式整合。
- **即時儀表板**  
  使用Grafana或Superset實現銷售趨勢即時監控。

#### 工具與技術
- **BI平台**：Tableau（視覺化分析）、Looker（嵌入式分析）。
- **資料沙盒**：建立實驗環境供資料科學團隊測試機器學習模型。

---

### 5. 中繼資料管理（Meta-flow）
#### 核心功能
- **資料血緣追蹤**  
  記錄資料從來源到報表的完整路徑，滿足合規性要求（如GDPR）。
- **資料字典**  
  定義欄位意義（如「客戶ID」的編碼規則與關聯表）。
- **版本控制**  
  管理ETL腳本與資料模型變更歷史，支援回滾機制。

#### 工具與技術
- **中繼資料平台**：Apache Atlas（Hadoop生態系）、Alation（企業級資料目錄）。
- **自動化文件**：Dataedo自動生成資料庫文件與ER圖。


## 資料倉儲組件架構
### 1. 載入管理器（Load Manager）
#### 核心功能
- **異質資料源整合**  
  支援資料庫（Oracle/MySQL）、雲端服務（Salesforce API）、文件（PDF文字萃取）。
- **暫存區設計**  
  使用記憶體資料庫（Redis）加速轉換，或雲端物件儲存（S3）處理大檔案。

#### 技術架構
```text
資料源 → 擷取連接器 → 暫存區（Staging Area） → 轉換引擎 → 目標倉儲
```
- **案例工具**：Informatica PowerCenter（企業級ETL）、Talend Open Studio（開源整合）。

---

### 2. 倉儲管理器（Warehouse Manager）
#### 核心功能
- **資料分區（Partitioning）**  
  按時間（年月分區）或業務維度（區域分區）優化查詢效能。
- **索引策略**  
  建立聚合索引（如每月銷售彙總）與全文檢索（產品描述搜索）。
- **資料安全**  
  實施欄位級加密（AES-256）與動態遮罩（如隱藏客戶電話中間四碼）。

---

### 3. 查詢管理器（Query Manager）
#### 核心功能
- **查詢優化**  
  使用查詢重寫（Query Rewrite）將OLAP請求轉為預計算聚合表查詢。
- **並行控制**  
  透過資源池（Resource Pool）限制複雜查詢的CPU/記憶體用量。
- **快取機制**  
  使用Redis快照儲存熱門報表結果，降低重複計算負載。

---
![ETL 流程](image/etl_process_visualization.svg)
- **說明**：圖示顯示從 `Electronics3CStore`（來源）提取訂單數據，經過 SSIS 轉換（清洗、聚合），載入資料倉儲（星型模型）。

## 五、資料倉儲的技術與工具

### 1. 資料庫
- **SQL Server**：支援資料倉儲建置，與 SSIS、SSAS 整合。
- **雲端選項**：Snowflake、Google BigQuery、Azure Synapse Analytics。
- **範例**：使用 SQL Server 2022 為 `Electronics3CStore` 建立資料倉儲。

### 2. ETL 工具
- **SQL Server Integration Services (SSIS)**：執行 ETL 流程，支援多源數據整合。
- **其他工具**：Informatica、Talend、Apache Nifi。
- **範例**：SSIS 封裝從 `Electronics3CStore` 提取 `Sales.Orders`，轉換後載入資料倉儲。

### 3. 分析工具
- **SQL Server Analysis Services (SSAS)**：建立多維模型（OLAP 立方體），支援銷售分析。
- **Power BI**：生成視覺化報表，例如 `Electronics3CStore` 的銷售趨勢圖。
- **範例**：Power BI 連接到資料倉儲，顯示「按地區的產品銷售」儀表板。

### **多方位資料建模（Multi-Dimensional Data Modeling）說明**

多方位資料建模是一種專為分析型系統設計的資料結構方法，**以維度（Dimensions）和量值（Measures）為核心**，將資料組織成多維立方體（Cube），支持從不同業務角度進行快速查詢與分析。此模型廣泛應用於商業智慧（BI）和資料倉儲系統。

---

#### **核心組成元素**
1. **維度（Dimensions）**  
   - **定義**：描述業務實體的屬性（如時間、地點、產品），用於切割分析視角。  
   - **結構**：包含階層（Hierarchy）與層級（Level），例如時間維度可細分為「年→季→月→日」。  
   - **範例**：  
     - **產品維度**：類別→品牌→型號  
     - **地理維度**：國家→城市→店鋪  

2. **量值（Measures）**  
   - **定義**：需計算的數值指標（如銷售額、庫存量），通常存儲於事實表（Fact Table）。  
   - **類型**：  
     - **可加量值**：可跨維度彙總（如銷售量）。  
     - **半可加量值**：僅部分維度可加（如庫存需按時間彙總）。  
     - **不可加量值**：需特殊計算（如毛利率）。  

3. **多維立方體（Cube）**  
   - **架構**：由多個維度交叉形成的資料結構，支持快速切片（Slice）、切塊（Dice）、下鑽（Drill-down）等操作。  
   - **範例**：銷售分析Cube可從「時間×產品×地區」三個維度交叉分析銷售額。

---

#### **設計架構類型**
| 架構類型      | 星型模型（Star Schema）                | 雪花模型（Snowflake Schema）          |
|---------------|----------------------------------------|----------------------------------------|
| **結構**      | 單層維度表直接連結事實表               | 維度表進一步正規化為多層關聯表         |
| **查詢效率**  | 高（減少表連接）                       | 較低（需多層連接）                     |
| **儲存效率**  | 較低（重複資料多）                     | 較高（減少冗餘）                       |
| **應用場景**  | 即時報表、OLAP分析                     | 複雜維度管理、高度正規化需求           |

---

#### **實例：零售銷售分析模型**
##### **1. 維度設計**
- **時間維度**：  
  ```sql
  CREATE TABLE DimTime (
    TimeKey INT PRIMARY KEY,
    Date DATE,
    Month VARCHAR(20),
    Quarter CHAR(2),
    Year INT
  );
  ```
- **產品維度**：  
  ```sql
  CREATE TABLE DimProduct (
    ProductKey INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    Category NVARCHAR(100),
    Brand NVARCHAR(100)
  );
  ```

##### **2. 事實表設計**
```sql
CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    TimeKey INT FOREIGN KEY REFERENCES DimTime(TimeKey),
    ProductKey INT FOREIGN KEY REFERENCES DimProduct(ProductKey),
    StoreKey INT,
    SalesAmount DECIMAL(18,2),
    Quantity INT
);
```

##### **3. 多維分析操作**
- **切片**：分析「2023年Q3」的銷售數據。  
- **下鑽**：從「年度銷售額」下鑽至「各月銷售趨勢」。  
- **旋轉**：將行列從「產品類別×地區」切換為「時間×銷售管道」。

---

#### **視覺化說明**
##### **1. 星型模型架構圖**
```text
          +-----------------+
          |   FactSales     |
          +--------+--------+
          | SalesKey        |
          | TimeKey         +------+
          | ProductKey      |      |
          | StoreKey        |      |
          | SalesAmount     |      |
          | Quantity        |      |
          +--------+--------+      |
                   |               |
                   |               |
        +----------v-------+   +---v---------------+
        |   DimProduct     |   |   DimTime         |
        +------------------+   +-------------------+
        | ProductKey       |   | TimeKey           |
        | ProductName      |   | Date              |
        | Category         |   | Month             |
        | Brand            |   | Quarter           |
        +------------------+   | Year              |
                               +-------------------+
```

##### **2. 多維立方體操作示意**
```text
               +-------------------+
               | 銷售額分析Cube    |
               | 維度: 時間×產品×地區 |
               +---------+---------+
                         |
         +---------------v----------------+
         | 時間: 2023年Q3                 |
         | 產品: 電子產品類別              |
         | 地區: 北區                     |
         +----------------+---------------+
                         |
         +---------------v----------------+
         | 量值: 銷售額 $1,200,000        |
         | 訂單數: 850                    |
         +--------------------------------+
```

---

#### **應用工具與技術**
- **開發工具**：  
  - Microsoft SSAS（SQL Server Analysis Services）  
  - Oracle OLAP  
  - SAP BW  
- **視覺化工具**：  
  - Tableau（多維度交叉分析）  
  - Power BI（鑽取報表與矩陣視圖）  
  - QlikView（關聯式模型探索）  

---

#### **進階應用：動態多維分析**
結合機器學習技術實現預測性分析，例如：  
- **銷售預測**：以歷史銷售Cube訓練時間序列模型，預測未來季度需求。  
- **異常檢測**：在多維度中標記偏離正常範圍的銷售波動（如特定地區庫存異常）。  

此建模方法透過結構化維度與量值，將複雜業務邏輯轉換為直觀分析路徑，是現代資料驅動決策的基礎架構。

## 六、實務範例：`Electronics3CStore` 資料倉儲

### 情境
`Electronics3CStore` 是一家電商公司，數據分散在：
- **交易資料庫**：`Sales.Orders`, `Sales.OrderDetails`, `Customers` 等。
- **外部來源**：供應商 CSV（產品庫存）、線上廣告 API（點擊數據）。
- **需求**：
  - 分析過去 5 年的銷售趨勢，按產品、地區、時間分組。
  - 生成報表，支援庫存管理和行銷決策。

3. **分析與報表**
   - 使用 **SSAS** 建立 OLAP 立方體，支援多維分析（例如按產品和地區的銷售）。
   - 使用 **Power BI** 生成視覺化報表：
     - **範例報表**：柱狀圖顯示「2025 年按地區的產品銷售額」。
   - **T-SQL 查詢範例**：
     ```sql
     SELECT 
         p.CategoryName,
         c.Region,
         t.Year,
         SUM(f.SalesAmount) AS TotalSales
     FROM Fact_Sales f
     JOIN Dim_Product p ON f.ProductKey = p.ProductKey
     JOIN Dim_Customer c ON f.CustomerKey = c.CustomerKey
     JOIN Dim_Time t ON f.TimeKey = t.TimeKey
     GROUP BY p.CategoryName, c.Region, t.Year;
     ```

## 七、資料倉儲的好處與挑戰

### 好處
1. **決策支援**：提供全面數據視圖，幫助企業發現趨勢（例如 `Electronics3CStore` 的熱銷產品）。
2. **效能提升**：星型模型優化查詢速度，不影響交易系統（參考前文 OLTP vs. OLAP）。
3. **數據一致性**：整合多源數據，確保分析可靠。
4. **前文連結**：資料倉儲支援前文的備份計畫（例如分析歷史備份日誌）。

### 挑戰
1. **建置成本**：需要硬體（例如 NVMe SSD，參考前文 1TB 備份）、ETL 設計和維護。
2. **更新延遲**：批次更新不適合即時需求（例如 `Electronics3CStore` 的即時訂單）。
3. **複雜性**：星型模型和 SSIS 封裝設計需要專業知識。



```mermaid
graph LR
    A[來源<br>Electronics3CStore<br>CSV, API] -->|提取| B[SSIS<br>清洗、轉換]
    B -->|載入| C[資料倉儲<br>maolah_DW<br>Fact_Sales, Dim_*]
    C -->|分析| D[Power BI<br>SSAS]
