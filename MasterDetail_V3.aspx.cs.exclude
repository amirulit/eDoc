
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class MasterDetail : System.Web.UI.Page
{
    private static string conStr =
        ConfigurationManager.ConnectionStrings[
            "DMSConnection"
        ].ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {
    }


    // MASTER MODEL

    public class MasterModel
    {
        public int MasterID { get; set; }
        public string DocumentNo { get; set; }
        public string ReferenceNo { get; set; }
        public string Subject { get; set; }
        public string DocumentDate { get; set; }
        public string Department { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public string Status { get; set; }
        public string Remarks { get; set; }
    }


    // DETAIL MODEL

    public class DetailModel
    {
        public int DetailID { get; set; }
        public string DetailType { get; set; }
        public string Description { get; set; }
        public string ReferenceNo { get; set; }
        public string Remarks { get; set; }
    }


    // LOAD ALL MASTER RECORDS

    [WebMethod]
    public static List<MasterModel> GetMasters()
    {
        List<MasterModel> list = new List<MasterModel>();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string sql = @"
                SELECT
                    MasterID,
                    DocumentNo,
                    ReferenceNo,
                    Subject,
                    DocumentDate,
                    Department,
                    CreatedBy,
                    CreatedDate,
                    Status,
                    Remarks
                FROM DMS_Master
                ORDER BY MasterID DESC";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new MasterModel
                        {
                            MasterID = Convert.ToInt32(
                                dr["MasterID"]),

                            DocumentNo = Convert.ToString(
                                dr["DocumentNo"]),

                            ReferenceNo = Convert.ToString(
                                dr["ReferenceNo"]),

                            Subject = Convert.ToString(
                                dr["Subject"]),

                            DocumentDate = dr["DocumentDate"] == DBNull.Value
                                ? ""
                                : Convert.ToDateTime(
                                    dr["DocumentDate"]).ToString("dd-MMM-yyyy"),

                            Department = Convert.ToString(
                                dr["Department"]),

                            CreatedBy = Convert.ToString(
                                dr["CreatedBy"]),

                            CreatedDate = dr["CreatedDate"] == DBNull.Value
                                ? ""
                                : Convert.ToDateTime(
                                    dr["CreatedDate"]).ToString("dd-MMM-yyyy HH:mm"),

                            Status = Convert.ToString(
                                dr["Status"]),

                            Remarks = Convert.ToString(
                                dr["Remarks"])
                        });
                    }
                }
            }
        }

        return list;
    }


    // LOAD DETAILS FOR SELECTED MASTER

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
                cmd.Parameters.Add(
                    "@MasterID",
                    SqlDbType.Int
                ).Value = masterId;

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
