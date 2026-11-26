using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    public Int32 Role { get; set; }

    public String Name { get; set; }


    public String Name2 { get; set; }


    protected void Page_Load(object sender, EventArgs e)
    {

        //Session["UserType"] = "cadmaker";

        Role = Convert.ToInt32(Session["Role"].ToString()); 

        Name = Session["Name"].ToString() + "/" + Session["RoleName"].ToString();

        Name2 = Session["Name"].ToString();

    }
}
