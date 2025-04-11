namespace Ch18_3_2
{
    partial class Form1
    {
        /// <summary>
        /// 設計工具所需的變數。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清除任何使用中的資源。
        /// </summary>
        /// <param name="disposing">如果應該處置受控資源則為 true，否則為 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form 設計工具產生的程式碼

        /// <summary>
        /// 此為設計工具支援所需的方法 - 請勿使用程式碼編輯器修改
        /// 這個方法的內容。
        /// </summary>
        private void InitializeComponent()
        {
            this.PictureBox2 = new System.Windows.Forms.PictureBox();
            this.PictureBox1 = new System.Windows.Forms.PictureBox();
            this.txtName = new System.Windows.Forms.TextBox();
            this.Label6 = new System.Windows.Forms.Label();
            this.Button3 = new System.Windows.Forms.Button();
            this.Button2 = new System.Windows.Forms.Button();
            this.Button1 = new System.Windows.Forms.Button();
            this.txtBirthday = new System.Windows.Forms.TextBox();
            this.Label4 = new System.Windows.Forms.Label();
            this.txtTel = new System.Windows.Forms.TextBox();
            this.Label3 = new System.Windows.Forms.Label();
            this.txtSid = new System.Windows.Forms.TextBox();
            this.Label1 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.PictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // PictureBox2
            // 
            this.PictureBox2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.PictureBox2.Location = new System.Drawing.Point(12, 71);
            this.PictureBox2.Name = "PictureBox2";
            this.PictureBox2.Size = new System.Drawing.Size(208, 10);
            this.PictureBox2.TabIndex = 75;
            this.PictureBox2.TabStop = false;
            // 
            // PictureBox1
            // 
            this.PictureBox1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.PictureBox1.Location = new System.Drawing.Point(219, 21);
            this.PictureBox1.Name = "PictureBox1";
            this.PictureBox1.Size = new System.Drawing.Size(10, 129);
            this.PictureBox1.TabIndex = 74;
            this.PictureBox1.TabStop = false;
            // 
            // txtName
            // 
            this.txtName.Location = new System.Drawing.Point(60, 41);
            this.txtName.Name = "txtName";
            this.txtName.Size = new System.Drawing.Size(138, 22);
            this.txtName.TabIndex = 73;
            // 
            // Label6
            // 
            this.Label6.Location = new System.Drawing.Point(13, 38);
            this.Label6.Name = "Label6";
            this.Label6.Size = new System.Drawing.Size(48, 24);
            this.Label6.TabIndex = 72;
            this.Label6.Text = "姓名:";
            this.Label6.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // Button3
            // 
            this.Button3.Location = new System.Drawing.Point(246, 88);
            this.Button3.Name = "Button3";
            this.Button3.Size = new System.Drawing.Size(112, 32);
            this.Button3.TabIndex = 71;
            this.Button3.Text = "更新學號的記錄";
            this.Button3.Click += new System.EventHandler(this.Button3_Click);
            // 
            // Button2
            // 
            this.Button2.Location = new System.Drawing.Point(246, 49);
            this.Button2.Name = "Button2";
            this.Button2.Size = new System.Drawing.Size(112, 32);
            this.Button2.TabIndex = 70;
            this.Button2.Text = "刪除學號的記錄";
            this.Button2.Click += new System.EventHandler(this.Button2_Click);
            // 
            // Button1
            // 
            this.Button1.Location = new System.Drawing.Point(246, 12);
            this.Button1.Name = "Button1";
            this.Button1.Size = new System.Drawing.Size(112, 32);
            this.Button1.TabIndex = 69;
            this.Button1.Text = "搜尋學號的記錄";
            this.Button1.Click += new System.EventHandler(this.Button1_Click);
            // 
            // txtBirthday
            // 
            this.txtBirthday.Location = new System.Drawing.Point(59, 124);
            this.txtBirthday.Name = "txtBirthday";
            this.txtBirthday.Size = new System.Drawing.Size(139, 22);
            this.txtBirthday.TabIndex = 68;
            // 
            // Label4
            // 
            this.Label4.Location = new System.Drawing.Point(12, 121);
            this.Label4.Name = "Label4";
            this.Label4.Size = new System.Drawing.Size(51, 24);
            this.Label4.TabIndex = 67;
            this.Label4.Text = "生日:";
            this.Label4.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // txtTel
            // 
            this.txtTel.Location = new System.Drawing.Point(59, 93);
            this.txtTel.Name = "txtTel";
            this.txtTel.Size = new System.Drawing.Size(139, 22);
            this.txtTel.TabIndex = 66;
            // 
            // Label3
            // 
            this.Label3.Location = new System.Drawing.Point(7, 93);
            this.Label3.Name = "Label3";
            this.Label3.Size = new System.Drawing.Size(58, 24);
            this.Label3.TabIndex = 65;
            this.Label3.Text = "電話:";
            this.Label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // txtSid
            // 
            this.txtSid.Location = new System.Drawing.Point(60, 14);
            this.txtSid.Name = "txtSid";
            this.txtSid.Size = new System.Drawing.Size(138, 22);
            this.txtSid.TabIndex = 64;
            this.txtSid.Text = "S001";
            // 
            // Label1
            // 
            this.Label1.Location = new System.Drawing.Point(13, 11);
            this.Label1.Name = "Label1";
            this.Label1.Size = new System.Drawing.Size(48, 24);
            this.Label1.TabIndex = 63;
            this.Label1.Text = "學號:";
            this.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(364, 161);
            this.Controls.Add(this.PictureBox2);
            this.Controls.Add(this.PictureBox1);
            this.Controls.Add(this.txtName);
            this.Controls.Add(this.Label6);
            this.Controls.Add(this.Button3);
            this.Controls.Add(this.Button2);
            this.Controls.Add(this.Button1);
            this.Controls.Add(this.txtBirthday);
            this.Controls.Add(this.Label4);
            this.Controls.Add(this.txtTel);
            this.Controls.Add(this.Label3);
            this.Controls.Add(this.txtSid);
            this.Controls.Add(this.Label1);
            this.Name = "Form1";
            this.Text = "學生資料管理";
            ((System.ComponentModel.ISupportInitialize)(this.PictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        internal System.Windows.Forms.PictureBox PictureBox2;
        internal System.Windows.Forms.PictureBox PictureBox1;
        internal System.Windows.Forms.TextBox txtName;
        internal System.Windows.Forms.Label Label6;
        internal System.Windows.Forms.Button Button3;
        internal System.Windows.Forms.Button Button2;
        internal System.Windows.Forms.Button Button1;
        internal System.Windows.Forms.TextBox txtBirthday;
        internal System.Windows.Forms.Label Label4;
        internal System.Windows.Forms.TextBox txtTel;
        internal System.Windows.Forms.Label Label3;
        internal System.Windows.Forms.TextBox txtSid;
        internal System.Windows.Forms.Label Label1;
    }
}

