using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserListing_CAD : System.Web.UI.Page
{
    public DataTable TableData  {get;set;}

    public DataTable TableData_Role {get;set;}

    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = Listing();

        TableData = ds.Tables[0];

        TableData_Role = ds.Tables[1];


        Select1.DataSource = TableData_Role;
        Select1.DataTextField = "func_role";
        Select1.DataValueField = "func_role";
        Select1.DataBind();
    }

    [System.Web.Services.WebMethod]
    public static string UpdateFuncRole(string id, string roleId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                string query = @"UPDATE t_CAD_Officials_V2
                             SET func_role = @roleId
                             WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@roleId", roleId);
                    cmd.Parameters.AddWithValue("@id", id);

                    con.Open();

                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                        return "success";
                    else
                        return "Employee not found";
                }
            }
        }
        catch (Exception ex)
        {
            return "Error updating role";
        }
    }
    public DataSet Listing()
    {


        //if (Session["UserType"].ToString() == "Admin")
        //    Status = "A";
        //else if (Session["UserType"].ToString() == "Admin(Back Office)")
        //    Status = "Approved";
        //else
        //    Status = "ALL";

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_UserListing_CAD";
        command.Connection = connection;
        //command.Parameters.Add(new SqlParameter("@branchcode", Session["BranchCode"]));
        //command.Parameters.Add(new SqlParameter("@status", Status));

        //command.Parameters.Add(new SqlParameter("@ValueDate", ValueDate));
        //SqlCommand cmd = new SqlCommand("select * from t_FundRequsition", connection);
        //SqlCommand cmd = new SqlCommand(Sql, connection);


        SqlDataAdapter sda = new SqlDataAdapter(command);
        DataSet ds = new DataSet();

        try
        {
            sda.Fill(ds);
            //ErrorMSG = "";
        }
        catch (Exception ex)
        {
            //ErrorMSG = ex.Message;
        }
        //return ds.Tables[0];

        return ds;

    }
}