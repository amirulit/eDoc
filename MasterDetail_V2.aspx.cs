
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Services;

public partial class MasterDetail_V2 : System.Web.UI.Page
{
    static string conStr =
        ConfigurationManager.ConnectionStrings[
            "DMSConnection"
        ].ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMaster();
        }
    }


    private void LoadMaster()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string sql = @"
                SELECT
                    MasterID,
                    DocumentNo,
                    Subject,
                    DocumentDate,
                    Status
                FROM DMS_Master
                ORDER BY MasterID DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
            {
                DataTable dt = new DataTable();

                da.Fill(dt);

                rptMaster.DataSource = dt;
                rptMaster.DataBind();

                if (dt.Rows.Count > 0)
                {
                    hfSelectedMasterId.Value =
                        dt.Rows[0]["MasterID"].ToString();
                }
            }
        }
    }


    public class DetailModel
    {
        public int DetailID { get; set; }

        public string DetailType { get; set; }

        public string Description { get; set; }

        public string ReferenceNo { get; set; }

        public string Remarks { get; set; }
    }


    [WebMethod]
    public static List<DetailModel> GetDetails(int masterId)
    {
        List<DetailModel> list = new List<DetailModel>();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string sql = @"
                SELECT
                    DetailID,
                    DetailType,
                    Description,
                    ReferenceNo,
                    Remarks
                FROM DMS_Detail
                WHERE MasterID = @MasterID
                ORDER BY DetailID DESC";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@MasterID",
                    SqlDbType.Int).Value = masterId;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new DetailModel
                        {
                            DetailID = Convert.ToInt32(
                                dr["DetailID"]),

                            DetailType = Convert.ToString(
                                dr["DetailType"]),

                            Description = Convert.ToString(
                                dr["Description"]),

                            ReferenceNo = Convert.ToString(
                                dr["ReferenceNo"]),

                            Remarks = Convert.ToString(
                                dr["Remarks"])
                        });
                    }
                }
            }
        }

        return list;
    }
}
