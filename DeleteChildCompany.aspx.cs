using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class DeleteChildCompany : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string motherCode = Request.QueryString["motherCode"];
            string childCode = Request.QueryString["childCode"];

            if (!string.IsNullOrEmpty(motherCode) &&
                !string.IsNullOrEmpty(childCode))
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings[
                        "YourConnectionString"].ConnectionString))
                {
                    string sql = @"
                    DELETE FROM dbo.t_Group
                    WHERE mother_com_cus_code = @motherCode
                    AND child_com_cus_code = @childCode";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@motherCode", motherCode);
                    cmd.Parameters.AddWithValue("@childCode", childCode);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("YourExistingPage.aspx");
        }
    }
}