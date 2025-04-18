# 函數搭配參數
Function objectPath {"路徑為" + $args[0]  + "`\" +  $args[1] }
# 呼叫函數，因為如同一般命令，所以參數間不以逗號分隔
objectPath a b

Function objectPath2 ($x, $y)
{
    $ObjectPath = $x + "`\" + $y
    write-Host "路徑為 $ObjectPath"
}
objectPath a b

# 函數使用 "param"
# param 的宣告必須在第一行，在它之前只能有空白或註解
Function objectPath3
{
    param ($x, $y)
    $ObjectPath = $x + "`\" + $y
     write-Host "路徑為 $ObjectPath"   
}
objectPath3 a b
