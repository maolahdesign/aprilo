# SQL Server 2022 資料庫角色（database role）成員資格的完整說明：

---

## 一、什麼是資料庫角色（Database Role）

資料庫角色是 SQL Server 中用來**集中管理資料庫層級權限**的安全主體（security principal），類似 Windows 的群組。你可以將多個使用者加入同一角色，並針對角色授權，讓權限管理更簡單一致。

---

## 二、資料庫角色的種類

### 1. **固定資料庫角色（Fixed Database Roles）**
這些角色在每個資料庫中都預先定義，無法刪除，且其權限不可更改（除了 public 角色）。常見角色如下：

| 角色名稱             | 說明                                                                                 |
|----------------------|--------------------------------------------------------------------------------------|
| db_owner             | 擁有資料庫內所有權限，可進行所有設定、維護與刪除資料庫。                             |
| db_securityadmin     | 可管理自訂角色成員資格與權限，具潛在權限提升風險，需加強監控。                       |
| db_accessadmin       | 可新增或移除 Windows 登入、群組及 SQL Server 登入對資料庫的存取權限。                |
| db_backupoperator    | 可執行資料庫備份。                                                                   |
| db_ddladmin          | 可執行任何 DDL（資料定義語言）指令，如建立、修改資料表等。                           |
| db_datawriter        | 可新增、修改、刪除所有使用者資料表的資料。                                           |
| db_datareader        | 可讀取所有使用者資料表與檢視表的資料。                                               |
| db_denydatawriter    | 不可新增、修改、刪除任何使用者資料表的資料。                                         |
| db_denydatareader    | 不可讀取任何使用者資料表與檢視表的資料。                                             |
| public               | 所有使用者預設皆屬於 public 角色，僅具備最基本的存取權限。                           |

> 除 public 外，這些角色的權限無法更改。db_owner 可管理其他角色的成員資格。

### 2. **自訂資料庫角色（User-Defined Database Roles）**
- 管理員可依需求自訂角色，並用 `GRANT`、`DENY`、`REVOKE` 指令調整權限。
- 適合細緻化權限控管與分工。

---

## 三、角色成員資格管理

- **新增成員：**
  ```sql
  ALTER ROLE db_datareader ADD MEMBER Troie;
  ```
- **移除成員：**
  ```sql
  ALTER ROLE db_datareader DROP MEMBER Troie;
  ```
- 可將任何資料庫帳號或其他資料庫角色加入角色，但**不建議將自訂角色加入固定角色**，避免權限意外擴大。

---

## 四、查詢角色成員資格

查詢所有資料庫角色及其成員：
```sql
SELECT roles.principal_id AS RolePrincipalID,
       roles.name AS RolePrincipalName,
       database_role_members.member_principal_id AS MemberPrincipalID,
       members.name AS MemberPrincipalName
FROM sys.database_role_members AS database_role_members
INNER JOIN sys.database_principals AS roles
    ON database_role_members.role_principal_id = roles.principal_id
INNER JOIN sys.database_principals AS members
    ON database_role_members.member_principal_id = members.principal_id;
```

---

## 五、注意事項

- **資料庫角色只適用於單一資料庫範圍**，無法授與伺服器層級權限。
- **登入（Login）與伺服器角色（Server Role）** 屬於伺服器層級，無法直接加入資料庫角色。
- **public 角色**：所有資料庫使用者預設皆屬於 public，無法移除。
- 權限管理建議：盡量以角色為單位授權，減少直接對使用者授權，方便維護與稽核。

---

## 六、常見應用範例

- **給資料分析師只讀權限：**
  ```sql
  ALTER ROLE db_datareader ADD MEMBER analyst_user;
  ```
- **給開發人員可寫入資料但不可刪除權限：**
  - 先加入 db_datawriter，再用 DENY 禁止 DELETE 權限。

---
