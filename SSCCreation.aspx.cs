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
        public Int32 drawdown_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            drawdown_id = Convert.ToInt32(Request.QueryString[0].ToString());
        }


        protected void btnDownload_Click(object sender, EventArgs e)
        {
            int drawdownId = Convert.ToInt32(drawdown_id);
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
            int drawdownId = Convert.ToInt32(drawdown_id);
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