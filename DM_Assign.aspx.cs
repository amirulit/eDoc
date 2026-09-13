using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

public partial class DM_Assign : System.Web.UI.Page
{
    public DataTable TableData;

    protected void Page_Load(object sender, EventArgs e)
    {
        TableData = Listing();

        DataTable dt = DM_Listing();

        Select1.DataSource = dt;
        Select1.DataTextField = "dm_fullname";   // The column name to display (e.g., "CategoryName")
        Select1.DataValueField = "dm_domainid"; // The column name for the value (e.g., "CategoryID")
        Select1.DataBind();
    }


    [WebMethod]
    public static string UpdateRecordMethod(string id, string value)
    {
        string connString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            // Use your actual stored procedure name
            using (SqlCommand cmd = new SqlCommand("usp_AssignDM", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                // Add parameters matching your stored procedure definition
                cmd.Parameters.AddWithValue("@RecordID", id);
                cmd.Parameters.AddWithValue("@NewValue", value);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    return "Database updated successfully!";
                }
                catch (Exception ex)
                {
                    // Log error if needed
                    return "Error: " + ex.Message;
                }
            }
        }

    }

    public DataTable DM_Listing()
    {


        //if (Session["UserType"].ToString() == "Admin")
        //    Status = "A";
        //else if (Session["UserType"].ToString() == "Admin(Back Office)")
        //    Status = "Approved";
        //else
        //    Status = "ALL";

        //String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

      String  ConStr =ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;



        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_DMList";
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
        return ds.Tables[0];
    
    }

         
    public DataTable Listing()
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
        command.CommandText = "usp_Drawdown_Listing_V2";
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
        return ds.Tables[0];

    }
}