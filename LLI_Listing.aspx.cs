using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class LLI_Listing : System.Web.UI.Page
{
    public DataTable TableData;

    protected void Page_Load(object sender, EventArgs e)
    {
        TableData = Listing();
    }

    public class DropdownItem
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Division { get; set; }
    }

    public class EmployeeEditResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; }

        public string RoleId { get; set; }
        public string BranchId { get; set; }

        public List<DropdownItem> Roles { get; set; }
        public List<DropdownItem> Branches { get; set; }
    }

    public class UpdateResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; }
    }
    [System.Web.Services.WebMethod]
    public static EmployeeEditResponse GetEmployeeEditData(string id)
    {
        EmployeeEditResponse result = new EmployeeEditResponse();

        result.Roles = new List<DropdownItem>();
        result.Branches = new List<DropdownItem>();

        try
        {
            string cs = ConfigurationManager
                .ConnectionStrings["dbconn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Get current employee role and branch
                string query = @"SELECT role, branchcode
                             FROM t_User
                             WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (!dr.Read())
                        {
                            result.Success = false;
                            result.Message = "Employee not found";
                            return result;
                        }

                        result.RoleId = dr["role"].ToString();
                        result.BranchId = dr["branchcode"].ToString();
                    }
                }

                // Get roles
                query = @"SELECT RoleID, RoleName, Division
          FROM t_Role
          ORDER BY Division, RoleName";

                using (SqlCommand cmd = new SqlCommand(query, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        result.Roles.Add(new DropdownItem
                        {
                            Id = dr["RoleID"].ToString(),
                            Name = dr["RoleName"].ToString(),
                            Division = dr["Division"].ToString()
                        });
                    }
                }

                // Get branches
                query = @"SELECT branch_code, branch_name
                      FROM t_BranchInfo
                      ORDER BY branch_name  asc";

                using (SqlCommand cmd = new SqlCommand(query, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        result.Branches.Add(new DropdownItem
                        {
                            Id = dr["branch_code"].ToString(),
                            Name = dr["branch_name"].ToString()
                        });
                    }
                }
            }

            result.Success = true;
            result.Message = "Success";
        }
        catch (Exception ex)
        {
            result.Success = false;
            result.Message = "Unable to load data:" + ex.Message;
        }

        return result;
    }

    [System.Web.Services.WebMethod]
    public static UpdateResponse UpdateEmployee(
        string id,
        string roleId,
        string branchId)
    {
        UpdateResponse result = new UpdateResponse();

        try
        {
            string cs = ConfigurationManager
                .ConnectionStrings["dbconn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                UPDATE t_user
                SET role = @roleId,
                    branchcode = @branchId
                WHERE id = @id
/*
                AND EXISTS (
                    SELECT 1 FROM RoleMaster
                    WHERE role_id = @roleId
                )
                AND EXISTS (
                    SELECT 1 FROM BranchMaster
                    WHERE branch_code = @branchId
                )

*/";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@roleId", roleId);
                    cmd.Parameters.AddWithValue("@branchId", branchId);

                    con.Open();

                    int rows = cmd.ExecuteNonQuery();

                    result.Success = rows > 0;
                    result.Message = rows > 0
                        ? "Updated successfully"
                        : "Employee not found or invalid selection";
                }
            }
        }
        catch (Exception ex)
        {
            result.Success = false;
            result.Message = "Error updating employee";
        }

        return result;
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
        command.CommandText = "usp_LLI_Listing";
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