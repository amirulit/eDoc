[WebMethod]
public static List<Facility> GetFacilities(string drawdownId)
{
    List<Facility> list = new List<Facility>();

    // Execute stored procedure
    // Read records from SQL Server
    // Populate list

    return list;
}




function BindFacilities(data) {

    var html = "";

    html += "<table class='table table-bordered'>";
    html += "<thead><tr><th>Information</th>";

    $.each(data, function (i, item) {
        html += "<th>Facility " + (i + 1) + "</th>";
    });

    html += "</tr></thead><tbody>";

    var fields = [
        { name: "Facility Name", key: "FacilityName" },
        { name: "Limit", key: "Limit" },
        { name: "Expiry Date", key: "ExpiryDate" },
        { name: "Outstanding", key: "Outstanding" },
        { name: "Interest Rate", key: "InterestRate" }
    ];

    $.each(fields, function (i, field) {

        html += "<tr><th>" + field.name + "</th>";

        $.each(data, function (j, item) {
            html += "<td>" +
                (item[field.key] == null ? "" : item[field.key]) +
                "</td>";
        });

        html += "</tr>";
    });

    html += "</tbody></table>";

    $("#divFacilities").html(html);
}





<div class="card">
    <div class="card-header">
        <h3>Loan Facility Information</h3>
    </div>

    <div class="card-body table-responsive">
        <div id="divFacilities"></div>
    </div>
</div>


CREATE TABLE dbo.DrawdownFacility
(
    FacilityID INT IDENTITY(1,1) PRIMARY KEY,
    DrawdownID VARCHAR(30),
    FacilityName VARCHAR(100),
    LimitAmount DECIMAL(18,2),
    LimitExpiry DATE,
    Outstanding DECIMAL(18,2),
    InterestRate DECIMAL(8,2)
);




CREATE PROCEDURE dbo.usp_GetDrawdownFacilities
    @DrawdownID VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ROW_NUMBER() OVER (ORDER BY FacilityID) AS FacilityNo,
        FacilityName,
        LimitAmount,
        LimitExpiry,
        Outstanding,
        InterestRate
    INTO #Facilities
    FROM dbo.DrawdownFacility
    WHERE DrawdownID = @DrawdownID;

    DECLARE @cols NVARCHAR(MAX);
    DECLARE @sql NVARCHAR(MAX);

    SELECT @cols =
        STRING_AGG(
            CAST(
                'MAX(CASE WHEN FacilityNo = '
                + CAST(FacilityNo AS VARCHAR(10))
                + ' THEN InfoValue END) AS '
                + QUOTENAME('Facility ' + CAST(FacilityNo AS VARCHAR(10)))
                AS NVARCHAR(MAX)
            ), ','
        ) WITHIN GROUP (ORDER BY FacilityNo)
    FROM #Facilities;

    IF @cols IS NULL
    BEGIN
        SELECT CAST(NULL AS NVARCHAR(100)) AS [Information]
        WHERE 1 = 0;
        RETURN;
    END;

    SET @sql = N'
        SELECT
            Info AS [Information],
            ' + @cols + '
        FROM
        (
            SELECT
                FacilityNo,
                Info,
                InfoValue
            FROM #Facilities
            CROSS APPLY
            (
                VALUES
                    (1, ''Facility Name'', FacilityName),
                    (2, ''Limit Amount'', CONVERT(VARCHAR(30), LimitAmount)),
                    (3, ''Limit Expiry'', CONVERT(VARCHAR(10), LimitExpiry, 23)),
                    (4, ''Outstanding'', CONVERT(VARCHAR(30), Outstanding)),
                    (5, ''Interest Rate'', CONVERT(VARCHAR(20), InterestRate))
            ) V(SortOrder, Info, InfoValue)
        ) D
        GROUP BY SortOrder, Info
        ORDER BY SortOrder;
    ';

    EXEC sp_executesql @sql;
