using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";

        
        
        Response.Redirect("Dashboard.aspx");




    }
}