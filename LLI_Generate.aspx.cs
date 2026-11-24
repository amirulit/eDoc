using iTextSharp.text.pdf.parser;
using Newtonsoft.Json;
using NReco.PdfGenerator;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LLI_Generate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public class LLIRequest
    {

        public Int32 drawdown_id { get; set; }
        public MasterInfo master { get; set; }

        public FacilityInfo[] facilities { get; set; }

        public RemarksInfo[] remarks { get; set; }




        public String masterHTML { get; set; }

        public String facilitiesHTML { get; set; }

        public String remarksHTML { get; set; }
    }

    public class MasterInfo
    {
        public string id { get; set; }
        public string edoc_id { get; set; }
        public string edoc_refno { get; set; }
        public string booking_branch { get; set; }
        public string sanction_reference { get; set; }
        public string sanction_date { get; set; }
    }

    public class FacilityInfo
    {
        public string loan_nature { get; set; }
        public string amount { get; set; }
        public string validity { get; set; }
        public string customer_name { get; set; }
        public string drawdown_asked_for { get; set; }
        public string limit_reference { get; set; }
        public string child_code { get; set; }
        public string parent_code { get; set; }
    }

    public class RemarksInfo
    {
        public string SL { get; set; }
        public string Remarks { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object SaveLLIComplete(LLIRequest request)
    {
        try
        {
            if (request == null || request.master == null)
            {
                return new
                {
                    Success = false,
                    Message = "Invalid request data."
                };
            }

            // Convert complete request into JSON
            string jsonData = JsonConvert.SerializeObject(request);

            string connectionString =
                ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
                INSERT INTO LLI_Submissions
                (
                    PayloadJson,
                    CreatedAt
                )
                VALUES
                (
                    @PayloadJson,
                    GETDATE()
                );

                SELECT CAST(SCOPE_IDENTITY() AS INT);
            ";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@PayloadJson", SqlDbType.NVarChar, -1)
                        .Value = jsonData;

                    int savedId = Convert.ToInt32(cmd.ExecuteScalar());

                    return new
                    {
                        Success = true,
                        Message = "Data saved successfully.",
                        Id = savedId
                    };
                }
            }
        }
        catch (Exception ex)
        {
            return new
            {
                Success = false,
                Message = ex.Message
            };
        }
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object SaveLLIComplete_V2(LLIRequest request)
    {
        try
        {
            if (request == null || request.master == null)
            {
                return new
                {
                    Success = false,
                    Message = "Invalid request data."
                };
            }

            // Convert each object separately into JSON

            Int32 drawdown_id = Convert.ToInt32(request.drawdown_id);

            String masterJson = JsonConvert.SerializeObject(request.master);

            String facilitiesJson = JsonConvert.SerializeObject(request.facilities);

            String remarksJson = JsonConvert.SerializeObject(request.remarks);

            String masterHTML = request.masterHTML;

            String facilitiesHTML = request.facilitiesHTML;

            String remarksHTML = request.remarksHTML;


            String connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
                INSERT INTO t_LLI_Submissions
                (
                    DrawdownId,    
                    MasterJson,
                    FacilitiesJson,
                    RemarksJson,
                    MasterHTML,
                    FacilitiesHTML,
                    RemarksHTML,
                    CreatedAt
                )
                VALUES
                (
                    @DrawdownId,
                    @MasterJson,
                    @FacilitiesJson,
                    @RemarksJson,
 @MasterHTML,
                    @FacilitiesHTML,
                    @RemarksHTML,
                    GETDATE()
                );

                SELECT CAST(SCOPE_IDENTITY() AS INT);
            ";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {

                    cmd.Parameters.Add("@DrawdownId", SqlDbType.Int, -1).Value = drawdown_id;
                    cmd.Parameters.Add("@MasterJson", SqlDbType.NVarChar, -1).Value = masterJson;
                    cmd.Parameters.Add("@FacilitiesJson", SqlDbType.NVarChar, -1).Value = facilitiesJson;
                    cmd.Parameters.Add("@RemarksJson", SqlDbType.NVarChar, -1).Value = remarksJson;

                    cmd.Parameters.Add("@MasterHTML", SqlDbType.NVarChar, -1).Value = masterHTML;
                    cmd.Parameters.Add("@FacilitiesHTML", SqlDbType.NVarChar, -1).Value = facilitiesHTML;
                    cmd.Parameters.Add("@RemarksHTML", SqlDbType.NVarChar, -1).Value = remarksHTML;

                    int savedId = Convert.ToInt32(cmd.ExecuteScalar());

                    return new
                    {
                        Success = true,
                        Message = "Data saved successfully.",
                        Id = savedId
                    };
                }
            }
        }
        catch (Exception ex)
        {
            // Log exception on server
            return new
            {
                Success = false,
                Message = "Unable to save data."
            };
        }
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object GetLLIData(int drawdownid)
    {
        try
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
                SELECT DrawdownId,
                    MasterJson,
                    FacilitiesJson,
                    RemarksJson,
MasterHtml,
FacilitiesHtml,
RemarksHtml


                FROM t_LLI_Submissions
                WHERE DrawdownId = @DrawdownId
            ";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@DrawdownId", SqlDbType.Int).Value = drawdownid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            return new
                            {
                                Success = true,
                                DrawdownId = dr["DrawdownId"].ToString(),
                                MasterJson = dr["MasterJson"].ToString(),
                                FacilitiesJson = dr["FacilitiesJson"].ToString(),
                                RemarksJson = dr["RemarksJson"].ToString(),

                                MasterHtml = dr["MasterHtml"].ToString(),
                                FacilitiesHtml = dr["FacilitiesHtml"].ToString(),
                                RemarksHtml = dr["RemarksHtml"].ToString()


                            };
                        }
                    }
                }
            }

            return new
            {
                Success = false,
                Message = "No record found."
            };
        }
        catch (Exception ex)
        {
            // Log ex on server
            return new
            {
                Success = false,
                Message = "Unable to retrieve data."
            };
        }
    }




    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object GenerateLLIPdf(int drawdownid)
    {
        try
        {
            String masterHtml = "";
            String facilitiesHtml = "";
            String remarksHtml = "";

            String cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

            // 1. Get saved HTML from database
            using (SqlConnection con = new SqlConnection(cs))
            {
                String sql = @"
                SELECT MasterHtml, FacilitiesHtml, RemarksHtml
                FROM t_LLI_Submissions
                WHERE DrawdownId = @DrawdownId";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.Add("@DrawdownId", SqlDbType.Int).Value = drawdownid;

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (!dr.Read())
                        {
                            return new
                            {
                                Success = false,
                                Message = "Record not found."
                            };
                        }

                        masterHtml = dr["MasterHtml"] == DBNull.Value ? "" : dr["MasterHtml"].ToString();

                        facilitiesHtml = dr["FacilitiesHtml"] == DBNull.Value ? "" : dr["FacilitiesHtml"].ToString();

                        remarksHtml = dr["RemarksHtml"] == DBNull.Value ? "" : dr["RemarksHtml"].ToString();


                    }
                }
            }

            // 2. Build complete HTML document
            StringBuilder html = new StringBuilder();

            html.Append(@"
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset='UTF-8' />

            <style>

                body {
                    font-family: Arial, sans-serif;
                    font-size: 11px;
                    color: #333;
                }

                h2 {
                    text-align: center;
                    color: #174A7E;
                    margin-bottom: 25px;
                }

                h3 {
                    color: #174A7E;
                    border-bottom: 2px solid #174A7E;
                    padding-bottom: 6px;
                    margin-top: 25px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 10px;
                    margin-bottom: 15px;
                }

                th {
                    background-color: #174A7E;
                    color: white;
                    font-weight: bold;
                    text-align: left;
                }

                th, td {
                    border: 1px solid #ccc;
                    padding: 7px;
                    font-size: 10px;
                    word-wrap: break-word;
                }

                tr {
                    page-break-inside: avoid;
                }

                thead {
                    display: table-header-group;
                }

                .section {
                    margin-bottom: 20px;
                }

            </style>
        </head>

        <body>

            <h2>Mercantile Bank PLC</h2>
            <h5>Credit Adimistration Division</h5>

            <div class='section'>
                <h3>Master Information</h3>");

            html.Append(masterHtml);

            html.Append(@"
            </div>
            We declare that all security documantation have been completed and physically checked by branch, virtually confimred by CAD.
            <div class='section'>
                <h3>Facilities Information</h3>");

            html.Append(facilitiesHtml);

            html.Append(@"
            </div>

            <div class='section'>
                <h3>Remarks Information</h3>");

            html.Append(remarksHtml);

            html.Append(@"
            </div>

        </body>
        </html>");



            html.Append(@"

    <br/><br/>

    <table style='width:100%; border-collapse:collapse;
                  text-align:center; margin-top:40px;'>

        <tr>
            <td style='width:50%; border:1px solid #333;
                       padding:15px 10px;'>

                <div style='height:65px;'></div>

                <div style='border-top:1px solid #333;
                            padding-top:8px;
                            font-weight:bold;'>
                    Document Manager
                </div>

            </td>

            <td style='width:50%; border:1px solid #333;
                       padding:15px 10px;'>

                <div style='height:65px;'></div>

                <div style='border-top:1px solid #333;
                            padding-top:8px;
                            font-weight:bold;'>
                    Unit Head<br/>
                    Documentation Unit
                </div>

            </td>
        </tr>

        <tr>
            <td style='width:50%; border:1px solid #333;
                       padding:15px 10px;'>

                <div style='height:65px;'></div>

                <div style='border-top:1px solid #333;
                            padding-top:8px;
                            font-weight:bold;'>
                    Limit Manager
                </div>

            </td>

            <td style='width:50%; border:1px solid #333;
                       padding:15px 10px;'>

                <div style='height:65px;'></div>

                <div style='border-top:1px solid #333;
                            padding-top:8px;
                            font-weight:bold;'>
                    Unit Head<br/>
                    Limit Maintenance Unit
                </div>

            </td>
        </tr>

    </table>

");


            // 3. Generate PDF
            HtmlToPdfConverter pdfConverter = new HtmlToPdfConverter();

            pdfConverter.Size = PageSize.A4;
            pdfConverter.Orientation = PageOrientation.Landscape;

            pdfConverter.Margins = new PageMargins
            {
                Top = 12,
                Bottom = 12,
                Left = 10,
                Right = 10
            };

            pdfConverter.PageFooterHtml = @"

            <div style='font-family:Arial;font-size:9px; text-align:center;width:100%;'>Page <span class='page'></span>of <span class='topage'></span></div>";


            // 4. Generate PDF bytes
            byte[] pdfBytes = pdfConverter.GeneratePdf(html.ToString());

            // 5. Return Base64 PDF
            /*
            return new
            {
                Success = true,
                FileName = "Drawdown_" + DrawdownId + ".pdf",
                PdfBase64 = Convert.ToBase64String(pdfBytes)
            };
            */



            var htmlToPdf = new HtmlToPdfConverter
            {
                Size = PageSize.Legal,
                Orientation = PageOrientation.Portrait,
                Margins = new PageMargins { Top = 20, Bottom = 20, Left = 15, Right = 15 }
            };



            htmlToPdf.CustomWkHtmlArgs = "--enable-local-file-access";


            //var html = String.Format("<body>Hello world: {0}</body>", DateTime.Now);


            //byte[] pdfBytes = htmlToPdf.GeneratePdf(sb.ToString());

            /*
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Checklist.pdf");
            Response.BinaryWrite(pdfBytes);
            Response.End();
            */


            String folderPath = @"E:\eDoc_LLI";
            String filePath = System.IO.Path.Combine(folderPath, drawdownid + "_LLI.pdf");

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



            //Show PDF in browser

            /*
        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", "inline; filename=" + drawdown_id + "_Checklist.pdf");
        Response.BinaryWrite(pdfBytes);
        Response.End();
            */



           return new
           {
               Success = true,
               FileName = drawdownid + "_LLI.pdf",
               PdfBase64 = Convert.ToBase64String(pdfBytes)
           };



        }

        catch (Exception ex)
        {
            // Log ex.ToString() on the server
            return new
            {
                Success = false,
                Message = "PDF generation failed:" + ex.Message
            };
        }
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object GetFacilities(Int32 drawdown_id)
    {
        List<Dictionary<String, Object>> result = new List<Dictionary<String, Object>>();

        String conStr = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            String sql = @"
        DECLARE @cols NVARCHAR(MAX);
        DECLARE @sql NVARCHAR(MAX);

        SELECT @cols = STUFF((
            SELECT ',' + QUOTENAME(
                'Facility' + CAST(FacilityNo AS VARCHAR(10))
            )
            FROM
            (
                SELECT ROW_NUMBER() OVER (ORDER BY id) AS FacilityNo
                FROM dbo.t_Sanction_Master_Details
            ) A
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

        SET @sql = '
        SELECT *
        FROM
        (
            SELECT
                ''loan_nature'' AS FieldName,
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)) AS FacilityNo,
                CAST(loan_nature AS NVARCHAR(MAX)) AS Value
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''amount'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(amount AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''validity'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(validity AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''customer_name'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(customer_name AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details
        ) AS SourceData

        PIVOT
        (
            MAX(Value)
            FOR FacilityNo IN (' + @cols + ')
        ) AS PivotTable';

        EXEC sp_executesql @sql;
        ";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        Dictionary<string, object> row = new Dictionary<string, object>();

                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            row[dr.GetName(i)] = dr.IsDBNull(i) ? null : dr.GetValue(i);
                        }

                        result.Add(row);
                    }
                }
            }
        }

        return result;
    }

    [WebMethod]
    public static object GetFacilities_V2()
    {
        Dictionary<string, object> result =    new Dictionary<string, object>();

        String conStr = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // TABLE 1: Dynamic PIVOT Query
            String sql1 = @"
        DECLARE @cols NVARCHAR(MAX);
        DECLARE @sql NVARCHAR(MAX);

        SELECT @cols = STUFF((
            SELECT ',' + QUOTENAME(
                'Facility' + CAST(FacilityNo AS VARCHAR(10))
            )
            FROM
            (
                SELECT ROW_NUMBER() OVER (ORDER BY id) AS FacilityNo
                FROM dbo.t_Sanction_Master_Details where edoc_id=567
            ) A
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

        SET @sql = '
        SELECT *
        FROM
        (
            SELECT
                ''loan_nature'' AS FieldName,
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)) AS FacilityNo,
                CAST(loan_nature AS NVARCHAR(MAX)) AS Value
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''amount'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(amount AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''validity'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                --CAST(validity AS NVARCHAR(MAX))
                Convert(varchar(10),validity,23)
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''customer_name'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(customer_name AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''limit_reference'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                ''''
            FROM dbo.t_Sanction_Master_Details



            UNION ALL

            SELECT
                ''drawdown_asked_for'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
               ''''
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''parent_code'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
               ''''
            FROM dbo.t_Sanction_Master_Details


            UNION ALL

            SELECT
                ''child_code'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
               ''''
            FROM dbo.t_Sanction_Master_Details


        ) AS SourceData

        PIVOT
        (
            MAX(Value)
            FOR FacilityNo IN (' + @cols + ')
        ) AS PivotTable  ORDER BY
    CASE FieldName
        WHEN ''loan_nature'' THEN 1
        WHEN ''amount'' THEN 2
        WHEN ''validity'' THEN 3
        WHEN ''customer_name'' THEN 4
        ELSE 5
    END;';

        EXEC sp_executesql @sql;
        ";

            result.Add("Facilities", GetTableData(con, sql1));


            // TABLE 2: Normal query
            string sql2 = @"
            SELECT id,	edoc_id,	edoc_refno,	booking_branch,	sanction_reference,	sanction_date
            FROM dbo.t_Sanction_Master
            WHERE id = 15
        ";

            result.Add("Master", GetTableData(con, sql2));


            // TABLE 3: Normal query
            string sql3 = @"
            SELECT top 10 *
            FROM dbo.t_Group where mother_com_cus_code!=''
        ";

            result.Add("Group", GetTableData(con, sql3));
        }

        return result;
    }

    private static List<Dictionary<string, object>> GetTableData(SqlConnection con, string sql)
    {
        List<Dictionary<string, object>> result = new List<Dictionary<string, object>>();

        using (SqlCommand cmd = new SqlCommand(sql, con))
        {
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    Dictionary<string, object> row =
                        new Dictionary<string, object>();

                    for (int i = 0; i < dr.FieldCount; i++)
                    {
                        row[dr.GetName(i)] =
                            dr.IsDBNull(i) ? null : dr.GetValue(i);
                    }

                    result.Add(row);
                }
            }
        }

        return result;
    }
}