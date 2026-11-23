using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Generate_SSC_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DisplayPDF();
        }
    }


    private void DisplayPDF()
    {
        try
        {
            // 1. Get generated document ID
            int documentId;

            if (!int.TryParse(
                Request.QueryString["id"],
                out documentId))
            {
                Response.StatusCode = 400;
                return;
            }

            // 2. Get PDF information from database
            GeneratedSSCRepository repository =
                new GeneratedSSCRepository();

            GeneratedSSC document =
                repository.GetDocument(documentId);

            if (document == null)
            {
                Response.StatusCode = 404;
                return;
            }

            // 3. Resolve physical PDF path
            string folderPath =
                Server.MapPath("~/App_Data/SSC/");

            string physicalPath =
                Server.MapPath(document.FilePath);

            // 4. Ensure the file belongs to the SSC folder
            string fullFolder =
                Path.GetFullPath(folderPath);

            string fullFile =
                Path.GetFullPath(physicalPath);

            if (!fullFile.StartsWith(
                fullFolder,
                StringComparison.OrdinalIgnoreCase))
            {
                throw new Exception("Invalid PDF path.");
            }

            // 5. Check PDF exists
            if (!File.Exists(fullFile))
            {
                Response.StatusCode = 404;
                Response.Write("PDF file not found.");
                return;
            }

            // 6. Display PDF in browser
            Response.Clear();
            Response.ClearHeaders();

            Response.ContentType = "application/pdf";

            Response.AddHeader(
                "Content-Disposition",
                "inline; filename=\"" +
                Path.GetFileName(document.FileName) + "\""
            );

            Response.AddHeader(
                "Content-Length",
                new FileInfo(fullFile).Length.ToString()
            );

            Response.Cache.SetCacheability(
                HttpCacheability.Private);

            Response.Cache.SetNoStore();

            Response.TransmitFile(fullFile);

            Response.Flush();

            Context.ApplicationInstance.CompleteRequest();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Trace.TraceError(
                "SSC PDF viewing error: " + ex);

            Response.Clear();
            Response.StatusCode = 500;
            Response.Write("Unable to display PDF.");

            Context.ApplicationInstance.CompleteRequest();
        }
    }

    protected override void Render(
        System.Web.UI.HtmlTextWriter writer)
    {
        // Prevent ASPX markup from being appended to PDF response.
    }
}