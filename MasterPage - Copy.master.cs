using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    public Int32 Role;

    public String Name;


    protected void Page_Load(object sender, EventArgs e)
    {

        //Session["UserType"] = "cadmaker";

        Role = Convert.ToInt32(Session["Role"].ToString());


        Name = Session["Name"].ToString() + "/" + Session["RoleName"].ToString();

    }
    protected static readonly HashSet<int> SanctionUploadRoles = new HashSet<int>
{
    21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51
};

    protected static readonly HashSet<int> SanctionViewRoles = new HashSet<int>
{
    5, 7, 9, 11
};

    protected static readonly HashSet<int> SanctionAndChecklistRoles = new HashSet<int>
{
    57, 61, 65, 69
};

    protected static readonly HashSet<int> DrawdownRoles = new HashSet<int>
{
    5, 7, 9, 11, 15, 20, 57, 59, 61, 63, 65, 67, 69, 71
};

    protected static readonly HashSet<int> AssignDmRoles = new HashSet<int>
{
    59, 63, 67
};

    protected static readonly HashSet<int> UserManagementRoles = new HashSet<int>
{
    5, 10, 15, 20
};

    protected static readonly HashSet<int> AdminRoles = new HashSet<int>
{
    97, 99
};

    protected bool HasRole(HashSet<int> roleSet)
    {
        return roleSet != null && roleSet.Contains(Role);
    }

    protected string GetActiveClass(params string[] pageNames)
    {
        string currentPage = Path.GetFileName(Request.AppRelativeCurrentExecutionFilePath ?? string.Empty);
        foreach (string page in pageNames)
        {
            if (string.Equals(currentPage, page, StringComparison.OrdinalIgnoreCase))
            {
                return " class=\"active\"";
            }
        }
        return string.Empty;
    }
}
