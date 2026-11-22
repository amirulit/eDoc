using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_UserList : System.Web.UI.Page
{
    public Int32 Role { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboardUserList();
        }
    }

    private void LoadDashboardUserList()
    {
        Role = Convert.ToInt32(Session["Role"]);
        string branchCode = Convert.ToString(Session["BranchCode"]);

        string connectionString =
            ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Dashboard_User_List", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@Role", SqlDbType.Int).Value = Role;
                cmd.Parameters.Add("@BranchCode", SqlDbType.VarChar, 500).Value =
                   string.IsNullOrEmpty(branchCode)
                   ? (object)DBNull.Value
                   : branchCode;

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    GridView1.DataSource = dt;
                    GridView1.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        lblMsg.Text = "No User Data Found";
                    }
                    else
                    {
                        lblMsg.Text = "";
                    }
                }
            }
        }
    }

}