using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using Newtonsoft.Json.Linq;

public partial class ACI : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        String cus_id = Request.QueryString[0].ToString();

        Object obj = new Object();

        //String url = @"http://182.160.102.164:8000/api/customer/59001546";

        String url = @"http://182.160.102.164:8000/api/customer/" + cus_id;


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
        //request.Headers.Add("validate_only", "TRUE");
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


            if (content.Contains("Data not found"))
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
                    customer_code = jbj2["customer_code"].ToString(),
                    customer_type = jbj2["customer_type"].ToString(),
                    customer_name = jbj2["customer_name"].ToString()
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


        //return obj;

        Response.Write(obj);
    }
}