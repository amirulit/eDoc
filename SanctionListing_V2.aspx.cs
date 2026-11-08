using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

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

    [System.Web.Services.WebMethod]
    public static List<DocumentInfo> GetUploadedDocuments(string edocId)
    {
        List<DocumentInfo> documents = new List<DocumentInfo>();

        string connectionString = ConfigurationManager
            .ConnectionStrings["dbConn"].ConnectionString;

        string query = @"
        SELECT
            id,
            edoc_id,
            file_type,
            file_name,
            upload_by,
            upload_time
        FROM dbo.t_Document_Upload_By_CD
        --WHERE edoc_id = @edoc_id
        ORDER BY id DESC";

        using (SqlConnection con = new SqlConnection(connectionString))
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            // Adjust SqlDbType and length to match your edoc_id column.
            cmd.Parameters.Add("@edoc_id", SqlDbType.NVarChar, 100)
                          .Value = edocId;

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