using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_Ongoing : System.Web.UI.Page
{
    public Int32 Role { get; set; }

    public Int32 BranchCode { get; set; }


    protected void Page_Load(object sender, EventArgs e)
    {

        //Role = Convert.ToInt32(Session["Role"]);


        //BranchCode = Convert.ToInt32(Session["BranchCode"]);
        

        //Int32 Entry_Status = Convert.ToInt32(Request.QueryString[0].ToString());

        //String connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    using (SqlCommand cmd = new SqlCommand("usp_Dashboard_Uploaded_Sanction", con))
        //    {
        //        cmd.CommandType = CommandType.StoredProcedure;

        //        //cmd.Parameters.Add("@sanction_segment", SqlDbType.VarChar, 500).Value = sanctionSegment;

        //        cmd.Parameters.Add("@Role", SqlDbType.Int, 500).Value = Role;

        //        cmd.Parameters.Add("@Entry_Status", SqlDbType.Int, 500).Value = Entry_Status;


        //        cmd.Parameters.Add("@BranchCode", SqlDbType.VarChar, 500).Value = BranchCode;


        //        con.Open();

        //        using (SqlDataReader rdr = cmd.ExecuteReader())
        //        {
        //            if (rdr.Read())
        //            {
        //                GridView1.DataSource = rdr;
        //                GridView1.DataBind();

        //            }
        //            else
        //            {
        //                lblMsg.Text = "No Data Found";
        //            }
        //        }
        //    }
        //}


        LoadUploadedSanction();
            
    }


    private void LoadUploadedSanction()
    {
        Role = Convert.ToInt32(Session["Role"]);

        // BranchCode should be string because SQL parameter is VARCHAR
        string branchCode = Convert.ToString(Session["BranchCode"]);

        int entryStatus = Convert.ToInt32(Request.QueryString[0].ToString());
        object statusValue = DBNull.Value;

        if (int.TryParse(Request.QueryString["Entry_Status"], out entryStatus))
        {
            statusValue = entryStatus;
        }

        string connectionString =
            ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(
                "usp_Dashboard_Ongoing_Checklist", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@Role", SqlDbType.Int).Value = Role;

                cmd.Parameters.Add("@Entry_Status", SqlDbType.Int).Value =
                    statusValue;

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
                        lblMsg.Text = "No Data Found";
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