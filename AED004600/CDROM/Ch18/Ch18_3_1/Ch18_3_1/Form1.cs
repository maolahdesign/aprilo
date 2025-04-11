using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Ch18_3_1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        public DataSet BindDatabase(string strSQL)
        {
            string strDbCon;
            SqlDataAdapter objAdapter;
            DataSet objDataSet = new DataSet();
            strDbCon = "Data Source=(local);Initial Catalog=教務系統" + ";Integrated Security=SSPI";
            try
            {
                using (SqlConnection objCon = new SqlConnection(strDbCon))
                {
                    objCon.Open();  // 開啟資料庫連線
                    objAdapter = new SqlDataAdapter(strSQL, objCon);
                    objAdapter.Fill(objDataSet, "Temp");
                    return objDataSet;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("錯誤: " + strSQL);
            }
            return null;
        }

        private void ToolStripButton1_Click(object sender, EventArgs e)
        {
            // 建立資料繫結
            dgvOutput.DataSource = BindDatabase(tlstSQL.Text).Tables["Temp"];
        }
    }
}
