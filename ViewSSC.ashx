<%@ WebHandler Language="C#" Class="ViewSSC" %>

using System;
using System.IO;
using System.Web;

public class ViewSSC : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        int drawdownId;

        if (!int.TryParse(context.Request.QueryString["id"], out drawdownId))
        {
            context.Response.StatusCode = 400;
            return;
        }

        // TODO: Verify authenticated user's permission
        // to access this drawdownId.

        string folderPath = @"E:\eDoc_SSC";

        string fileName = "SSC_" + drawdownId + ".pdf";
        string filePath = Path.Combine(folderPath, fileName);

        if (!File.Exists(filePath))
        {
            context.Response.StatusCode = 404;
            return;
        }

        context.Response.Clear();
        context.Response.ContentType = "application/pdf";
        context.Response.AddHeader(
            "Content-Disposition",
            "inline; filename=" + fileName);

        context.Response.TransmitFile(filePath);
        context.Response.Flush();
        context.ApplicationInstance.CompleteRequest();
    }

    public bool IsReusable
    {
        get { return false; }
    }
}