using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [System.Web.Services.WebMethod]
    public static Employee GetEmpInfo(String EmpId)
    {
        Employee e = new Employee();

        EmployeeService es = new EmployeeService();
        e = es.GetEmpDetails(EmpId);
        e.POPCode = new Utility().return_T24_BranchCode(e.POPCode);
        return e;

    }
}