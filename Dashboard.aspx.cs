using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard : System.Web.UI.Page
{
    public Int32 Role { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

        Role = Convert.ToInt32(Session["Role"]);

    }
}