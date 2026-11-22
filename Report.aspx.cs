using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public class TradeLicenseInfo
    {
        public string sanction_ids { get; set; }
        public string sanction_refno { get; set; }
        public string drawdown_id { get; set; }
        public string cus_types { get; set; }
        public string loan_natures { get; set; }
        public string securities { get; set; }
        public string loan_amount { get; set; }
        public string appr_auth { get; set; }
        public string expiry { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<TradeLicenseInfo> GetApprovalAuthorityInfo(string type)
    {
        List<TradeLicenseInfo> list = new List<TradeLicenseInfo>();

        String connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_ApprovalAuthority_Info", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@Type", SqlDbType.VarChar, 500).Value = type;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        TradeLicenseInfo item = new TradeLicenseInfo();

                        item.sanction_ids = Convert.ToString(dr["sanction_ids"]);
                        item.sanction_refno = Convert.ToString(dr["sanction_refno"]);
                        item.drawdown_id = Convert.ToString(dr["drawdown_id"]);
                        item.cus_types = Convert.ToString(dr["cus_types"]);
                        item.loan_natures = Convert.ToString(dr["loan_natures"]);
                        item.securities = Convert.ToString(dr["securities"]);
                        item.loan_amount = Convert.ToString(dr["loan_amount"]);
                        item.appr_auth = Convert.ToString(dr["appr_auth"]);

                        item.expiry = dr["expiry"] == DBNull.Value
                            ? ""
                            : Convert.ToDateTime(dr["expiry"]).ToString("dd-MMM-yyyy");

                        list.Add(item);
                    }
                }
            }
        }

        return list;
    }

    public class CreditRatingInfo
    {
        public string sanction_ids { get; set; }
        public string sanction_refno { get; set; }
        public string drawdown_id { get; set; }
        public string cus_types { get; set; }
        public string loan_natures { get; set; }
        public string securities { get; set; }
        public string loan_amount { get; set; }
        public string rating_company { get; set; }
        public string expiry { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<CreditRatingInfo> GetCreditRatingInfo(string type)
    {
        List<CreditRatingInfo> list = new List<CreditRatingInfo>();

        string connectionString =
            ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(
                "usp_CreditRating_Info", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@Type", SqlDbType.VarChar, 500).Value = type;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        CreditRatingInfo item = new CreditRatingInfo();

                        item.sanction_ids = Convert.ToString(dr["sanction_ids"]);
                        item.sanction_refno = Convert.ToString(dr["sanction_refno"]);
                        item.drawdown_id = Convert.ToString(dr["drawdown_id"]);
                        item.cus_types = Convert.ToString(dr["cus_types"]);
                        item.loan_natures = Convert.ToString(dr["loan_natures"]);
                        item.securities = Convert.ToString(dr["securities"]);
                        item.loan_amount = Convert.ToString(dr["loan_amount"]);
                        item.rating_company = Convert.ToString(dr["rating_company"]);

                        item.expiry = dr["expiry"] == DBNull.Value
                            ? ""
                            : Convert.ToDateTime(dr["expiry"]).ToString("dd-MMM-yyyy");

                        list.Add(item);
                    }
                }
            }
        }

        return list;
    }

}