using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Services;
using System.Data;
using System.Web.Script.Services;
using System.Configuration;
using System.IO;

public partial class SanctionUpload_V4 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadCusList();


        LoadLoanNature();


        LoadBranch();


        if (Request.QueryString.AllKeys.Contains("CusID"))
        {
            String CusID = Request.QueryString["CusID"].ToString();
            //ddlCustomer.Items.FindByValue(CusID);

            //ddlCustomer.SelectedIndex = ddlCustomer.Items.IndexOf(ddlCustomer.Items.FindByValue(CusID));

            //select1.Items.FindByValue(CusID).Selected = true;

            //ddlCustomer.Items.FindByText(CusID).Selected = true;

            /*
            ListItem oItem = ddlCustomer.Items.FindByValue(CusID);
            if (oItem != null) oItem.Selected = true;
            */

        }


        if (!IsPostBack)
        {
            LoadNextRefNo();
        }

    }




    private void LoadNextRefNo()
    {
        string connectionString =ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        string query = @"

	SELECT NEXT VALUE FOR EDOC_Seq AS EDOC_Seq;";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                txtEdocId.Text = Convert.ToString(cmd.ExecuteScalar());
            }
        }
    }

    public class DropdownData
    {
        public List<Customer> cusList { get; set; }
        public List<LoanNature> loanNatureList { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static DropdownData GetDropdownData()
    {
        DropdownData result = new DropdownData();

        result.cusList = new List<Customer>();
        result.loanNatureList = new List<LoanNature>();

        string cs = ConfigurationManager
            .ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // Load customers
            string customerQuery = @"
            SELECT cus_code,
                   cus_name + '-' + cus_code AS cid
            FROM t_CustomerInfo";

            using (SqlCommand cmd = new SqlCommand(customerQuery, con))
            {
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        result.cusList.Add(new Customer
                        {
                            id = dr["cus_code"].ToString(),
                            text = dr["cid"].ToString()
                        });
                    }
                }
            }

            // Load loan nature
            string loanQuery = @"
            SELECT LEFT(loan_nature, 20) AS name,
                   loan_nature_short AS short_name
            FROM t_LoanNature";

            using (SqlCommand cmd = new SqlCommand(loanQuery, con))
            {
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        result.loanNatureList.Add(new LoanNature
                        {
                            name = dr["name"].ToString(),
                            short_name = dr["short_name"].ToString()
                        });
                    }
                }
            }
        }

        return result;
    }




    public class DropdownItem
    {
        public string Value { get; set; }
        public string Text { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<DropdownItem> GetCustomerCodes()
    {
        var items = new List<DropdownItem>();

        string cs = ConfigurationManager
            .ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(
                @"
            SELECT cus_code,
                   cus_name + '-' + cus_code AS cid
            FROM t_CustomerInfo", con))
            {
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string code = dr["cus_code"].ToString();

                        string text = dr["cid"].ToString();

                        items.Add(new DropdownItem
                        {
                            Value = code,
                            Text = text
                        });
                    }
                }
            }
        }

        return items;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<DropdownItem> GetLoanNatures()
    {
        var items = new List<DropdownItem>();

        string cs = ConfigurationManager
            .ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand(
                @"
            SELECT LEFT(loan_nature, 70) AS name,
                   id id
            FROM t_LoanNature_V2", con))
            {
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        items.Add(new DropdownItem
                        {
                            Value = dr["id"].ToString(),
                            Text = dr["name"].ToString()
                        });
                    }
                }
            }
        }

        return items;
    }




    public class Obj
    {

        public String cus_ids;

        public String sanction_reference;
        public String sanction_date;
        public String sanction_authority;

        public String booking_branch;
        public String sanction_doc;
       
    }


    protected void LoadCusList()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = "select cus_name,cus_code, cus_name+'-'+cus_code cid from t_CustomerInfo";
        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);
            //select1.DataSource = Ds.Tables[0];
            //select1.DataTextField = "cid";
            //select1.DataValueField = "cus_code";
            //select1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    public class Customer
    {
        public string id { get; set; }
        public string text { get; set; }
    }




    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<Customer> GetCusList()
    {
        List<Customer> result = new List<Customer>();

        String cs = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(
            @"select cus_name,cus_code, cus_name+'-'+cus_code cid from t_CustomerInfo", con))
        {
            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    result.Add(new Customer
                    {
                        id = dr["cus_code"].ToString(),
                        text = dr["cid"].ToString()
                    });
                }
            }
        }

        return result;
    }

  

    public class LoanNature
    {
        public string name { get; set; }
        public string short_name { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<LoanNature> LoadLoanNature()
    {
        List<LoanNature> loanList = new List<LoanNature>();

        string connectionString =
            ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT left(loan_nature,50) AS name,
                                loan_nature_short AS short_name
                         FROM t_LoanNature";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        loanList.Add(new LoanNature
                        {
                            name = reader["name"].ToString(),
                            short_name = reader["short_name"].ToString()
                        });
                    }
                }
            }
        }

        return loanList;
    }



    public class SanctionUpload
    {
        public string EdocId { get; set; }
        public string Branch { get; set; }
        public string SanctionReference { get; set; }
        public string SanctionDate { get; set; }
        public string Segment { get; set; }
        public string ApprovalAuthority { get; set; }
        public Double TotalAmount { get; set; }

        public List<FacilityDetail> Facilities { get; set; }
    }

    public class FacilityDetail
    {
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        public string LoanNature { get; set; }
        public decimal Amount { get; set; }
        public string Validity { get; set; }
    }

    public class SaveResult
    {
        public bool Success { get; set; }
        public string Message { get; set; }
    }





    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static SaveResult SaveSanction_V2(SanctionUpload request)
    {

        String refno;

        String Sql = "";

        String Sts;

        int sanctionId;

        String edoc_ref_no;


        String Inputter = HttpContext.Current.Session["DomainID"].ToString();

        if (request == null ||
            String.IsNullOrWhiteSpace(request.Branch) ||
            String.IsNullOrWhiteSpace(request.SanctionReference) ||
            String.IsNullOrWhiteSpace(request.Segment) ||
            String.IsNullOrWhiteSpace(request.ApprovalAuthority) || request.Facilities == null || request.Facilities.Count == 0)
        {
            return new SaveResult
            {
                Success = false,
                Message = "Please provide all required sanction details."
            };
        }
        /*
        if (request.SanctionDate == default(DateTime))
        {
            return new SaveResult
            {
                Success = false,
                Message = "Invalid sanction date."
            };
        }
        */

        foreach (FacilityDetail facility in request.Facilities)
        {
            if (facility == null ||
                String.IsNullOrWhiteSpace(facility.CustomerCode) ||
                String.IsNullOrWhiteSpace(facility.LoanNature) ||
                facility.Amount < 0 /*|| facility.Validity == default(DateTime)*/
                )
            {
                return new SaveResult
                {
                    Success = false,
                    Message = "Invalid facility details."
                };
            }
        }

        String connectionString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;




        Sql = @"

                

DECLARE @FileCreatedDate DATE = GETDATE();
DECLARE @Year INT = YEAR(@FileCreatedDate);
DECLARE @NextNumber INT;
DECLARE @edoc_ref_no varchar(500);

SELECT @NextNumber =
    ISNULL(count(*), 0) + 1
FROM t_Sanction_Master
WHERE   YEAR(entry_time) = @Year;

set @edoc_ref_no=CONCAT(@Year, '', FORMAT(@NextNumber, '00000')) 



INSERT INTO [dbo].[t_Sanction_Master]
           ([edoc_id]
           ,[edoc_refno]
           ,[booking_branch]
           ,[sanction_reference]
           ,[sanction_date]
           ,[sanction_segment]
           ,[sanction_approval_authority]
           ,[total_amount]
           ,[customer_id]
           ,[sanction_doc]
           ,[status]
           ,[ssc_status]
           ,[entry_by]
           ,[entry_time]
           ,[sanction_reference_org]
           ,[sanction_date_org]
           ,[sanction_segment_org]
           ,[sanction_Approval_authority_org]
           ,[entry_by_org]
           ,[entry_time_org])
     VALUES
           (" + request.EdocId + @"
           ,@edoc_ref_no
           ,'" + request.Branch + @"'
           ,'" + request.SanctionReference + @"'
           ,'" + request.SanctionDate + @"'
           ,'" + request.Segment + @"'
           ,'" + request.ApprovalAuthority + @"'
           ," + request.TotalAmount + @"
           ,null
           ,null
           ,1
           ,1
           ,'" + Inputter + @"'
           ,getdate()
           ,'" + request.SanctionReference + @"'
           ,'" + request.SanctionDate + @"'
           ,'" + request.Segment + @"'
           ,'" + request.ApprovalAuthority + @"'
           ,'" + Inputter + @"'
           ,getdate()


)";


          Sql = Sql + @"  --SELECT CAST(SCOPE_IDENTITY() AS INT);

select @edoc_ref_no edoc_ref_no

";




        foreach (FacilityDetail facility
in request.Facilities)
        {

            Sql = Sql + @"


 




INSERT INTO [dbo].[t_Sanction_Master_Details]
           ([edoc_id]
           ,[edoc_refno]
           ,[sanction_reference]
           ,[customer_id]
           ,[customer_name]
           ,[loan_nature]
           ,[loan_nature_edoc]
           ,[currency]
           ,[amount]
           ,[validity]
           ,[entry_by]
           ,[entry_time]
           ,[sanction_reference_org]
           ,[facility_nature_org]
           ,[currency_org]
           ,[amount_org]
           ,[validity_org]
           ,[entry_by_org]
           ,[entry_time_org])
     VALUES
           (" + request.EdocId + @"

         ,@edoc_ref_no
         ,'" + request.SanctionReference + @"'
         ,'" + facility.CustomerCode + @"'
         ,'" + facility.CustomerName + @"'
         ,'" + facility.LoanNature + @"'
         ,'" + facility.LoanNature + @"'
         ,'BDT'
         ,'" + facility.Amount + @"'
         ,'" + facility.Validity + @"'
         ,'" + Inputter + @"'
         ,getdate()
         ,'" + request.SanctionReference + @"'
         ,'" + facility.LoanNature + @"'
         ,'BDT'
         ,'" + facility.Amount + @"'
         ,'" + facility.Validity + @"'
         ,'" + Inputter + @"'
         ,getdate()


)
 
";

        }



        String InputDate = System.DateTime.Now.ToString("yyyyMMdd");

        //File.WriteAllText(@"E:\SOD\Sql.sql", Sql);
        File.AppendAllText(@"E:\eDoc_SQL\Sql_" + InputDate + ".sql", Sql + "\n\n===============================================================\n");


        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();




                //SqlCommand cmd = new SqlCommand(Sql, conn, transaction);
                SqlCommand cmd = new SqlCommand(Sql, conn);

                //cmd.ExecuteNonQuery();

                //sanctionId = Convert.ToInt32(cmd.ExecuteScalar());

                edoc_ref_no = Convert.ToString(cmd.ExecuteScalar());

                

                //object result = cmd.ExecuteScalar();

                //sl = Convert.ToInt32(result);

                //refno = result.ToString();

                //transaction.Commit();
                //return "Records inserted successfully!";
                Sts = "Records inserted successfully!";




            }

            return new SaveResult
            {
                Success = true,
                Message = "Sanction saved successfully." + edoc_ref_no
            };


        }
        catch (Exception ex)
        {
            // Log ex on the server using your logging framework.
            // Do not return database exception details to the client.


            Sts = "Error: " + ex.Message;


            File.AppendAllText(@"E:\SOD_SQL\SqlError_" + InputDate + ".sql", Sts + "\n\n===============================================================\n");

            return new SaveResult
            {
                Success = false,
                Message = "Unable to save sanction details. Please try again."
            };
        }
    }





    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static SaveResult SaveSanction(SanctionUpload request)
    {
        if (request == null ||
            String.IsNullOrWhiteSpace(request.Branch) ||
            String.IsNullOrWhiteSpace(request.SanctionReference) ||
            String.IsNullOrWhiteSpace(request.Segment) ||
            String.IsNullOrWhiteSpace(request.ApprovalAuthority) || request.Facilities == null || request.Facilities.Count == 0)
        {
            return new SaveResult
            {
                Success = false,
                Message = "Please provide all required sanction details."
            };
        }

        //if (request.SanctionDate == default(DateTime))
        //{
        //    return new SaveResult
        //    {
        //        Success = false,
        //        Message = "Invalid sanction date."
        //    };
        //}

        foreach (FacilityDetail facility in request.Facilities)
        {
            if (facility == null ||
                String.IsNullOrWhiteSpace(facility.CustomerCode) ||
                String.IsNullOrWhiteSpace(facility.LoanNature) ||
                facility.Amount < 0 
                
                /*||
                facility.Validity == default(DateTime)*/
                )
            {
                return new SaveResult
                {
                    Success = false,
                    Message = "Invalid facility details."
                };
            }
        }

        String connectionString =
            ConfigurationManager
                .ConnectionStrings["dbConn"]
                .ConnectionString;

        try
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlTransaction transaction =
                    con.BeginTransaction())
                {
                    try
                    {
                        int sanctionId;

                        // Insert master record
                        string masterSql = @"
                                INSERT INTO dbo.SanctionMaster
                                (
                                    Branch,
                                    SanctionReference,
                                    SanctionDate,
                                    Segment,
                                    ApprovalAuthority
                                )
                                VALUES
                                (
                                    @Branch,
                                    @Reference,
                                    @SanctionDate,
                                    @Segment,
                                    @Authority
                                );

                                SELECT CAST(SCOPE_IDENTITY() AS INT);";

                        using (SqlCommand cmd =
                            new SqlCommand(
                                masterSql, con, transaction))
                        {
                            cmd.Parameters.Add(
                                "@Branch",
                                SqlDbType.NVarChar, 100)
                                .Value = request.Branch.Trim();

                            cmd.Parameters.Add(
                                "@Reference",
                                SqlDbType.NVarChar, 100)
                                .Value =
                                    request.SanctionReference.Trim();

                            //cmd.Parameters.Add(
                            //    "@SanctionDate",
                            //    SqlDbType.Date)
                            //    .Value = request.SanctionDate.Date;

                            cmd.Parameters.Add(
                                "@Segment",
                                SqlDbType.NVarChar, 100)
                                .Value = request.Segment.Trim();

                            cmd.Parameters.Add(
                                "@Authority",
                                SqlDbType.NVarChar, 150)
                                .Value =
                                    request.ApprovalAuthority.Trim();

                            sanctionId = Convert.ToInt32(
                                cmd.ExecuteScalar());
                        }

                        // Insert all facility records
                        string facilitySql = @"
                                INSERT INTO dbo.SanctionFacility
                                (
                                    SanctionId,
                                    CustomerId,
                                    NatureOfFacility,
                                    Amount,
                                    Validity
                                )
                                VALUES
                                (
                                    @SanctionId,
                                    @CustomerId,
                                    @Nature,
                                    @Amount,
                                    @Validity
                                );";

                        foreach (FacilityDetail facility
                            in request.Facilities)
                        {
                            using (SqlCommand cmd =
                                new SqlCommand(
                                    facilitySql,
                                    con,
                                    transaction))
                            {
                                cmd.Parameters.Add(
                                    "@SanctionId",
                                    SqlDbType.Int)
                                    .Value = sanctionId;

                                cmd.Parameters.Add(
                                    "@CustomerId",
                                    SqlDbType.NVarChar, 50)
                                    .Value =
                                        facility.CustomerCode.Trim();

                                cmd.Parameters.Add(
                                    "@Nature",
                                    SqlDbType.NVarChar, 150)
                                    .Value =
                                        facility.LoanNature.Trim();

                                SqlParameter amountParam =
                                    cmd.Parameters.Add(
                                        "@Amount",
                                        SqlDbType.Decimal);

                                amountParam.Precision = 18;
                                amountParam.Scale = 2;
                                amountParam.Value = facility.Amount;

                                //cmd.Parameters.Add(
                                //    "@Validity",
                                //    SqlDbType.Date)
                                //    .Value = facility.Validity.Date;

                                cmd.ExecuteNonQuery();
                            }
                        }

                        transaction.Commit();

                        return new SaveResult
                        {
                            Success = true,
                            Message = "Sanction saved successfully." + sanctionId
                        };
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log ex on the server using your logging framework.
            // Do not return database exception details to the client.

            return new SaveResult
            {
                Success = false,
                Message =  "Unable to save sanction details. Please try again."
            };
        }
    }



    protected void LoadBranch()
    {
        //String cus_type = Request.QueryString[0].ToString();
        //Int32 cus_auto_id = Convert.ToInt32(Request.QueryString[1].ToString());
        //String c_type = Request.QueryString[2].ToString().Split('-')[0];


        SqlConnection con = new SqlConnection(@"Data Source=HO-IT-101;Initial Catalog=db_CAD;User ID=sa;Password=Mbl@1234;Integrated Security=False;MultipleActiveResultSets=True;");
        SqlCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;

        cmd.CommandText = " select '' code,'<--Select-->' name  union  all select branch_code code,branch_name name from t_BranchInfo";
        cmd.Connection = con;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet Ds = new DataSet();
        try
        {
            da.Fill(Ds);
            select3.DataSource = Ds.Tables[0];
            select3.DataTextField = "name";
            select3.DataValueField = "code";
            select3.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }


    [WebMethod(EnableSession = true)]
    public static Object[] Sanction_Upload(Obj Obj)
    {




         
        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        Object[] details = null;

        String msg;


        String Sanc_Date = Obj.sanction_date;

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



        String drawdown_id = "";

        try
        {


            SqlConnection connection = new SqlConnection(ConStr);




            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_SanctionUpload";
            command.Connection = connection;

            SqlParameter[] parameters = 

                    {

                       
                        new SqlParameter("@sanction_reference",Obj.sanction_reference), 
                        new SqlParameter("@sanction_date",Sanc_Date), 
                        new SqlParameter("@sanction_authority",Obj.sanction_authority), 
                        
                        new SqlParameter("@booking_branch",Obj.booking_branch), 
                        new SqlParameter("@sanction_doc",Obj.sanction_doc), 
                        new SqlParameter("@entry_by","Test"),
                       
                        new SqlParameter("@entry_time",DateTime.Now)
                    
                    };



            command.Parameters.AddRange(parameters);


            /*
            SqlParameter auto_id_parm = new SqlParameter("@auto_id", SqlDbType.Int);
            auto_id_parm.Direction = ParameterDirection.Output;
            command.Parameters.Add(auto_id_parm);

            */


            /*
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
            */

            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            //drawdown_id = auto_id_parm.Value.ToString();

            msg = "Data Saved";
            //drawdown_id = auto_id_parm.Value.ToString();






            HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

            //Fetch the File Name.





            //String fileName = Customer_Auto_ID + "_" + File_Auto_ID + "_" + postedFile.FileName + Path.GetExtension(postedFile.FileName);

            String fileName = Obj.booking_branch + "-" + Obj.sanction_authority + "_" + postedFile.FileName;

            //Save the File.
            //postedFile.SaveAs(path + fileName);

            //postedFile.SaveAs(@"E:\tt\" + fileName + "_" + Path.GetFileName(postedFile.FileName));

            //postedFile.SaveAs(@"E:\CAD_Doc\" + fileName + "_ITD");

            postedFile.SaveAs(@"E:\eDoc_SanctionDoc\" + fileName);



        }
        catch (Exception ex)
        {
            msg = ex.Message;
            drawdown_id = "";
        }

        //return msg;

        details = new object[] { msg, drawdown_id };

        return details;

    }
}