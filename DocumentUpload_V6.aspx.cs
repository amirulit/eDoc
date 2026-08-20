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

public partial class DocumentUpload_V6 : System.Web.UI.Page
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

    public DataTable TableData_Basic;
    public DataTable TableData_Charge;
    public DataTable TableData_Liability;
    public DataTable TableData_Loan;
    public DataTable TableData_Mortgage;
    public DataTable TableData_Other;
    public DataTable TableData_Syndication;
    public DataTable TableData_Undertaking;

    public String[] TabsName;
    public String[] DocType;

    public String Admin;


    protected void Page_Load(object sender, EventArgs e)
    {
        TabsName = ("Basic Documents~Charge Documents~Liability Takeover~Loan Documents~Mortgage Document~Other Documents~Syndication/Pledge Doc.~Undertaking").Split('~');
        DocType = ("Basic~Charge~Liability~Loan~Mortgage~Other~Syndication~Undertaking").Split('~');

        //txtCustomerType.Text = Request.QueryString[0].ToString();
        //txteDOCID.Text = Request.QueryString[1].ToString();
        //Admin = "Y";
        LoadDocList();
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
    protected void LoadDocList()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.CommandText = "usp_DocList_View_V2";
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

                    };

        cmd.Parameters.AddRange(parameters);

        cmd.CommandTimeout = 0;

        //con.Open();

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);

            if (Ds.Tables[0].Rows.Count > 0)
            {

                TableData_Basic = Ds.Tables[0];
                TableData_Charge = Ds.Tables[1];
                TableData_Liability = Ds.Tables[2];
                TableData_Loan = Ds.Tables[3];
                TableData_Mortgage = Ds.Tables[4];
                TableData_Other = Ds.Tables[5];
                TableData_Syndication = Ds.Tables[6];
                TableData_Undertaking = Ds.Tables[7];


                //GridView1.DataSource = Ds.Tables[0];
                //GridView1.DataBind();

            }
            else
            {
                //Label0.Text = "No Data Found as a Account Holder";
            }

        }
        catch (Exception ex)
        {
            //lblError.Text = ex.Message;
        }
    }
}