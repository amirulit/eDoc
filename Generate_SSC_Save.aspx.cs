using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Generate_SSC_Save : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenerateAndSavePDF();
        }
    }
    private void GenerateAndSavePDF()
    {
        string physicalPath = null;

        try
        {
            // 1. Get certificate ID
            int certificateId;

            if (!int.TryParse(
                Request.QueryString["id"],
                out certificateId))
            {
                throw new Exception("Invalid certificate ID.");
            }

            // 2. Get certificate information from database
            CertificateRepository repository =
                new CertificateRepository();

            SecuritySatisfactionCertificate data =
                repository.GetCertificate(certificateId);

            if (data == null)
            {
                throw new Exception("Certificate not found.");
            }

            // 3. Generate PDF
            CertificatePdfService pdfService =
                new CertificatePdfService();

            byte[] pdfBytes =
                pdfService.GeneratePdf(data);

            // 4. Create PDF folder
            string folderPath =
                Server.MapPath("~/App_Data/SSC/");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            // 5. Generate unique filename
            string fileName =
                "SSC_" + certificateId + "_" +
                Guid.NewGuid().ToString("N") + ".pdf";

            // 6. Save PDF in folder
            physicalPath =
                Path.Combine(folderPath, fileName);

            File.WriteAllBytes(physicalPath, pdfBytes);

            // 7. Save PDF information in database
            string relativePath =
                "~/App_Data/SSC/" + fileName;

            string createdBy =
                Context.User.Identity.IsAuthenticated
                    ? Context.User.Identity.Name
                    : "System";

            GeneratedSSCRepository documentRepository =
                new GeneratedSSCRepository();

            int documentId =
                documentRepository.SaveDocument(
                    certificateId,
                    fileName,
                    relativePath,
                    createdBy
                );

            // 8. Open saved PDF in browser
            Response.Redirect(
                "ViewSSC.aspx?id=" + documentId,
                false
            );

            Context.ApplicationInstance.CompleteRequest();
        }
        catch (Exception ex)
        {
            // Remove orphan PDF if database insertion fails
            if (!string.IsNullOrEmpty(physicalPath) &&
                File.Exists(physicalPath))
            {
                File.Delete(physicalPath);
            }

            System.Diagnostics.Trace.TraceError(
                "SSC generation error: " + ex);

            Response.Clear();
            Response.StatusCode = 500;
            Response.ContentType = "text/plain";
            Response.Write(
                "PDF generation failed. Please contact administrator.");

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}