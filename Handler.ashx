<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {


        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");


        string cus_ids = context.Request.Form["cus_ids"];
        string sanction_reference = context.Request.Form["sanction_reference"];
        string sanction_date = context.Request.Form["sanction_date"];
        string sanction_authority = context.Request.Form["sanction_authority"];
        string booking_branch = context.Request.Form["booking_branch"];

        HttpPostedFile file = context.Request.Files["sanction_doc"];

        string fileName = "";

        if (file != null && file.ContentLength > 0)
        {
            fileName = System.IO.Path.GetFileName(file.FileName);

            string folder = @"E:\eDoc_SanctionDoc";//context.Server.MapPath("~/Uploads/Sanction/");

            if (!System.IO.Directory.Exists(folder))
            {
                System.IO.Directory.CreateDirectory(folder);
            }

            string savePath = System.IO.Path.Combine(folder, fileName);

            file.SaveAs(savePath);
        }

        // Save database information here

        context.Response.ContentType = "application/json";

        context.Response.Write(
            "{\"message\":\"Data Saved\",\"fileName\":\"" +
            fileName.Replace("\"", "") +
            "\"}"
        );
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}