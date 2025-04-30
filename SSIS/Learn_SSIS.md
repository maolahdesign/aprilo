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
- [SQL Server Data Tools (SSDT)](https://learn.microsoft.com/zh-tw/sql/ssdt/download-sql-server-data-tools-ssdt?view=sql-server-ver16&tabs=vs2022)
- [SQL Server Integration Services Projects 2022](https://marketplace.visualstudio.com/items?itemName=SSIS.MicrosoftDataToolsIntegrationServices)

# SQL Server Integration Services (SSIS) 30小時課程大綱與參考資料

## 課程總覽
- 課程時長：30小時（含實作練習時間）
- 課程安排：第一天4小時，之後每天7小時（上午3小時，下午4小時），共計約5天
- 課程目標：讓學員掌握SSIS的核心概念與實作技能，能夠獨立開發、部署和管理企業級ETL解決方案

## 第一天 (4小時)

### 資料整合服務概覽 (4小時)

> **章節簡介**: 本章節介紹SSIS基本概念、歷史發展與在Microsoft BI生態系統中的定位。學員將了解ETL流程基礎知識、SSIS系統架構與開發環境設置，為後續實作打下堅實基礎。

**13:00-13:45 SSIS簡介及其在Microsoft BI架構中的角色**
- 什麼是SSIS (SQL Server Integration Services)
- SSIS的發展歷史：從DTS到SSIS
- SSIS在Microsoft BI生態系統中的位置
- SSIS與其他Microsoft BI工具（SSAS, SSRS）的關係
- SSIS的主要功能與應用場景

**13:45-14:30 ETL概念與最佳實踐介紹**
- ETL (Extract, Transform, Load) 基本概念
- Extract：資料擷取技術與策略
- Transform：資料轉換與清理方法
- Load：資料載入技術與最佳實踐
- 增量載入 vs. 完全載入
- CDC (Change Data Capture) 概念介紹
- ETL設計模式與最佳實踐

**14:30-14:45 休息**

**14:45-15:30 SSIS架構與元件詳解**
- SSIS系統架構與主要元件
- 控制流程 (Control Flow) 概念與元件
- 資料流程 (Data Flow) 概念與元件
- 事件處理系統
- 連線管理器 (Connection Managers)
- 變數與參數系統
- SSIS服務與代理程式

**15:30-17:00 Visual Studio與SSDT安裝與設定 & 基礎實作**
- SQL Server Data Tools (SSDT) 簡介
- 支援的Visual Studio版本
- SSDT安裝步驟與注意事項
- 環境設定與自訂選項
- 連接到不同版本的SQL Server
- 實作：安裝與設定開發環境
- 實作：建立簡單的SSIS專案

**參考資料與下載連結:**
- [SQL Server Integration Services 官方文件](https://docs.microsoft.com/zh-tw/sql/integration-services/sql-server-integration-services)
- [SQL Server Data Tools 下載](https://docs.microsoft.com/zh-tw/sql/ssdt/download-sql-server-data-tools-ssdt)
- [Microsoft Learn: SSIS 入門課程](https://learn.microsoft.com/zh-tw/sql/integration-services/sql-server-integration-services?view=sql-server-ver16)
- [ETL基礎概念白皮書](https://www.microsoft.com/zh-tw/download/details.aspx?id=14841)