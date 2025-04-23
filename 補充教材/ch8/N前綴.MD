# `N` 前綴
在 SQL Server 中，資料值前面的 `N` 前綴表示這是一個 Unicode 字符串常量（Unicode string literal）。這個 `N` 代表 National Language Character Set 的縮寫。

使用 `N` 前綴的主要作用是：

1. **支援多語言文字** - 它告訴 SQL Server 後面的字符串是 Unicode 格式，使用 `nchar`、`nvarchar` 或 `ntext` 資料類型，而不是普通的 `char`、`varchar` 或 `text` 類型。

2. **避免字符轉換問題** - 當您需要存儲非英文字符（如中文、日文、韓文、阿拉伯文等）時，使用 `N` 前綴可以確保這些字符被正確處理和存儲。

3. **防止亂碼** - 對於中文等雙位元組字符，如果不使用 `N` 前綴而資料庫欄位又是 Unicode 類型，可能會導致字符轉換錯誤或亂碼。

在您的範例中：
```sql
INSERT INTO Employees (name, email, phone)
VALUES
(N'黃經理', N'manager.huang@3cstore.com', N'0912123123')
```

`N'黃經理'` 確保中文名稱能被正確處理，`N'manager.huang@3cstore.com'` 和 `N'0912123123'` 雖然只包含 ASCII 字符，加上 `N` 也不會有問題，但嚴格來說不是必須的，因為這些值不包含非 ASCII 字符。

總結來說，當處理包含非 ASCII 字符的字符串時，特別是亞洲文字，在 SQL Server 中使用 `N` 前綴是一個最佳實踐。