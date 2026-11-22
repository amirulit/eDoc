using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;

public partial class SanctionListing_V2 : System.Web.UI.Page
{
    public DataTable TableData{get;set;}

    public Int32 Role {get;set;}

    protected void Page_Load(object sender, EventArgs e)
    {



        Role = Convert.ToInt32(Session["Role"].ToString());


        TableData = Listing();

        BLL b = new BLL();

        select3.DataSource = b.LoadBranch();
        select3.DataTextField = "name";
        select3.DataValueField = "code";
        select3.DataBind();


        Select4.DataSource = b.LoadCusList();
        Select4.DataTextField = "cid";
        Select4.DataValueField = "cus_code";
        Select4.DataBind();


        Select5.DataSource = b.LoadLoanNatures();
        Select5.DataTextField = "name";
        Select5.DataValueField = "id";
        Select5.DataBind();



    }


    public class SanctionDetailUpdate
    {
        public int id { get; set; }
        public string loan_nature_name { get; set; }
        public string currency { get; set; }
        public decimal amount { get; set; }
        public string validity { get; set; }
    }



    [WebMethod]
    public static Object SaveSanctionDetails_V2(

        string customer,
        string loanNature,
        string currency,
        string amount,
        string validity)
    {

        String Output = "";
        try
        {
            string constr = ConfigurationManager
                .ConnectionStrings["dbConn"]
                .ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = @"
                INSERT INTO t_Sanction_Master_Details
                (customer_id, loan_nature, Currency, Amount, Validity)
                VALUES
                (@Customer, @LoanNature, @Currency, @Amount, @Validity)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Customer", customer);
                    cmd.Parameters.AddWithValue("@LoanNature", loanNature);
                    cmd.Parameters.AddWithValue("@Currency", currency);
                    cmd.Parameters.AddWithValue("@Amount", Convert.ToDecimal(amount));
                    cmd.Parameters.AddWithValue("@Validity", validity);

                    con.Open();
                    //cmd.ExecuteNonQuery();

                    //return Convert.ToInt32(cmd.ExecuteScalar());

                    //return cmd.ExecuteScalar().ToString();

                    Output = cmd.ExecuteScalar().ToString();
                }
            }

