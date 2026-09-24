using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace CAD.DataAccess
{
    public partial class SSCCreation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnDownload_Click(object sender, EventArgs e)
        {
            int drawdownId = Convert.ToInt32(219);
            //int sscNumber = GetNextSscNumber(); // your auto-generation logic

            byte[] pdfBytes = SscPdfGenerator.GenerateSscPdf(drawdownId);

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "attachment; filename=SSC_{drawdownId}.pdf");
            Response.BinaryWrite(pdfBytes);
            Response.End();

        }
        protected void btnDownloadCond_Click(object sender, EventArgs e)
        {
            int drawdownId = Convert.ToInt32(216);
            //int sscNumber = GetNextSscNumber(); // your auto-generation logic

            byte[] pdfBytes = SscPdfGenerator.GenerateSscConditionalPdf(drawdownId);

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "attachment; filename=SSC_{drawdownId}.pdf");
            Response.BinaryWrite(pdfBytes);
            Response.End();

        }
        
    }
}