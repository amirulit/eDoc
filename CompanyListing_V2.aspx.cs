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

public partial class CompanyListing_V2 : System.Web.UI.Page
{
    public DataTable TableData;

    public Int32 Role;

    protected void Page_Load(object sender, EventArgs e)
    {
        TableData = Listing();
        Role = Convert.ToInt32(Session["Role"].ToString());
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
                            getCmd.Parameters.AddWithValue("@MotherCompany",motherCompany.Trim());

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
    public DataTable Listing()
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
        }
        catch (Exception ex)
        {
            //ErrorMSG = ex.Message;
        }
        return ds.Tables[0];

    }
}