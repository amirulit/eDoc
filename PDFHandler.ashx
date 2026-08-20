<%@ WebHandler Language="C#" Class="PDFHandler" %>

using System;
using System.Web;
using System.IO;

public class PDFHandler : IHttpHandler {
    
    /*
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
    */
    
    
    public bool IsReusable {
        get {
            return false;
        }
    }
    
    
    public void ProcessRequest(HttpContext context)
    {
        String filePath = @"E:\CAD_Doc\" + context.Request.QueryString["filePath"];

        //String filePath = @"E:\CAD_Doc\2_MTB_4622_213402_25-11-2024_23864.pdf.pdf";

        // Ensure the file path is valid and secure
        if (!String.IsNullOrEmpty(filePath) && File.Exists(filePath))
        {
            context.Response.ContentType = "application/pdf";
            context.Response.WriteFile(filePath);
        }
        else
        {
            context.Response.StatusCode = 404;
            context.Response.Write("File not found.");
        }
    }
}