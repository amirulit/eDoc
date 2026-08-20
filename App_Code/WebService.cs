using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }
    [WebMethod]
    public string UploadFile()
    {
        try
        {
            // Get the uploaded file
            HttpPostedFile uploadedFile = HttpContext.Current.Request.Files["file"];

            if (uploadedFile != null && uploadedFile.ContentLength > 0)
            {
                // Define the save path (you can adjust this path as needed)
                string savePath = Server.MapPath("~/UploadedFiles/") + uploadedFile.FileName;

                // Save the uploaded file to the server
                uploadedFile.SaveAs(savePath);

                return "File uploaded successfully!";
            }
            else
            {
                return "No file selected.";
            }
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
    }
}
