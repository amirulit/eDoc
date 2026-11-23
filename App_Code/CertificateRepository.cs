using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CertificateRepository
/// </summary>
 
	
public class CertificateRepository
{
    private readonly string connectionString;

    public CertificateRepository()
    {
        connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
    }

    public SecuritySatisfactionCertificate GetCertificate(int id)
    {
        const string sql = @"
                SELECT
                    SSCNumber,
                    CertificateDate,
                    CFRNumber,
                    BranchName,
                    RMName,
                    RMID,
                    BorrowerName,
                    ApprovalAuthority,
                    SanctionReference,
                    SanctionDate,
                    NatureOfFacility,
                    LimitAsked,
                    SanctionExpiry
                FROM SecuritySatisfactionCertificate
                WHERE Id = @Id";

        using (SqlConnection con =
               new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                        return null;

                    SecuritySatisfactionCertificate data =
                        new SecuritySatisfactionCertificate();

                    data.SSCNumber =
                        GetString(dr, "SSCNumber");

                    data.CertificateDate =
                        Convert.ToDateTime(dr["CertificateDate"]);

                    data.CFRNumber =
                        GetString(dr, "CFRNumber");

                    data.BranchName =
                        GetString(dr, "BranchName");

                    data.RMName =
                        GetString(dr, "RMName");

                    data.RMID =
                        GetString(dr, "RMID");

                    data.BorrowerName =
                        GetString(dr, "BorrowerName");

                    data.ApprovalAuthority =
                        GetString(dr, "ApprovalAuthority");

                    data.SanctionReference =
                        GetString(dr, "SanctionReference");

                    data.SanctionDate =
                        GetNullableDate(dr, "SanctionDate");

                    data.NatureOfFacility =
                        GetString(dr, "NatureOfFacility");

                    data.LimitAsked =
                        GetNullableDecimal(dr, "LimitAsked");

                    data.SanctionExpiry =
                        GetNullableDate(dr, "SanctionExpiry");

                    return data;
                }
            }
        }
    }
    private string GetString(SqlDataReader dr, string column)
    {
        return dr[column] == DBNull.Value
            ? string.Empty
            : Convert.ToString(dr[column]);
    }

    private DateTime? GetNullableDate(
        SqlDataReader dr, string column)
    {
        if (dr[column] == DBNull.Value)
            return null;

        return Convert.ToDateTime(dr[column]);
    }

    private decimal? GetNullableDecimal(
        SqlDataReader dr, string column)
    {
        if (dr[column] == DBNull.Value)
            return null;

        return Convert.ToDecimal(dr[column]);
    }
}