            return new { message = "Success", id = Output };
        }
        catch (Exception ex)
        {
            return new { message = ex.Message, id = 0 };
        }
    }



    [WebMethod]
    public static Object SaveSanctionDetails(
        String edoc_id,
        String edoc_refno,
        String sanc_refno,
        String customer,
        String customerName,
        String loanNature,
        String currency,
        String amount,
        String validity)
    {



         String Inputter = HttpContext.Current.Session["DomainID"].ToString();

        Int32 id;
        try
        {
            String constr = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SP_SaveSanctionDetails", con))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@edoc_id", edoc_id);
                    cmd.Parameters.AddWithValue("@edoc_refno", edoc_refno);
                    cmd.Parameters.AddWithValue("@sanc_refno", sanc_refno);
                    cmd.Parameters.AddWithValue("@Customer", customer);
                    cmd.Parameters.AddWithValue("@CustomerName", customerName);
                    cmd.Parameters.AddWithValue("@LoanNature", loanNature);
                    cmd.Parameters.AddWithValue("@Currency", currency);
                    cmd.Parameters.AddWithValue("@Amount", Convert.ToDecimal(amount));
                    cmd.Parameters.AddWithValue("@Validity", validity);
                    cmd.Parameters.AddWithValue("@entry_by", Inputter);




                    con.Open();

                    //return Convert.ToInt32(cmd.ExecuteScalar());

                    id = Convert.ToInt32(cmd.ExecuteScalar());

                }

            }
            return new { message = "Success", id = id };
        }
        catch (Exception ex)
        {
            return new { message = ex.Message, id = 0 };
        }
    }



    [System.Web.Services.WebMethod]
    public static string UpdateSanctionDetail(SanctionDetailUpdate obj)
    {
        try
        {
            if (obj == null || obj.id <= 0)
                return "Invalid record";

            // Update your database here using parameterized SQL
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString))
            {
                string sql = @"
                UPDATE YourSanctionTable
                SET
                    loan_nature_name = @loan_nature_name,
                    currency = @currency,
                    amount = @amount,
                    validity = @validity
                WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@loan_nature_name", obj.loan_nature_name);
                    cmd.Parameters.AddWithValue("@currency", obj.currency);
                    cmd.Parameters.AddWithValue("@amount", obj.amount);
                    cmd.Parameters.AddWithValue("@validity", obj.validity);
                    cmd.Parameters.AddWithValue("@id", obj.id);

                    con.Open();

                    int result = cmd.ExecuteNonQuery();

                    return result > 0 ? "success" : "Record not found";
                }
            }
        }
        catch (Exception ex)
        {
            // Log exception
            return "Error updating record";
        }
    }
    public class DocumentInfo
    {
        public int Id { get; set; }
        public string FileType { get; set; }
        public string FileName { get; set; }
        public string UploadBy { get; set; }
        public string UploadTime { get; set; }
        public string FileUrl { get; set; }
    }


    [WebMethod]
    public static string DeleteDetail(int id)
    {
        string cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(
                "DELETE FROM t_Sanction_Master_Details WHERE id = @id", con))
            {
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

                con.Open();

                int affected = cmd.ExecuteNonQuery();

                return affected > 0 ? "Success" : "Record not found";
            }
        }
    }
    [WebMethod]
    public static Object UpdateMaster(
        int edoc_id,
        string booking_branch,
        string sanction_reference,
        string sanction_date,
        string sanction_segment,
        string sanction_approval_authority)
    {

        try
        {
            string cs = ConfigurationManager
                .ConnectionStrings["dbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "dbo.usp_UpdateSanctionMaster", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@edoc_id", SqlDbType.Int).Value = edoc_id;

                    cmd.Parameters.Add("@booking_branch", SqlDbType.VarChar, 50).Value = booking_branch;

                    cmd.Parameters.Add("@sanction_reference", SqlDbType.VarChar, 100).Value = sanction_reference;

                    cmd.Parameters.Add("@sanction_date", SqlDbType.Date).Value = Convert.ToDateTime(sanction_date);

                    cmd.Parameters.Add("@sanction_segment", SqlDbType.VarChar, 50).Value = sanction_segment;

                    cmd.Parameters.Add("@sanction_approval_authority", SqlDbType.VarChar, 100).Value = sanction_approval_authority;

                    con.Open();

                    int result = cmd.ExecuteNonQuery();

                    //return result > 0 ? "success" : "Unable to update Master";
                }
            }
            return new { message = "Success", id = 1 };
        }
        catch (Exception ex)
        {
            return new { message = ex.Message, id = 0 };
        }
    }

    [System.Web.Services.WebMethod]
    public static List<DocumentInfo> GetUploadedDocuments(String edocId)
    {
        List<DocumentInfo> documents = new List<DocumentInfo>();

        String connectionString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        String query = @"
        SELECT
            id,
            edoc_id,
            file_type,
            file_name,
            upload_by,
            upload_time
        FROM dbo.t_Document_Upload_By_CD
        --WHERE edoc_id in (" + edocId + @")
        --WHERE edoc_id in (@edoc_id )
        ORDER BY id DESC";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                // Adjust SqlDbType and length to match your edoc_id column.
                cmd.Parameters.Add("@edoc_id", SqlDbType.NVarChar, 100).Value = edocId;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string fileName = Convert.ToString(dr["file_name"]);

                        documents.Add(new DocumentInfo
                        {
                            Id = Convert.ToInt32(dr["id"]),
                            FileType = Convert.ToString(dr["file_type"]),
                            FileName = fileName,
                            UploadBy = Convert.ToString(dr["upload_by"]),
                            UploadTime = Convert.ToDateTime(dr["upload_time"]).ToString("dd-MMM-yyyy hh:mm tt"),


                            /*
                            FileUrl = "~/UploadedDocuments/" +
                                      Uri.EscapeDataString(
                                          System.IO.Path.GetFileName(fileName))

                            */
                            /*
                            FileUrl = "~/UploadedDocuments/" +
                                     Uri.EscapeDataString(
                                         System.IO.Path.GetFileName(fileName))
                            */

                            FileUrl = "ViewDocument.ashx?id=" + Convert.ToInt32(dr["id"])


                        });
                    }
                }
            }
        }

        return documents;

    }





    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string UpdateFinal(int edoc_id, string edoc_refno)
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(
                "usp_Update_Final_Sanction", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@edoc_id", SqlDbType.Int).Value = edoc_id;

                cmd.Parameters.Add("@edoc_refno", SqlDbType.VarChar, 100).Value =
                    edoc_refno;

                con.Open();

                int updatedRows = Convert.ToInt32(cmd.ExecuteScalar());

                if (updatedRows > 0)
                    return "SUCCESS";

                return "NO_RECORD";
            }
        }
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

        String Segment = String.Empty;

        String BranchCode = Session["BranchCode"].ToString();
        /*For Branch*/
        if (Role == 5 || Role == 7 || Role == 9 || Role == 11)
        {

            command.CommandText = "usp_SanctionLisitng_V2_Branch";

            command.Parameters.Add(new SqlParameter("@branchcode", BranchCode));
        }
        else if (Role == 61 || Role == 63)
        {
            //Segment = "CMSME|Agriculture";

            command.CommandText = "usp_SanctionLisitng_V2_SME_n_Agriculture";

            command.Parameters.Add(new SqlParameter("@domain_id", Session["DomainID"].ToString()));
        }
        else
        {

            if (Role == 21 || Role == 23 || Role == 57 || Role == 59)
            {
                Segment = "Corporate";


            }
            else if (Role == 25 || Role == 27)
            {
                Segment = "CMSME";


            }

            else if (Role == 29 || Role == 31 || Role == 65 || Role == 59)
            {
                Segment = "Retail";


            }

            else if (Role == 33 || Role == 35)
            {
                Segment = "Agriculture";


            }

           
            else
            {
                Segment = "ALL";
            }


            command.Parameters.Add(new SqlParameter("@Segment", Segment));

        }





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