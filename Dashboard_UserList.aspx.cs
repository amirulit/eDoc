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

        Role = Convert.ToInt32(Session["Role"]);

        String connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Dashboard_Credit_Division_Total_User", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.Add("@sanction_segment", SqlDbType.VarChar, 500)
                //              .Value = sanctionSegment;

                cmd.Parameters.Add("@Role", SqlDbType.Int, 500).Value = Role;


                con.Open();

                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        GridView1.DataSource = rdr;
                        GridView1.DataBind();
                            
                    }
                }
            }
        }
    }
}