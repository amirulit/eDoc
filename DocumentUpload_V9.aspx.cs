using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.IO;
using System.Data.SqlClient;

public partial class DocumentUpload_V9 : System.Web.UI.Page
{
    /*
Basic Documents
Charge Documents
Liability takeover
Loan Documents
Mortgage Document
Other Documents
Syndication/Pledge Doc.
Undertaking
Upload Not Required
 
    */
    public DataTable TableData;

    //public DataTable TableData_Basic;
    //public DataTable TableData_Charge;
    //public DataTable TableData_Liability;
    //public DataTable TableData_Loan;
    //public DataTable TableData_Mortgage;
    //public DataTable TableData_Other;
    //public DataTable TableData_Syndication;
    //public DataTable TableData_Undertaking;

    public DataTable TableData_GENERAL;
    public DataTable TableData_MORTGAGE;
    public DataTable TableData_LIABILITY;
    public DataTable TableData_HYPOTHECATION;
    public DataTable TableData_PLEDGE;
    public DataTable TableData_ASSIGNMENT;
    public DataTable TableData_LIEN;
    public DataTable TableData_SET;
    public DataTable TableData_CHARGE;
    public DataTable TableData_SYNDICATION;
    public DataTable TableData_INSURANCE;
    public DataTable TableData_UNDERTAKING;
    public DataTable TableData_LETTER;
    public DataTable TableData_IDBP;
    public DataTable TableData_OTHER;

    public DataTable TableData_Exception;

    public DataTable TableData_AnyOtherDocument;

    public DataTable TableData_Confirmation;





    public String[] TabsName;
    public String[] DocType;
    public String[] DocSerial;

    public String Admin;


    protected void Page_Load(object sender, EventArgs e)
    {

        TabsName = ("Basic Documents~Charge Documents~Liability Takeover~Loan Documents~Mortgage Document~Other Documents~Syndication/Pledge Doc.~Undertaking").Split('~');
        DocType = ("Basic~Charge~Liability~Loan~Mortgage~Other~Syndication~Undertaking").Split('~');

        TabsName = ("GENERAL DOCUMENTS~MORTGAGE OF PROPERTIES~LIABILITY TAKE OVER FROM OTHER BANKS~HYPOTHECATION OF STOCK/ MACHINERY & EQUIPMENT/ RECEIVABLES~PLEDGE OF SHARES~ASSIGNMENT~LIEN~SET-OFF~CHARGE WITH RJSC~SYNDICATION~INSURANCE POLICY~UNDERTAKING~LETTER OF GUARANTEE~IDBP/ FDBP~OTHER DOCUMENTS").Split('~');
        DocType = ("GENERAL~MORTGAGE~LIABILITY~HYPOTHECATION~PLEDGE~ASSIGNMENT~LIEN~SET~CHARGE~SYNDICATION~INSURANCE~UNDERTAKING~LETTER~IDBP~OTHER").Split('~');
        DocSerial = ("A~B~C~D~E~F~G~H~I~J~K~L~M~N~O").Split('~');;


        //txtCustomerType.Text = Request.QueryString[0].ToString();
        //txteDOCID.Text = Request.QueryString[1].ToString();
        //Admin = "Y";
        LoadDocList();

        //LoadCusList();


    }
    [WebMethod]
    public static Object[] GetDetails2(String fn)
    {
        Object[] details = null;
        String imageUrl = "";


        //String filepath = @"E:\Desktop Screen Shot 20181030.jpg";

        String filepath = @"E:\CAD_Doc\" + fn;


        FileStream fs = new FileStream(filepath, FileMode.Open, FileAccess.Read);
        BinaryReader br = new BinaryReader(fs);
        Byte[] bytes = br.ReadBytes((Int32)fs.Length);
        br.Close();
        fs.Close();
        String base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
        imageUrl = "data:image/png;base64," + base64String;

        details = new object[] { imageUrl, fn };

        return details;
    }

