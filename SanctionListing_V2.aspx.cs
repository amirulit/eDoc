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

public partial class SanctionListing_V2 : System.Web.UI.Page
{
    public DataTable TableData;

    public Int32 Role;

    protected void Page_Load(object sender, EventArgs e)
    {
        TableData = Listing();


        Role = Convert.ToInt32(Session["Role"].ToString());
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

                return affected > 0 ? "success" : "Record not found";
            }
        }
    }
    [WebMethod]
    public static string UpdateMaster(
        int edoc_id,
        string booking_branch,
        string sanction_reference,
        string sanction_date,
        string sanction_segment,
        string sanction_approval_authority)
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

                cmd.Parameters.Add("@sanction_date", SqlDbType.Date).Value =
                    Convert.ToDateTime(sanction_date);

                cmd.Parameters.Add("@sanction_segment", SqlDbType.VarChar, 50).Value = sanction_segment;

                cmd.Parameters.Add("@sanction_approval_authority", SqlDbType.VarChar, 100).Value = sanction_approval_authority;

                con.Open();

                int result = cmd.ExecuteNonQuery();

                return result > 0 ? "success" : "Unable to update Master";
            }
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
}