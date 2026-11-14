using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using System.Text;

public partial class CompanyListing_V3 : System.Web.UI.Page
{
    public DataTable TableData;


    public DataTable TableData_MotherCompany;
    public DataTable TableData_ChildCompanyDetails;

    public Int32 Role;

    protected void Page_Load(object sender, EventArgs e)
    {
        TableData = Listing();
        Role = Convert.ToInt32(Session["Role"].ToString());


        LoadCusList();
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
            Select1.DataSource = Ds.Tables[0];
            Select1.DataTextField = "cid";
            Select1.DataValueField = "cus_code";
            Select1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }



    [WebMethod(EnableSession = true)]
    public static object SaveMotherCompany(string cusId, string motherCompany)
    {
        try
        {
            // Check user authentication
            if (HttpContext.Current.Session["DomainID"] == null)
            {
                return new
                {
                    success = false,
                    message = "Session expired. Please login again."
                };
            }

            if (string.IsNullOrWhiteSpace(cusId) ||
                string.IsNullOrWhiteSpace(motherCompany))
            {
                return new
                {
                    success = false,
                    message = "Invalid Customer ID."
                };
            }

            if (cusId.Trim() == motherCompany.Trim())
            {
                return new
                {
                    success = false,
                    message = "Customer cannot be its own Mother Company."
                };
            }

            string conStr = ConfigurationManager
                .ConnectionStrings["dbConn"]
                .ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                // Verify Mother Company exists
                String checkQuery = @"
                SELECT COUNT(*)
                FROM t_CustomerInfo
                WHERE cus_code = @MotherCompany";

                using (SqlCommand cmd = new SqlCommand(checkQuery, con))
                {
                    cmd.Parameters.AddWithValue("@MotherCompany", motherCompany.Trim());

                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    if (count == 0)
                    {
                        return new
                        {
                            success = false,
                            message = "Mother Company Customer ID does not exist."
                        };
                    }
                }

                // Update Mother Company
                String query = @"
                UPDATE t_Comp
                SET mother_company = @MotherCompany
                WHERE cus_code = @CusID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MotherCompany", motherCompany.Trim());
                    cmd.Parameters.AddWithValue("@CusID", cusId.Trim());

                    int rows = cmd.ExecuteNonQuery();

                    //if (rows > 0)
                    //{
                    //    return new
                    //    {
                    //        success = true,
                    //        motherCompany = motherCompany.Trim(),
                    //        message = "Mother Company saved successfully."
                    //    };
                    //}


                    if (rows > 0)
                    {
                        // Get Mother Company Name
                        string motherCompanyName = "";

                        string getQuery = @"
              select  cus_name from [t_CustomerInfo]  WHERE cus_code = @MotherCompany";

                        using (SqlCommand getCmd = new SqlCommand(getQuery, con))
                        {
                            getCmd.Parameters.AddWithValue("@MotherCompany", motherCompany.Trim());

                            motherCompanyName = Convert.ToString(getCmd.ExecuteScalar());
                        }

                        return new
                        {
                            success = true,
                            motherCompany = motherCompany.Trim(),
                            motherCompanyName = motherCompanyName,
                            message = "Mother Company saved successfully."
                        };

                    }
                }
            }

