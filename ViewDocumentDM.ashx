<%@ WebHandler Language="C#" Class="ViewDocumentDM" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web;

public class ViewDocumentDM : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        int id;

        if (!int.TryParse(context.Request.QueryString["id"], out id))
        {
            context.Response.StatusCode = 400;
            return;
        }

        string connectionString =
            ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        string fileName = "";

        string query = @"
            SELECT file_name
            FROM dbo.t_Document_Upload_By_DM
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

            String physicalPath = Path.Combine(@"E:\eDoc_Upload_DM", fileName);

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
    }
    public bool IsReusable
    {
        get { return false; }
    }
}