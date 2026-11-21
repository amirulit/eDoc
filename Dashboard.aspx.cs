using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard : System.Web.UI.Page
{
    public Int32 Role{get;set;}

    public String BranchCode { get; set; }

    public Int32 tot_uploaded { get; set; }
    public Int32 tot_pending { get; set; }
    public Int32 tot_ssc { get; set; }
    public Int32 tot_user { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        

        Role = Convert.ToInt32(Session["Role"]);
        BranchCode = Convert.ToString(Session["BranchCode"]);

        //Response.Write("Role:" + Role);

        if (Role == 21 || Role == 23 || Role == 25 || Role == 27 || Role == 29 || Role == 31 || Role == 33 || Role == 35)
        {
            LoadDashboard_Credit_Division();
        }

        if (Role == 5 || Role == 7 || Role == 9 || Role == 11 )
        {
            LoadDashboard_Branch();
        }

        if (Role == 57 || Role == 59 || Role == 61 || Role == 63 || Role == 65 || Role == 67)
        {
            LoadDashboard_CAD_Division();
        }

        //if (Role == 21 || Role == 23 || Role == 25 || Role == 27 || Role == 29 || Role == 31 || Role == 33 || Role == 35)
        //{
        //    LoadDashboard_Credit_Division();
        //}

    }


    private void LoadDashboard_Credit_Division()
    {
        String connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Dashboard_Credit_Division", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.Add("@sanction_segment", SqlDbType.VarChar, 500)
                //              .Value = sanctionSegment;

                cmd.Parameters.Add("@Role", SqlDbType.Int, 500).Value = Role;


                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        //lblUploadedSanction.Text =
                        //    dr["uploaded_sanction_count"].ToString();

                        //lblPendingSanction.Text =
                        //    dr["pending_sanction_count"].ToString();

                        //lblTotalUsers.Text =
                        //    dr["tot_user"].ToString();

                        tot_uploaded = dr["tot_uploaded"].ToString();
                    }
                }
            }
        }
    }

    private void LoadDashboard_Branch()
    {
        String connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Dashboard_Branch", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.Add("@sanction_segment", SqlDbType.VarChar, 500)
                //              .Value = sanctionSegment;

                //cmd.Parameters.Add("@Role", SqlDbType.Int, 500).Value = Role;



                cmd.Parameters.Add("@branch_code", SqlDbType.VarChar, 500).Value = BranchCode;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblUploadedSanction.Text =
                            dr["uploaded_sanction_count"].ToString();

                        lblPendingSanction.Text =
                            dr["pending_sanction_count"].ToString();

                        lblTotalUsers.Text =
                            dr["tot_user"].ToString();
                    }
                }
            }
        }
    }
    private void LoadDashboard_CAD_Division()
    {
        String connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Dashboard_Credit_Division", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.Add("@sanction_segment", SqlDbType.VarChar, 500)
                //              .Value = sanctionSegment;

                cmd.Parameters.Add("@Role", SqlDbType.Int, 500).Value = Role;


                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblUploadedSanction.Text =
                            dr["uploaded_sanction_count"].ToString();

                        lblPendingSanction.Text =
                            dr["pending_sanction_count"].ToString();

                        lblTotalUsers.Text =
                            dr["tot_user"].ToString();
                    }
                }
            }
        }
    }
}