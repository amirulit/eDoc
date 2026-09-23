using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    public Int32 Role;


    protected void Page_Load(object sender, EventArgs e)
    {

        //Session["UserType"] = "cadmaker";

        Role = Convert.ToInt32(Session["Role"].ToString());

    }
}