    protected void LoadCusList()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = "select * from t_CustomerInfo";
        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);


        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadDocList()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.CommandText = "usp_DocList_View_V3";
        cmd.Connection = con;

        /*
        @CompanyCode 
        @AccountTitle
        @FathersName 
        @MothersName 
        @NationalID
        @MobileNO
        
        @TIN
        */
        // 'Part',72
        SqlParameter[] parameters = 
                    {
                        
                        //new SqlParameter("@customer_type",c_type)
                       //,new SqlParameter("@cus_id", cus_auto_id)

                        new SqlParameter("@customer_type","Part")
                       ,new SqlParameter("@cus_id", 72)
                       ,new SqlParameter("@drawdown_id",  Convert.ToInt32( Request.QueryString[0].ToString()))

                    };

        cmd.Parameters.AddRange(parameters);

        cmd.CommandTimeout = 0;

        //con.Open();

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);

            //if (Ds.Tables[0].Rows.Count > 0)
            //{

            //TableData_Basic = Ds.Tables[0];
            //TableData_Charge = Ds.Tables[1];
            //TableData_Liability = Ds.Tables[2];
            //TableData_Loan = Ds.Tables[3];
            //TableData_Mortgage = Ds.Tables[4];
            //TableData_Other = Ds.Tables[5];
            //TableData_Syndication = Ds.Tables[6];
            //TableData_Undertaking = Ds.Tables[7];


            TableData_GENERAL = Ds.Tables[0];
            TableData_MORTGAGE = Ds.Tables[1];
            TableData_LIABILITY = Ds.Tables[2];
            TableData_HYPOTHECATION = Ds.Tables[3];
            TableData_PLEDGE = Ds.Tables[4];
            TableData_ASSIGNMENT = Ds.Tables[5];
            TableData_LIEN = Ds.Tables[6];
            TableData_SET = Ds.Tables[7];
            TableData_CHARGE = Ds.Tables[8];
            TableData_SYNDICATION = Ds.Tables[9];
            TableData_INSURANCE = Ds.Tables[10];
            TableData_UNDERTAKING = Ds.Tables[11];
            TableData_LETTER = Ds.Tables[12];
            TableData_IDBP = Ds.Tables[13];
            TableData_OTHER = Ds.Tables[14];



            TableData_Exception = Ds.Tables[15];
            TableData_AnyOtherDocument = Ds.Tables[16];
            TableData_Confirmation = Ds.Tables[17];

            GridView1.DataSource = Ds.Tables[18];
            GridView1.DataBind();
            //GridView1.DataSource = Ds.Tables[0];
            //GridView1.DataBind();

            //}
            //else
            //{
            //Label0.Text = "No Data Found as a Account Holder";
            //}

        }
        catch (Exception ex)
        {
            //lblError.Text = ex.Message;
        }
    }

    public class Obj
    {
        public String doc_name;
        public Int32 drawdown_id;
        public String status;
        public Int32 doc_sl;
        public String details;
        public String deadline;

    }

    [WebMethod(EnableSession = true)]
    public static String Save_DocumentStatus(Obj Obj)
    {
        //Object[] details = null;
        String msg = "";

        //String e_doc_id = "";
        //Int32 auto_id = 0;

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_Save_Document_Status";
        command.Connection = connection;

        command.Parameters.Add(new SqlParameter("@drawdown_id", Obj.drawdown_id));
        command.Parameters.Add(new SqlParameter("@doc_sl", Obj.doc_sl));
        command.Parameters.Add(new SqlParameter("@status", Obj.status));
        command.Parameters.Add(new SqlParameter("@details", Obj.details));
        command.Parameters.Add(new SqlParameter("@deadline", Obj.deadline));
        command.Parameters.Add(new SqlParameter("@input_by", "test"));


        //command.Parameters.AddRange(parameters);
        connection.Open();
        Int32 i = command.ExecuteNonQuery();
        connection.Close();
        if (i > 0)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Input Saved Successfully');window.location = 'List.aspx';", true);
            msg = "Data Saved";
        }
        else
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
            msg = "Data Not Saved";
        }

        //SqlParameter e_docid_parm = new SqlParameter("@eDOC_ID", SqlDbType.VarChar, 50);
        //e_docid_parm.Direction = ParameterDirection.Output;
        //command.Parameters.Add(e_docid_parm);

        //SqlParameter auto_id_parm = new SqlParameter("@auto_id", SqlDbType.Int);
        //auto_id_parm.Direction = ParameterDirection.Output;
        //command.Parameters.Add(auto_id_parm);

        //try
        //{

        //SqlDataAdapter sda = new SqlDataAdapter(command);
        //DataSet ds = new DataSet();
        //sda.Fill(ds);

        //e_doc_id = e_docid_parm.Value.ToString();
        //auto_id = Convert.ToInt32(auto_id_parm.Value.ToString());


        //}

        //catch (Exception ex)
        //{

        //}



        //return e_doc_id;

        //details = new object[] { e_doc_id, auto_id };

        //return details;

        return msg;

    }

    [WebMethod(EnableSession = true)]
    public static String Save_AnyDoc(Obj Obj)
    {
        //Object[] details = null;
        String msg = "";

        //String e_doc_id = "";
        //Int32 auto_id = 0;

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_Save_Other_Documents";
        command.Connection = connection;

        command.Parameters.Add(new SqlParameter("@drawdown_id", Obj.drawdown_id));
        command.Parameters.Add(new SqlParameter("@doc_name", Obj.doc_name));
        command.Parameters.Add(new SqlParameter("@status", Obj.status));
        command.Parameters.Add(new SqlParameter("@details", Obj.details));
        command.Parameters.Add(new SqlParameter("@deadline", Obj.deadline));
        command.Parameters.Add(new SqlParameter("@input_by", "test"));


        //command.Parameters.AddRange(parameters);
        connection.Open();
        Int32 i = command.ExecuteNonQuery();
        connection.Close();
        if (i > 0)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Input Saved Successfully');window.location = 'List.aspx';", true);
            msg = "Data Saved";
        }
        else
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
            msg = "Data Not Saved";
        }

        

        return msg;

    }


    [WebMethod(EnableSession = true)]
    public static String SaveOtherDocuments(Int32 dd_id, String doc_name, String status, String details)
    {
        //Object[] details = null;
        String msg = "";

        //String e_doc_id = "";
        //Int32 auto_id = 0;

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_Save_Other_Documents";
        command.Connection = connection;

        command.Parameters.Add(new SqlParameter("@drawdown_id", dd_id));
        command.Parameters.Add(new SqlParameter("@doc_name", doc_name));
        command.Parameters.Add(new SqlParameter("@status", status));
        command.Parameters.Add(new SqlParameter("@details", details));
        command.Parameters.Add(new SqlParameter("@deadline", details));
        


        //command.Parameters.AddRange(parameters);
        connection.Open();
        Int32 i = command.ExecuteNonQuery();
        connection.Close();
        if (i > 0)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Input Saved Successfully');window.location = 'List.aspx';", true);
            msg = "Data Saved";
        }
        else
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
            msg = "Data Not Saved";
        }

       

        return msg;
    }

    [WebMethod(EnableSession = true)]
    public static String SaveConfirmation(Int32 dd_id, Int32 question_id, String reply, String reason)
    {
        //Object[] details = null;
        String msg = "";

        //String e_doc_id = "";
        //Int32 auto_id = 0;

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_Save_Confirmation_Reply";
        command.Connection = connection;

        command.Parameters.Add(new SqlParameter("@drawdown_id", dd_id));
        command.Parameters.Add(new SqlParameter("@question_id", question_id));
        command.Parameters.Add(new SqlParameter("@reply", reply));
        command.Parameters.Add(new SqlParameter("@reason", reason));
        command.Parameters.Add(new SqlParameter("@input_by", "test"));
        

        try
        {
            //command.Parameters.AddRange(parameters);
            connection.Open();
            Int32 i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Input Saved Successfully');window.location = 'List.aspx';", true);
                msg = "Data Saved";
            }
            else
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
                msg = "Data Not Saved";
            }

        }
        catch (Exception ex)
        {
            msg = ex.Message;
        }

        return msg;
    }



    public class ExceptionData
    {
        public Int32 doc_sl;
        public String doc_name;
        public String status;
        public String details;

        public String deadline;
         

    }

    [WebMethod]
    public static ExceptionData[] GetData() //Show the details of the data after insert in HTML Table
    {
        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        DataTable TableData = new DataTable();

        var details = new List<ExceptionData>();

        using (var con = new SqlConnection(ConStr))
        {
            String query = @"select
	row_number() over (order by id asc )  doc_sl
	,e.*
from
(
select d.id,d.doc_name,d.status,d.details,d.deadline from [dbo].[t_DocumentStatus] d where status in ('Part','Not')
union all
select o.id,o.doc_name,o.status,o.details,o.deadline  from [dbo].[t_OtherDocuments] o  where o.status not in  ('Obtained')
)e";

            //const string query = "select * from [dbo].[t_DocumentStatus] where status in ('Part','Not') ";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    TableData.Clear();
                    sda.Fill(TableData);
                    details.AddRange(from DataRow dtrow in TableData.Rows
                                     select new ExceptionData
                                     {
                                         doc_sl = Convert.ToInt32(dtrow["doc_sl"]),
                                         doc_name = dtrow["doc_name"].ToString(),
                                         status = dtrow["status"].ToString(),
                                         details = dtrow["details"].ToString(),
                                         deadline = dtrow["deadline"].ToString()
                                     });
                }
            }
        }

        return details.ToArray();

    }
     [WebMethod]
    public static ExceptionData[] GetDataAnyOthDoc() //Show the details of the data after insert in HTML Table
    {
        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        DataTable TableData = new DataTable();

        var details = new List<ExceptionData>();

        using (var con = new SqlConnection(ConStr))
        {
            String query = @"select  row_number() over (order by id asc) doc_sl,o.* from [dbo].[t_OtherDocuments] o where o.status in  ('Obtained')";


            //const string query = "select row_number() over (order by id asc )  doc_sl  ,o.* from [dbo].[t_OtherDocuments] o  ";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    TableData.Clear();
                    sda.Fill(TableData);
                    details.AddRange(from DataRow dtrow in TableData.Rows
                                     select new ExceptionData
                                     {
                                         doc_sl = Convert.ToInt32(dtrow["doc_sl"]),
                                         doc_name = dtrow["doc_name"].ToString(),
                                         status = dtrow["status"].ToString(),
                                         details = dtrow["details"].ToString(),
                                         deadline = dtrow["deadline"].ToString(),
                                     });
                }
            }
        }

        return details.ToArray();
    }
    
}
