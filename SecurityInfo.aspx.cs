using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Globalization;

public partial class SecurityInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public class SecurityInfoDto
    {
        public long EntryId { get; set; }
        public int KeyNo { get; set; }

        public string Header01 { get; set; }
        public string Header02 { get; set; }
        public string Header03 { get; set; }
        public string Header04 { get; set; }
    }


    public class FieldConfig
    {
        public string Header { get; set; }
        public string Label { get; set; }
        public string Type { get; set; }
        public bool Required { get; set; }
        public string LookupGroup { get; set; }
        public List<string> Options { get; set; }
    }

    public class KeyConfig
    {
        public int KeyNo { get; set; }
        public string Title { get; set; }
        public List<FieldConfig> Fields { get; set; }
    }



    public static class SecurityInfoConfig
    {
        private static FieldConfig F(
            string header,
            string label,
            string type,
            bool required = false,
            string lookup = null)
        {
            return new FieldConfig
            {
                Header = header,
                Label = label,
                Type = type,
                Required = required,
                LookupGroup = lookup
            };
        }

        public static List<KeyConfig> GetAll()
        {
            var list = new List<KeyConfig>();

            list.Add(new KeyConfig
            {
                KeyNo = 7,
                Title = "Approval Authority",
                Fields = new List<FieldConfig> {
                F("Header01", "Approval Authority", "select", true, "ApprovalAuthority"),
                F("Header02", "Expiry", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 43,
                Title = "Deed Information",
                Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 44,
                Title = "Deed Copy Details",
                Fields = new List<FieldConfig> {
                F("Header01", "Original/Certified/Photocopy", "select", true, "DocumentCopyType"),
                F("Header02", "Deed Number", "number", true),
                F("Header03", "Date", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 45,
                Title = "Deed Registration",
                Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "SRO", "select", true, "SRO"),
                F("Header04", "Deed Delivery Date (Expected)", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 46,
                Title = "Deed Information",
                Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true)
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 49,
                Title = "Deed Information",
                Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 53,
                Title = "Khatian Information",
                Fields = new List<FieldConfig> {
                F("Header01", "Khatian Number", "number", true),
                F("Header02", "DCR Number", "number"),
                F("Header03", "DCR Page Number", "number")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 62,
                Title = "Valuation Company",
                Fields = new List<FieldConfig> {
                F("Header01", "Valuation Company", "select", true, "ValuationCompany"),
                F("Header02", "Date", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 74,
                Title = "Previous Bank",
                Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Previous Bank", "select", true, "PreviousBank"),
                F("Header04", "Previous Branch", "select", false, "PreviousBranch")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 80,
                Title = "Original/Certified",
                Fields = new List<FieldConfig> {
                F("Header01", "Original/Certified", "select", true, "DocumentType"),
                F("Header02", "Deed Number", "text"),
                F("Header03", "Date", "date"),
                F("Header04", "Withdrawal Date (if Certified Selected)", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 82,
                Title = "Original/Certified",
                Fields = new List<FieldConfig> {
                F("Header01", "Original/Certified", "select", true, "DocumentType"),
                F("Header02", "Deed Number", "text"),
                F("Header03", "Date", "date"),
                F("Header04", "Withdrawal Date (if Certified Selected)", "date")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 85,
                Title = "Deed Amount",
                Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 86,
                Title = "Deed Amount",
                Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 143,
                Title = "Submission Details",
                Fields = new List<FieldConfig> {
                F("Header01", "Submission Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 145,
                Title = "Submission Details",
                Fields = new List<FieldConfig> {
                F("Header01", "Submission Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 186,
                Title = "Guarantor Company",
                Fields = new List<FieldConfig> {
                F("Header01", "Guarantor Company", "text", true)
            }
            });

            list.Add(new KeyConfig
            {
                KeyNo = 211,
                Title = "ECAI Information",
                Fields = new List<FieldConfig> {
                F("Header01", "ECAI Name", "select", true, "ECAI"),
                F("Header02", "Expiry", "date"),
                F("Header03", "Rating", "select", false, "Rating")
            }
            });

            return list;
        }
    }


    private static string ConnectionString
    {
        get
        {
            return ConfigurationManager
                .ConnectionStrings["DBConn"]
                .ConnectionString;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<KeyConfig> GetConfiguration()
    {
        List<KeyConfig> config = SecurityInfoConfig.GetAll();

        using (SqlConnection con =
            new SqlConnection(ConnectionString))
        {
            con.Open();

            foreach (KeyConfig key in config)
            {
                foreach (FieldConfig field in key.Fields)
                {
                    if (!String.IsNullOrEmpty(field.LookupGroup))
                    {
                        field.Options = new List<string>();

                        using (SqlCommand cmd = new SqlCommand(@"
                            SELECT ValueText
                            FROM dbo.SecurityInfoLookup
                            WHERE GroupName = @GroupName
                              AND IsActive = 1
                            ORDER BY ValueText", con))
                        {
                            cmd.Parameters.Add("@GroupName", SqlDbType.VarChar, 50).Value = field.LookupGroup;

                            using (SqlDataReader dr =
                                cmd.ExecuteReader())
                            {
                                while (dr.Read())
                                {
                                    field.Options.Add(dr["ValueText"].ToString());
                                }
                            }
                        }

                        // Static document options are also
                        // available from the lookup table.
                    }
                }
            }
        }

        return config;
    }

    // 2. Insert

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool SaveInfo(
        long parentId,
        int keyNo,
        string[] values)
    {
        if (values == null || values.Length != 4)
            throw new Exception("Invalid field values.");

        KeyConfig config = SecurityInfoConfig.GetAll()
            .Find(x => x.KeyNo == keyNo);

        if (config == null)
            throw new Exception("Invalid key number.");

        // Validate the fields on the server.

        for (int i = 0; i < config.Fields.Count; i++)
        {
            FieldConfig field = config.Fields[i];

            string value = values[i] ?? "";

            if (field.Required &&
                String.IsNullOrWhiteSpace(value))
            {
                throw new Exception(
                    field.Label + " is required."
                );
            }

            if (field.Type == "number" &&
                !String.IsNullOrWhiteSpace(value))
            {
                decimal number;

                if (!Decimal.TryParse(
                    value,
                    NumberStyles.Number,
                    CultureInfo.InvariantCulture,
                    out number))
                {
                    throw new Exception(
                        "Invalid number: " + field.Label
                    );
                }
            }

            if (field.Type == "date" &&
                !String.IsNullOrWhiteSpace(value))
            {
                DateTime date;

                if (!DateTime.TryParseExact(
                    value,
                    "yyyy-MM-dd",
                    CultureInfo.InvariantCulture,
                    DateTimeStyles.None,
                    out date))
                {
                    throw new Exception(
                        "Invalid date: " + field.Label
                    );
                }
            }

            // Validate dropdown values against permitted
            // options, not merely the browser selection.
            if (field.Type == "select" &&
                !String.IsNullOrWhiteSpace(value))
            {
                if (field.Options != null &&
                    field.Options.Count > 0 &&
                    !field.Options.Contains(value))
                {
                    throw new Exception(
                        "Invalid selection: " + field.Label
                    );
                }
            }
        }

        string user = HttpContext.Current.User.Identity.Name;

        if (String.IsNullOrWhiteSpace(user))
            throw new Exception("Login required.");

        using (SqlConnection con =
            new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO dbo.SecurityInfo
                (
                    ParentId,
                    KeyNo,
                    Header01,
                    Header02,
                    Header03,
                    Header04,
                    CreatedBy
                )
                VALUES
                (
                    @ParentId,
                    @KeyNo,
                    @Header01,
                    @Header02,
                    @Header03,
                    @Header04,
                    @CreatedBy
                )", con))
            {
                cmd.Parameters.Add(
                    "@ParentId", SqlDbType.BigInt
                ).Value = parentId;

                cmd.Parameters.Add(
                    "@KeyNo", SqlDbType.Int
                ).Value = keyNo;

                for (int i = 0; i < 4; i++)
                {
                    string parameter = "@Header0" + (i + 1);

                    cmd.Parameters.Add(
                        parameter,
                        SqlDbType.NVarChar,
                        500
                    ).Value = String.IsNullOrWhiteSpace(values[i])
                        ? (object)DBNull.Value
                        : values[i].Trim();
                }

                cmd.Parameters.Add(
                    "@CreatedBy",
                    SqlDbType.NVarChar,
                    100
                ).Value = user.Length > 100
                    ? user.Substring(0, 100)
                    : user;

                con.Open();

                return cmd.ExecuteNonQuery() > 0;
            }
        }
    }

    // 3. Load saved information

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<SecurityInfoDto> GetInfo(long parentId)
    {
        List<SecurityInfoDto> list =
            new List<SecurityInfoDto>();

        using (SqlConnection con =
            new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT
                    EntryId,
                    KeyNo,
                    Header01,
                    Header02,
                    Header03,
                    Header04
                FROM dbo.SecurityInfo
                WHERE ParentId = @ParentId
                ORDER BY KeyNo, EntryId DESC", con))
            {
                cmd.Parameters.Add(
                    "@ParentId", SqlDbType.BigInt
                ).Value = parentId;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new SecurityInfoDto
                        {
                            EntryId = Convert.ToInt64(
                                dr["EntryId"]
                            ),

                            KeyNo = Convert.ToInt32(
                                dr["KeyNo"]
                            ),

                            Header01 = ReadValue(dr, "Header01"),
                            Header02 = ReadValue(dr, "Header02"),
                            Header03 = ReadValue(dr, "Header03"),
                            Header04 = ReadValue(dr, "Header04")
                        });
                    }
                }
            }
        }

        return list;
    }

    private static string ReadValue(
        SqlDataReader dr,
        string column)
    {
        return dr[column] == DBNull.Value
            ? ""
            : dr[column].ToString();
    }

    // 4. Delete

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool DeleteInfo(
        long entryId,
        long parentId)
    {
        if (String.IsNullOrWhiteSpace(
            HttpContext.Current.User.Identity.Name))
        {
            throw new Exception("Login required.");
        }

        using (SqlConnection con =
            new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(@"
                DELETE FROM dbo.SecurityInfo
                WHERE EntryId = @EntryId
                  AND ParentId = @ParentId", con))
            {
                cmd.Parameters.Add(
                    "@EntryId", SqlDbType.BigInt
                ).Value = entryId;

                cmd.Parameters.Add(
                    "@ParentId", SqlDbType.BigInt
                ).Value = parentId;

                con.Open();

                return cmd.ExecuteNonQuery() > 0;
            }
        }
    }
}