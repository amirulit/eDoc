using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for SscRepository
/// </summary>
/// 
namespace CAD.DataAccess
{
    public static class SscRepository
    {
        public static SSCData GetSscData(int drawdownId)
        {
            SSCData data = null;

            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString))
            using (var cmd = new SqlCommand("getSSCUncond", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@drawdown_id", drawdownId);
                conn.Open();

                using (var rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        data = new SSCData
                        {
                            CfrNo = rdr["cfr_no"].ToString(),
                            BranchName = rdr["Branch_Name"].ToString(),
                            CustomerName = rdr["Customer_Name"].ToString(),
                            SancAuthority = rdr["sanction_authority"] as string,
                            SancReferenceNo = rdr["sanction_reference"] as string,
                            SancDate = rdr["sanction_date"] as string,
                            RmName = rdr["entry_by"] as string,
                            LoanNatures = rdr["loan_natures"] as string,
                            LoanAmount = rdr["loan_amount"].ToString(),
                            ExpDate = rdr["exp_date"] as string
                        };
                    }
                }
            }

            return data;
        }

        public static SSCData GetSscConditionalData(int drawdownId)
        {
            SSCData data = null;

            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString))
            using (var cmd = new SqlCommand("getSSCConditional", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@drawdown_id", drawdownId);
                conn.Open();

                using (var rdr = cmd.ExecuteReader())
                {
                    // --- First result set: header/certificate data ---
                    if (rdr.Read())
                    {
                        data = new SSCData
                        {
                            Id = rdr["id"].ToString(),
                            CfrNo = rdr["cfr_no"].ToString(),
                            SancReferenceNo = rdr["sanction_reference"] as string,
                            SancDate = rdr["sanction_date"] as string,
                            SancAuthority = rdr["sanction_authority"] as string,
                            BranchName = rdr["Branch_Name"] as string,
                            CustomerName = rdr["Customer_Name"] as string,
                            LoanNatures = rdr["loan_natures"] as string,
                            //SancAuthority = rdr["sanc_authority"] as string,
                            //SancReferenceNo = rdr["sanc_reference_no"] as string,
                            //SancDate = rdr["sanc_date"] == DBNull.Value ? "" : Convert.ToDateTime(rdr["sanc_date"]).ToString("dd/MM/yyyy"),
                            LoanAmount = rdr["loan_amount"].ToString(),
                            ExpDate = rdr["exp_date"] as string,
                            //Status = rdr["status"] as string
                        };
                    }

                    if (data == null)
                        throw new Exception("No record found for drawdown_id " + drawdownId);

                    // --- Second result set: pending/outstanding documents ---
                    if (rdr.NextResult())
                    {
                        while (rdr.Read())
                        {
                            data.PendingDocuments.Add(new PendingDocument
                            {
                                DocSl = Convert.ToInt32(rdr["doc_sl"]),
                                DocName = rdr["doc_name"] as string,
                                Status = rdr["status"] as string,
                                Details = rdr["details"] as string,
                                Deadline = rdr["deadline"] as string
                            });
                        }
                    }
                }
            }

            return data;
        }
    }
}