            return new
            {
                success = false,
                message = "Customer not found."
            };
        }
        catch (Exception ex)
        {
            // Log exception in production
            return new
            {
                success = false,
                message = "Unable to save Mother Company : " + ex.Message
            };
        }
    }


    [WebMethod(EnableSession = true)]
    public static object DeleteMotherCompany(string cusId)
    {
        try
        {
            // Check user authentication
            if (HttpContext.Current.Session["DomainID"] == null)
            {
                return new
                {
                    success = false,
                    message = "Session expired. Please login again."
                };
            }

            if (string.IsNullOrWhiteSpace(cusId))
            {
                return new
                {
                    success = false,
                    message = "Invalid Customer ID."
                };
            }

            string conStr = ConfigurationManager
                .ConnectionStrings["dbConn"]
                .ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                string query = @"
                UPDATE t_Comp
                SET mother_company = NULL
                WHERE cus_code = @CusID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CusID", cusId.Trim());

                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        return new
                        {
                            success = true,
                            message = "Mother Company deleted successfully."
                        };
                    }
                }
            }

            return new
            {
                success = false,
                message = "Customer not found."
            };
        }
        catch (Exception ex)
        {
            // Log exception in production
            return new
            {
                success = false,
                message = "Unable to delete Mother Company."
            };
        }
    }

    public StringBuilder Build_Customer_Dropdown(DataTable dt)
    {

        StringBuilder selectOptions = new StringBuilder();

        selectOptions.Append("<select class='form-control input-sm child-company-input'>");
        selectOptions.Append("<option value=''>-- Select Child Company --</option>");

        foreach (DataRow row in dt.Rows)
        {
            selectOptions.Append("<option value='");
            selectOptions.Append(HttpUtility.HtmlAttributeEncode(Convert.ToString(row["cus_code"])));
            selectOptions.Append("'>");
            selectOptions.Append(HttpUtility.HtmlEncode(Convert.ToString(row["cid"])));
            selectOptions.Append("</option>");
        }

        selectOptions.Append("</select>");

        return selectOptions;

    }
    public DataTable Listing()
    {
        string ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";

        DataSet ds = new DataSet();

        try
        {
            using (SqlConnection connection = new SqlConnection(ConStr))
            {
                using (SqlCommand command = new SqlCommand("usp_CompanyListing", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter sda = new SqlDataAdapter(command))
                    {
                        sda.Fill(ds);
                    }
                }
            }

            // Check DataSet tables
            if (ds.Tables.Count < 2)
            {
                throw new Exception("Stored procedure must return two tables: Mother Company and Child Company.");
            }

            TableData_MotherCompany = ds.Tables[0];
            TableData_ChildCompanyDetails = ds.Tables[1];

            StringBuilder cus_selectOptions = Build_Customer_Dropdown(ds.Tables[2]);


            StringBuilder sb = new StringBuilder();

            sb.Append("<div id='childSelectTemplate' style='display:none;'>");
            sb.Append(cus_selectOptions.ToString());
            sb.Append("</div>");

            sb.Append("<table id='example3' class='table table-bordered table-striped'>");

            sb.Append("<thead>");
            sb.Append("<tr>");
            sb.Append("<th>Mother Company Cus Code</th>");
            sb.Append("<th>Mother Company Cus Name</th>");
            sb.Append("<th>Child Company Details</th>");
            sb.Append("<th>Action</th>");
            sb.Append("</tr>");
            sb.Append("</thead>");

            sb.Append("<tbody>");

            foreach (DataRow master in TableData_MotherCompany.Rows)
            {
                string motherCode = Convert.ToString(master["cus_code"]).Trim();
                string motherName = Convert.ToString(master["name"]);

                sb.Append("<tr>");

                // Mother Company Code
                sb.Append("<td>");
                sb.Append(HttpUtility.HtmlEncode(motherCode));
                sb.Append("</td>");

                // Mother Company Name
                sb.Append("<td>");
                sb.Append(HttpUtility.HtmlEncode(motherName));
                sb.Append("</td>");

                // Child Company Details
                sb.Append("<td>");

                DataRow[] details = TableData_ChildCompanyDetails.Select("mother_com_cus_code = '" + motherCode.Replace("'", "''") + "'");

                if (details.Length > 0)
                {
                    sb.Append("<table class='table table-bordered table-striped'>");
                    sb.Append("<tbody>");

                    foreach (DataRow detail in details)
                    {
                        string childCode = Convert.ToString(detail["child_com_cus_code"]);
                        string childName = Convert.ToString(detail["child_com_cus_name"]);

                        sb.Append("<tr>");

                        sb.Append("<td>");
                        sb.Append(HttpUtility.HtmlEncode(childCode));
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(HttpUtility.HtmlEncode(childName));
                        sb.Append("</td>");

                        sb.Append("<td>");

                        sb.Append("<button type='button' class='btn btn-danger btn-xs' ");
                        sb.Append("onclick=\"deleteChildCompany('");
                        sb.Append(HttpUtility.JavaScriptStringEncode(motherCode));
                        sb.Append("','");
                        sb.Append(HttpUtility.JavaScriptStringEncode(childCode));
                        sb.Append("')\">Delete</button>");

                        sb.Append("</td>");

                        sb.Append("</tr>");
                    }

                    sb.Append("</tbody>");
                    sb.Append("</table>");
                }
                else
                {
                    //sb.Append("<span class='text-muted'>No Child Company Found</span>");

                    sb.Append("<span class='text-muted'></span>");
                }

                //sb.Append("</td>");

                // Action
                //sb.Append("<td>");

                sb.Append("<button type='button' ");
                sb.Append("class='btn btn-primary btn-xs add-mother' ");
                sb.Append("cus-id='");
                sb.Append(HttpUtility.HtmlAttributeEncode(motherCode));
                sb.Append("'>Add</button>");

                sb.Append("<div class='mother-input-area' style='display:none; margin-top:5px;'>");

                sb.Append("<input type='text' ");
                sb.Append("class='form-control input-sm child-company-input' ");
                sb.Append("placeholder='Enter Child Company Cus ID' />");

                sb.Append("<div class='select-container'></div>");

                // Select dropdown
                sb.Append("<select class='form-control input-sm child-company-input'>");
                sb.Append("<option value=''>-- Select Child Company --</option>");
                //sb.Append(selectOptions.ToString());
                sb.Append("</select>");



                sb.Append("<button type='button' ");
                sb.Append("class='btn btn-success btn-xs save-mother' ");
                sb.Append("cus-id='");
                sb.Append(HttpUtility.HtmlAttributeEncode(motherCode));
                sb.Append("' style='margin-top:5px;'>Save</button>");

                sb.Append("<button type='button' ");
                sb.Append("class='btn btn-default btn-xs cancel-mother' ");
                sb.Append("style='margin-top:5px;'>Cancel</button>");

                sb.Append("</div>");

                sb.Append("</td>");

                sb.Append("</tr>");
            }

            sb.Append("</tbody>");
            sb.Append("</table>");


            sb.Append("<div id='childSelectTemplate' style='display:none;'>");
            sb.Append(cus_selectOptions.ToString());
            sb.Append("</div>");

            // Assign generated HTML to Literal
            ltrMotherChildCompany.Text = sb.ToString();

            return TableData_MotherCompany;
        }
        catch (Exception ex)
        {
            // Do not hide errors during debugging
            System.Diagnostics.Debug.WriteLine(ex.ToString());

            throw;
        }
    }

    public DataTable Listing_OLD()
    {


        //if (Session["UserType"].ToString() == "Admin")
        //    Status = "A";
        //else if (Session["UserType"].ToString() == "Admin(Back Office)")
        //    Status = "Approved";
        //else
        //    Status = "ALL";

        String ConStr = @"Data Source=.;Initial Catalog=db_CAD;Integrated Security=False;User ID=sa;Password=Mbl@1234;Connection Timeout=0";


        SqlConnection connection = new SqlConnection(ConStr);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = "usp_CompanyListing";
        command.Connection = connection;
        //command.Parameters.Add(new SqlParameter("@branchcode", Session["BranchCode"]));
        //command.Parameters.Add(new SqlParameter("@status", Status));

        //command.Parameters.Add(new SqlParameter("@ValueDate", ValueDate));
        //SqlCommand cmd = new SqlCommand("select * from t_FundRequsition", connection);
        //SqlCommand cmd = new SqlCommand(Sql, connection);


        SqlDataAdapter sda = new SqlDataAdapter(command);
        DataSet ds = new DataSet();

        try
        {
            sda.Fill(ds);
            //ErrorMSG = "";


            TableData_MotherCompany = ds.Tables[0];
            TableData_ChildCompanyDetails = ds.Tables[1];


            StringBuilder sb = new StringBuilder();

            sb.Append("<table id='example3' class='table table-bordered table-striped'>");

            sb.Append("<thead><tr>");
            sb.Append("<th>Mother Company Cus Code</th>");
            sb.Append("<th>Mother Company Cus Name</th>");
            sb.Append("<th>Child Company Details</th>");
            sb.Append("<th>Action</th>");
            sb.Append("</tr></thead><tbody>");

            foreach (DataRow master in TableData_MotherCompany.Rows)
            {
                string motherCode = Convert.ToString(master["cus_code"]);
                string motherName = Convert.ToString(master["CustomerName"]);

                sb.Append("<tr>");

                // Mother Company Code
                sb.Append("<td>");
                sb.Append(HttpUtility.HtmlEncode(motherCode));
                sb.Append("</td>");

                // Mother Company Name
                sb.Append("<td>");
                sb.Append(HttpUtility.HtmlEncode(motherName));
                sb.Append("</td>");

                // Child Company Details
                sb.Append("<td>");

                DataRow[] details = TableData_ChildCompanyDetails.Select("mother_com_cus_code = '" + motherCode.Replace("'", "''") + "'");

                if (details.Length > 0)
                {
                    sb.Append("<table class='table table-bordered table-striped'>");
                    sb.Append("<tbody>");

                    foreach (DataRow detail in details)
                    {
                        string childCode = Convert.ToString(detail["child_com_cus_code"]);
                        string childName = Convert.ToString(detail["child_com_cus_name"]);

                        sb.Append("<tr>");

                        sb.Append("<td>");
                        sb.Append(HttpUtility.HtmlEncode(childCode));
                        sb.Append("</td>");

                        sb.Append("<td>");
                        sb.Append(HttpUtility.HtmlEncode(childName));
                        sb.Append("</td>");

                        sb.Append("<td>");

                        sb.Append("<button type='button' class='btn btn-danger btn-xs' ");
                        sb.Append("onclick=\"deleteChildCompany('");
                        sb.Append(HttpUtility.JavaScriptStringEncode(motherCode));
                        sb.Append("','");
                        sb.Append(HttpUtility.JavaScriptStringEncode(childCode));
                        sb.Append("')\">Delete</button>");

                        sb.Append("</td>");

                        sb.Append("</tr>");
                    }

                    sb.Append("</tbody></table>");
                }
                else
                {
                    sb.Append("<span class='text-muted'>No Child Company Found</span>");
                }

                sb.Append("</td>");
 
                sb.Append("<td>");

                sb.Append("<button type='button' ");
                sb.Append("class='btn btn-primary btn-xs add-mother' ");
                sb.Append("cus-id='" + HttpUtility.HtmlAttributeEncode(motherCode) + "'>");
                sb.Append("Add</button>");

                sb.Append("<div class='mother-input-area' style='display:none; margin-top:5px;'>");

                sb.Append("<input type='text' ");
                sb.Append("class='form-control input-sm mother-company-input' ");
                sb.Append("placeholder='Enter Child Company Cus ID' />");

                sb.Append("<button type='button' ");
                sb.Append("class='btn btn-success btn-xs save-mother' ");
                sb.Append("cus-id='" + HttpUtility.HtmlAttributeEncode(motherCode) + "' ");
                sb.Append("style='margin-top:5px;'>Save</button>");

                sb.Append("<button type='button' ");
                sb.Append("class='btn btn-default btn-xs cancel-mother' ");
                sb.Append("style='margin-top:5px;'>Cancel</button>");

                sb.Append("</div>");

                sb.Append("</td>");



                sb.Append("</tr>");

            }

            sb.Append("</tbody></table>");

            ltrMotherChildCompany.Text = sb.ToString();





        }
        catch (Exception ex)
        {
            //ErrorMSG = ex.Message;
        }
        return ds.Tables[0];

        //return null;

    }
}