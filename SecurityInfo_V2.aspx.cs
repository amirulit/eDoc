using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Script.Services;

public partial class SecurityInfo_V2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object DeleteChecklist(
        int id,
        int applicationId)
    {
        try
        {
            string cs = ConfigurationManager
                .ConnectionStrings["DBConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                DELETE FROM MortgageChecklistDetails
                WHERE Id = @Id
                  AND ApplicationId = @ApplicationId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;

                    cmd.Parameters.Add("@ApplicationId", SqlDbType.Int)
                        .Value = applicationId;

                    con.Open();

                    int rows = cmd.ExecuteNonQuery();

                    if (rows == 0)
                        return new { Success = false, Message = "Record not found." };
                }
            }

            return new { Success = true, Message = "Deleted successfully." };
        }
        catch (Exception ex)
        {
            return new { Success = false, Message = "Unable to delete record." + ex.Message };
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<object> GetChecklist(
        int applicationId,
        int keyNo)
    {
        List<object> result = new List<object>();

        string cs = ConfigurationManager
            .ConnectionStrings["DBConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
            SELECT Id, DetailsJson
            FROM MortgageChecklistDetails
            WHERE ApplicationId = @ApplicationId
              AND KeyNo = @KeyNo
            ORDER BY Id DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@ApplicationId", SqlDbType.Int)
                    .Value = applicationId;

                cmd.Parameters.Add("@KeyNo", SqlDbType.Int)
                    .Value = keyNo;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        result.Add(new
                        {
                            Id = Convert.ToInt32(dr["Id"]),
                            DetailsJson = dr["DetailsJson"].ToString()
                        });
                    }
                }
            }
        }

        return result;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object SaveChecklist(
        int applicationId,
        int keyNo,
        string detailsJson)
    {
        try
        {
            // Validate the application and key against the
            // authenticated user's permissions before saving.

            var validKeys = new int[]
        {
            7, 43, 44, 45, 46, 49, 53, 62, 74,
            80, 82, 85, 86, 143, 145, 186, 211
        };

            if (Array.IndexOf(validKeys, keyNo) < 0)
                return new { Success = false, Message = "Invalid key number." };

            if (string.IsNullOrWhiteSpace(detailsJson))
                return new { Success = false, Message = "No information provided." };

            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            // Ensure the submitted data is valid JSON.
            serializer.DeserializeObject(detailsJson);

            string cs = ConfigurationManager
                .ConnectionStrings["DBConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                INSERT INTO MortgageChecklistDetails
                (
                    ApplicationId,
                    KeyNo,
                    ChecklistDescription,
                    DetailsJson
                )
                VALUES
                (
                    @ApplicationId,
                    @KeyNo,
                    @Description,
                    @DetailsJson
                )";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@ApplicationId", SqlDbType.Int)
                        .Value = applicationId;

                    cmd.Parameters.Add("@KeyNo", SqlDbType.Int)
                        .Value = keyNo;

                    cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 1000)
                        .Value = "Checklist Key " + keyNo;

                    cmd.Parameters.Add("@DetailsJson", SqlDbType.NVarChar, -1)
                        .Value = detailsJson;

                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }

            return new { Success = true, Message = "Saved successfully." };
        }
        catch (Exception)
        {
            return new { Success = false, Message = "Unable to save information." };
        }
    }
}