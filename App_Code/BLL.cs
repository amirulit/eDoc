using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for BLL
/// </summary>
public class BLL
{
    public string cs { get; set; }

	public BLL()
	{
		//
		// TODO: Add constructor logic here
		//



          cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;
	}


    public DataSet LoadBranch()
    {


        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];




        //SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");


        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = " select '' code,'<--Select-->' name  union  all select branch_code code,branch_name name from t_BranchInfo";

        //cmd.CommandText = "  select branch_code code,branch_name name from t_BranchInfo";


        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);
            /*
            select3.DataSource = Ds.Tables[0];
            select3.DataTextField = "name";
            select3.DataValueField = "code";
            select3.DataBind();
            */
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
        }
        return Ds;
    }
}