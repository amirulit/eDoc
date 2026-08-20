<%@ WebHandler Language="C#" Class="ImageHandler_V2" %>

using System;
using System.Web;
using System.IO;
public class ImageHandler_V2 : IHttpHandler {
    
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
        string filePath = @"E:\CAD_Doc\" + context.Request.QueryString["filePath"];

        // Validate and check if the file exists
        if (!string.IsNullOrEmpty(filePath) && File.Exists(filePath))
        {
            context.Response.ContentType = "image/jpeg"; // Or "image/png" based on the image type
            context.Response.WriteFile(filePath);
        }
        else
        {
            context.Response.StatusCode = 404;
            context.Response.Write("Image not found.");
        }
    }

}