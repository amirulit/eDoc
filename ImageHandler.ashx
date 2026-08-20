<%@ WebHandler Language="C#" Class="ImageHandler" %>

using System;
using System.Web;

using System.IO;

public class ImageHandler : IHttpHandler {
    
    
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
        if (!string.IsNullOrEmpty(context.Request.QueryString["FileName"]))
        {
            string filePath = "F:\\Image\\";
            string fileName = context.Request.QueryString["FileName"];
            string contentType = "image/" + System.IO.Path.GetExtension(fileName).Replace(".", "");
            using (System.IO.FileStream fs = new System.IO.FileStream(filePath + fileName, System.IO.FileMode.Open, FileAccess.Read))
            {
                using (System.IO.BinaryReader br = new System.IO.BinaryReader(fs))
                {
                    // Read the file and convert it to Byte Array.
                    byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    br.Close();
                    fs.Close();

                    // Write the file to response Stream.                   
                    context.Response.ContentType = contentType;
                    context.Response.BinaryWrite(bytes);
                    context.Response.End();
                }
            }
        }
    }
}