using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.DirectoryServices;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using Newtonsoft.Json.Linq;
/// <summary>
/// Summary description for EmployeeService
/// </summary>
public class EmployeeService
{
    String connStr = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;


    public Int32 dbOperationStatus;
    public String dbOperationResult;


    public EmployeeService()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public Int32 CreateUser(Employee E)
    {

        return 1;

    }

    public Employee GetEmpDetails(String EmpId)
    {
        /*
         return new Customer
         {
             AccountNo = accountNo,
             Beneficiary = "John Doe",
             Branch = "Main",
             MaturityDate = DateTime.Now.AddYears(1),
             InterestRate = 5.5m,
             FaceValue = 10000,
             EncashmentValue = 9500,
             Lien = "No"
         };
        */

        Employee emp = new Employee();

        String T24_API_Address = "http://10.10.100.68/HRM_API/api/T24/GetEmployeeInfo";

        //String T24_API_Address = "http://10.10.100.68/HRM_API/HRM/GetEmpInfo";

        String url = T24_API_Address + @"/" + EmpId;

        //String T24_API_User = ConfigurationManager.AppSettings["T24_API_User"].ToString();
        //String T24_API_Pwd = ConfigurationManager.AppSettings["T24_API_Pwd"].ToString();

        //String Credentials = T24_API_User + @"/" + T24_API_Pwd;

        var request = (HttpWebRequest)WebRequest.Create(url);

        request.Method = "GET";

        //request.Headers.Add("credentials", Credentials);


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


            JObject jbj = JObject.Parse(content);

            //JObject jObj = JObject.Parse(jsonString);

            emp = jbj.ToObject<Employee>();


            //String api_response = jbj["body"].ToString();

            //JArray jsonArray = JArray.Parse(api_response);


            //sod = FormatResponse(jsonArray);

        }
        catch (Exception ex)
        {
            emp = new Employee
            {
                EmployeeID = "NA",
                EmployeeName = "NA"
            };
        }

        return emp;

    }
}