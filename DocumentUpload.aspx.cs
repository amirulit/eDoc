using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.IO;

public partial class DocumentUpload : System.Web.UI.Page
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
    public DataTable TableData_Basic;

    public DataTable TableData_Charge;
    public DataTable TableData_Liability;
    public DataTable TableData_Loan;
    public DataTable TableData_Mortgage;
    public DataTable TableData_Other;
    public DataTable TableData_Syndication;
    public DataTable TableData_Undertaking;


    protected void Page_Load(object sender, EventArgs e)
    {

        txtCustomerType.Text = Request.QueryString[0].ToString();
        txteDOCID.Text = Request.QueryString[1].ToString();

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


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.CommandText = "usp_DocList";
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

        SqlParameter[] parameters = 
                    {
                        
                        new SqlParameter("@customer_type", "Indv")
                    
                    
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
            lblError.Text = ex.Message;
        }
    }
}