using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NReco.PdfGenerator;

public partial class ChecklistGen : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        var htmlToPdf = new HtmlToPdfConverter
        {
            Size = PageSize.A4,
            Orientation = PageOrientation.Portrait,
            Margins = new PageMargins { Top = 20, Bottom = 20, Left = 15, Right = 15 }
        };

        var html = String.Format("<body>Hello world: {0}</body>", DateTime.Now);


        byte[] pdfBytes = htmlToPdf.GeneratePdf(html);


        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=Test.pdf");
        Response.BinaryWrite(pdfBytes);
        Response.End();
    }
}