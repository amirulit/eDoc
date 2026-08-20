using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO;
using System.Net;

public partial class DocUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {




    }


    [WebMethod]
    public void UploadFiles()
    {




        //Create the Directory.
        //string path = HttpContext.Current.Server.MapPath("~/Uploads/");
        //if (!Directory.Exists(path))
        //{
        //Directory.CreateDirectory(path);
        //}

        //Fetch the File.
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.
        String fileName = HttpContext.Current.Request.Form["fileName"] + Path.GetExtension(postedFile.FileName);

        //Save the File.
        //postedFile.SaveAs(path + fileName);

        postedFile.SaveAs(@"E:\CAD_Doc\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

        //Send OK Response to Client.
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(fileName);
        HttpContext.Current.Response.Flush();



    }
}