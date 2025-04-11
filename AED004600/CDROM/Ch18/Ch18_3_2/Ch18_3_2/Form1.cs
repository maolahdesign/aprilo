using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Ch18_3_2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        // 程序：使用交易執行一個或兩個SQL操作指令
        public void ExecuteSQL(string strSQL1, string strSQL2)
        {
            SqlCommand objCmd;
            SqlTransaction objTran;
            string strDbCon;
            strDbCon = "Data Source=(local);Initial Catalog=教務系統" + ";Integrated Security=SSPI";
            using (SqlConnection objCon = new SqlConnection(strDbCon))
            {
                objCon.Open();  // 開啟資料庫連線
                                // 開始交易
                objTran = objCon.BeginTransaction();
                objCmd = objCon.CreateCommand();
                objCmd.Transaction = objTran;  // 指定屬性
                try
                {
                    objCmd.CommandText = strSQL1;
                    // 執行第一個SQL指令
                    objCmd.ExecuteNonQuery();
                    if (((strSQL2.Trim()).Length) != 0)
                    {
                        objCmd.CommandText = strSQL2;
                        // 執行第二個SQL指令
                        objCmd.ExecuteNonQuery();
                    }
                    objTran.Commit();    // 認可交易
                }
                catch (Exception ex)
                {
                    MessageBox.Show("T-SQL指令執行失敗!");
                    objTran.Rollback();  // 回復交易
                }
            }
        }

        // 函數：取得學生資料的ArrayList物件
        public ArrayList GetStudentData(string stdno)
        {
            SqlCommand objCmd;
            SqlDataReader objDataReader;
            string strDbCon, strSQL;
            ArrayList student = new ArrayList();
            strDbCon = "Data Source=(local);Initial Catalog=教務系統" + ";Integrated Security=SSPI";
            using (SqlConnection objCon = new SqlConnection(strDbCon))
            {
                objCon.Open();  // 開啟資料庫連線
                strSQL = "SELECT * FROM 學生 ";
                strSQL += "WHERE 學號 = '" + stdno + "'";
                objCmd = new SqlCommand(strSQL, objCon);
                objDataReader = objCmd.ExecuteReader();
                // 取得資料表的記錄資料
                if (objDataReader.Read())
                {
                    student.Add(objDataReader["姓名"]);
                    student.Add(objDataReader["電話"]);
                    student.Add(objDataReader["生日"]);
                }
                else
                {
                    student.Add("N/A");
                    student.Add("N/A");
                    student.Add("N/A");
                }
                objDataReader.Close();
            }
            return student;  // 傳回學生資料的ArrayList
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            // 查詢學生資料
            ArrayList student = GetStudentData(txtSid.Text);
            // 顯示學生資料
            txtName.Text = student[0].ToString();
            txtTel.Text = student[1].ToString();
            txtBirthday.Text = student[2].ToString();
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            string strSQL;
            DialogResult result;
            result = MessageBox.Show("確定刪除學號的記錄:" + txtSid.Text, "確認操作", MessageBoxButtons.YesNo);
            if  (result == DialogResult.Yes)
            {
                // 建立SQL刪除記錄資料
                strSQL = "DELETE FROM 學生 WHERE 學號 = '";
                strSQL += txtSid.Text + "'";
                ExecuteSQL(strSQL, "");   // 執行SQL
            }
        }

        private void Button3_Click(object sender, EventArgs e)
        {
            string strSQL1, strSQL2;
            // 建立SQL敘述更新資料庫記錄
            DateTime birthday = DateTime.Parse(txtBirthday.Text);
            strSQL1 = "UPDATE 學生 SET ";
            strSQL1 += "電話='" + txtTel.Text + "'";
            strSQL1 += " WHERE 學號 ='" + txtSid.Text + "'";
            strSQL2 = "UPDATE 學生 SET ";
            strSQL2 += "生日='" + birthday.ToShortDateString() + "'";
            strSQL2 += " WHERE 學號 ='" + txtSid.Text + "'";
            ExecuteSQL(strSQL1, strSQL2);   // 執行SQL 
            MessageBox.Show("已經更新學號的記錄!");
        }
    }
}
