using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class DrawdownListing_V2 : System.Web.UI.Page
{
    public DataTable TableData;

    protected void Page_Load(object sender, EventArgs e)
    {
        TableData = Listing();
    }


    [System.Web.Services.WebMethod]
    public static object GetReason(int drawdown_id)
    {
        String cs = ConfigurationManager
            .ConnectionStrings["dbConn"]
            .ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand("usp_Show_Decline_Reason", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@drawdown_id", drawdown_id);

            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (dr.Read())
                {
                    return new
                    {
                        id = dr["id"],
                        cus_name = dr["cus_name"],
                        cr_incharge_decline_reason = dr["cr_incharge_decline_reason"],
                        hob_decline_reason = dr["hob_decline_reason"],
                        dm_decline_reason = dr["dm_decline_reason"],
                        unit_head_decline_reason = dr["unit_head_decline_reason"]
                    };
                }
            }
        }

        return null;
    }


    //[System.Web.Services.WebMethod]
    //public static List<Employee> GetEmployees()
    //{
    //    List<Employee> employees = new List<Employee>();

    //    string connectionString =
    //        ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

    //    using (SqlConnection con = new SqlConnection(connectionString))
    //    {
    //        using (SqlCommand cmd = new SqlCommand("usp_Show_Decline_Reason", con))
    //        {
    //            cmd.CommandType = CommandType.StoredProcedure;

    //            con.Open();

    //            using (SqlDataReader dr = cmd.ExecuteReader())
    //            {
    //                while (dr.Read())
    //                {
    //                    employees.Add(new Employee
    //                    {
    //                        EmployeeId = Convert.ToInt32(dr["EmployeeId"]),
    //                        EmployeeName = dr["EmployeeName"].ToString(),
    //                        Department = dr["Department"].ToString(),
    //                        Salary = Convert.ToDecimal(dr["Salary"])
    //                    });
    //                }
    //            }
    //        }
    //    }

    //    return employees;
    //}


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