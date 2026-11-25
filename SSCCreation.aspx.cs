using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;


public partial class SSCCreation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        int drawdownId = Convert.ToInt32(476);
        //int sscNumber = GetNextSscNumber(); // your auto-generation logic

        byte[] pdfBytes = SscPdfGenerator.GenerateUnconCentralizedSscPdf(drawdownId);

        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", "attachment; filename=SSC_" + drawdownId + ".pdf");
        Response.BinaryWrite(pdfBytes);
        Response.End();

    }
    protected void btnDownloadCond_Click(object sender, EventArgs e)
    {
        int drawdownId = Convert.ToInt32(477);
        //int sscNumber = GetNextSscNumber(); // your auto-generation logic

        byte[] pdfBytes = SscPdfGenerator.GenerateCondCentralizedSSCPdf(drawdownId);

        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", "attachment; filename=SSC_" + drawdownId + ".pdf");
        Response.BinaryWrite(pdfBytes);
        Response.End();

    }

    protected void btnDownloadUnConDeCenSSC_Click(object sender, EventArgs e)
    {
        int drawdownId = Convert.ToInt32(476);
        //int sscNumber = GetNextSscNumber(); // your auto-generation logic

        byte[] pdfBytes = SscPdfGenerator.GenerateUnconDeCentralizedSscPdf(drawdownId);

        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", "attachment; filename=SSC_" + drawdownId + ".pdf");
        Response.BinaryWrite(pdfBytes);
        Response.End();

    }
    protected void btnDownloadConDeCenSSC_Click(object sender, EventArgs e)
    {
        int drawdownId = Convert.ToInt32(477);
        //int sscNumber = GetNextSscNumber(); // your auto-generation logic

        byte[] pdfBytes = SscPdfGenerator.GenerateCondDeCentralizedSSCPdf(drawdownId);

        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", "attachment; filename=SSC_" + drawdownId + ".pdf");
        Response.BinaryWrite(pdfBytes);
        Response.End();

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        int drawdownId = 476;

        byte[] pdfBytes = SscPdfGenerator.GenerateUnconCentralizedSscPdf(drawdownId);

        // PDF storage location
        string folderPath = @"E:\eDoc_SSC";

        // Create folder if not exists
        if (!Directory.Exists(folderPath))
        {
            Directory.CreateDirectory(folderPath);
        }

        // File name
        string fileName = "SSC_" + drawdownId + ".pdf";

        // Complete file path
        string filePath = Path.Combine(folderPath, fileName);

        // Write PDF file
        File.WriteAllBytes(filePath, pdfBytes);

        // Optional confirmation
        lblMessage.Text = "PDF saved successfully: " + filePath;
    }





    [WebMethod]
    public static string GenerateSSC_OLD(int drawdownId)
    {
        try
        {
            // Generate PDF
            byte[] pdfBytes =
                SscPdfGenerator.GenerateUnconCentralizedSscPdf(drawdownId);

            // Storage location
            string folderPath = @"E:\eDoc_SSC";

            // Create folder if not exists
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            // File name
            string fileName = "SSC_" + drawdownId + ".pdf";

            // Complete file path
            string filePath = Path.Combine(folderPath, fileName);

            // Save PDF
            File.WriteAllBytes(filePath, pdfBytes);

            return "PDF generated successfully: " + fileName;
        }
        catch (Exception ex)
        {
            // Log exception in production
            return "ERROR: " + ex.Message;
        }
    }



    [WebMethod(EnableSession = true)]
    public static string GenerateSSC(int drawdownId)
    {
        try
        {
            byte[] pdfBytes =
                SscPdfGenerator.GenerateUnconCentralizedSscPdf(drawdownId);

            string folderPath = @"E:\eDoc_SSC";

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fileName = "SSC_" + drawdownId + ".pdf";
            string filePath = Path.Combine(folderPath, fileName);

            // Save PDF on server
            File.WriteAllBytes(filePath, pdfBytes);

            // Insert file information into database here
            // InsertSSCFile(drawdownId, fileName, "Centralized",
            //               "PDF", HttpContext.Current.User.Identity.Name);


            int i = InsertSSCFile(drawdownId, fileName, "Centralized", "onditional", "Test");


            // Return browser-accessible URL
            string pdfUrl = VirtualPathUtility.ToAbsolute(
                "~/ViewSSC.ashx?id=" + drawdownId);

            return pdfUrl;
        }
        catch (Exception ex)
        {
            // Log exception
            throw new Exception("PDF generation failed." + ex.Message);
        }
    }

    public static int InsertSSCFile(
    int drawdownId,
    string fileName,
    string sscMode,
    string type,
    string createBy)
    {
        string cs = ConfigurationManager
            .ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(
                "usp_Insert_SSC_Files", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@drawdown_id", SqlDbType.Int)
                    .Value = drawdownId;

                cmd.Parameters.Add("@file_name", SqlDbType.VarChar, 500)
                    .Value = fileName;

                cmd.Parameters.Add("@ssc_mode", SqlDbType.VarChar, 50)
                    .Value = sscMode;

                cmd.Parameters.Add("@type", SqlDbType.VarChar, 50)
                    .Value = type;

                cmd.Parameters.Add("@create_by", SqlDbType.VarChar, 500)
                    .Value = createBy;

                cmd.Parameters.Add("@create_date", SqlDbType.DateTime)
                    .Value = DateTime.Now;

                con.Open();

                object result = cmd.ExecuteScalar();

                return Convert.ToInt32(result);
            }
        }
    }
}
