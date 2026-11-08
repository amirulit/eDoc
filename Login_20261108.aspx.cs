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

        Session["DomainID"] = "md.amirul@mblbd.com";

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
        Session["DomainID"] = "RM";

        Session["Name"] = "Relationship Manager";

        Session["Role"] = 1;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "CD";

        Session["Name"] = "Credit Division";

        Session["Role"] = 3;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCI_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "CI";

        Session["Name"] = "Credit Incharge";

        Session["Role"] = 5;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnMOP_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "md.amirul@mblbd.com";

        Session["Name"] = "Manager Operation";

        Session["Role"] = 10;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnHOB_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "HOB";


        Session["Name"] = "Head of Branch";

        Session["Role"] = 15;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnAdmin_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "Admin";


        Session["Name"] = "Admin";


        Session["Role"] = 99;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnDM_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "DM";

        Session["Name"] = "Documentation Manager";

        Session["Role"] = 2;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnUnitHead_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "UH";


        Session["Name"] = "Unit Head";

        Session["Role"] = 20;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
}