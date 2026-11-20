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

        

        Session["DomainID"] = "md.amirul@mblbd.com";

        Session["Name"] = "Mohammad Amirul Islam";

        Session["Role"] = 5;

        Session["RoleName"] = "RM(Branch)";


        Session["BranchCode"] = "BD0010101";


        Response.Redirect("Dashboard.aspx");


    }
    protected void btnCD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-CBD";

        Session["Name"] = "Ahsanul Islam";

        Session["Role"] = 21;

        Session["UserType"] = "CADMaker";

        //if (txtDomainID.Text == "cadmaker@mblbd.com")
        //    Session["UserType"] = "CADMaker";
        //if (txtDomainID.Text == "cadchecker@mblbd.com")
        //    Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCI_Click(object sender, EventArgs e)
    {


        Session["DomainID"] = "nowfel.ahmed@mblbd.com";

        Session["Name"] = "Sheikh Nowfel Ahmed";

        Session["Role"] = 7;

        Session["RoleName"] = "CI";


        Session["BranchCode"] = "BD0010101";


        Response.Redirect("Dashboard.aspx");


         


    }
    protected void btnMOP_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "md.amirul@mblbd.com";

        Session["Name"] = "Manager Operation";

        Session["Role"] = 10;

        Session["UserType"] = "CADMaker";

        //if (txtDomainID.Text == "cadmaker@mblbd.com")
        //    Session["UserType"] = "CADMaker";
        //if (txtDomainID.Text == "cadchecker@mblbd.com")
        //    Session["UserType"] = "CADChecker";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnHOB_Click(object sender, EventArgs e)
    {

        Session["DomainID"] = "ahsanul.islam@mblbd.com";

        Session["Name"] = "Ahsanul Islam";

        Session["Role"] = 11;

        Session["RoleName"] = "HOB";


        Session["BranchCode"] = "BD0010101";


        Response.Redirect("Dashboard.aspx");



         

        //if (txtDomainID.Text == "cadmaker@mblbd.com")
        //    Session["UserType"] = "CADMaker";
        //if (txtDomainID.Text == "cadchecker@mblbd.com")
        //    Session["UserType"] = "CADChecker";



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
        Session["DomainID"] = "Prabal@mblbd.com";

        Session["Name"] = "Lutful Hoque Prabal";
        Session["RoleName"] = "RM-CBD";

        Session["Role"] = 21;

        Session["BranchCode"] = "Credit";

       



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_SME_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "nazrul@mblbd.com";

        Session["RoleName"] = "RM-CMSME";
        Session["Name"] = "Nazrul Islam";

        Session["Role"] = 25;

        Session["BranchCode"] = "Credit";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_Retail_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "rejoan@mblbd.com";

        Session["Name"] = "Rejoanul Hoque";

        Session["Role"] = 29;

        Session["RoleName"] = "RM-Retail";

        Session["BranchCode"] = "Credit";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_Agri_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "sadek@mblbd.com";

        Session["Name"] = "A T M SADIQUSSALAM CHOWDHURY";

        Session["Role"] = 33;
        Session["RoleName"] = "RM-Agri";

        Session["BranchCode"] = "Credit";


        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_CBD_SAMD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "RM-CBD(SAMD)";

        Session["Name"] = "RM-CBD(SAMD)";

        Session["Role"] = 33;





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
        Session["BranchCode"] = "CAD";
        Session["DomainID"] = "mahmudulhasan@mblbd.com";

        Session["Name"] = "MD. MAHMUDUL HASAN";

        Session["Role"] = 57;
        Session["RoleName"] = "DM-CBD";

      
        Response.Redirect("Dashboard.aspx");


 
    }
    protected void btnCAD_UH_CBD_Click(object sender, EventArgs e)
    {

        Session["func_role"] = "Unit Head-Corporate";

        Session["DomainID"] = "mohanta@mblbd.com";

        Session["Name"] = "Kali Pad Mohonta";

        Session["RoleName"] = "UH-CBD";

        Session["Role"] = 59;

        Session["BranchCode"] = "CAD";


        Session["Working_Area"] = "Corporate";

        Response.Redirect("Dashboard.aspx");


    }
    protected void btnCAD_DM_SME_Click(object sender, EventArgs e)
    {
        Session["BranchCode"] = "CAD";
        Session["DomainID"] = "sabbir.hasan@mblbd.com";

        Session["Name"] = "MD. SABBIR HASAN";

        Session["Role"] = 61;
        Session["RoleName"] = "DM-SME";


        //Session["BranchCode"] = "SME-CAD";


        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCAD_UH_SME_Click(object sender, EventArgs e)
    {
        Session["Working_Area"] = "CMSME & Agri";


        
        Session["BranchCode"] = "CAD";

        Session["DomainID"] = "amotaleb@mblbd.com";



        Session["Name"] = "MOHAMMAD ABDUL MOTALEB";
        Session["RoleName"] = "UH-CMSME";


        Session["Role"] = 63;


       


        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCAD_DM_Retail_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_UH_Retail_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "UH-CBD";

        Session["Name"] = "UH-CBD";

        Session["Role"] = 59;

        Session["BranchCode"] = "CAD";


        Session["Working_Area"] = "Retail";

        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCAD_DM_Agri_Click(object sender, EventArgs e)
    {

    }
    protected void btnCAD_UH_Agri_Click(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {



        Session["DomainID"] = "md.amirul@mblbd.com";

        Session["Name"] = "Mohammad Amirul Islam";

        Session["Role"] = 5;

        Session["RoleName"] = "RM(Branch)";


        Session["BranchCode"] = "BD0010102";


        Response.Redirect("Dashboard.aspx");

    }
    protected void Button2_Click(object sender, EventArgs e)
    {


        Session["DomainID"] = "nowfel.ahmed@mblbd.com";

        Session["Name"] = "Sheikh Nowfel Ahmed";

        Session["Role"] = 7;

        Session["RoleName"] = "CI";


        Session["BranchCode"] = "BD0010102";


        Response.Redirect("Dashboard.aspx");


    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "ahsanul.islam@mblbd.com";

        Session["Name"] = "Ahsanul Islam";

        Session["Role"] = 7;

        Session["RoleName"] = "HOB";


        Session["BranchCode"] = "BD0010102";


        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_UH_CBD_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "Prabal@mblbd.com";

        Session["Name"] = "Lutful Hoque Prabal";
        Session["RoleName"] = "Unit Head-CBD";

        Session["Role"] = 23;

        Session["BranchCode"] = "Credit";





        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_UH_SME_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "nazrul@mblbd.com";

        Session["RoleName"] = "Unit Head-CMSME";
        Session["Name"] = "Nazrul Islam";

        Session["Role"] = 27;

        Session["BranchCode"] = "Credit";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_UH_Retail_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "rejoan@mblbd.com";

        Session["Name"] = "Rejoanul Hoque";

        Session["Role"] = 31;

        Session["RoleName"] = "Unit Head-Retail";

        Session["BranchCode"] = "Credit";



        Response.Redirect("Dashboard.aspx");
    }
    protected void btnCD_UH_Agri_Click(object sender, EventArgs e)
    {
        Session["DomainID"] = "sadek@mblbd.com";

        Session["Name"] = "A T M SADIQUSSALAM CHOWDHURY";

        Session["Role"] = 35;
        Session["RoleName"] = "Unit Head-Agri";

        Session["BranchCode"] = "Credit";


        Response.Redirect("Dashboard.aspx");
    }
}