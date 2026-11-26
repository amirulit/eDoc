<%@ WebHandler Language="C#" Class="UploadFiles_DM" %>

using System;
using System.IO;
using System.Web;
using System.Web.SessionState;


using System.Data.SqlClient;
using System.Data;

public class UploadFiles_DM : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (context.Request.HttpMethod != "POST")
                throw new Exception("Invalid request method.");

            if (context.Request.Files.Count == 0)
                throw new Exception("No file received.");

            HttpPostedFile postedFile = context.Request.Files[0];

            if (postedFile == null || postedFile.ContentLength == 0)
                throw new Exception("Empty file.");

            int dd_id = Convert.ToInt32(
                context.Request.Form["dd_id"]);

            String doc_type = context.Request.Form["doc_type"];

            if (String.IsNullOrEmpty(doc_type))
                throw new Exception("Document type is missing.");

            String f_name = Path.GetFileName(postedFile.FileName);

            String fileName = dd_id + "_" + f_name;

            String uploadPath = @"E:\eDoc_Upload_DM\";

            if (!Directory.Exists(uploadPath))
                Directory.CreateDirectory(uploadPath);

            String fullPath = Path.Combine(uploadPath, fileName);

            postedFile.SaveAs(fullPath);

            // Call your existing database method here.
            String err_msg = Document_Upload_DM(dd_id, doc_type, fileName);

            context.Response.ContentType = "text/plain";

            if (string.IsNullOrEmpty(err_msg))
            {
                context.Response.StatusCode = 200;
                context.Response.Write(fileName);
            }
            else
            {
                context.Response.StatusCode = 400;
                context.Response.Write(err_msg);
            }
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.ContentType = "text/plain";
            context.Response.Write(ex.Message);
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }

    // Connect this to your existing Document_Upload_CD method.
    //private string Document_Upload_CD(
    //    int edoc_id, string doc_type, string f_name)
    //{
        
    //    return "";
    //}



    protected String Document_Upload_DM(Int32 dd_id, String doc_type, String file_name)
    {

        Int32 i;

        String ErrorMSG = "";

        String ConStr = System.Configuration.ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_Document_Upload_By_DM";
        command.Connection = connection;

        SqlParameter[] parameters = 


                    {


                        new SqlParameter("@drawdown_id",dd_id), 
                        new SqlParameter("@file_type",doc_type), 
                        new SqlParameter("@file_name",file_name), 
                        new SqlParameter("@by","Test")
                    
                    
                    };


        command.Parameters.AddRange(parameters);


        try
        {
            connection.Open();
            i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('LOAN Proposal Created Successfully');window.location = 'ProposalListing.aspx';", true);
                ErrorMSG = "";
            }
            else
            {
                ErrorMSG = "Error";
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! LOAN Proposal Creation failed');", true);
            }
        }

        catch (Exception ex)
        {
            //lblStatus.Text = ex.Message;
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Error Occured : " + ex.Message + "');", true);

            ErrorMSG = ex.Message;
        }
        return ErrorMSG;

    }

}
