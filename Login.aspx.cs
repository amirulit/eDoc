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
        


         


        Session["DomainID"] = "RM-Branch";

        Session["Name"] = "RM-Branch";

        Session["Role"] = 5;


        Session["BranchCode"] = "BD0010101";


        Response.Redirect("Dashboard.aspx");


    }
    protected void btnCD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-CBD";

        Session["Name"] = "RM-CBD";

        Session["Role"] = 21;

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

        Session["Role"] = 7;

        Session["UserType"] = "CADMaker";

        if (txtDomainID.Text == "cadmaker@mblbd.com")
            Session["UserType"] = "CADMaker";
        if (txtDomainID.Text == "cadchecker@mblbd.com")
            Session["UserType"] = "CADChecker";

        Session["BranchCode"] = "BD0010101";

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

        Session["Role"] = 11;

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
    protected void btnCD_CBD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-CBD";

        Session["Name"] = "RM-CBD";

        Session["Role"] = 21;

       



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_SME_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-CMSME";

        Session["Name"] = "RM-CMSME";

        Session["Role"] = 25;





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_Retail_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-Retail";

        Session["Name"] = "RM-Retail";

        Session["Role"] = 27;





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_Agri_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-Agri";

        Session["Name"] = "RM-Agri";

        Session["Role"] = 29;





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_CBD_SAMD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-CBD(SAMD)";

        Session["Name"] = "RM-CBD(SAMD)";

        Session["Role"] = 37;





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_SME_SAMD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-CMSME(SAMD)";

        Session["Name"] = "RM-CMSME(SAMD)";

        Session["Role"] = 41;





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_Retail_SAMD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-Retail(SAMD)";

        Session["Name"] = "RM-Retail(SAMD)";

        Session["Role"] = 45;





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_Agri_SAMD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-Agri(SAMD)";

        Session["Name"] = "RM-Agri(SAMD)";

        Session["Role"] = 49;





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCAD_DM_CBD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "DM-CBD";

        Session["Name"] = "DM-CBD";

        Session["Role"] = 57;
        Response.Redirect("Dashboard.aspx");
 
    }
    protected void btnCAD_UH_CBD_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_DM_SME_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_UH_SME_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_DM_Retail_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_UH_Retail_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_DM_Agri_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_UH_Agri_Click(object sender, EventArgs e)
    {

    }
}