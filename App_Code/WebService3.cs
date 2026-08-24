using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.IO;
using System.Net;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Services;
using Newtonsoft.Json.Linq;

/// <summary>
/// Summary description for WebService3
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ScriptService]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService3 : System.Web.Services.WebService
{

    public WebService3()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public String HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod(EnableSession = true)]
    public static Object Get_ACI_DealerInfo(String cus_code)
    {



        Object obj = new Object();

        String url = @"http://182.160.102.164:8000/api/customer/59001546";


        //String url = URL + cus_code;

        //String T24_API_User = ConfigurationManager.AppSettings["T24_API_User"].ToString();
        //String T24_API_Pwd = ConfigurationManager.AppSettings["T24_API_Pwd"].ToString();

        //String T24_API_User = "AMIRUL.ITD";
        //String T24_API_Pwd = "AAbb@a2106";

        //String T24_API_User = "MBL.DEV.API01";
        //String T24_API_Pwd = "Mbl@!#789M";

        //MBL.DEV.API01/Mbl@!#789M

        //String Credentials = T24_API_User + @"/" + T24_API_Pwd;

        var request = (HttpWebRequest)WebRequest.Create(url);

        request.Method = "GET";

        //String companyId = HttpContext.Current.Session["BranchCode"].ToString();

        request.Headers.Add("Authorization", "25164d6c6f9db6225b38da0fb45db6bdb7a1e75e12aa7fb7eef108334683d127");
        request.Headers.Add("validate_only", "TRUE");
        //request.Headers.Add("companyId", companyId);



        request.AutomaticDecompression = DecompressionMethods.Deflate | DecompressionMethods.GZip;

        var content = String.Empty;



        try
        {
            using (var response = (HttpWebResponse)request.GetResponse())
            {
                using (var stream = response.GetResponseStream())
                {
                    using (var sr = new StreamReader(stream))
                    {
                        content = sr.ReadToEnd();


                    }
                }
            }


            if (content.Contains("[]"))
            {

                obj = new
                {
                    StatusCode = "2222",
                    StatusText = "No records were found that matched the selection criteria"

                };

            }
            else
            {

                JObject jbj = JObject.Parse(content);
                String api_response = jbj["body"].ToString();

                JArray jsonArray = JArray.Parse(api_response);


                JObject jbj2 = JObject.Parse(jsonArray[0].ToString());


                obj = new
                {
                    StatusCode = "0000",
                    StatusText = "SUCCESS",
                    customerMnemonic = jbj2["customerMnemonic"].ToString(),
                    ltCusFathername = jbj2["ltCusFathername"].ToString(),
                    ltCusMothername = jbj2["ltCusMothername"].ToString(),
                    shortName = jbj2["shortName"].ToString(),
                    tinId = jbj2["tinId"].ToString(),
                    gender = jbj2["gender"].ToString(),
                    smsNumber = jbj2["smsNumber"].ToString(),
                    presentAddress = jbj2["presentAddress"].ToString(),
                    ltCusPermanentAddress = (jbj2["ltCusPermanentAddress"].ToString()),
                    legalId = jbj2["legalId"].ToString(),
                    legalDocumentName = (jbj2["legalDocumentName"].ToString()),
                    ltCusSourceofFunds = jbj2["ltCusSourceofFunds"].ToString(),
                    ltCusOccupation = (jbj2["ltCusOccupation"].ToString())
                };
            }
        }

        catch (Exception ex)
        {
            obj = new
            {
                StatusCode = "9999",
                StatusText = ex.Message
            };
        }


        return obj;


    }


    [WebMethod]
    public static Object[] GetDetails2(String fn)
    {
        Object[] details = null;
        String imageUrl = "";


        //String filepath = @"E:\Desktop Screen Shot 20181030.jpg";

        String filepath = @"E:\CAD_Doc\" + fn;

        
        FileStream fs = new FileStream(filepath, FileMode.Open, FileAccess.Read);
        BinaryReader br = new BinaryReader(fs);
        Byte[] bytes = br.ReadBytes((Int32)fs.Length);
        br.Close();
        fs.Close();
        String base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
        imageUrl = "data:image/png;base64," + base64String;

        details = new object[] { imageUrl, fn };

        return details;
    }



    [WebMethod]
    public void UploadFiles()
    {
        //try
        //{

        //Create the Directory.
        //string path = HttpContext.Current.Server.MapPath("~/Uploads/");
        //if (!Directory.Exists(path))
        //{
        //Directory.CreateDirectory(path);
        //}

        Int32 Customer_Auto_ID = Convert.ToInt32(HttpContext.Current.Request.Form["cus_id"].ToString());

        Int32 File_Auto_ID = Convert.ToInt32(HttpContext.Current.Request.Form["file_auto_id"].ToString());

        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.





        //String fileName = Customer_Auto_ID + "_" + File_Auto_ID + "_" + postedFile.FileName + Path.GetExtension(postedFile.FileName);

        String fileName = Customer_Auto_ID + "_" + File_Auto_ID + "_" + postedFile.FileName;

        //Save the File.
        //postedFile.SaveAs(path + fileName);

        //postedFile.SaveAs(@"E:\tt\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

        //postedFile.SaveAs(@"E:\CAD_Doc\" + fileName + "_ITD");

        postedFile.SaveAs(@"E:\CAD_Doc\" + fileName);

        String SqlStr = "INSERT INTO [dbo].[t_Uploads_Customer]  ([cus_id],[doc_id],[file_name],[upload_date_time],[upload_by],[upload_ip])   VALUES   (" + Customer_Auto_ID + "," + File_Auto_ID + ",'" + fileName + "',getdate(),'Test','127.0.0.1')";

        Int32 i;

        String ErrorMSG = "";

        //String ConStr = ConfigurationManager.ConnectionStrings["MBLFileTracker"].ConnectionString;

        SqlConnection connection = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");

        //SqlConnection connection = new SqlConnection(con);
        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.Text;
        command.CommandText = SqlStr;
        command.Connection = connection;



        try
        {
            connection.Open();
            i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('LOAN Proposal Created Successfully');window.location = 'ProposalListing.aspx';", true);
                ErrorMSG = "OK";
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


        //HttpContext.Current.Response.StatusCode =(int)HttpStatusCode.InternalServerError;

        //Send OK Response to Client.
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(fileName);
        HttpContext.Current.Response.Flush();

        //}
        //catch (Exception ex)
        //{
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
        //HttpContext.Current.Response.Write(ex.Message);
        //HttpContext.Current.Response.Flush();
        //} 

    }



    [WebMethod]
    public void UploadFiles_4()
    {
        //try
        //{

        //Create the Directory.
        //string path = HttpContext.Current.Server.MapPath("~/Uploads/");
        //if (!Directory.Exists(path))
        //{
        //Directory.CreateDirectory(path);
        //}

        //Int32 Customer_Auto_ID = Convert.ToInt32(HttpContext.Current.Request.Form["customer_auto_id"].ToString());

        Int32 File_Auto_ID = Convert.ToInt32(HttpContext.Current.Request.Form["file_auto_id"].ToString());

        Int32 Cust_ID = Convert.ToInt32(HttpContext.Current.Request.Form["cust_id"].ToString()); 

        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.





        //String fileName = Customer_Auto_ID + "_" + File_Auto_ID + "_" + postedFile.FileName + Path.GetExtension(postedFile.FileName);

        String fileName = Cust_ID + "_" + File_Auto_ID + "_" + postedFile.FileName;

        //Save the File.
        //postedFile.SaveAs(path + fileName);

        //postedFile.SaveAs(@"E:\tt\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

        //postedFile.SaveAs(@"E:\CAD_Doc\" + fileName + "_ITD");

        postedFile.SaveAs(@"E:\CAD_Doc\" + fileName);

        //String SqlStr = "INSERT INTO [dbo].[t_Uploads]  ([cus_id],[doc_id],[file_name],[upload_date_time],[upload_by],[upload_ip])   VALUES   (" + Customer_Auto_ID + "," + File_Auto_ID + ",'" + fileName + "',getdate(),'Test','127.0.0.1')";

        String SqlStr = "INSERT INTO [dbo].[t_Uploads_Profile]  ([cus_id],[doc_id],[file_name],[upload_date_time],[upload_by],[upload_ip])   VALUES   (" + Cust_ID + "," + File_Auto_ID + ",'" + fileName + "',getdate(),'Test','127.0.0.1')";

        Int32 i;

        String ErrorMSG = "";

        //String ConStr = ConfigurationManager.ConnectionStrings["MBLFileTracker"].ConnectionString;

        SqlConnection connection = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");

        //SqlConnection connection = new SqlConnection(con);
        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.Text;
        command.CommandText = SqlStr;
        command.Connection = connection;



        try
        {
            connection.Open();
            i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('LOAN Proposal Created Successfully');window.location = 'ProposalListing.aspx';", true);
                ErrorMSG = "OK";
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


        //HttpContext.Current.Response.StatusCode =(int)HttpStatusCode.InternalServerError;

        //Send OK Response to Client.
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(fileName);
        HttpContext.Current.Response.Flush();

        //}
        //catch (Exception ex)
        //{
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
        //HttpContext.Current.Response.Write(ex.Message);
        //HttpContext.Current.Response.Flush();
        //} 

    }


    [WebMethod]
    public void UploadFiles_5()
    {
        //try
        //{

        //Create the Directory.
        //string path = HttpContext.Current.Server.MapPath("~/Uploads/");
        //if (!Directory.Exists(path))
        //{
        //Directory.CreateDirectory(path);
        //}

        String cus_id = HttpContext.Current.Request.Form["cus_id"].ToString();

        Int32 doc_id = Convert.ToInt32(HttpContext.Current.Request.Form["doc_id"].ToString());


        String required = HttpContext.Current.Request.Form["required"].ToString();


        String expiry = HttpContext.Current.Request.Form["expiry"].ToString();


        if (expiry != "")
        {
            expiry = expiry.ToString().Substring(6, 4) + '-' + expiry.ToString().Substring(3, 2) + '-' + expiry.ToString().Substring(0, 2);
        }

        String remarks = HttpContext.Current.Request.Form["remarks"].ToString(); 

        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.





        //String fileName = Customer_Auto_ID + "_" + File_Auto_ID + "_" + postedFile.FileName + Path.GetExtension(postedFile.FileName);

        String fileName = cus_id + "_" + doc_id + "_" + postedFile.FileName;

        //Save the File.
        //postedFile.SaveAs(path + fileName);

        //postedFile.SaveAs(@"E:\tt\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

        //postedFile.SaveAs(@"E:\CAD_Doc\" + fileName + "_ITD");

        postedFile.SaveAs(@"E:\CAD_Doc\" + fileName);

        //String SqlStr = "INSERT INTO [dbo].[t_Uploads]  ([cus_id],[doc_id],[file_name],[upload_date_time],[upload_by],[upload_ip])   VALUES   (" + Customer_Auto_ID + "," + File_Auto_ID + ",'" + fileName + "',getdate(),'Test','127.0.0.1')";

        //String SqlStr = "INSERT INTO [dbo].[t_Uploads_Customer]  ([cus_id],[doc_id],[required],[status],[reason],[date],[expiry],[remarks],[file_name],[upload_date_time],[upload_by],[upload_ip])   VALUES   ('" + cus_id + "'," + doc_id + ",'" + required + "','Obtained','" + fileName + "',getdate(),'Test','127.0.0.1')";

        //Int32 i;

        String ErrorMSG = "";

        //String ConStr = ConfigurationManager.ConnectionStrings["MBLFileTracker"].ConnectionString;

        //SqlConnection connection = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");

        //SqlConnection connection = new SqlConnection(con);
        //SqlCommand command = new SqlCommand();
        //command.CommandType = CommandType.Text;
        //command.CommandText = SqlStr;
        //command.Connection = connection;



        //try
        //{
            //connection.Open();
            //i = command.ExecuteNonQuery();
            //connection.Close();
            //if (i > 0)
            //{
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('LOAN Proposal Created Successfully');window.location = 'ProposalListing.aspx';", true);
                //ErrorMSG = "OK";
            //}
            //else
            //{
                //ErrorMSG = "Error";
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! LOAN Proposal Creation failed');", true);
            //}
        //}

        //catch (Exception ex)
        //{
            //lblStatus.Text = ex.Message;
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Error Occured : " + ex.Message + "');", true);

            //ErrorMSG = ex.Message;
        //}



        using (SqlConnection connection = new SqlConnection(
            @"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;"))
        {
            using (SqlCommand command = new SqlCommand("usp_SaveDocumentUpload_Customer_With_FileUpload", connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@cus_id", cus_id);
                command.Parameters.AddWithValue("@doc_id", doc_id);
                command.Parameters.AddWithValue("@required", required);
                command.Parameters.AddWithValue("@status", "Obtained");
                //command.Parameters.AddWithValue("@reason", fileName);
                //command.Parameters.AddWithValue("@date", DateTime.Now);

                if (expiry != "")
                {
                    command.Parameters.AddWithValue("@expiry", expiry);
                }
                command.Parameters.AddWithValue("@remarks", remarks);
                command.Parameters.AddWithValue("@file_name", fileName);
                command.Parameters.AddWithValue("@upload_date_time", DateTime.Now);
                command.Parameters.AddWithValue("@upload_by", "test");
                command.Parameters.AddWithValue("@upload_ip", "127.0.0.1");


                /*
                
                command.Parameters.Add("@cus_id", SqlDbType.VarChar, 50).Value = cus_id;
                command.Parameters.Add("@doc_id", SqlDbType.Int).Value = doc_id;
                command.Parameters.Add("@required", SqlDbType.VarChar, 10).Value = required;
                command.Parameters.Add("@status", SqlDbType.VarChar, 50).Value = "Obtained";
                command.Parameters.Add("@reason", SqlDbType.VarChar, 500).Value = fileName;
                command.Parameters.Add("@date", SqlDbType.DateTime).Value = DateTime.Now;
                command.Parameters.Add("@expiry", SqlDbType.VarChar, 50).Value = "Test";
                command.Parameters.Add("@remarks", SqlDbType.VarChar, 500).Value = remarks;
                command.Parameters.Add("@file_name", SqlDbType.VarChar, 500).Value = fileName;
                command.Parameters.Add("@upload_date_time", SqlDbType.DateTime).Value = DateTime.Now;
                command.Parameters.Add("@upload_by", SqlDbType.VarChar, 100).Value = upload_by;
                command.Parameters.Add("@upload_ip", SqlDbType.VarChar, 50).Value = upload_ip; 
                 
                */

                try
                {
                    connection.Open();

                    int i = command.ExecuteNonQuery();

                    if (i > 0)
                    {
                        ErrorMSG = "OK";

                       
                    }
                    else
                    {
                        ErrorMSG = "Error";
                    }


                    HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
                    HttpContext.Current.Response.Write(fileName);
                    HttpContext.Current.Response.Flush();


                }
                catch (Exception ex)
                {
                    ErrorMSG = ex.Message;
                    HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    HttpContext.Current.Response.Write(ex.Message);
                    HttpContext.Current.Response.Flush();
                }

            }

        }


        //HttpContext.Current.Response.StatusCode =(int)HttpStatusCode.InternalServerError;

        //Send OK Response to Client.
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        //HttpContext.Current.Response.Write(fileName);
        //HttpContext.Current.Response.Flush();

        //}
        //catch (Exception ex)
        //{
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
        //HttpContext.Current.Response.Write(ex.Message);
        //HttpContext.Current.Response.Flush();
        //} 

    }


    [WebMethod]
    public void DeleteFile()
    {

        Int32 id = Convert.ToInt32(HttpContext.Current.Request.Form["id"].ToString());


        String SqlStr = "Delete [dbo].[t_Uploads]   where id=" + id;

        Int32 i;

        String ErrorMSG = "";

        //String ConStr = ConfigurationManager.ConnectionStrings["MBLFileTracker"].ConnectionString;

        SqlConnection connection = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");

        //SqlConnection connection = new SqlConnection(con);
        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.Text;
        command.CommandText = SqlStr;
        command.Connection = connection;



        try
        {
            connection.Open();
            i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('LOAN Proposal Created Successfully');window.location = 'ProposalListing.aspx';", true);
                ErrorMSG = "OK";
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

        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(ErrorMSG);
        HttpContext.Current.Response.Flush();
    }

    [WebMethod]
    public void UploadFiles_3()
    {
        //try
        //{

        //Create the Directory.
        //string path = HttpContext.Current.Server.MapPath("~/Uploads/");
        //if (!Directory.Exists(path))
        //{
        //Directory.CreateDirectory(path);
        //}

        //Fetch the File.
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.
        String filename = (postedFile.FileName);
        String filepath = HttpContext.Current.Request.Form["filepath"];

        //Save the File.
        //postedFile.SaveAs(path + fileName);

        //postedFile.SaveAs(@"E:\tt\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

        postedFile.SaveAs(@"E:\CAD_Doc\" + filepath + @"\" + filename);

        //Send OK Response to Client.
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(filename);
        HttpContext.Current.Response.Flush();

        //}
        //catch (Exception ex)
        //{
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
        //HttpContext.Current.Response.Write(ex.Message);
        //HttpContext.Current.Response.Flush();
        //} 
    }

    [WebMethod]
    public String uplo(Int32 ID, String Status)
    {
        return ID.ToString() + "-" + Status;

        //return HttpContext.Current.Request.Form["name"];

        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        //HttpContext.Current.Response.Write("OK");
        //HttpContext.Current.Response.Flush();

    }

    [WebMethod]
    public void u()
    {
        //return HttpContext.Current.Request.Form["name"];

        string n = HttpContext.Current.Request.Form["name"];

        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(n);
        HttpContext.Current.Response.Flush();


    }

    [WebMethod]
    public void UploadFiles_2()
    {

        //try
        //{

        //Create the Directory.
        //string path = HttpContext.Current.Server.MapPath("~/Uploads/");
        //if (!Directory.Exists(path))
        //{
        //Directory.CreateDirectory(path);
        //}

        //Fetch the File.
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.
        //String fileName = HttpContext.Current.Request.Form["fileName"] + "_" + Path.GetExtension(postedFile.FileName);

        Int32 file_no = Convert.ToInt32(HttpContext.Current.Request.Form["file_no"]);

        String f_name = Path.GetFileName(postedFile.FileName);

        String fileName = HttpContext.Current.Request.Form["file_no"] + "_" + Path.GetFileName(postedFile.FileName);

        //String fileName = HttpContext.Current.Request.Form["file_no"] + "_" + f_name;

        //Save the File.
        //postedFile.SaveAs(path + fileName);

        //postedFile.SaveAs(@"E:\tt\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

        postedFile.SaveAs(@"E:\CAD_Doc\" + fileName);

        //String SqlStr = "Insert into t_LoanInfo_SanctionLetter values (" + file_no + ",'" + fileName + "',getdate(),'" + HttpContext.Current.Session["DomainID"] + "','Uploaded','" + HttpContext.Current.Session["BranchCode"] + "')  ";

        //File.AppendAllText(@"E:\LoanFileTracker_Error\Log.txt", SqlStr);

        //SanctionLetterUpload(SqlStr); 

        //Send OK Response to Client.
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(fileName);
        HttpContext.Current.Response.Flush();

        //}
        //catch (Exception ex)
        //{
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
        //HttpContext.Current.Response.Write(ex.Message);
        //HttpContext.Current.Response.Flush();
        //}



    }



    protected void SanctionLetterUpload(String SqlStr)
    {

        Int32 i;

        String ErrorMSG = "";

        String ConStr = ConfigurationManager.ConnectionStrings["MBLFileTracker"].ConnectionString;

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.Text;
        command.CommandText = SqlStr;
        command.Connection = connection;



        try
        {
            connection.Open();
            i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('LOAN Proposal Created Successfully');window.location = 'ProposalListing.aspx';", true);
                ErrorMSG = "OK";
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
        //return ErrorMSG;
    }
    [WebMethod(EnableSession = true)]
    public void Save_Indv()
    {


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        String msg;
        /*
        String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        */

        //String json = JsonConvert.SerializeObject(Ob);

        //JObject obj = JObject.Parse(json);

        //String Valid = "";
        //String Params = "";



        /*
        if (obj.ContainsKey("params"))
        {
            Params = obj["params"].ToString();
            Valid = "The JSON object has a 'params' property" + Params;
        }
        else
        {
            Valid = "The JSON object does not have a 'params' property" + Params;
        }
        return Request.CreateResponse(HttpStatusCode.Created, Valid);
        */





        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Save_INDV";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        new SqlParameter("@edoc_id",HttpContext.Current.Request.Form["edoc_id"]), 
                        new SqlParameter("@cus_code",HttpContext.Current.Request.Form["cus_code"]), 
                        new SqlParameter("@name",HttpContext.Current.Request.Form["name"] ),
                        new SqlParameter("@fname",HttpContext.Current.Request.Form["fname"] ),
                        new SqlParameter("@mname",HttpContext.Current.Request.Form["mname"]),
                        
                        

                    };


            command.Parameters.AddRange(parameters);
            connection.Open();
            Int32 i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Input Saved Successfully');window.location = 'List.aspx';", true);
                msg = "Data Saved";
            }
            else
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);
                msg = "Data Not Saved";
            }
        }
        catch (Exception ex)
        {
            //lblStatus.Text = ex.Message;
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Error Occured : " + ex.Message + "');", true);
            msg = ex.Message;
        }

        //return msg;
    }
}
