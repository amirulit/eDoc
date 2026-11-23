using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LLI_Generate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object GetFacilities()
    {
        List<Dictionary<string, object>> result =
            new List<Dictionary<string, object>>();

        string conStr = ConfigurationManager
            .ConnectionStrings["dbconn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string sql = @"
        DECLARE @cols NVARCHAR(MAX);
        DECLARE @sql NVARCHAR(MAX);

        SELECT @cols = STUFF((
            SELECT ',' + QUOTENAME(
                'Facility' + CAST(FacilityNo AS VARCHAR(10))
            )
            FROM
            (
                SELECT ROW_NUMBER() OVER (ORDER BY id) AS FacilityNo
                FROM dbo.t_Sanction_Master_Details
            ) A
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

        SET @sql = '
        SELECT *
        FROM
        (
            SELECT
                ''loan_nature'' AS FieldName,
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)) AS FacilityNo,
                CAST(loan_nature AS NVARCHAR(MAX)) AS Value
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''amount'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(amount AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''validity'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(validity AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details

            UNION ALL

            SELECT
                ''customer_name'',
                ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
                CAST(customer_name AS NVARCHAR(MAX))
            FROM dbo.t_Sanction_Master_Details
        ) AS SourceData

        PIVOT
        (
            MAX(Value)
            FOR FacilityNo IN (' + @cols + ')
        ) AS PivotTable';

        EXEC sp_executesql @sql;
        ";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        Dictionary<string, object> row =
                            new Dictionary<string, object>();

                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            row[dr.GetName(i)] =
                                dr.IsDBNull(i) ? null : dr.GetValue(i);
                        }

                        result.Add(row);
                    }
                }
            }
        }

        return result;
    }
}