END;
GO
```

### 2. Expected SQL result

For 3 facilities:

| Information | Facility 1 | Facility 2 | Facility 3 |
|---|---|---|---|
| Facility Name | Term Loan | OD | Import Loan |
| Limit Amount | 5000000 | 3000000 | 2000000 |
| Limit Expiry | 2026-12-31 | 2027-06-30 | 2027-03-31 |
| Outstanding | 2000000 | 1000000 | 500000 |
| Interest Rate | 10 | 11 | 9 |

For 5 facilities, SQL automatically returns 5 facility columns.

No need to modify the stored procedure when the facility count changes.

## 3. ASP.NET Web Forms WebMethod

The stored procedure returns dynamic columns, so don't define fixed properties in your C# model.

Use `List<Dictionary<string, object>>` to handle variable columns.

```csharp
[WebMethod]
public static List<Dictionary<string, object>>
    GetDrawdownFacilities(string drawdownId)
{
    List<Dictionary<string, object>> result =
        new List<Dictionary<string, object>>();

    string cs = ConfigurationManager
        .ConnectionStrings["DBConnection"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(
        "usp_GetDrawdownFacilities", con))
    {
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add("@DrawdownID",
            SqlDbType.VarChar, 30).Value = drawdownId;

        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        {
            DataTable dt = new DataTable();
            da.Fill(dt);

            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, object> row =
                    new Dictionary<string, object>();

                foreach (DataColumn col in dt.Columns)
                {
                    row[col.ColumnName] =
                        dr[col] == DBNull.Value ? null : dr[col];
                }

                result.Add(row);
            }
        }
    }

    return result;
}
```

## 4. Bootstrap modal

```html
<div class="modal fade" id="facilityModal">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <div class="modal-header">
                <h4>Drawdown Loan Facilities</h4>
                <button type="button" class="close"
                    data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body">

                <div id="divFacilityTable"
                     class="table-responsive">
                </div>

            </div>

            <div class="modal-footer">
                <button type="button"
                    class="btn btn-primary"
                    onclick="PrintFacilities()">
                    Print / PDF
                </button>

                <button type="button"
                    class="btn btn-secondary"
                    data-dismiss="modal">
                    Close
                </button>
            </div>

        </div>
    </div>
</div>
```

## 5. jQuery AJAX and dynamic table binding

This code doesn't require knowing the number of columns beforehand.

```javascript
function ShowFacilities(drawdownId) {

    $.ajax({
        type: "POST",
        url: "Drawdown.aspx/GetDrawdownFacilities",
        data: JSON.stringify({ drawdownId: drawdownId }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            var data = response.d;
            var html = "";

            if (data.length == 0) {
                $("#divFacilityTable").html(
                    "No facility information found."
                );
                $("#facilityModal").modal("show");
                return;
            }

            var columns = Object.keys(data[0]);

            html += "<table id='tblFacility' ";
            html += "class='table table-bordered table-striped'>";
            html += "<thead><tr>";

            $.each(columns, function (i, col) {
                html += "<th></th>".replace(
                    "</th>",
                    ""
                );

                // Header text
                var th = $("<th>").text(col);
                // Build headers below
            });

            html = "<table id='tblFacility' class='table table-bordered table-striped'><thead><tr>";

            $.each(columns, function (i, col) {
                html += $("<div>").text(col).html();
                html = html.replace(
                    new RegExp(
                        $("<div>").text(col).html() + "$"
                    ), 
                    $("<div>").text(col).html()
                );
            });

            html += "</tr></thead><tbody>";

            $.each(data, function (i, row) {

                html += "<tr>";

                $.each(columns, function (j, col) {

                    var value = row[col] == null
                        ? ""
                        : row[col];

                    html += $("<td>")
                        .text(value)
                        .prop("outerHTML");
                });

                html += "</tr>";
            });

            html += "</tbody></table>";

            $("#divFacilityTable").html(html);

            $("#facilityModal").modal("show");
        },

        error: function (xhr) {
            alert("Unable to load facility information.");
        }
    });
}
```

**Correction: use this simpler binding function** for the dynamic table above. It safely encodes the column names and cell values.

```javascript
function escapeHtml(value) {
    return $("<div/>").text(
        value == null ? "" : value
    ).html();
}

