using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Globalization;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Utility
/// </summary>
public class Utility
{

    public String ErrorMSG;
    public Utility()
    {
        //
        // TODO: Add constructor logic here
        //
    }



    public string ToTitleCase(string text)
    {

        //return Regex.Replace(text, "[a-z][A-Z]", m => m.Value[0] + " " + char.ToUpper(m.Value[1]));

        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(text);

    }

    public SqlDateTime ConvertSQLDateTime(string txtdt)
    {
        SqlDateTime sqldt;
        DateTime dt;
        if (String.IsNullOrEmpty(txtdt))
        {
            sqldt = SqlDateTime.Null;
        }
        else
        {
            dt = Convert.ToDateTime(txtdt.ToString().Substring(6, 4) + '-' + txtdt.ToString().Substring(3, 2) + '-' + txtdt.ToString().Substring(0, 2));
            //sqldt = Convert.ToDateTime(txtdt.ToString().Substring(6, 4) + '-' + txtdt.ToString().Substring(3, 2) + '-' + txtdt.ToString().Substring(0,2));
            //sqldt = Convert.ToDateTime(txtdt.ToString().Substring(3, 2) + '/' + txtdt.ToString().Substring(0, 2) + '/' + txtdt.ToString().Substring(6, 4));
            //sqldt = DateTime.ParseExact(txtdt.ToString().Substring(3, 2) + '/' + txtdt.ToString().Substring(0, 2) + '/' + txtdt.ToString().Substring(6, 4), "MM/dd/yyyy", null);
            //sqldt = DateTime.ParseExact(txtdt.ToString().Substring(3, 2) + '/' + txtdt.ToString().Substring(0, 2) + '/' + txtdt.ToString().Substring(6, 4), "MM/dd/yyyy", null);

            sqldt = dt;
        }
        return sqldt;
    }




    public string return_T24_BranchCode(String hrm_br_cd)
    {

        //SqlConnection connection = new SqlConnection(new DBCon().ConStr2);

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString);

        SqlCommand command = new SqlCommand();
        command.CommandType = CommandType.Text;
        command.CommandText = "select * from [dbo].[t_HRM_T24_Mapping]  where [HR_BRCOD]='" + hrm_br_cd + "'";
        command.Connection = connection;


        //command.Parameters.Add(new SqlParameter("@BranchCode", Session["BranchCode"]));
        //command.Parameters.Add(new SqlParameter("@status", "ALL"));

        //command.Parameters.Add(new SqlParameter("@ValueDate", ValueDate));
        //SqlCommand cmd = new SqlCommand("select * from t_FundRequsition", connection);
        //SqlCommand cmd = new SqlCommand(Sql, connection);


        SqlDataAdapter sda = new SqlDataAdapter(command);
        DataSet ds = new DataSet();

        try
        {
            sda.Fill(ds);
            ErrorMSG = "";
        }
        catch (Exception ex)
        {
            ErrorMSG = ex.Message;
        }
        return ds.Tables[0].Rows[0]["COMPANY_ID"].ToString();
    }

    public Int32 ChangeUserStatus(String employeeid)
    {
        Int32 Sts;

        //SqlConnection connection = new SqlConnection(new DBCon().ConStr2);

        //SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString);

        //SqlCommand command = new SqlCommand();
        //command.CommandType = CommandType.Text;
        String Sql = "update t_User set status='Inactive' where empid='" + employeeid + "' ";
        //command.Connection = connection;


        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString))
        {
            conn.Open();

            //SqlTransaction transaction = conn.BeginTransaction();

            try
            {




                //SqlCommand cmd = new SqlCommand(Sql, conn, transaction);
                SqlCommand cmd = new SqlCommand(Sql, conn);

                cmd.ExecuteNonQuery();

                //transaction.Commit();
                //return "Records inserted successfully!";
                //Sts = "Records inserted successfully!";

                Sts = 1;

            }
            catch (Exception ex)
            {
                //transaction.Rollback();
                //return "Error: " + ex.Message;
                //Sts = "Error: " + ex.Message;

                Sts = 0;
            }

            return Sts;
        }
    }
}