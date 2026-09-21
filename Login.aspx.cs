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

        Session["Role"] = 2;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";

        
        
        Response.Redirect("Dashboard.aspx");




    }

    protected void btnRM_Click(object sender, EventArgs e)
    {

    }
    protected void btnCD_Click(object sender, EventArgs e)
    {

    }
    protected void btnCI_Click(object sender, EventArgs e)
    {

    }
    protected void btnMOP_Click(object sender, EventArgs e)
    {

    }
    protected void btnHOB_Click(object sender, EventArgs e)
    {

    }
    protected void btnAdmin_Click(object sender, EventArgs e)
    {

    }
    protected void btnDM_Click(object sender, EventArgs e)
    {

    }
    protected void btnUnitHead_Click(object sender, EventArgs e)
    {

    }
}