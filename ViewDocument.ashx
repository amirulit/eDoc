<%@ WebHandler Language="C#" Class="ViewDocument" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web;

public class ViewDocument : IHttpHandler
{
    
    
    //public void ProcessRequest(HttpContext context)
    //{
        //int id;
        
        

        //if (!int.TryParse(context.Request.QueryString["id"], out id))
        //{
        //    context.Response.StatusCode = 400;
        //    return;
        //}

        /*
        String Type;
        String FileName;  
        
        String connectionString =
            ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        String fileName = "";

        String query = @"
            SELECT file_name
            FROM dbo.t_Document_Upload_By_CD
            WHERE id = @id";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

                con.Open();

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    context.Response.StatusCode = 404;
                    return;
                }

                fileName = Path.GetFileName(Convert.ToString(result));
            }

            String physicalPath = Path.Combine(@"E:\eDoc_SanctionDoc", fileName);

            if (!File.Exists(physicalPath))
            {
                context.Response.StatusCode = 404;
                return;
            }

            context.Response.ContentType = "application/pdf";
            context.Response.AddHeader("Content-Disposition", "inline; filename=\"" + fileName.Replace("\"", "") + "\"");

            context.Response.TransmitFile(physicalPath);
            context.Response.Flush();
            context.ApplicationInstance.CompleteRequest();
        }
        */

//        String id = context.Request.QueryString["id"];
//        String Type = context.Request.QueryString["Typ"];
//        String FileName = context.Request.QueryString["FileName"];

       
//        System.Collections.Generic.Dictionary<string, string> folders = new System.Collections.Generic.Dictionary<string, string>(
//            StringComparer.OrdinalIgnoreCase)
//{
//    { "CD", @"E:\eDoc_SanctionDoc" },
//    { "DM", @"E:\eDoc_Upload_DM" },
//    { "LLI", @"E:\eDoc_LLI" }
//};
        
        

//        if (String.IsNullOrEmpty(Type) || !folders.ContainsKey(Type))
//        {
//            context.Response.StatusCode = 400;
//            return;
//        }

//        if (String.IsNullOrWhiteSpace(FileName) ||
//            FileName != Path.GetFileName(FileName))
//        {
//            context.Response.StatusCode = 400;
//            return;
//        }

//        String physicalPath = Path.Combine(folders[Type], FileName);

//        if (!File.Exists(physicalPath))
//        {
//            context.Response.StatusCode = 404;
//            return;
//        }

//        context.Response.Clear();

//        context.Response.ContentType = "application/pdf";

//        context.Response.AddHeader(
//             "Content-Disposition",
//             "inline; filename=\"" + FileName.Replace("\"", "") + "\""
//         );
 

//        context.Response.TransmitFile(physicalPath);

//        context.ApplicationInstance.CompleteRequest();
        
        
//        return;

//    }

    
     
    public void ProcessRequest(HttpContext context)
    {
        int id;

        if (!int.TryParse(context.Request.QueryString["id"], out id))
        {
            context.Response.StatusCode = 400;
            return;
        }

        String type = context.Request.QueryString["Typ"];
        String FileName = context.Request.QueryString["FileName"];


        System.Collections.Generic.Dictionary<String, String> Folders =
            new System.Collections.Generic.Dictionary<String, String>(
                StringComparer.OrdinalIgnoreCase)
    {
        { "CD", @"E:\eDoc_Upload_SanctionDoc" },
        { "DM", @"E:\eDoc_Upload_DM" },
        { "LLI", @"E:\eDoc_Upload_LLI" }
    };

        if (String.IsNullOrEmpty(type) || !Folders.ContainsKey(type))
        {
            context.Response.StatusCode = 400;
            return;
        }


        /*
        string tableName;

        switch (type.ToUpperInvariant())
        {
            case "CD":
                tableName = "t_Document_Upload_By_CD";
                break;

            case "DM":
                tableName = "t_Document_Upload_By_DM";
                break;

            case "LLI":
                tableName = "t_Document_Upload_By_LLI";
                break;

            default:
                context.Response.StatusCode = 400;
                return;
        }

        string FileName = "";

        string cs = ConfigurationManager
            .ConnectionStrings["dbConn"].ConnectionString;

        string sql = "SELECT file_name FROM dbo." + tableName +
                     " WHERE id = @id";

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

            con.Open();

            object result = cmd.ExecuteScalar();

            if (result == null || result == DBNull.Value)
            {
                context.Response.StatusCode = 404;
                return;
            }

            FileName = Path.GetFileName(Convert.ToString(result));
        }
        */




        String physicalPath = Path.Combine(Folders[type], FileName);

        if (!File.Exists(physicalPath))
        {
            
            context.Response.StatusCode = 404;
            return;
            
            
        }

        context.Response.Clear();

        context.Response.ContentType = "application/pdf";

        context.Response.AddHeader("Content-Disposition", "inline; filename=\"" + FileName.Replace("\"", "") + "\"");

        context.Response.TransmitFile(physicalPath);

        context.ApplicationInstance.CompleteRequest();
        
        
        
    } 
     
   

    public bool IsReusable
    {
        get { return false; }
    }
}