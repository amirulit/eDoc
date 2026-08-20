using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;

public partial class Default5 : System.Web.UI.Page
{

     public DataTable TableData;
    public DataTable dt;

    public String Status;

    public String fdt;
    public String tdt;

    public String tdt_as_on;


    public String BankDate;

    public String EMP_ID;

    public Int32 Role;

    public String GenTime;


    public Double Dep_Target;

    public String BranchName;

    public Double start_bal;
    public Double to_bal;
    public Double diff;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadDocList();
    }

    [WebMethod]
    public string UploadFile()
    {
        try
        {
            // Get the uploaded file
            HttpPostedFile uploadedFile = HttpContext.Current.Request.Files["file"];

            if (uploadedFile != null && uploadedFile.ContentLength > 0)
            {
                // Define the save path (you can adjust this path as needed)
                string savePath = Server.MapPath("~/UploadedFiles/") + uploadedFile.FileName;

                // Save the uploaded file to the server
                uploadedFile.SaveAs(savePath);

                return "File uploaded successfully!";
            }
            else
            {
                return "No file selected.";
            }
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
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

                TableData = Ds.Tables[0];
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