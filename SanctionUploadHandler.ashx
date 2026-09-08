<%@ WebHandler Language="C#" Class="SanctionUploadHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class SanctionUploadHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {


        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");


        String cus_ids = context.Request.Form["cus_ids"];
        String sanction_reference = context.Request.Form["sanction_reference"];
        String sanction_date = context.Request.Form["sanction_date"];
        String sanction_authority = context.Request.Form["sanction_authority"];
        String booking_branch = context.Request.Form["booking_branch"];

        HttpPostedFile file = context.Request.Files["sanction_doc"];




        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        Object[] details = null;

        String msg;


        String Sanc_Date = sanction_date;

        Sanc_Date = Sanc_Date.ToString().Substring(6, 4) + '-' + Sanc_Date.ToString().Substring(3, 2) + '-' + Sanc_Date.ToString().Substring(0, 2);

        //EffectiveFrom = EffectiveFrom.ToString().Substring(6, 4) + '-' + EffectiveFrom.ToString().Substring(3, 2) + '-' + EffectiveFrom.ToString().Substring(0, 2);

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }


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



        //String drawdown_id = "";

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_SanctionUpload";
            command.Connection = connection;

            SqlParameter[] parameters = 

                    {

                       
                        new SqlParameter("@sanction_reference", sanction_reference), 
                        new SqlParameter("@sanction_date",Sanc_Date), 
                        new SqlParameter("@sanction_authority",sanction_authority), 
                        
                        new SqlParameter("@booking_branch",booking_branch), 
                        new SqlParameter("@sanction_doc",file.FileName), 
                        new SqlParameter("@entry_by","Test"),
                       
                        new SqlParameter("@entry_time",DateTime.Now)
                    
                    };



            command.Parameters.AddRange(parameters);


            /*
            SqlParameter auto_id_parm = new SqlParameter("@auto_id", SqlDbType.Int);
            auto_id_parm.Direction = ParameterDirection.Output;
            command.Parameters.Add(auto_id_parm);

            */



            connection.Open();
            Int32 i = command.ExecuteNonQuery();
            connection.Close();
            if (i > 0)
            {
                msg = "Data Saved";
            }
            else
            {
                msg = "Data not Saved";
            }
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('OOOOOOOOOOPPS ! Input Saved Failed');", true);







            String fileName = "";

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

            context.Response.Write("{\"status\":1,\"message\":\"Data Saved\",\"fileName\":\"" + fileName.Replace("\"", "") + "\"}");

        }
        catch (Exception ex)
        {
            context.Response.ContentType = "application/json";

            context.Response.Write("{\"status\":0,\"message\":\"Data not Saved\",\"fileName\":\"" + ex.Message + "\"}");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}