function BindFacilityTable(data) {

    var html = "";

    if (!data || data.length == 0) {
        $("#divFacilityTable").html("No records found.");
        return;
    }

    var columns = Object.keys(data[0]);

    html += "<table id='tblFacility' ";
    html += "class='table table-bordered table-striped'>";
    html += "<thead><tr>";

    $.each(columns, function (i, col) {
        html += "<th>" + escapeHtml(col) + "</th>";
    });

    html += "</tr></thead><tbody>";

    $.each(data, function (i, row) {

        html += "<tr>";

        $.each(columns, function (j, col) {
            html += "<td>" + escapeHtml(row[col]) + "</td>";
        });

        html += "</tr>";
    });

    html += "</tbody></table>";

    $("#divFacilityTable").html(html);
}
```

Call it inside AJAX success:

```javascript
success: function (response) {

    BindFacilityTable(response.d);

    $("#facilityModal").modal("show");
}
```

### 6. Print / PDF

You can print the exact same dynamically generated table, including all facility columns.

```javascript
function PrintFacilities() {

    var content = $("#tblFacility")[0].outerHTML;

    var win = window.open("", "_blank");

    win.document.write(
        "<html><head><title>Loan Facilities</title>"
    );

    win.document.write("<style>");
    win.document.write("@page { size: landscape; margin: 15mm; }");
    win.document.write("table { width:100%; border-collapse:collapse; }");
    win.document.write("th,td { border:1px solid #333; padding:6px; }");
    win.document.write("th { background:#eee; }");
    win.document.write("</style>");

    win.document.write("</head><body>");
    win.document.write(content);
    win.document.write("</body></html>");

    win.document.close();
    win.focus();
    win.print();
}
```

The browser print dialog allows the user to select **Save as PDF**.

---

### Important database design recommendation

Do not create a permanent SQL table with dynamic columns for every Drawdown ID. Keep the original facility information normalized (one facility per row), and generate the dynamic columns only when retrieving data for the modal or PDF.

This gives you:
- 2, 3, 5 or even more facilities without schema changes.
- One stored procedure.
- One WebMethod.
- One reusable jQuery table.
- Consistent modal and PDF output.

**One additional suggestion:** If you want the actual facility names (Term Loan, OD, Import Loan) as the column headers instead of Facility 1, Facility 2, Facility 3, I can adapt the stored procedure to generate those dynamic headers too.


Instead of String_agg:

SELECT @cols = STUFF
(
    (
        SELECT
            ',MAX(CASE WHEN FacilityNo = '
            + CAST(FacilityNo AS VARCHAR(10))
            + ' THEN InfoValue END) AS '
            + QUOTENAME(
                'Facility ' + CAST(FacilityNo AS VARCHAR(10))
              )
        FROM #Facilities
        ORDER BY FacilityNo
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'),
    1, 1, ''
);


function BindFacilities(data) {

    var html = "";

    html += "<table class='table table-bordered'>";
    html += "<thead><tr><th>Information</th>";

    $.each(data, function (i, item) {
        html += "<th>Facility " + (i + 1) + "</th>";
    });

    html += "</tr></thead><tbody>";

    var fields = [
        { name: "Facility Name", key: "FacilityName", type: "text" },
        { name: "Limit", key: "Limit", type: "number" },
        { name: "Expiry Date", key: "ExpiryDate", type: "date" },
        { name: "Outstanding", key: "Outstanding", type: "number" },
        { name: "Interest Rate", key: "InterestRate", type: "number" }
    ];

    $.each(fields, function (i, field) {

        html += "<tr>";
        html += "<th>" + field.name + "</th>";

        $.each(data, function (j, item) {

            var value = item[field.key] == null
                ? ""
                : item[field.key];

            html += "<td>";

            html += "<input ";
            html += "type='" + field.type + "' ";
            html += "class='form-control facility-input' ";
            html += "data-index='" + j + "' ";
            html += "data-field='" + field.key + "' ";
            html += "value='" + escapeHtml(value) + "'>";

            html += "</td>";
        });

        html += "</tr>";
    });

    html += "</tbody></table>";

    $("#divFacilities").html(html);
}

function escapeHtml(value) {

    return $("<div/>")
        .text(value)
        .html()
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;");
}



function GetFacilityData() {

    var facilities = [];

    $("#divFacilities .facility-input").each(function () {

        var index = $(this).data("index");
        var field = $(this).data("field");
        var value = $(this).val();

        if (!facilities[index]) {
            facilities[index] = {};
        }

        facilities[index][field] = value;

    });

    return facilities;
}




[
  {
    "FacilityName": "Term Loan",
    "Limit": "6000000",
    "ExpiryDate": "2026-12-31",
    "Outstanding": "2000000",
    "InterestRate": "10"
  },
  {
    "FacilityName": "OD Facility",
    "Limit": "3000000",
    "ExpiryDate": "2027-06-30",
    "Outstanding": "1000000",
    "InterestRate": "11"
  }
]




function SaveFacilities() {

    var facilities = GetFacilityData();

    $.ajax({
        type: "POST",
        url: "Drawdown.aspx/SaveFacilities",
        data: JSON.stringify({
            drawdownId: $("#txtDrawdownID").val(),
            facilities: facilities
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            alert(response.d);
        },

        error: function () {
            alert("Save failed");
        }
    });
}



[WebMethod]
public static string SaveFacilities(
    string drawdownId,
    List<Facility> facilities)
{
    // Validate and save using parameterized SQL
    return "Saved successfully";
}

public class Facility
{
    public int FacilityID { get; set; }
    public string FacilityName { get; set; }
    public decimal Limit { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public decimal Outstanding { get; set; }
    public decimal InterestRate { get; set; }
}

[WebMethod]
public static List<Facility> GetFacilities(string drawdownId)
{
    List<Facility> list = new List<Facility>();

    string cs = ConfigurationManager
        .ConnectionStrings["DBConnection"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    {
        using (SqlCommand cmd = new SqlCommand(
            "usp_GetDrawdownFacilities", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@DrawdownID",
                SqlDbType.VarChar, 30).Value = drawdownId;

            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    Facility obj = new Facility();

                    obj.FacilityID = Convert.ToInt32(
                        dr["FacilityID"]);

                    obj.FacilityName =
                        dr["FacilityName"].ToString();

                    obj.Limit = dr["LimitAmount"] == DBNull.Value
                        ? 0
                        : Convert.ToDecimal(dr["LimitAmount"]);

                    obj.ExpiryDate =
                        dr["LimitExpiry"] == DBNull.Value
                        ? (DateTime?)null
                        : Convert.ToDateTime(dr["LimitExpiry"]);

                    obj.Outstanding =
                        dr["Outstanding"] == DBNull.Value
                        ? 0
                        : Convert.ToDecimal(dr["Outstanding"]);

                    obj.InterestRate =
                        dr["InterestRate"] == DBNull.Value
                        ? 0
                        : Convert.ToDecimal(dr["InterestRate"]);

                    list.Add(obj);
                }
            }
        }
    }



    return list;
}


var fields = [
    { name: "Facility Name", key: "FacilityName" },
    { name: "Limit", key: "Limit" },
    { name: "Expiry Date", key: "ExpiryDate" },
    { name: "Outstanding", key: "Outstanding" },
    { name: "Interest Rate", key: "InterestRate" }
];

[
  {
    "FacilityID": 1,
    "FacilityName": "Term Loan",
    "Limit": 5000000,
    "ExpiryDate": "2026-12-31",
    "Outstanding": 2000000,
    "InterestRate": 10
  },
  {
    "FacilityID": 2,
    "FacilityName": "",
    "Limit": 0,
    "ExpiryDate": null,
    "Outstanding": 0,
    "InterestRate": 0
  }
]



using System.Web.Script.Serialization;

JavaScriptSerializer js = new JavaScriptSerializer();

string jsonData = js.Serialize(facilities);




CREATE TABLE DrawdownFacilityJson
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    DrawdownID VARCHAR(30),
    FacilityData NVARCHAR(MAX),
    CreateDate DATETIME DEFAULT GETDATE()
);


[WebMethod]
public static string SaveFacilities(
    string drawdownId,
    List<Facility> facilities)
{
    JavaScriptSerializer js =
        new JavaScriptSerializer();

    string jsonData = js.Serialize(facilities);

    string cs = ConfigurationManager
        .ConnectionStrings["DBConnection"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    {
        using (SqlCommand cmd = new SqlCommand(
            @"INSERT INTO DrawdownFacilityJson
              (DrawdownID, FacilityData)
              VALUES (@DrawdownID, @FacilityData)", con))
        {
            cmd.Parameters.Add("@DrawdownID",
                SqlDbType.VarChar, 30).Value = drawdownId;

            cmd.Parameters.Add("@FacilityData",
                SqlDbType.NVarChar, -1).Value = jsonData;

            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    return "Saved successfully";
}


Json back to list:



public class aFacility
{
    public int FacilityID { get; set; }
    public string FacilityName { get; set; }
    public decimal Limit { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public decimal Outstanding { get; set; }
    public decimal InterestRate { get; set; }
}



using System.Web.Script.Serialization;

string jsonData = ""; // JSON retrieved from SQL Server

JavaScriptSerializer js =
    new JavaScriptSerializer();

List<aFacility> facilities =
    js.Deserialize<List<aFacility>>(jsonData);

if (facilities != null)
{
    foreach (aFacility item in facilities)
    {
        string name = item.FacilityName;
        decimal limit = item.Limit;
        DateTime? expiry = item.ExpiryDate;
    }
}


List<aFacility> facilities =
    new List<aFacility>();

if (!string.IsNullOrWhiteSpace(jsonData))
{
    JavaScriptSerializer js =
        new JavaScriptSerializer();

    facilities = js.Deserialize<List<aFacility>>(jsonData)
                 ?? new List<aFacility>();
}




string jsonData = "";

using (SqlConnection con = new SqlConnection(cs))
using (SqlCommand cmd = new SqlCommand(
    @"SELECT FacilityData
      FROM DrawdownFacilityJson
      WHERE DrawdownID = @DrawdownID", con))
{
    cmd.Parameters.Add("@DrawdownID",
        SqlDbType.VarChar, 30).Value = drawdownId;

    con.Open();

    object result = cmd.ExecuteScalar();

    if (result != null && result != DBNull.Value)
        jsonData = result.ToString();
}


