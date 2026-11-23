using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Generate_SSC : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenerateCertificate();
        }
    }

    private void GenerateCertificate()
    {
        try
        {
            int certificateId;

            if (!int.TryParse(     Request.QueryString["id"],out certificateId))
            {
                Response.StatusCode = 400;
                Response.Write("Invalid certificate ID.");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Step 1: Get database record
            CertificateRepository repository =
                new CertificateRepository();

            SecuritySatisfactionCertificate data =
                repository.GetCertificate(certificateId);

            if (data == null)
            {
                Response.StatusCode = 404;
                Response.Write("Certificate not found.");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Step 2: Generate PDF
            CertificatePdfService pdfService =
                new CertificatePdfService();

            byte[] pdfBytes =
                pdfService.GeneratePdf(data);

            // Step 3: Download PDF
            string fileName =
                "SSC_" + certificateId + ".pdf";

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/pdf";

            Response.AddHeader(
                "Content-Disposition",
                "attachment; filename=\"" + fileName + "\"");

            Response.AddHeader(
                "Content-Length",
                pdfBytes.Length.ToString());

            Response.BinaryWrite(pdfBytes);
            Response.Flush();

            Context.ApplicationInstance.CompleteRequest();
        }
        catch (Exception ex)
        {
            // Log the full exception on the server.
            System.Diagnostics.Trace.TraceError("SSC PDF generation failed: " + ex);

            Response.Clear();
            Response.StatusCode = 500;
            Response.ContentType = "text/plain";
            Response.Write("Unable to generate SSC PDF. Please contact administrator.");

            Context.ApplicationInstance.CompleteRequest();
        }
    }
    protected override void Render(System.Web.UI.HtmlTextWriter writer)
    {
        // Do not render ASPX markup after PDF download.
    }
}