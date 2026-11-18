using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;

public partial class ProfileListing : System.Web.UI.Page
{
    public DataTable TableData;

    public Int32 Role;

    protected void Page_Load(object sender, EventArgs e)
    {
        TableData = Listing();
        Role = Convert.ToInt32(Session["Role"].ToString());

        LoadCusList();


    }


    [WebMethod]
    public static object GetCustomerDetails(String cus_type,String customerId)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_GetCustomerDetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@CustomerId", SqlDbType.VarChar).Value = customerId;

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }

            return new
            {
                Master = ds.Tables.Count > 0 ? ConvertTable(ds.Tables[0]) : null,
                Details = ds.Tables.Count > 1 ? ConvertTable(ds.Tables[1]) : null
            };

        }
    }


    protected void LoadCusList()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = "select cus_name,cus_code, cus_name+'-'+cus_code cid from t_CustomerInfo";
        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);
            Select4.DataSource = Ds.Tables[0];
            Select4.DataTextField = "cid";
            Select4.DataValueField = "cus_code";
            Select4.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    [WebMethod]
    public static string DeleteCustomerDetail(int id)
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
        using (SqlCommand cmd = new SqlCommand(
            "DELETE FROM t_Comp_OwnerInfo WHERE id=@Id", con))
        {
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;

            con.Open();

            cmd.ExecuteNonQuery();
        }

        return "success";
    }
    private static List<Dictionary<string, object>> ConvertTable(DataTable dt)
    {
        var rows = new List<Dictionary<string, object>>();

        foreach (DataRow dr in dt.Rows)
        {
            var row = new Dictionary<string, object>();

            foreach (DataColumn col in dt.Columns)
            {
                row[col.ColumnName] =
                    dr[col] == DBNull.Value ? null : dr[col];
            }

            rows.Add(row);
        }

        return rows;
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
        command.CommandText = "usp_CustomerListing_V2";
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