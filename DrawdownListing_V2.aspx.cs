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
using System.Web.Script.Services;

public partial class DrawdownListing_V2 : System.Web.UI.Page
{
    public DataTable TableData;

    public Int32 Role { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

        Role = Convert.ToInt32(Session["Role"].ToString());



        TableData = Listing();

       
    }
    public class DeclineReason
    {
        public string cus_name { get; set; }
        public string cr_reason { get; set; }
        public string hob_reason { get; set; }
        public string dm_reason { get; set; }
        public string unit_reason { get; set; }
    }

    [WebMethod]
    public static DeclineReason GetDeclineReason(int drawdown_id)
    {
        DeclineReason obj = null;

        string cs = ConfigurationManager
                    .ConnectionStrings["dbConn"]
                    .ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(
                "usp_Show_Decline_Reason", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@drawdown_id", SqlDbType.Int)
                              .Value = drawdown_id;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        obj = new DeclineReason
                        {
                            cus_name = Convert.ToString(dr["cus_name"]),
                            cr_reason = Convert.ToString(dr["cr_incharge_decline_reason"]),
                            hob_reason = Convert.ToString(dr["hob_decline_reason"]),
                            dm_reason = Convert.ToString(dr["dm_decline_reason"]),
                            unit_reason = Convert.ToString(dr["unit_head_decline_reason"])
                        };
                    }
                }
            }
        }

        return obj;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveSSCConditions(
        int drawdown_id,
        string conditions,
        string deadline,
        string office_note)
    {
        try
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "usp_SSC_Conditions_Save", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@drawdown_id", SqlDbType.Int).Value = drawdown_id;

                    cmd.Parameters.Add("@conditions", SqlDbType.VarChar, 8000).Value =
                        conditions ?? "";

                    cmd.Parameters.Add("@deadline", SqlDbType.DateTime).Value =
                        string.IsNullOrEmpty(deadline)
                        ? (object)DBNull.Value
                        : Convert.ToDateTime(deadline);

                    cmd.Parameters.Add("@office_note", SqlDbType.VarChar, 50).Value =
                        office_note ?? "";

                    cmd.Parameters.Add("@create_date", SqlDbType.DateTime).Value =
                        DateTime.Now;

                    cmd.Parameters.Add("@create_by", SqlDbType.VarChar, 500).Value =
                        "Test";

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return "Success";
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
    }

    public class QueryDetails
    {
        public string query { get; set; }
        public string query_by_role { get; set; }
        public string create_date { get; set; }
        public string create_by { get; set; }
    }

    [WebMethod]
    public static List<QueryDetails> GetQueryDetails(int drawdown_id)
    {
        List<QueryDetails> list = new List<QueryDetails>();

        string cs = ConfigurationManager
            .ConnectionStrings["dbConn"]
            .ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("usp_ShowQuery", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@drawdown_id", SqlDbType.Int).Value = drawdown_id;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        QueryDetails obj = new QueryDetails();

                        obj.query = Convert.ToString(dr["query"]);
                        obj.query_by_role = Convert.ToString(dr["query_by_role"]);

                        obj.create_date = dr["create_date"] == DBNull.Value
                            ? ""
                            : Convert.ToDateTime(dr["create_date"]).ToString("dd-MM-yyyy hh:mm tt");

                        obj.create_by = Convert.ToString(dr["create_by"]);

                        list.Add(obj);
                    }
                }
            }
        }

        return list;
    }

    [WebMethod]
    public static string SaveSSCConditions(int drawdown_id, string conditions)
    {
        string cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    {
        using (SqlCommand cmd = new SqlCommand("usp_SSC_Conditions_Save", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@drawdown_id", drawdown_id);
            cmd.Parameters.AddWithValue("@conditions", conditions);
            cmd.Parameters.AddWithValue("@deadline", DBNull.Value);
            cmd.Parameters.AddWithValue("@remarks", DBNull.Value);
            cmd.Parameters.AddWithValue("@create_date", DateTime.Now);

            string username = HttpContext.Current.User.Identity.Name;
            cmd.Parameters.AddWithValue("@create_by",
                string.IsNullOrEmpty(username) ? "Test" : username);

            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    return "Success";
    }
    public class SSCCondition
    {
        public int condition_id { get; set; }
        public string conditions { get; set; }
        public string deadline { get; set; }
        public string remarks { get; set; }
    }

    [WebMethod]
    public static List<SSCCondition> GetSSCConditions(int drawdown_id)
    {
        List<SSCCondition> list = new List<SSCCondition>();

        string cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            string sql = @"SELECT id, conditions, deadline, remarks
                       FROM t_SSC_Conditions
                       WHERE drawdown_id = @drawdown_id
                       ORDER BY id asc";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@drawdown_id", drawdown_id);

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new SSCCondition
                        {
                            condition_id = Convert.ToInt32(dr["id"]),
                            conditions = dr["conditions"].ToString(),
                            deadline = dr["deadline"] == DBNull.Value ? "" : Convert.ToDateTime(dr["deadline"]).ToString("dd-MMM-yyyy"),
                            remarks = dr["remarks"] == DBNull.Value ? "" : dr["remarks"].ToString()
                        });
                    }
                }
            }
        }

        return list;
    }


    [WebMethod]
    public static string DeleteSSCConditions(int condition_id, int drawdown_id)
    {
        string cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            string sql = @"DELETE FROM t_SSC_Conditions
                       WHERE id = @condition_id
                       AND drawdown_id = @drawdown_id";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@condition_id", condition_id);
                cmd.Parameters.AddWithValue("@drawdown_id", drawdown_id);

                con.Open();

                int result = cmd.ExecuteNonQuery();

                return result > 0 ? "Success" : "Record not found";
            }
        }
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
        //command.CommandText = "usp_Drawdown_Listing_V3";
        command.Connection = connection;
        //command.Parameters.Add(new SqlParameter("@branchcode", Session["BranchCode"]));
        //command.Parameters.Add(new SqlParameter("@status", Status));

        //command.Parameters.Add(new SqlParameter("@ValueDate", ValueDate));
        //SqlCommand cmd = new SqlCommand("select * from t_FundRequsition", connection);
        //SqlCommand cmd = new SqlCommand(Sql, connection);

        String BranchCode = Session["BranchCode"].ToString();


        ////For Branch
        if (Role == 5 || Role == 7 || Role == 9 || Role == 11)
        {
            command.Parameters.Add(new SqlParameter("@BranchCode", BranchCode));
            command.CommandText = "usp_Drawdown_Listing_For_Branch_Update";

        }
        else
        {

            command.Parameters.Add(new SqlParameter("@Role", Role));
            command.CommandText = "usp_Drawdown_Listing_For_CAD_Update";

        }


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