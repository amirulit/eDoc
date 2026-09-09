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
using System.Data.SqlTypes;
using System.Text;
using NReco.PdfGenerator;

public partial class Checklist_View_V2_PdfGen : System.Web.UI.Page
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

    public String drawdown_id;
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


    protected string DocumentTableHtml { get; set; }



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
        
        
        //LoadDocList();

        LoadCheckList();

        //LoadCusList();
        hfCusID.Value = Request.QueryString[1].ToString();
        hfDrawdownID.Value = Request.QueryString[0].ToString();


        if (!IsPostBack)
        {
            // Load your TableData_GENERAL,
            // TableData_MORTGAGE, etc. first.

           BuildDocumentTable();
        }
    }

    private void BuildDocumentTable()
    {
        StringBuilder sb = new StringBuilder();

        // Document section names
        string[] tabsName =
    {
        "GENERAL DOCUMENTS",
        "MORTGAGE OF PROPERTIES",
        "LIABILITY TAKE OVER FROM OTHER BANKS",
        "HYPOTHECATION OF STOCK/ MACHINERY & EQUIPMENT/ RECEIVABLES",
        "PLEDGE OF SHARES",
        "ASSIGNMENT",
        "LIEN",
        "SET-OFF",
        "CHARGE WITH RJSC",
        "SYNDICATION",
        "INSURANCE POLICY",
        "UNDERTAKING",
        "LETTER OF GUARANTEE",
        "IDBP/ FDBP",
        "OTHER DOCUMENTS"
    };

        // Document type
        string[] docType =
    {
        "GENERAL",
        "MORTGAGE",
        "LIABILITY",
        "HYPOTHECATION",
        "PLEDGE",
        "ASSIGNMENT",
        "LIEN",
        "SET",
        "CHARGE",
        "SYNDICATION",
        "INSURANCE",
        "UNDERTAKING",
        "LETTER",
        "IDBP",
        "OTHER"
    };

        // Serial
        string[] docSerial =
    {
        "A", "B", "C", "D", "E",
        "F", "G", "H", "I", "J",
        "K", "L", "M", "N", "O"
    };

        // Map DocType -> DataTable
        Dictionary<string, DataTable> tables =
            new Dictionary<string, DataTable>(StringComparer.OrdinalIgnoreCase)
    {
        { "GENERAL", TableData_GENERAL },
        { "MORTGAGE", TableData_MORTGAGE },
        { "LIABILITY", TableData_LIABILITY },
        { "HYPOTHECATION", TableData_HYPOTHECATION },
        { "PLEDGE", TableData_PLEDGE },
        { "ASSIGNMENT", TableData_ASSIGNMENT },
        { "LIEN", TableData_LIEN },
        { "SET", TableData_SET },
        { "CHARGE", TableData_CHARGE },
        { "SYNDICATION", TableData_SYNDICATION },
        { "INSURANCE", TableData_INSURANCE },
        { "UNDERTAKING", TableData_UNDERTAKING },
        { "LETTER", TableData_LETTER },
        { "IDBP", TableData_IDBP },
        { "OTHER", TableData_OTHER }
    };


        sb.Append(@"
<style>

 table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid black;
        padding: 5px;
    }

    thead {
        display: table-header-group;
    }


 thead {
        display: table-header-group;
    }

   th,
  td {
        border: 1px solid black;

font-family:Cambria
    }

 .my-table
        {
            border-top: 1px solid #ddd !important;
        }
        
        .my-table th, .my-table td
        {
            border: 1px solid #ddd !important;
        }


</style>
");

        // Table opening
        sb.AppendLine("<table class='table table-condensed my-table'>");

        // Header
        sb.AppendLine("<thead>");
        sb.AppendLine("<tr>");
        sb.AppendLine("<th>SL#</th>");
        sb.AppendLine("<th>Name</th>");
        sb.AppendLine("<th>Required ?</th>");
        sb.AppendLine("<th>Status</th>");
        sb.AppendLine("<th>Reason</th>");
        sb.AppendLine("<th>Remarks</th>");
        sb.AppendLine("<th>Initial</th>");
        sb.AppendLine("</tr>");
        sb.AppendLine("</thead>");

        sb.AppendLine("<tbody>");


        // Sections
        for (int i = 0; i < docType.Length; i++)
        {
            DataTable tableData;

            if (!tables.TryGetValue(docType[i], out tableData))
                continue;

            if (tableData == null || tableData.Rows.Count == 0)
                continue;


            // Section header
            sb.AppendLine("<tr>");

            sb.AppendFormat(
                "<td><h3>{0}.</h3></td>",
                HttpUtility.HtmlEncode(docSerial[i])
            );

            sb.AppendFormat(
                "<td colspan='6'><h3>{0}</h3></td>",
                HttpUtility.HtmlEncode(tabsName[i])
            );

            sb.AppendLine("</tr>");


            // Documents
            foreach (DataRow row in tableData.Rows)
            {
                String sl = Convert.ToString(row["Sl"]);
                String name = Convert.ToString(row["name"]);
                String required = Convert.ToString(row["required"]);
                String status = Convert.ToString(row["status"]);
                String reason = Convert.ToString(row["reason"]);
                String remarks = Convert.ToString(row["remarks"]);


                sb.AppendLine("<tr>");

                sb.AppendFormat(
                    "<td>{0}</td>",
                    HttpUtility.HtmlEncode(sl)
                );

                sb.AppendFormat(
                    "<td style='width:33%;'>{0}</td>",
                    HttpUtility.HtmlEncode(name)
                );

                sb.AppendFormat(
                    "<td>{0}</td>",
                    HttpUtility.HtmlEncode(required)
                );

                sb.AppendFormat(
                    "<td>{0}</td>",
                    HttpUtility.HtmlEncode(status)
                );

                sb.AppendFormat(
                    "<td>{0}</td>",
                    HttpUtility.HtmlEncode(reason)
                );

                sb.AppendFormat(
                    "<td>{0}</td>",
                    HttpUtility.HtmlEncode(remarks)
                );

                sb.AppendLine("<td></td>");

                sb.AppendLine("</tr>");
            }
        }


        sb.AppendLine("</tbody>");
        sb.AppendLine("</table>");

        sb.AppendLine("<br/>");


        String[] files =
{
    "20060630001_Scan_0002.jpg.jpg",
    "20070610002_Scan_0001.jpg.jpg",
    "20100816035_Signature Khurshed.jpg.jpg",
    "20130331001_Sig_Misbah.jpg.jpg",
    "20150406003_Sig_Pallab.jpg.jpg",
    "20151227005_Sig_300-80.jpg.jpg"
};


 sb.AppendLine("<table><tbody><tr>");

for (int i = 0; i < files.Length; i++)
{
    sb.AppendLine(@"
        <td>
            
            <img  width=""100"" height=""80"" src=""file:///E:/SOD_Signature/" + files[i] + @"/>

            ""<br/>"+"Name"+@"<br/>""

            ""<br/>" + "Designation" + @"<br/>""

        </td>");

    if ((i + 1) % 4 == 0 && i + 1 < files.Length)
    {
        sb.AppendLine("</tr><tr>");
    }
}

sb.AppendLine("</tr></tbody></table>");


         




        /*
        var converter = new NReco.PdfGenerator.HtmlToPdfConverter();
        byte[] pdf = converter.GeneratePdf(sb.ToString());
        */




        var htmlToPdf = new HtmlToPdfConverter
        {
            Size = PageSize.A4,
            Orientation = PageOrientation.Portrait,
            Margins = new PageMargins { Top = 20, Bottom = 20, Left = 15, Right = 15 }
        };



        htmlToPdf.CustomWkHtmlArgs = "--enable-local-file-access";


        //var html = String.Format("<body>Hello world: {0}</body>", DateTime.Now);


        byte[] pdfBytes = htmlToPdf.GeneratePdf(sb.ToString());

        /*
        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=Checklist.pdf");
        Response.BinaryWrite(pdfBytes);
        Response.End();
        */


        String folderPath = @"E:\eDoc_Checklist";
        String filePath = Path.Combine(folderPath, drawdown_id + "_Checklist.pdf");

        // Create folder if it doesn't exist
        if (!Directory.Exists(folderPath))
        {
            Directory.CreateDirectory(folderPath);
        }

        // Delete existing file
        if (File.Exists(filePath))
        {
            File.Delete(filePath);
        }

        // Save PDF
        File.WriteAllBytes(filePath, pdfBytes);


        //return sb.ToString();



    }



    [WebMethod(EnableSession = true)]
    public static String Save_DocumentUpload_Drawdown(Obj Obj)
    {
        Utility u = new Utility();

        //Object[] details = null;
        String msg = "";

        //String e_doc_id = "";
        //Int32 auto_id = 0;

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_SaveDocumentUpload_Drawdown";
        command.Connection = connection;

        command.Parameters.Add(new SqlParameter("@cus_id", Obj.cus_id));
        command.Parameters.Add(new SqlParameter("@doc_id", Obj.doc_id));
        command.Parameters.Add(new SqlParameter("@drawdown_id", Obj.drawdown_id));

        command.Parameters.Add(new SqlParameter("@required", Obj.required));
        command.Parameters.Add(new SqlParameter("@status", Obj.status));
        command.Parameters.Add(new SqlParameter("@reason", Obj.reason));

        if (Obj.deadline != "")
        {
            SqlDateTime date = u.ConvertSQLDateTime(Obj.deadline);
            command.Parameters.Add(new SqlParameter("@date", date));
        }

        if (Obj.expiry != "")
        {
            SqlDateTime expiry = u.ConvertSQLDateTime(Obj.expiry);
            command.Parameters.Add(new SqlParameter("@expiry", expiry));

        }
        command.Parameters.Add(new SqlParameter("@remarks", Obj.remarks));

        command.Parameters.Add(new SqlParameter("@file_name", Obj.file_name));
        command.Parameters.Add(new SqlParameter("@upload_by", "Test"));
        command.Parameters.Add(new SqlParameter("@upload_ip", "Test"));


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
    public static String DeleteDocument(Int32 drawdown_id, String cus_id, Int32 data_id)
    {
        //Object[] details = null;
        String msg = "";

        //String e_doc_id = "";
        //Int32 auto_id = 0;

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_DeleteUpload";
        command.Connection = connection;

        command.Parameters.Add(new SqlParameter("@doc_type", "L"));
        command.Parameters.Add(new SqlParameter("@cus_id", cus_id));
        command.Parameters.Add(new SqlParameter("@doc_id", data_id));
        command.Parameters.Add(new SqlParameter("@drawdown_id", drawdown_id));


        //command.Parameters.AddRange(parameters);
        connection.Open();
        Int32 i = command.ExecuteNonQuery();
        connection.Close();
        if (i > 0)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Input Saved Successfully');window.location = 'List.aspx';", true);
            msg = "Data Deleted";
        }
        else
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
            msg = "Data Not Deleted";
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
    protected void LoadCheckList()
    {
          drawdown_id = Request.QueryString[0].ToString();

        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];

        //String cus_id = Request.QueryString[3].ToString();


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.CommandText = "usp_Checklist_View";
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

            /*
             GENERAL DOCUMENTS
MORTGAGE OF PROPERTIES
LIABILITY TAKE OVER FROM OTHER BANKS
HYPOTHECATION OF STOCK/ MACHINERY & EQUIPMENT/ RECEIVABLES
PLEDGE OF SHARES
ASSIGNMENT
LIEN
SET-OFF
CHARGE WITH RJSC
SYNDICATION
INSURANCE POLICY
UNDERTAKING
LETTER OF GUARANTEE
IDBP/ FDBP
OTHER DOCUMENTS
             
             */

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

        public String cus_id;
        public Int32 doc_id;
        public Int32 drawdown_id;

        public String required;
        public String status;
        public String reason;
        public String deadline;


        public String expiry;
        public String remarks;


        public String file_name;
        public Int32 upload_by;
        public String upload_ip;


    }



    public class Obj2
    {

        public String doc_name;
        public Int32 drawdown_id;
        public String status;
        public Int32 doc_sl;
        public String details;
        public String deadline;


    }
    public class Obj_AnyDoc
    {

        public String doc_name;
        public Int32 drawdown_id;
        public String status;
        public Int32 doc_sl;
        public String details;
        public String deadline;


    }




    [WebMethod(EnableSession = true)]
    public static String Save_DocumentStatus(Obj2 Obj)
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
    public static String Save_AnyDoc(Obj_AnyDoc Obj)
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
