using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GeneratedSSCRepository
/// </summary>
 
    public class GeneratedSSCRepository
    {
        private readonly string connectionString;

        public GeneratedSSCRepository()
        {
            connectionString =ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        // Save generated PDF information
        public int SaveDocument(
            int certificateId,
            string fileName,
            string filePath,
            string createdBy)
        {
            string sql = @"
                INSERT INTO GeneratedSSCDocuments
                (
                    CertificateId,
                    FileName,
                    FilePath,
                    CreatedDate,
                    CreatedBy,
                    IsActive
                )
                VALUES
                (
                    @CertificateId,
                    @FileName,
                    @FilePath,
                    GETDATE(),
                    @CreatedBy,
                    1
                );

                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            using (SqlConnection con =
                new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@CertificateId",
                    SqlDbType.Int).Value = certificateId;

                cmd.Parameters.Add("@FileName",
                    SqlDbType.NVarChar, 255).Value = fileName;

                cmd.Parameters.Add("@FilePath",
                    SqlDbType.NVarChar, 500).Value = filePath;

                cmd.Parameters.Add("@CreatedBy",
                    SqlDbType.NVarChar, 100).Value =
                    string.IsNullOrEmpty(createdBy)
                        ? (object)DBNull.Value
                        : createdBy;

                con.Open();

                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        // Get generated PDF information
        public GeneratedSSC GetDocument(int documentId)
        {
            string sql = @"
                SELECT
                    Id,
                    CertificateId,
                    FileName,
                    FilePath,
                    CreatedDate
                FROM GeneratedSSCDocuments
                WHERE Id = @Id
                  AND IsActive = 1";

            using (SqlConnection con =
                new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@Id",
                    SqlDbType.Int).Value = documentId;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                        return null;

                    return new GeneratedSSC
                    {
                        Id = Convert.ToInt32(dr["Id"]),
                        CertificateId =
                            Convert.ToInt32(dr["CertificateId"]),

                        FileName = Convert.ToString(dr["FileName"]),
                        FilePath = Convert.ToString(dr["FilePath"]),

                        CreatedDate =
                            Convert.ToDateTime(dr["CreatedDate"])
                    };
                }
            }
        }
    }

    public class GeneratedSSC
    {
        public int Id { get; set; }
        public int CertificateId { get; set; }

        public string FileName { get; set; }
        public string FilePath { get; set; }

        public DateTime CreatedDate { get; set; }
    }
 