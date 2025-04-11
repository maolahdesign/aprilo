using System;
using System.Data.SqlClient;

namespace Ch20_4
{
    class Program
    {
        static void Main(string[] args)
        {
            // 設定連線字串
            string connString = "Server=localhost;User ID=MyDB;Password=Aa123456;Database=教務系統;";

            // 宣告SqlConnection物件
            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    // 開啟資料庫連線
                    conn.Open();

                    // 宣告SqlCommand物件，並設定T-SQL指令和SqlConnection物件
                    using (SqlCommand cmd = new SqlCommand("SELECT 課程編號, 名稱, 學分 FROM 課程 WHERE 學分 >= 3", conn))
                    {
                        // 宣告SqlDataReader物件，並執行查詢指令
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            // 顯示查詢結果
                            while (reader.Read())
                            {
                                Console.WriteLine("{0}\t{1}\t{2}", reader[0], reader[1], reader[2]);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
            Console.Read();
        }
    }
}

