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
using System.Web.Script.Services;

public partial class SanctionListing_V3 : System.Web.UI.Page
{
    public DataTable TableData;

    public Int32 Role;

    protected void Page_Load(object sender, EventArgs e)
    {

        TableData = Listing(); 

        Role = Convert.ToInt32(Session["Role"].ToString());


        LoadSecurity();
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
        command.CommandText = "usp_SanctionLisitng_V2";
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



    public class SanctionDetail
    {
        public int id { get; set; }
        public string edoc_id { get; set; }
        public string edoc_refno { get; set; }
        public string sanction_reference { get; set; }
        public string customer_id { get; set; }
        public string customer_name { get; set; }
        public string loan_nature { get; set; }
        public string loan_nature_edoc { get; set; }
        public string currency { get; set; }
        public string amount { get; set; }
        public string validity { get; set; }

        public string cus_type { get; set; }
        public string short_form { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<SanctionDetail> GetSanctionDetails(Int32 id)
    {
        var list = new List<SanctionDetail>();

        String cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;



        String query = @"


        SELECT 
                 s.id
                ,[edoc_id]
                ,[edoc_refno]
                ,[sanction_reference]
                ,s.customer_id
                ,[customer_name]
                ,l.loan_nature
                ,s.loan_nature_edoc
                ,[currency]
                ,[amount]
                ,convert(varchar(10),validity,23)validity
                --,convert(date,validity)validity
				,c.cus_type
				,l.short_form
        
        FROM 
            [dbo].[t_Sanction_Master_Details] s
		join
			[dbo].[t_CustomerInfo] c
		on
			s.customer_id=c.[cus_code]
		join
			[dbo].[t_LoanNature_V2] l
		on
			s.loan_nature=l.id
        where
			edoc_id=" + id + @"
			
        ORDER BY 
            s.id asc;


";

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new SanctionDetail
                        {
                            id = Convert.ToInt32(dr["id"]),
                            edoc_id = GetString(dr, "edoc_id"),
                            edoc_refno = GetString(dr, "edoc_refno"),
                            sanction_reference = GetString(dr, "sanction_reference"),
                            customer_id = GetString(dr, "customer_id"),
                            customer_name = GetString(dr, "customer_name"),
                            loan_nature = GetString(dr, "loan_nature"),
                            loan_nature_edoc = GetString(dr, "loan_nature_edoc"),
                            currency = GetString(dr, "currency"),
                            amount = GetString(dr, "amount"),
                            validity = GetString(dr, "validity"),
                            cus_type = GetString(dr, "cus_type"),
                            short_form = GetString(dr, "short_form")
                        });
                    }
                }
            }
        }

        return list;
    }






    [WebMethod]
    public static Object[] Drawdown_Save_V2(

         Int32 id,
  String edocRefNo,
  String branch,
  String date,
  String segment,
  String authority,
        String sanctionRefNo,


        String amount,

        String rowIds,
        String customerIds,
        String customerTypes,
        String loanTypes,
        String securityTypes)

    {
        // Example:
        // rowIds         = "101,102,105"
        // customerTypes  = "IND,CORP"
        // loanTypes      = "Personal,Business"
        // securityTypes  = "FDR,LAND"

        // Perform server-side validation and database processing here.

        Int32 Role = Convert.ToInt32(HttpContext.Current.Session["Role"].ToString());


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";



        Object[] details = null;

        Int32 status;

        String msg;


        //String exp_date = Obj.expiry_date;

        //exp_date = exp_date.ToString().Substring(6, 4) + '-' + exp_date.ToString().Substring(3, 2) + '-' + exp_date.ToString().Substring(0, 2);

        //EffectiveFrom = EffectiveFrom.ToString().Substring(6, 4) + '-' + EffectiveFrom.ToString().Substring(3, 2) + '-' + EffectiveFrom.ToString().Substring(0, 2);

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }


        //String json = JsonConvert.SerializeObject(Ob);

        //JObject obj = JObject.Parse(json);

        //String Valid = "";
        //String Params = "";



        /*
        if (obj.ContainsKey("params"))
        {
            Params = obj["params"].ToString();
            Valid = "The JSON object has a 'params' property" + Params;
        }
        else
        {
            Valid = "The JSON object does not have a 'params' property" + Params;
        }
        return Request.CreateResponse(HttpStatusCode.Created, Valid);
        */



        String drawdown_id = "";

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Drawdown_Save_V2";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        //new SqlParameter("@cus_ids",Obj.cus_ids.ToString().Split(',')[0]), 

                        new SqlParameter("@sanction_id",id), 
                        new SqlParameter("@sanction_refno",sanctionRefNo), 
                        new SqlParameter("@edoc_refno",edocRefNo), 


                          new SqlParameter("@row_ids",rowIds), 
                        new SqlParameter("@cus_ids",customerIds), 
                        new SqlParameter("@cus_types",customerTypes), 
                        new SqlParameter("@loan_types",loanTypes), 
                        new SqlParameter("@sec_types",securityTypes), 

                        new SqlParameter("@loan_amount",amount), 
                        //new SqlParameter("@expiry_date",exp_date), 
                        
                        //new SqlParameter("@cus_name",Obj.cus_name), 
                        //new SqlParameter("@sanc_authority",Obj.sanc_auth), 
                        //new SqlParameter("@sanc_reference_no",Obj.sanc_ref),
                        //new SqlParameter("@sanc_date",Sanc_Date),
                        //new SqlParameter("@liab_pos",Obj.liab_pos),

                        //new SqlParameter("@tot_exposure",Obj.tot_exp),
                        //new SqlParameter("@cib_status",Obj.cib_sts),
                        //new SqlParameter("@create_by","Test")
                        //new SqlParameter("@tin",Obj.tin),
                        //new SqlParameter("@pre_addr",Obj.pre_addr),


                        new SqlParameter("@input_by_role",(Role==1?"RM":"DM"))

                    };


            command.Parameters.AddRange(parameters);

            SqlParameter auto_id_parm = new SqlParameter("@auto_id", SqlDbType.Int);
            auto_id_parm.Direction = ParameterDirection.Output;
            command.Parameters.Add(auto_id_parm);

            /*
            connection.Open();
            Int32 i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {   
                msg = "Data Saved";
            }
            else
            {
                msg = "Data not Saved";
            }
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
            */

            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            //drawdown_id = auto_id_parm.Value.ToString();
            status = 1;
            msg = "Data Saved";
            drawdown_id = auto_id_parm.Value.ToString();

        }
        catch (Exception ex)
        {
            status = 0;
            msg = ex.Message;
            drawdown_id = "";
        }

        //return msg;

        details = new object[] { status, msg, drawdown_id };

        return details;


        //return "Data received successfully.";
    }



    [WebMethod(EnableSession = true)]
    public static Object[] Checklist_Generate(Int32 drawdown_id)
    {

        String DomainID = HttpContext.Current.Session["DomainID"].ToString();

        Int32 Role = Convert.ToInt32(HttpContext.Current.Session["Role"].ToString());

        Object[] details = null;

        Int32 status;

        String msg;



        //String drawdown_id = Request.QueryString[0].ToString();

        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];

        //String cus_id = Request.QueryString[3].ToString();


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");

        //String connectionString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;


        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.CommandText = "usp_Checklist_Generate";
        cmd.Connection = con;


        /*
        SqlParameter[] parameters = 
                    {
                        
                         new SqlParameter("@primary_cus_id","100052469")
                        ,new SqlParameter("@drawdown_id", 1)

                        ,new SqlParameter("@Search_CUS","PVT")
                        ,new SqlParameter("@Search_LOAN", "OD,CC,EMFS,HBL,HP,SF")
                        ,new SqlParameter("@Search_COLL", "FI,PG,CG,TR,Assignment")

                    };
        */

        SqlParameter[] parameters = 
                    {
                        new SqlParameter("@drawdown_id", drawdown_id),
                        new SqlParameter("@by",DomainID)

                    };


        cmd.Parameters.AddRange(parameters);

        cmd.CommandTimeout = 0;

        con.Open();

        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataSet Ds = new DataSet();

        try
        {
            //da.Fill(Ds);

            cmd.ExecuteNonQuery();


            status = 1;
            msg = "Checklist Generated Successfully";
        }


        catch (Exception ex)
        {
            status = 0;
            msg = "Checklist Generation Failed :" + ex.Message;

        }

        //return msg;

        details = new object[] { status, msg };

        return details;

    }


    public class Obj
    {

        public String sanction_id;
        public String sancton_refno;

        public String cus_ids;
        public String loan_natures;
        public String securities;

        //public String cus_name;
        //public String sanc_auth;
        //public String sanc_ref;
        //public String sanc_date;
        //public String liab_pos;
        //public String tot_exp;

        public String expiry_date;
        public String loan_amount;
        public String cib_sts;

    }



    [WebMethod(EnableSession = true)]
    public static Object[] Drawdown_Save(Obj Obj)
    {
        Int32 Role = Convert.ToInt32(HttpContext.Current.Session["Role"].ToString());


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";



        Object[] details = null;

        Int32 status;

        String msg;


        String exp_date = Obj.expiry_date;

        exp_date = exp_date.ToString().Substring(6, 4) + '-' + exp_date.ToString().Substring(3, 2) + '-' + exp_date.ToString().Substring(0, 2);

        //EffectiveFrom = EffectiveFrom.ToString().Substring(6, 4) + '-' + EffectiveFrom.ToString().Substring(3, 2) + '-' + EffectiveFrom.ToString().Substring(0, 2);

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }


        //String json = JsonConvert.SerializeObject(Ob);

        //JObject obj = JObject.Parse(json);

        //String Valid = "";
        //String Params = "";



        /*
        if (obj.ContainsKey("params"))
        {
            Params = obj["params"].ToString();
            Valid = "The JSON object has a 'params' property" + Params;
        }
        else
        {
            Valid = "The JSON object does not have a 'params' property" + Params;
        }
        return Request.CreateResponse(HttpStatusCode.Created, Valid);
        */



        String drawdown_id = "";

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Drawdown_Save_V2";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        //new SqlParameter("@cus_ids",Obj.cus_ids.ToString().Split(',')[0]), 

                        new SqlParameter("@sanction_id",Obj.sanction_id), 
                        new SqlParameter("@sanction_refno",Obj.sancton_refno), 



                        new SqlParameter("@cus_ids",Obj.cus_ids), 
                        new SqlParameter("@loan_natures",Obj.loan_natures), 
                        new SqlParameter("@securities",Obj.securities), 

                        new SqlParameter("@loan_amount",Obj.loan_amount), 
                        new SqlParameter("@expiry_date",exp_date), 
                        
                        //new SqlParameter("@cus_name",Obj.cus_name), 
                        //new SqlParameter("@sanc_authority",Obj.sanc_auth), 
                        //new SqlParameter("@sanc_reference_no",Obj.sanc_ref),
                        //new SqlParameter("@sanc_date",Sanc_Date),
                        //new SqlParameter("@liab_pos",Obj.liab_pos),

                        //new SqlParameter("@tot_exposure",Obj.tot_exp),
                        new SqlParameter("@cib_status",Obj.cib_sts),
                        //new SqlParameter("@create_by","Test")
                        //new SqlParameter("@tin",Obj.tin),
                        //new SqlParameter("@pre_addr",Obj.pre_addr),


                        new SqlParameter("@input_by_role",(Role==1?"RM":"DM"))

                    };


            command.Parameters.AddRange(parameters);

            SqlParameter auto_id_parm = new SqlParameter("@auto_id", SqlDbType.Int);
            auto_id_parm.Direction = ParameterDirection.Output;
            command.Parameters.Add(auto_id_parm);

            /*
            connection.Open();
            Int32 i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {   
                msg = "Data Saved";
            }
            else
            {
                msg = "Data not Saved";
            }
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
            */

            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            //drawdown_id = auto_id_parm.Value.ToString();
            status = 1;
            msg = "Data Saved";
            drawdown_id = auto_id_parm.Value.ToString();

        }
        catch (Exception ex)
        {
            status = 0;
            msg = ex.Message;
            drawdown_id = "";
        }

        //return msg;

        details = new object[] { status, msg, drawdown_id };

        return details;


    }


    protected void LoadSecurity()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = "select id, short_name  from [dbo].[t_CollType_V2]";
        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);
            select4.DataSource = Ds.Tables[0];
            select4.DataTextField = "short_name";
            select4.DataValueField = "id";
            select4.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<SanctionDetail> GetSanctionDetails_V2()
    {
        List<SanctionDetail> list = new List<SanctionDetail>();

        string cs = ConfigurationManager
            .ConnectionStrings["dbConn"]
            .ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(
                "dbo.usp_GetSanctionDetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new SanctionDetail
                        {
                            id = Convert.ToInt32(dr["id"]),
                            edoc_id = GetString(dr, "edoc_id"),
                            edoc_refno = GetString(dr, "edoc_refno"),
                            sanction_reference = GetString(dr, "sanction_reference"),
                            customer_id = GetString(dr, "customer_id"),
                            customer_name = GetString(dr, "customer_name"),
                            loan_nature = GetString(dr, "loan_nature"),
                            loan_nature_edoc = GetString(dr, "loan_nature_edoc"),
                            currency = GetString(dr, "currency"),
                            amount = GetString(dr, "amount"),
                            validity = GetString(dr, "validity")
                        });
                    }
                }
            }

        }
        return list;
    }
    private static string GetString(SqlDataReader dr, string column)
    {
        return dr[column] == DBNull.Value ? "" : Convert.ToString(dr[column]);
    }
}