using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for WebService1
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService1 : System.Web.Services.WebService {

    public WebService1 () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }


    [WebMethod]
    public void CreateUser()
    {



        String empid = HttpContext.Current.Request.Form["empid"];
        String name = HttpContext.Current.Request.Form["name"];
        String designation = HttpContext.Current.Request.Form["designation"];
        String role = HttpContext.Current.Request.Form["role"];
        String branchcode = HttpContext.Current.Request.Form["branchcode"];
        String branchname = HttpContext.Current.Request.Form["branchname"];
        String phone = HttpContext.Current.Request.Form["phone"];

        String domain = HttpContext.Current.Request.Form["domain"];

        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];


        String fileName = HttpContext.Current.Request.Form["fileName"] + Path.GetExtension(postedFile.FileName);


        String connStr = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;


        String Sql = @"

if not exists (select 1 from t_User  where domain='" + domain + @"')
begin

INSERT INTO [dbo].[t_User]
           ([empid]
           ,[name]
           ,[designation]
           ,[role]
           ,[branchcode]
           ,[branchname]
           ,[phone]
           ,[domain]


,[signature_image_name]

,[status]

,createdate

)
     VALUES
           ('" + empid + "','" + name + "','" + designation + "','" + role + "','" + branchcode.Replace("BD001", "") + "','" + branchname + "','" + phone + "','" + domain + "','" + fileName + @"','Inactive',getdate())
        
        
        end
        
        ";


        File.WriteAllText(@"E:\eDoc_SQL\Sql_UserCreate.sql", System.DateTime.Now.ToLongDateString() + "-" + System.DateTime.Now.ToLongTimeString() + "-" + Sql + "\n\n");

        Int32 DB_Sts;
        String Status = "";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            //SqlTransaction transaction = conn.BeginTransaction();

            try
            {




                //SqlCommand cmd = new SqlCommand(Sql, conn, transaction);
                SqlCommand cmd = new SqlCommand(Sql, conn);

                Int32 i = cmd.ExecuteNonQuery();

                if (i > 0)
                {
                    postedFile.SaveAs(@"E:\eDoc_Signature\" + empid + "_" + fileName);

                    //transaction.Commit();
                    //return "Records inserted successfully!";
                    //Sts = "Records inserted successfully!";

                    DB_Sts = 1;
                    Status = DB_Sts + "-User Created Successfully!";


                    HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
                    //HttpContext.Current.Response.Write(fileName);
                    HttpContext.Current.Response.Write(Status);
                    HttpContext.Current.Response.Flush();


                    /*
                    DB_Sts = 1;

                    var result = new
                    {
                        status = DB_Sts,
                        message = "User Created Successfully!"
                    };

                    string json = new JavaScriptSerializer().Serialize(result);

                    HttpContext.Current.Response.Clear();
                    HttpContext.Current.Response.ContentType = "application/json; charset=utf-8";
                    HttpContext.Current.Response.Write(json);
                    HttpContext.Current.Response.End();
                    */

                }
                else
                {
                    DB_Sts = 0;
                    Status = DB_Sts + "-User Already Exists!";

                    HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
                    //HttpContext.Current.Response.Write(fileName);
                    HttpContext.Current.Response.Write(Status);
                    HttpContext.Current.Response.Flush();


                    /*
                    DB_Sts = 0;

                    var result = new
                    {
                        status = DB_Sts,
                        message = "User creation failed!"
                    };

                    string json = new JavaScriptSerializer().Serialize(result);

                    HttpContext.Current.Response.ContentType = "application/json";
                    HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
                    HttpContext.Current.Response.Write(json);
                    HttpContext.Current.Response.End();
                    */
                }
            }
            catch (Exception ex)
            {
                //transaction.Rollback();
                //return "Error: " + ex.Message;
                //Sts = "Error: " + ex.Message;
                DB_Sts = 0;
                Status = DB_Sts + "-Error: " + ex.Message;

                HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
                //HttpContext.Current.Response.Write(fileName);
                HttpContext.Current.Response.Write(Status);
                HttpContext.Current.Response.Flush();


                /*
                DB_Sts = 0;

                var result = new
                {
                    status = DB_Sts,
                    message = "User creation failed!"
                };

                string json = new JavaScriptSerializer().Serialize(result);

                HttpContext.Current.Response.ContentType = "application/json";
                HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
                HttpContext.Current.Response.Write(json);
                HttpContext.Current.Response.End();
                */

            }

        }


        //try
        //{

        //Create the Directory.
        //string path = HttpContext.Current.Server.MapPath("~/Uploads/");
        //if (!Directory.Exists(path))
        //{
        //Directory.CreateDirectory(path);
        //}

        //Fetch the File.
        //HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.
        //String fileName = HttpContext.Current.Request.Form["fileName"] + Path.GetExtension(postedFile.FileName);

        //Save the File.
        //postedFile.SaveAs(path + fileName);

        //postedFile.SaveAs(@"E:\tt\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

        //postedFile.SaveAs(@"E:\SOD_Signature\" + empid + "_" + fileName);

        //Send OK Response to Client.
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        //HttpContext.Current.Response.Write(fileName);
        //HttpContext.Current.Response.Write(Status);
        //HttpContext.Current.Response.Flush();

        //}
        //catch (Exception ex)
        //{
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
        //HttpContext.Current.Response.Write(ex.Message);
        //HttpContext.Current.Response.Flush();
        //} 
    }
}
