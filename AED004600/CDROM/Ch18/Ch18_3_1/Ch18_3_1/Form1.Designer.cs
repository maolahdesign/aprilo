namespace Ch18_3_1
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.tlsSQLTool = new System.Windows.Forms.ToolStrip();
            this.ToolStripLabel1 = new System.Windows.Forms.ToolStripLabel();
            this.tlstSQL = new System.Windows.Forms.ToolStripTextBox();
            this.ToolStripButton1 = new System.Windows.Forms.ToolStripButton();
            this.dgvOutput = new System.Windows.Forms.DataGridView();
            this.tlsSQLTool.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvOutput)).BeginInit();
            this.SuspendLayout();
            // 
            // tlsSQLTool
            // 
            this.tlsSQLTool.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ToolStripLabel1,
            this.tlstSQL,
            this.ToolStripButton1});
            this.tlsSQLTool.Location = new System.Drawing.Point(0, 0);
            this.tlsSQLTool.Name = "tlsSQLTool";
            this.tlsSQLTool.Size = new System.Drawing.Size(544, 25);
            this.tlsSQLTool.TabIndex = 2;
            this.tlsSQLTool.Text = "ToolStrip1";
            // 
            // ToolStripLabel1
            // 
            this.ToolStripLabel1.Name = "ToolStripLabel1";
            this.ToolStripLabel1.Size = new System.Drawing.Size(66, 22);
            this.ToolStripLabel1.Text = "SQL指令：";
            // 
            // tlstSQL
            // 
            this.tlstSQL.Font = new System.Drawing.Font("Microsoft JhengHei UI", 9F);
            this.tlstSQL.Name = "tlstSQL";
            this.tlstSQL.Size = new System.Drawing.Size(400, 25);
            this.tlstSQL.Text = "SELECT * FROM 學生";
            // 
            // ToolStripButton1
            // 
            this.ToolStripButton1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.ToolStripButton1.Image = ((System.Drawing.Image)(resources.GetObject("ToolStripButton1.Image")));
            this.ToolStripButton1.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.ToolStripButton1.Name = "ToolStripButton1";
            this.ToolStripButton1.Size = new System.Drawing.Size(35, 22);
            this.ToolStripButton1.Text = "查詢";
            this.ToolStripButton1.Click += new System.EventHandler(this.ToolStripButton1_Click);
            // 
            // dgvOutput
            // 
            this.dgvOutput.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvOutput.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvOutput.Location = new System.Drawing.Point(0, 0);
            this.dgvOutput.Name = "dgvOutput";
            this.dgvOutput.ReadOnly = true;
            this.dgvOutput.RowTemplate.Height = 24;
            this.dgvOutput.Size = new System.Drawing.Size(544, 271);
            this.dgvOutput.TabIndex = 3;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(544, 271);
            this.Controls.Add(this.tlsSQLTool);
            this.Controls.Add(this.dgvOutput);
            this.Name = "Form1";
            this.Text = "SQL查詢工具";
            this.tlsSQLTool.ResumeLayout(false);
            this.tlsSQLTool.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvOutput)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        internal System.Windows.Forms.ToolStrip tlsSQLTool;
        internal System.Windows.Forms.ToolStripLabel ToolStripLabel1;
        internal System.Windows.Forms.ToolStripButton ToolStripButton1;
        internal System.Windows.Forms.ToolStripTextBox tlstSQL;
        internal System.Windows.Forms.DataGridView dgvOutput;
    }
}

