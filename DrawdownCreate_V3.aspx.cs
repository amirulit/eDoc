using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Services;
using System.Data;

public partial class DrawdownCreate_V3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadCusList();


        LoadLoanNature();


        LoadSecurity();

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
            select1.DataSource = Ds.Tables[0];
            select1.DataTextField = "cid";
            select1.DataValueField = "cus_code";
            select1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }



    protected void LoadLoanNature()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = "select loan_nature name,loan_nature_short short_name from t_LoanNature";
        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);
            select3.DataSource = Ds.Tables[0];
            select3.DataTextField = "name";
            select3.DataValueField = "short_name";
            select3.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    protected void LoadSecurity()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = "select coll_type name,col_type_short short_name from t_CollType";
        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);
            select4.DataSource = Ds.Tables[0];
            select4.DataTextField = "name";
            select4.DataValueField = "short_name";
            select4.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }


    [WebMethod(EnableSession = true)]
    public static Object[] Drawdown_Save(Obj Obj)
    {

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
            command.CommandText = "usp_Drawdown_Save";
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
                                   new SqlParameter("@expiry_date",Obj.expiry_date), 
                        
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
                        //new SqlParameter("@per_addr",Obj.per_addr)

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





    [WebMethod(EnableSession = true)]
    public static Object[] Checklist_Generate(Int32 drawdown_id)
    {



        Object[] details = null;

        Int32 status;

        String msg;



        //String drawdown_id = Request.QueryString[0].ToString();

        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];

        //String cus_id = Request.QueryString[3].ToString();


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
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
                        new SqlParameter("@drawdown_id", drawdown_id)
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
}