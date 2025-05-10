# SQL Server Integrated Service ETL

SQL Server Integration Services (SSIS)，這是 Microsoft SQL Server 提供的一個企業級數據整合和轉換平台。SSIS 是一個 ETL（Extract, Transform, Load，即擷取、轉換、載入）工具，用於：

1. 從各種不同的數據源中提取數據
2. 對數據進行清理、轉換和整合
3. 將處理後的數據載入目標系統（通常是數據倉庫）

有時候人們會非正式地將其稱為 "SQL Server Integrated Service ETL"，強調其 ETL 功能，但正確的官方名稱是 SQL Server Integration Services (SSIS)。

SSIS 是 SQL Server 商業智慧(BI)套件的一部分，與 SQL Server Analysis Services (SSAS) 和 SQL Server Reporting Services (SSRS) 共同組成 SQL Server 的商業智慧解決方案。

- 資料整合服務概覽 
- SSIS Data Tools環境介紹 
- SSIS封裝部署與執行 
- SSIS中的簡易輔助工具 
- SSIS的運算式 
- 傳送和維護資料庫物件的相關工作 
- 資料流程 
- 容器交易與管理 
- 分析服務整合 
- SSIS的安全架構 
- SSIS的進階設計

## 建立環境
- [Visual Studio](https://visualstudio.microsoft.com/zh-hant/downloads/?cid=learn-onpage-download-install-visual-studio-page-cta)
- [SQL Server Data Tools (SSDT)](https://learn.microsoft.com/zh-tw/sql/ssdt/download-sql-server-data-tools-ssdt?view=sql-server-ver16&tabs=vs2022)
- [SQL Server Integration Services Projects 2022](https://marketplace.visualstudio.com/items?itemName=SSIS.MicrosoftDataToolsIntegrationServices)
- Open SSMS
  1. Create Database SSIS
  2. open download/ssis/SettingUp.sql
  3. use SSIS
  4. exec SettingUp.sql
- Setup Tools -> option
- Setup Window
- Create New Project
- 卸載\ 開啟專案
- Open SSIS ToolBar extensions->SSIS
- 5 tabs check 
  Data Flow Tab
  每個 tab 都有專用的工具<如果找不到就是在錯誤的 tab

### Data Flow

    
### connection manager
- Open SSMS
  1. Create Database TAIWANJOBS
  2. import CSV file(data 台灣就業通網站職缺清單.csv)
     工作 -> 匯入一般檔案
- 匯入練習
  - 104.csv 匯入 tbl JOBS
- 練習一
    1. 建立一個新 package/project
    2. source tbl JOB_LISTINGS
    3. destination tbl NEW_JOB_LISTINGS
    
    ```sql
    CREATE TABLE [dbo].[NEW_JOB_LISTINGS](
        [OCCU_DESC] [nvarchar](100) NULL,
        [JOB_PERSON] [tinyint] NOT NULL,
        [JOB_DETAIL] [nvarchar](1400) NOT NULL,
        [CITYNAME] [nvarchar](50) NOT NULL,
        [WKTIME] [nvarchar](50) NULL,
        [SALARYCD] [nvarchar](50) NOT NULL,
        [EDGRDESC] [nvarchar](50) NOT NULL,
        [COMPNAME] [nvarchar](50) NOT NULL,
    )
    ``` 
    
## 轉換 Transforming

- 轉換驗證
- data conversion
- derived column
- 練習二
    1. 清空 NEW_JOB_LISTINGS
    2. 使用 data conversion 導入資料
- 練習三
    1. 清空 NEW_JOB_LISTINGS
    2. 將 [NEW_JOB_LISTINGS] [JOB_PERSON] 資料型態改為 [varchar](5) NOT NULL
    3. 使用 derived column 導入資料 
    4. 建立 NUMBER_OF_PEOPLE 對應 JOB_PERSON