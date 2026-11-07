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
using System.Configuration;
using System.Web.Script.Services;

public partial class DocumentUpload_V10_New_Mapping_Drawdown : System.Web.UI.Page
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


    public DataTable TableData_SanctionAdvice;
    public DataTable TableData_Customers;
    public DataTable TableData_Facilities;
    public DataTable TableData_Securities;





    public String[] TabsName;
    public String[] DocType;
    public String[] DocSerial;

    public String Admin;

    public String CustomerName;


    protected void Page_Load(object sender, EventArgs e)
    {

        TabsName = ("Basic Documents~Charge Documents~Liability Takeover~Loan Documents~Mortgage Document~Other Documents~Syndication/Pledge Doc.~Undertaking").Split('~');
        DocType = ("Basic~Charge~Liability~Loan~Mortgage~Other~Syndication~Undertaking").Split('~');

        TabsName = ("GENERAL DOCUMENTS~MORTGAGE OF PROPERTIES~LIABILITY TAKE OVER FROM OTHER BANKS~HYPOTHECATION OF STOCK/ MACHINERY & EQUIPMENT/ RECEIVABLES~PLEDGE OF SHARES~ASSIGNMENT~LIEN~SET-OFF~CHARGE WITH RJSC~SYNDICATION~INSURANCE POLICY~UNDERTAKING~LETTER OF GUARANTEE~IDBP/ FDBP~OTHER DOCUMENTS").Split('~');
        DocType = ("GENERAL~MORTGAGE~LIABILITY~HYPOTHECATION~PLEDGE~ASSIGNMENT~LIEN~SET~CHARGE~SYNDICATION~INSURANCE~UNDERTAKING~LETTER~IDBP~OTHER").Split('~');
        DocSerial = ("A~B~C~D~E~F~G~H~I~J~K~L~M~N~O").Split('~'); ;


        //txtCustomerType.Text = Request.QueryString[0].ToString();
        //txteDOCID.Text = Request.QueryString[1].ToString();
        //Admin = "Y";
        LoadDocList();

        //LoadCusList();
        hfCusID.Value = Request.QueryString[1].ToString();
        hfDrawdownID.Value = Request.QueryString[0].ToString();
    }


    public class IncompleteRow
    {
        public string PrimaryKey { get; set; }
        public string Required { get; set; }
        public string Status { get; set; }
    }



    [WebMethod]
    public static string SaveIncompleteRows(String cusid,
        Int32 drawdownId,
        List<IncompleteRow> rows)
    {
        if (rows == null || rows.Count == 0)
            return "No records found!";

        string connStr = ConfigurationManager
            .ConnectionStrings["dbConn"]
            .ConnectionString;

        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();

            using (SqlTransaction tran = con.BeginTransaction())
            {
                try
                {
                    // 1. Create DataTable
                    DataTable dt = new DataTable();


                    dt.Columns.Add("CusId", typeof(string));
                    dt.Columns.Add("DrawdownId", typeof(int));
                    dt.Columns.Add("PrimaryKey", typeof(int));
                    dt.Columns.Add("Required", typeof(string));
                    dt.Columns.Add("Status", typeof(string));

                    foreach (var item in rows)
                    {
                        dt.Rows.Add(
                            cusid,
                            drawdownId,
                            Convert.ToInt32(item.PrimaryKey),
                            item.Required,
                            item.Status
                        );
                    }

                    // 2. Create temporary table
                    string createTemp = @"
                    CREATE TABLE #TempIncompleteRows
                    (
                        CusId VARCHAR(50),
                        DrawdownId INT,
                        PrimaryKey INT,
                        Required VARCHAR(5),
                        Status VARCHAR(50)
                    )";

                    using (SqlCommand cmd = new SqlCommand(
                        createTemp, con, tran))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    // 3. Bulk insert into temporary table
                    using (SqlBulkCopy bulk = new SqlBulkCopy(
                        con,
                        SqlBulkCopyOptions.Default,
                        tran))
                    {
                        bulk.DestinationTableName = "#TempIncompleteRows";

                        bulk.ColumnMappings.Add("CusId", "CusId");
                        bulk.ColumnMappings.Add("DrawdownId", "DrawdownId");
                        bulk.ColumnMappings.Add("PrimaryKey", "PrimaryKey");
                        bulk.ColumnMappings.Add("Required", "Required");
                        bulk.ColumnMappings.Add("Status", "Status");

                        bulk.WriteToServer(dt);
                    }

                    // 4. Update actual table
                    String updateSql = @"

                    

delete t_Uploads_Drawdown  where  drawdown_id=@DrawdownId and doc_id  in (select PrimaryKey   from  #TempIncompleteRows where DrawdownId=@DrawdownId)



INSERT INTO [dbo].[t_Uploads_Drawdown]
           (
            [cus_id]
           ,[drawdown_id]
           ,[doc_id]
           ,[required]
           ,[status]
           ,[upload_date_time]
           ,[upload_by]
           ,[upload_ip])

select CusId,DrawdownId,PrimaryKey,Required,Status,getdate(),@upload_by,@upload_ip from #TempIncompleteRows"




                        ;

                    using (SqlCommand cmd = new SqlCommand(updateSql, con, tran))
                    {
                        cmd.Parameters.Add("@DrawdownId", SqlDbType.VarChar).Value = drawdownId;
                        cmd.Parameters.Add("@upload_by", SqlDbType.VarChar).Value = "Test";
                        cmd.Parameters.Add("@upload_ip", SqlDbType.VarChar).Value = "127.0.0.1";

                        cmd.ExecuteNonQuery();

                    }

                    // 5. Commit transaction
                    tran.Commit();

                    return "Data saved successfully!";
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw new Exception(
                        "Error saving incomplete rows: " + ex.Message
                    );
                }
            }
        }
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
        command.Parameters.Add(new SqlParameter("@reason", Obj.details));

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
    protected void LoadDocList()
    {
        String drawdown_id = Request.QueryString[0].ToString();

        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];

        //String cus_id = Request.QueryString[3].ToString();


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.CommandText = "usp_Checklist_Load_For_Upload_V2";
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



            //GridView1.DataSource = Ds.Tables[18];
            //GridView1.DataBind();


            //CustomerName = Ds.Tables[18].Rows[0]["cus_name"].ToString();


            TableData_SanctionAdvice = Ds.Tables[18];
            GridView1.DataSource = TableData_SanctionAdvice;
            GridView1.DataBind();

            TableData_Customers = Ds.Tables[19];
            GridView2.DataSource = TableData_Customers;
            GridView2.DataBind();
            
            TableData_Facilities = Ds.Tables[20];
            GridView3.DataSource = TableData_Facilities;
            GridView3.DataBind();

            TableData_Securities = Ds.Tables[21];
            GridView4.DataSource = TableData_Securities;
            GridView4.DataBind();

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

    [WebMethod]
    public static bool Update_Status(string drawdown_id, string cus_id)
    {

        try
        {
            String connectionString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("dbo.UpdateSanctionReference", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@drawdown_id", SqlDbType.Int).Value = drawdown_id;
                cmd.Parameters.Add("@cus_id", SqlDbType.NVarChar, 255).Value = cus_id ?? (object)DBNull.Value;

                con.Open();

                int rows = Convert.ToInt32(cmd.ExecuteScalar());

                return rows > 0;
            }
        }
        catch
        {
            throw;
        }
    }


    [WebMethod]
    public static bool Finish(Int32 drawdown_id)
    {
        String DomainID = HttpContext.Current.Session["DomainID"].ToString();


        try
        {
            String connectionString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("usp_Checklist_Fillup_Finish", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@drawdown_id", SqlDbType.Int).Value = drawdown_id;
                cmd.Parameters.Add("@by", SqlDbType.VarChar, 500).Value = DomainID;

                con.Open();

                int result = Convert.ToInt32(cmd.ExecuteScalar());

                return result == 1;
            }

        }
        catch
        {
            throw;
        }
    }


    public class FieldInfo
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string LookupType { get; set; }
    }

    public class RecordInfo
    {
        public long RecordId { get; set; }
        public int PKNo { get; set; }
        public string Value01 { get; set; }
        public string Value02 { get; set; }
        public string Value03 { get; set; }
        public string Value04 { get; set; }
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<FieldInfo> LoadFields(int pk)
    {
        return GetFieldConfig(pk);
    }

    public static List<FieldInfo> GetFieldConfig(int pk)
    {
        List<FieldInfo> fields = new List<FieldInfo>();

        Action<string, string, string> add =
            (name, type, lookup) =>
            {
                fields.Add(new FieldInfo
                {
                    Name = name,
                    Type = type,
                    LookupType = lookup
                });
            };

        switch (pk)
        {
            case 7:
                add("Approval Authority", "select", "APPROVAL");
                add("Expiry", "date", "");
                break;

            case 43:
                add("Deed Number", "number", "");
                add("Date", "date", "");
                break;

            case 44:
                add("Original/Certified/Photocopy", "select", "ORIGINAL_TYPE");
                add("Deed Number", "number", "");
                add("Date", "date", "");
                break;

            case 45:
                add("Deed Number", "number", "");
                add("Date", "date", "");
                add("SRO", "select", "SRO");
                add("Deed Delivery Date", "date", "");
                break;

            case 46:
            case 49:
                add("Deed Number", "number", "");
                add("Date", "date", "");
                break;

            case 53:
                add("Khatian Number", "number", "");
                add("DCR Number", "number", "");
                add("DCR Page Number", "number", "");
                break;

            case 62:
                add("Valuation Company", "select", "VALUATION");
                add("Date", "date", "");
                break;

            case 74:
                add("Deed Number", "number", "");
                add("Date", "date", "");
                add("Previous Bank", "select", "BANK");
                add("Previous Branch", "text", "");
                break;

            case 80:
            case 82:
                add("Original/Certified", "select", "ORIGINAL_TYPE");
                add("Deed Number", "number", "");
                add("Date", "date", "");
                add("Withdrawal Date", "date", "");
                break;

            case 85:
            case 86:
                add("Deed Number", "number", "");
                add("Date", "date", "");
                add("Amount", "number", "");
                break;

            case 143:
            case 145:
                add("Submission Number", "number", "");
                add("Date", "date", "");
                add("Amount", "number", "");
                break;

            case 186:
                add("Guarantor Company", "text", "");
                break;

            case 211:
                add("ECAI Name", "select", "ECAI");
                add("Expiry", "date", "");
                add("Rating", "select", "RATING");
                break;
        }

        return fields;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<string> LoadLookup(string lookupType)
    {
        List<string> result = new List<string>();

        string cs = ConfigurationManager
            .ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(@"
        SELECT LookupValue
        FROM dbo.PK_Lookup
        WHERE LookupType = @Type
          AND IsActive = 1
        ORDER BY LookupValue", con))
        {
            cmd.Parameters.Add("@Type", SqlDbType.VarChar, 50)
                .Value = lookupType;

            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                    result.Add(Convert.ToString(dr["LookupValue"]));
            }
        }

        return result;
    }



    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool SaveRecord(int drawdown_id, int pk, string[] values)
    {
        List<FieldInfo> fields = GetFieldConfig(pk);

        if (fields.Count == 0 || values == null || values.Length != fields.Count)
            throw new Exception("Invalid input.");

        for (int i = 0; i < values.Length; i++)
        {
            if (String.IsNullOrWhiteSpace(values[i]))
                throw new Exception(fields[i].Name + " is required.");
        }

        string[] dbValues = new string[4];

        for (int i = 0; i < 4; i++)
            dbValues[i] = i < values.Length ? values[i] : null;

        string cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(@"
        INSERT INTO dbo.PK_Details
        (Drawdown_Id,PKNo, Value01, Value02, Value03, Value04)
        VALUES
        (@drawdown_id,@PK, @V1, @V2, @V3, @V4)", con))
            {

                cmd.Parameters.Add("@drawdown_id", SqlDbType.Int).Value = drawdown_id;

                cmd.Parameters.Add("@PK", SqlDbType.Int).Value = pk;




                for (int i = 0; i < 4; i++)
                {
                    cmd.Parameters.Add("@V" + (i + 1),
                        SqlDbType.NVarChar, 500).Value =
                        (object)dbValues[i] ?? DBNull.Value;
                }

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
        return true;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<RecordInfo> LoadRecords(int drawdown_id, int pk)
    {
        List<RecordInfo> result = new List<RecordInfo>();

        string cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(@"
        SELECT RecordId, PKNo,
               Value01, Value02, Value03, Value04
        FROM dbo.PK_Details
        WHERE Drawdown_Id=@drawdown_id and  PKNo = @PK
        ORDER BY RecordId DESC", con))
            {
                cmd.Parameters.Add("@drawdown_id", SqlDbType.Int).Value = drawdown_id;

                cmd.Parameters.Add("@PK", SqlDbType.Int).Value = pk;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        result.Add(new RecordInfo
                        {
                            RecordId = Convert.ToInt64(dr["RecordId"]),
                            PKNo = Convert.ToInt32(dr["PKNo"]),
                            Value01 = Convert.ToString(dr["Value01"]),
                            Value02 = Convert.ToString(dr["Value02"]),
                            Value03 = Convert.ToString(dr["Value03"]),
                            Value04 = Convert.ToString(dr["Value04"])
                        });
                    }
                }
            }
        }
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object DeleteRecord(int drawdown_id, int recordId)
    {

        try
        {
            string cs = ConfigurationManager
                .ConnectionStrings["dbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand(@"
        DELETE FROM dbo.PK_Details
        WHERE   Drawdown_Id=@drawdown_id and  RecordId = @ID", con))
                {
                    cmd.Parameters.Add("@drawdown_id", SqlDbType.Int).Value = drawdown_id;

                    cmd.Parameters.Add("@ID", SqlDbType.BigInt).Value = recordId;

                    con.Open();

                    //return cmd.ExecuteNonQuery() > 0;

                    cmd.ExecuteNonQuery();

                    return new { Success = true, Message = "Deleted successfully." };
                }
            }
        }
        catch (Exception ex)
        {
            return new { Success = false, Message = "Unable to delete record." + ex.Message };
        }
    }

    [WebMethod]
    public static ExceptionData[] GetData(Int32 drawdown_id) //Show the details of the data after insert in HTML Table
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

            query = @"

select 
	row_number() over (order by id asc )  doc_sl
	,*
from 
(
select
	e.id
	,e.name doc_name
	,e.status
	,e.reason details
	,convert(varchar(10),e.date,103)deadline
from
(

select e.*,m.name from t_Drawdown_Document_Master m
join
(

select * from [dbo].[t_Uploads_Drawdown] d where status in ('Part','Not')   and drawdown_id=@drawdown_id
union 
select * from [dbo].[t_Uploads_Drawdown] o where o.status not in  ('Obtained') and drawdown_id=@drawdown_id


)e
on
e.doc_id=m.primary_key
)e
union

select id,doc_name,status,details,deadline from t_OtherDocuments where drawdown_id=@drawdown_id and status in ('Part','Not')
)e



";




            using (var cmd = new SqlCommand(query, con))
            {

                cmd.Parameters.AddWithValue("@drawdown_id", drawdown_id);


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



    /*
    [WebMethod]
    public static bool Update_Status(string drawdown_id, string cus_id)
    {
        try
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"
                    UPDATE YourTable
                    SET SanctionReference = @SanctionReference
                    WHERE SanctionID = @SanctionID";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@SanctionID", drawdown_id);
                    cmd.Parameters.AddWithValue("@SanctionReference", cus_id);

                    con.Open();

                    int rows = cmd.ExecuteNonQuery();

                    return rows > 0;
                }
            }
        }
        catch (Exception)
        {
            return false;
        }
    }
    */

    public class Obj
    {

        public String doc_name;

        public String cus_id;
        public Int32 doc_id;
        public Int32 drawdown_id;

        public String required;
        public String status;
        public String reason;

        public String details;

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




    [WebMethod]
    public static ExceptionData[] GetDataAnyOthDoc(Int32 drawdown_id) //Show the details of the data after insert in HTML Table
    {
        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        DataTable TableData = new DataTable();

        var details = new List<ExceptionData>();

        using (var con = new SqlConnection(ConStr))
        {
            String query = @"select  row_number() over (order by id asc) doc_sl,o.* from [dbo].[t_OtherDocuments] o where o.status in  ('Obtained') and drawdown_id=@drawdown_id";


            //const string query = "select row_number() over (order by id asc )  doc_sl  ,o.* from [dbo].[t_OtherDocuments] o  ";
            using (var cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@drawdown_id", drawdown_id);


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
