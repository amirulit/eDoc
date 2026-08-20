using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net;
using System.IO;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;
using System.Data.SqlTypes;


public partial class DrawdownCreate : System.Web.UI.Page
{

    //String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    public static Object[] Get_eDocID(String cus_type)
    {
        Object[] details = null;

        String e_doc_id = "";
        Int32 auto_id = 0;

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_eDOC_ID_Create";
        command.Connection = connection;

        command.Parameters.Add(new SqlParameter("@cus_type", cus_type));


        SqlParameter e_docid_parm = new SqlParameter("@eDOC_ID", SqlDbType.VarChar, 50);
        e_docid_parm.Direction = ParameterDirection.Output;
        command.Parameters.Add(e_docid_parm);

        SqlParameter auto_id_parm = new SqlParameter("@auto_id", SqlDbType.Int);
        auto_id_parm.Direction = ParameterDirection.Output;
        command.Parameters.Add(auto_id_parm);

        try
        {

            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            e_doc_id = e_docid_parm.Value.ToString();
            auto_id = Convert.ToInt32(auto_id_parm.Value.ToString());


        }

        catch (Exception ex)
        {
        }

        //return e_doc_id;

        details = new object[] { e_doc_id, auto_id };

        return details;
    }



    

    [WebMethod(EnableSession = true)]
    public static Object Get_CustomerInfo(String cus_code)
    {



        Object obj = new Object();

        String URL = @"http://10.10.96.55:8280/irisEkycAuth/api/v1.0.0/party/party/customer?customerId=";
         

        String url = URL + cus_code;

        //String T24_API_User = ConfigurationManager.AppSettings["T24_API_User"].ToString();
        //String T24_API_Pwd = ConfigurationManager.AppSettings["T24_API_Pwd"].ToString();

        //String T24_API_User = "AMIRUL.ITD";
        //String T24_API_Pwd = "AAbb@a2106";

        String T24_API_User = "MBL.DEV.API01";
        String T24_API_Pwd = "Mbl@!#789M";

        //MBL.DEV.API01/Mbl@!#789M

        String Credentials = T24_API_User + @"/" + T24_API_Pwd;

        var request = (HttpWebRequest)WebRequest.Create(url);

        request.Method = "GET";

        //String companyId = HttpContext.Current.Session["BranchCode"].ToString();

        request.Headers.Add("credentials", Credentials);
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


    public class Obj
    {
        public String cus_type;
        public String edoc_id;
        public String cus_code;
        public String name;
        public String fname;
        public String mname;
        public String legal_id;
        public String legal_doc_name;
        public String gender;
        public String tin;
        public String pre_addr;
        public String per_addr;


    }

    
    public class PropOwnerInfo
    {
        public String edocid; 
        public String name;
        public String address;
        public String legalid;
        public String legaliddocname;
        public String phone;
 


    }


    public class PartPartnerInfo
    {
        public String edocid;
        public String name;
        public String address;
        
        public String phone;
       

    }

    
    public class CompOwnerInfo
    {
        public String edocid;
       
        public String name;

        public String address;
        public String role;
        public String phone;
       

    }

    public class SisterConcernInfo
    {
        public String edocid;
        public String cusid;
        public String name;
        public String address;
        public String phone;


    }

    public class JVCompanyInfo
    {
        public String edocid;
        public String cusid;
        public String name;
        public String address;
        public String phone;
       
    }


    [WebMethod(EnableSession = true)]
    public static String Profile_Create(Obj Obj)
    {


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        String msg;

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





        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Profile_Create";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        new SqlParameter("@cus_type",Obj.cus_type), 
                        new SqlParameter("@edoc_id",Obj.edoc_id), 
                        new SqlParameter("@cus_code",Obj.cus_code), 
                        new SqlParameter("@name",Obj.name),
                        new SqlParameter("@fname",Obj.fname),
                        new SqlParameter("@mname",Obj.mname),

                        new SqlParameter("@legal_id",Obj.legal_id),
                        new SqlParameter("@legal_doc_name",Obj.legal_doc_name),
                        new SqlParameter("@gender",Obj.gender),
                        new SqlParameter("@tin",Obj.tin),
                        new SqlParameter("@pre_addr",Obj.pre_addr),
                        new SqlParameter("@per_addr",Obj.per_addr)

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

        return msg;
    }


    [WebMethod(EnableSession = true)]
    public static String Prop_OwnerInfo_Save( PropOwnerInfo Obj)
    {


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        String msg;

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
         
        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Prop_OwnerInfo_Save";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        
                        new SqlParameter("@edoc_id",Obj.edocid), 
                        new SqlParameter("@name",Obj.name),
                        new SqlParameter("@address",Obj.address),
                        new SqlParameter("@legal_id",Obj.legalid), 
                        new SqlParameter("@legal_doc_name",Obj.legaliddocname),
                        new SqlParameter("@phone",Obj.phone) 
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

        return msg;
    }


    [WebMethod(EnableSession = true)]
    public static String Part_PartnerInfo_Save(PartPartnerInfo Obj)
    {


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        String msg;

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Part_PartnerInfo_Save";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        
                        new SqlParameter("@edoc_id",Obj.edocid), 
                        new SqlParameter("@name",Obj.name),
                        new SqlParameter("@address",Obj.address),
             
                        new SqlParameter("@phone",Obj.phone) 
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

        return msg;
    }


    [WebMethod(EnableSession = true)]
    public static String Comp_OwnerInfo_Save(CompOwnerInfo Obj)
    {


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        String msg;

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Comp_OwnerInfo_Save";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        
                        new SqlParameter("@edoc_id",Obj.edocid), 
                        new SqlParameter("@name",Obj.name),
                        new SqlParameter("@role",Obj.role),
                        new SqlParameter("@address",Obj.address),
                      
             
                        new SqlParameter("@phone",Obj.phone) 
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

        return msg;
    }



    [WebMethod(EnableSession = true)]
    public static String ConcernInfo_Save(SisterConcernInfo Obj)
    {


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        String msg;

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_Comp_SisterConcernInfo_Save";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        
                        new SqlParameter("@edoc_id",Obj.edocid), 
                        new SqlParameter("@t24_cus_id",Obj.cusid), 
                        new SqlParameter("@name",Obj.name),
                        new SqlParameter("@address",Obj.address),
                        new SqlParameter("@phone",Obj.phone)
 

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

        return msg;
    }



    [WebMethod(EnableSession = true)]
    public static String JVCompanyInfo_Save(JVCompanyInfo Obj)
    {


        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        String msg;

        //String DomainID = HttpContext.Current.Session["DomainID"].ToString();
        //String BranchCode = HttpContext.Current.Session["BranchCode"].ToString();
        //String BranchName = HttpContext.Current.Session["BranchName"].ToString();



        String ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (String.IsNullOrEmpty(ipAddress))
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_JV_CompanyInfo_Save";
            command.Connection = connection;



            SqlParameter[] parameters = 


                    {


                        
                        new SqlParameter("@edoc_id",Obj.edocid), 
                        new SqlParameter("@t24_cus_id",Obj.cusid), 
                        new SqlParameter("@name",Obj.name),
                        new SqlParameter("@address",Obj.address),
                        new SqlParameter("@phone",Obj.phone)
 

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

        return msg;
    }
}