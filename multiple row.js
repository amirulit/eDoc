Below is a complete example using ASP.NET Web Forms + jQuery AJAX + C# WebMethod to insert sanction details with multiple customer facility records.

It includes:

    Main fields: Branch, Sanction Reference, Sanction Date, Segment, Approval Authority.

    Repeatable section: Customer ID, Nature of Facility, Amount, Validity.

    Add More button to add multiple facility rows.

    Remove button to delete a row.

    Final Save button that sends all data as JSON to an ASP.NET static WebMethod.

1. ASPX page — SanctionEntry.aspx
aspx

<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="SanctionEntry.aspx.cs"
    Inherits="YourProject.SanctionEntry" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Sanction Entry</title>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        body {
            font-family: Arial;
            margin: 25px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(220px, 1fr));
            gap: 15px;
        }

        .field label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .field input, .field select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background: #f2f2f2;
        }

        td input, td select {
            width: 100%;
            padding: 7px;
            box-sizing: border-box;
        }

        button {
            padding: 9px 16px;
            margin-top: 15px;
            cursor: pointer;
        }

        .save-btn {
            background: #167d4a;
            color: white;
            border: none;
        }

        .remove-btn {
            background: #b42318;
            color: white;
            border: none;
        }

        #message {
            margin-top: 15px;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <h2>Sanction Entry</h2>

    <div class="form-grid">

        <div class="field">
            <label>Branch</label>
            <input type="text" id="txtBranch" required />
        </div>

        <div class="field">
            <label>Sanction Reference</label>
            <input type="text" id="txtSanctionReference" required />
        </div>

        <div class="field">
            <label>Sanction Date</label>
            <input type="date" id="txtSanctionDate" required />
        </div>

        <div class="field">
            <label>Segment</label>
            <input type="text" id="txtSegment" required />
        </div>

        <div class="field">
            <label>Approval Authority</label>
            <input type="text" id="txtApprovalAuthority" required />
        </div>

    </div>

    <h3>Facility Details</h3>

    <button type="button" id="btnAddMore">+ Add More</button>

    <table>
        <thead>
            <tr>
                <th>Customer ID</th>
                <th>Nature of Facility</th>
                <th>Amount</th>
                <th>Validity</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="facilityBody"></tbody>
    </table>

    <button type="button" id="btnSave" class="save-btn">
        Final Save
    </button>

    <div id="message" role="status"></div>

</form>

<script>
    $(function () {

        // Add one row initially
        addFacilityRow();

        $("#btnAddMore").on("click", function () {
            addFacilityRow();
        });

        function addFacilityRow() {
            var row = `
                <tr class="facility-row">
                    <td>
                        <input type="text"
                               class="customerId"
                               placeholder="Customer ID" required />
                    </td>
                    <td>
                        <input type="text"
                               class="natureOfFacility"
                               placeholder="Nature of Facility" required />
                    </td>
                    <td>
                        <input type="number"
                               class="amount"
                               placeholder="Amount"
                               min="0"
                               step="0.01" required />
                    </td>
                    <td>
                        <input type="date"
                               class="validity" required />
                    </td>
                    <td>
                        <button type="button"
                                class="remove-btn">Remove</button>
                    </td>
                </tr>`;

            $("#facilityBody").append(row);
        }

        // Remove a facility row
        $("#facilityBody").on("click", ".remove-btn", function () {
            $(this).closest("tr").remove();
        });

        // Final Save
        $("#btnSave").on("click", function () {

            var branch = $("#txtBranch").val().trim();
            var reference = $("#txtSanctionReference").val().trim();
            var sanctionDate = $("#txtSanctionDate").val();
            var segment = $("#txtSegment").val().trim();
            var authority = $("#txtApprovalAuthority").val().trim();

            if (!branch || !reference || !sanctionDate ||
                !segment || !authority) {
                alert("Please fill in all sanction details.");
                return;
            }

            var facilities = [];
            var invalid = false;

            $("#facilityBody .facility-row").each(function () {
                var row = $(this);

                var customerId = row.find(".customerId").val().trim();
                var nature = row.find(".natureOfFacility").val().trim();
                var amountText = row.find(".amount").val();
                var validity = row.find(".validity").val();
                var amount = Number(amountText);

                if (!customerId || !nature || !amountText ||
                    !validity || !Number.isFinite(amount) || amount < 0) {
                    invalid = true;
                    return false;
                }

                facilities.push({
                    CustomerId: customerId,
                    NatureOfFacility: nature,
                    Amount: amount,
                    Validity: validity
                });
            });

            if (invalid || facilities.length === 0) {
                alert("Please complete every facility row.");
                return;
            }

            var data = {
                Branch: branch,
                SanctionReference: reference,
                SanctionDate: sanctionDate,
                Segment: segment,
                ApprovalAuthority: authority,
                Facilities: facilities
            };

            $("#btnSave").prop("disabled", true);
            $("#message").text("Saving...");

            $.ajax({
                type: "POST",
                url: "SanctionEntry.aspx/SaveSanction",
                data: JSON.stringify({ request: data }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (response) {
                    var result = response.d;

                    if (result.Success) {
                        $("#message").css("color", "green")
                            .text(result.Message);

                        $("#form1")[0].reset();
                        $("#facilityBody").empty();
                        addFacilityRow();
                    } else {
                        $("#message").css("color", "red")
                            .text(result.Message);
                    }
                },

                error: function (xhr) {
                    $("#message").css("color", "red")
                        .text("Save failed. Please try again.");
                    console.error(xhr.responseText);
                },

                complete: function () {
                    $("#btnSave").prop("disabled", false);
                }
            });
        });

    });
</script>

</body>
</html>

2. C# WebMethod — SanctionEntry.aspx.cs

This example receives the main sanction data and all repeated facility rows in a single request.
csharp

using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Script.Services;

namespace YourProject
{
    public partial class SanctionEntry : System.Web.UI.Page
    {
        public class SanctionRequest
        {
            public string Branch { get; set; }
            public string SanctionReference { get; set; }
            public DateTime SanctionDate { get; set; }
            public string Segment { get; set; }
            public string ApprovalAuthority { get; set; }

            public List<FacilityRequest> Facilities { get; set; }
        }

        public class FacilityRequest
        {
            public string CustomerId { get; set; }
            public string NatureOfFacility { get; set; }
            public decimal Amount { get; set; }
            public DateTime Validity { get; set; }
        }

        public class SaveResult
        {
            public bool Success { get; set; }
            public string Message { get; set; }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static SaveResult SaveSanction(SanctionRequest request)
        {
            try
            {
                if (request == null ||
                    string.IsNullOrWhiteSpace(request.Branch) ||
                    string.IsNullOrWhiteSpace(request.SanctionReference) ||
                    string.IsNullOrWhiteSpace(request.Segment) ||
                    string.IsNullOrWhiteSpace(request.ApprovalAuthority) ||
                    request.Facilities == null ||
                    request.Facilities.Count == 0)
                {
                    return new SaveResult
                    {
                        Success = false,
                        Message = "Invalid or incomplete sanction details."
                    };
                }

                // TODO: Validate all values on the server.
                // TODO: Insert the master record and facility rows
                // using parameterized SQL inside one transaction.

                // Example:
                // SaveSanctionToDatabase(request);

                return new SaveResult
                {
                    Success = true,
                    Message = "Sanction details saved successfully."
                };
            }
            catch (Exception)
            {
                // Log the exception on the server.
                return new SaveResult
                {
                    Success = false,
                    Message = "An error occurred while saving the sanction."
                };
            }
        }
    }
}

Important: The WebMethod currently validates the basic request and returns a success response, but the actual database insertion is intentionally left as a TODO. Add your SQL transaction before using this in production.
3. Recommended database structure

Use a master table for the sanction and a detail table for the repeated facility rows.
SanctionMaster

One record per sanction

    SanctionId — Primary key

    Branch

    SanctionReference

    SanctionDate

    Segment

    ApprovalAuthority

SanctionFacility

Multiple records per sanction

    FacilityId — Primary key

    SanctionId — Foreign key

    CustomerId

    NatureOfFacility

    Amount

    Validity

When the user clicks Final Save, insert the master record first, retrieve its SanctionId, then insert all facility records using that ID, inside the same SQL transaction.
4. Example AJAX payload

For two facility rows, the request will look like this:
json

{
  "request": {
    "Branch": "Dhaka",
    "SanctionReference": "SAN-2026-001",
    "SanctionDate": "2026-10-14",
    "Segment": "Corporate",
    "ApprovalAuthority": "Head Office",
    "Facilities": [
      {
        "CustomerId": "C1001",
        "NatureOfFacility": "Term Loan",
        "Amount": 500000,
        "Validity": "2027-10-14"
      },
      {
        "CustomerId": "C1002",
        "NatureOfFacility": "Overdraft",
        "Amount": 250000,
        "Validity": "2027-04-14"
      }
    ]
  }
}

/*******************************************************/



var facilityCounter = 0;

function addFacilityRow() {

    facilityCounter++;

    var row =
        '<tr class="facility-row">' +

            '<td>' +
                '<input type="text" class="customerId" ' +
                'placeholder="Customer ID" required />' +
            '</td>' +

            '<td>' +
                '<select class="natureOfFacility" required ' +
                'style="width:200px">' +
                    '<option value="">Select Facility</option>' +
                    '<option value="Term Loan">Term Loan</option>' +
                    '<option value="Overdraft">Overdraft</option>' +
                    '<option value="Bank Guarantee">Bank Guarantee</option>' +
                    '<option value="Letter of Credit">Letter of Credit</option>' +
                '</select>' +
            '</td>' +

            '<td>' +
                '<input type="number" class="amount" ' +
                'placeholder="Amount" min="0" step="0.01" required />' +
            '</td>' +

            '<td>' +
                '<input type="date" class="validity" required />' +
            '</td>' +

            '<td>' +
                '<button type="button" class="remove-btn">Remove</button>' +
            '</td>' +

        '</tr>';

    var $row = $(row);

    $("#facilityBody").append($row);

    // Initialize Select2 for this new row
    $row.find(".natureOfFacility").select2({
        width: "200px",
        placeholder: "Select Facility",
        allowClear: true
    });
}

3. Add More and Remove handlers
javascript

$(document).ready(function () {

    addFacilityRow();

    $("#btnAddMore").on("click", function () {
        addFacilityRow();
    });

    $("#facilityBody").on("click", ".remove-btn", function () {

        var $row = $(this).closest("tr");

        // Destroy Select2 before removing the row
        $row.find(".natureOfFacility").select2("destroy");

        $row.remove();
    });

});

4. Collect the dropdown value when saving

Inside your existing AJAX save function, collect the selected value like this:
javascript

var facilities = [];

$("#facilityBody .facility-row").each(function () {

    var row = $(this);

    facilities.push({
        CustomerId: row.find(".customerId").val(),
        NatureOfFacility: row.find(".natureOfFacility").val(),
        Amount: row.find(".amount").val(),
        Validity: row.find(".validity").val()
    });

});


/**********************************/


If your Select2 dropdown is database-bound, you can load its options from SQL Server through an ASP.NET WebMethod using jQuery AJAX. Since the dropdown is inside a repeatable row, initialize Select2 every time you add a row.

Here is an example for the Nature of Facility dropdown.
1. C# WebMethod to load dropdown data

In SanctionEntry.aspx.cs, add this WebMethod. Replace the table and column names with your actual database names.
csharp

[WebMethod]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static List<FacilityOption> GetFacilityTypes()
{
    List<FacilityOption> list = new List<FacilityOption>();

    string cs = ConfigurationManager
        .ConnectionStrings["MyConnection"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    {
        string sql = @"
            SELECT FacilityId, FacilityName
            FROM dbo.FacilityType
            WHERE IsActive = 1
            ORDER BY FacilityName";

        using (SqlCommand cmd = new SqlCommand(sql, con))
        {
            con.Open();

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    list.Add(new FacilityOption
                    {
                        id = dr["FacilityId"].ToString(),
                        text = dr["FacilityName"].ToString()
                    });
                }
            }
        }
    }

    return list;
}

public class FacilityOption
{
    public string id { get; set; }
    public string text { get; set; }
}

Required namespaces:
csharp

using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;

2. Load dropdown data using jQuery AJAX

This loads the database records once and reuses them for every repeatable row.
javascript

var facilityOptions = [];

function loadFacilityTypes() {

    $.ajax({
        type: "POST",
        url: "SanctionEntry.aspx/GetFacilityTypes",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            facilityOptions = response.d;

            // Add the first row after dropdown data loads
            addFacilityRow();
        },

        error: function (xhr) {
            alert("Unable to load facility types.");
            console.log(xhr.responseText);
        }
    });
}

3. Create a repeatable row with Select2

This uses ordinary string concatenation, not template literals.
javascript

function addFacilityRow() {

    var row =
        '<tr class="facility-row">' +
            '<td><input type="text" class="customerId" required /></td>' +

            '<td>' +
                '<select class="natureOfFacility" style="width:200px" required>' +
                    '<option value="">Select Facility</option>' +
                '</select>' +
            '</td>' +

            '<td><input type="number" class="amount" min="0" step="0.01" required /></td>' +
            '<td><input type="date" class="validity" required /></td>' +

            '<td><button type="button" class="remove-btn">Remove</button></td>' +
        '</tr>';

    var $row = $(row);

    var $dropdown = $row.find(".natureOfFacility");

    // Bind database records to the dropdown
    $.each(facilityOptions, function (index, item) {
        $dropdown.append(
            $("<option></option>")
                .val(item.id)
                .text(item.text)
        );
    });

    $("#facilityBody").append($row);

    // Initialize Select2 after appending the row
    $dropdown.select2({
        width: "200px",
        placeholder: "Select Facility",
        allowClear: true
    });
}

4. Initialize Add More and Remove
javascript

$(document).ready(function () {

    loadFacilityTypes();

    $("#btnAddMore").on("click", function () {
        if (facilityOptions.length > 0) {
            addFacilityRow();
        }
    });

    $("#facilityBody").on("click", ".remove-btn", function () {
        var $row = $(this).closest("tr");

        $row.find(".natureOfFacility").select2("destroy");
        $row.remove();
    });

});

Important: Remove any earlier addFacilityRow() call from your page-ready handler. The first row is now added by loadFacilityTypes() after the database data has loaded.
5. Save the selected database ID

When collecting facility details, use:
javascript

var facilities = [];

$("#facilityBody .facility-row").each(function () {

    var row = $(this);

    facilities.push({
        CustomerId: row.find(".customerId").val(),
        NatureOfFacility: row.find(".natureOfFacility").val(),
        Amount: row.find(".amount").val(),
        Validity: row.find(".validity").val()
    });

});

/**************/



Great. So Nature of Facility will be a database-bound Select2 dropdown, while Customer ID, Amount, and Validity remain in the repeatable section.

Here is the setup specifically for that field.
1. Example database table

Assume your facility lookup table is FacilityType.
sql

CREATE TABLE dbo.FacilityType
(
    FacilityId INT PRIMARY KEY,
    FacilityName NVARCHAR(150) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

Example data:
sql

INSERT INTO dbo.FacilityType (FacilityId, FacilityName)
VALUES
(1, 'Term Loan'),
(2, 'Overdraft'),
(3, 'Bank Guarantee'),
(4, 'Letter of Credit');

If you already have a lookup table, use that instead of creating a new one.
2. ASP.NET WebMethod

Add this to SanctionEntry.aspx.cs. It returns the facility ID and name from SQL Server.
csharp

[WebMethod]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static List<FacilityOption> GetFacilityTypes()
{
    List<FacilityOption> result = new List<FacilityOption>();

    string cs = ConfigurationManager
        .ConnectionStrings["MyConnection"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(
        @"SELECT FacilityId, FacilityName
          FROM dbo.FacilityType
          WHERE IsActive = 1
          ORDER BY FacilityName", con))
    {
        con.Open();

        using (SqlDataReader dr = cmd.ExecuteReader())
        {
            while (dr.Read())
            {
                result.Add(new FacilityOption
                {
                    id = dr["FacilityId"].ToString(),
                    text = dr["FacilityName"].ToString()
                });
            }
        }
    }

    return result;
}

public class FacilityOption
{
    public string id { get; set; }
    public string text { get; set; }
}

Required namespaces:
csharp

using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;

3. jQuery AJAX and Select2

Make sure jQuery loads before the Select2 JavaScript library.

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
      rel="stylesheet" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

Use this JavaScript. It supports older JavaScript syntax without template literals.
javascript

var facilityOptions = [];

$(document).ready(function () {

    $.ajax({
        type: "POST",
        url: "SanctionEntry.aspx/GetFacilityTypes",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            facilityOptions = response.d;

            // Create the first row after loading lookup data
            addFacilityRow();
        },

        error: function (xhr) {
            console.log(xhr.responseText);
            alert("Unable to load Nature of Facility.");
        }
    });

    $("#btnAddMore").on("click", function () {
        addFacilityRow();
    });

    $("#facilityBody").on("click", ".remove-btn", function () {
        var row = $(this).closest("tr");

        row.find(".natureOfFacility").select2("destroy");
        row.remove();
    });
});

function addFacilityRow() {

    var html =
        '<tr class="facility-row">' +
            '<td><input type="text" class="customerId" required /></td>' +
            '<td>' +
                '<select class="natureOfFacility" style="width:200px" required>' +
                    '<option value="">Select Facility</option>' +
                '</select>' +
            '</td>' +
            '<td><input type="number" class="amount" min="0" step="0.01" required /></td>' +
            '<td><input type="date" class="validity" required /></td>' +
            '<td><button type="button" class="remove-btn">Remove</button></td>' +
        '</tr>';

    var row = $(html);
    var dropdown = row.find(".natureOfFacility");

    $.each(facilityOptions, function (index, item) {
        dropdown.append(
            $("<option></option>")
                .val(item.id)
                .text(item.text)
        );
    });

    $("#facilityBody").append(row);

    dropdown.select2({
        width: "200px",
        placeholder: "Select Facility",
        allowClear: true
    });
}

4. Save the selected facility ID

When preparing your AJAX save request, collect the selected ID:
javascript

var facilities = [];

$("#facilityBody .facility-row").each(function () {

    var row = $(this);

    facilities.push({
        CustomerId: row.find(".customerId").val(),
        NatureOfFacility: row.find(".natureOfFacility").val(),
        Amount: row.find(".amount").val(),
        Validity: row.find(".validity").val()
    });

});

/***************************************************/



No problem. If your JavaScript does not support template literals (backticks `), use normal string concatenation with +. This works with older JavaScript versions.

Replace your addFacilityRow() function with this version:
javascript

function addFacilityRow() {
    var row = '<tr class="facility-row">' +
        '<td>' +
            '<input type="text" class="customerId" ' +
            'placeholder="Customer ID" required />' +
        '</td>' +
        '<td>' +
            '<input type="text" class="natureOfFacility" ' +
            'placeholder="Nature of Facility" required />' +
        '</td>' +
        '<td>' +
            '<input type="number" class="amount" ' +
            'placeholder="Amount" min="0" step="0.01" required />' +
        '</td>' +
        '<td>' +
            '<input type="date" class="validity" required />' +
        '</td>' +
        '<td>' +
            '<button type="button" class="remove-btn">Remove</button>' +
        '</td>' +
    '</tr>';

    $("#facilityBody").append(row);
}

Your existing Add More and Remove event handlers can remain unchanged:
javascript

$("#btnAddMore").on("click", function () {
    addFacilityRow();
});

$("#facilityBody").on("click", ".remove-btn", function () {
    $(this).closest("tr").remove();
});

One more compatibility note

If your browser is old, you may also need to replace newer JavaScript methods such as Number.isFinite() with older alternatives.

For example, replace:
javascript

!Number.isFinite(amount)

with:
javascript

!isFinite(amount)

The rest of your jQuery AJAX request and ASP.NET WebMethod can remain the same.


/*******************************************************************************/

Sure. Below is the complete ASP.NET Web Forms + jQuery AJAX + C# WebMethod + SQL Server ADO.NET implementation, including actual database insertion.

The save process will:

    Insert the main sanction details into SanctionMaster.

    Retrieve the generated SanctionId.

    Insert all repeated customer facility rows into SanctionFacility.

    Commit everything in a single SQL transaction.

    Roll back all inserts if any operation fails.

1. Create SQL Server tables

Run this script in SQL Server Management Studio (SSMS).
sql

CREATE TABLE dbo.SanctionMaster
(
    SanctionId INT IDENTITY(1,1) PRIMARY KEY,
    Branch NVARCHAR(100) NOT NULL,
    SanctionReference NVARCHAR(100) NOT NULL,
    SanctionDate DATE NOT NULL,
    Segment NVARCHAR(100) NOT NULL,
    ApprovalAuthority NVARCHAR(150) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);

CREATE TABLE dbo.SanctionFacility
(
    FacilityId INT IDENTITY(1,1) PRIMARY KEY,
    SanctionId INT NOT NULL,
    CustomerId NVARCHAR(50) NOT NULL,
    NatureOfFacility NVARCHAR(150) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Validity DATE NOT NULL,

    CONSTRAINT FK_SanctionFacility_SanctionMaster
        FOREIGN KEY (SanctionId)
        REFERENCES dbo.SanctionMaster(SanctionId)
);

2. Add the connection string to Web.config

Replace the server, database, and authentication settings with your own.
xml

<configuration>
  <connectionStrings>
    <add name="MyConnection"
         connectionString="Data Source=YOUR_SERVER;
                           Initial Catalog=YOUR_DATABASE;
                           Integrated Security=True;
                           TrustServerCertificate=True;"
         providerName="System.Data.SqlClient" />
  </connectionStrings>
</configuration>

For SQL Server authentication, use an appropriately secured SQL login instead of Integrated Security=True.
3. Complete C# WebMethod — SanctionEntry.aspx.cs

Replace the placeholder WebMethod from the earlier example with this implementation. It uses parameterized SQL commands and a transaction to protect the master/detail inserts. 
Microsoft Learn
+1
csharp

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;

namespace YourProject
{
    public partial class SanctionEntry : System.Web.UI.Page
    {
        public class SanctionRequest
        {
            public string Branch { get; set; }
            public string SanctionReference { get; set; }
            public DateTime SanctionDate { get; set; }
            public string Segment { get; set; }
            public string ApprovalAuthority { get; set; }
            public List<FacilityRequest> Facilities { get; set; }
        }

        public class FacilityRequest
        {
            public string CustomerId { get; set; }
            public string NatureOfFacility { get; set; }
            public decimal Amount { get; set; }
            public DateTime Validity { get; set; }
        }

        public class SaveResult
        {
            public bool Success { get; set; }
            public string Message { get; set; }
            public int SanctionId { get; set; }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static SaveResult SaveSanction(SanctionRequest request)
        {
            if (request == null ||
                string.IsNullOrWhiteSpace(request.Branch) ||
                string.IsNullOrWhiteSpace(request.SanctionReference) ||
                string.IsNullOrWhiteSpace(request.Segment) ||
                string.IsNullOrWhiteSpace(request.ApprovalAuthority) ||
                request.Facilities == null ||
                request.Facilities.Count == 0)
            {
                return new SaveResult
                {
                    Success = false,
                    Message = "Please provide all required sanction details."
                };
            }

            if (request.SanctionDate == default(DateTime))
            {
                return new SaveResult
                {
                    Success = false,
                    Message = "Invalid sanction date."
                };
            }

            foreach (FacilityRequest facility in request.Facilities)
            {
                if (facility == null ||
                    string.IsNullOrWhiteSpace(facility.CustomerId) ||
                    string.IsNullOrWhiteSpace(facility.NatureOfFacility) ||
                    facility.Amount < 0 ||
                    facility.Validity == default(DateTime))
                {
                    return new SaveResult
                    {
                        Success = false,
                        Message = "Invalid facility details."
                    };
                }
            }

            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["MyConnection"]
                    .ConnectionString;

            try
            {
                using (SqlConnection con =
                    new SqlConnection(connectionString))
                {
                    con.Open();

                    using (SqlTransaction transaction =
                        con.BeginTransaction())
                    {
                        try
                        {
                            int sanctionId;

                            // Insert master record
                            string masterSql = @"
                                INSERT INTO dbo.SanctionMaster
                                (
                                    Branch,
                                    SanctionReference,
                                    SanctionDate,
                                    Segment,
                                    ApprovalAuthority
                                )
                                VALUES
                                (
                                    @Branch,
                                    @Reference,
                                    @SanctionDate,
                                    @Segment,
                                    @Authority
                                );

                                SELECT CAST(SCOPE_IDENTITY() AS INT);";

                            using (SqlCommand cmd =
                                new SqlCommand(
                                    masterSql, con, transaction))
                            {
                                cmd.Parameters.Add(
                                    "@Branch",
                                    SqlDbType.NVarChar, 100)
                                    .Value = request.Branch.Trim();

                                cmd.Parameters.Add(
                                    "@Reference",
                                    SqlDbType.NVarChar, 100)
                                    .Value =
                                        request.SanctionReference.Trim();

                                cmd.Parameters.Add(
                                    "@SanctionDate",
                                    SqlDbType.Date)
                                    .Value = request.SanctionDate.Date;

                                cmd.Parameters.Add(
                                    "@Segment",
                                    SqlDbType.NVarChar, 100)
                                    .Value = request.Segment.Trim();

                                cmd.Parameters.Add(
                                    "@Authority",
                                    SqlDbType.NVarChar, 150)
                                    .Value =
                                        request.ApprovalAuthority.Trim();

                                sanctionId = Convert.ToInt32(
                                    cmd.ExecuteScalar());
                            }

                            // Insert all facility records
                            string facilitySql = @"
                                INSERT INTO dbo.SanctionFacility
                                (
                                    SanctionId,
                                    CustomerId,
                                    NatureOfFacility,
                                    Amount,
                                    Validity
                                )
                                VALUES
                                (
                                    @SanctionId,
                                    @CustomerId,
                                    @Nature,
                                    @Amount,
                                    @Validity
                                );";

                            foreach (FacilityRequest facility
                                in request.Facilities)
                            {
                                using (SqlCommand cmd =
                                    new SqlCommand(
                                        facilitySql,
                                        con,
                                        transaction))
                                {
                                    cmd.Parameters.Add(
                                        "@SanctionId",
                                        SqlDbType.Int)
                                        .Value = sanctionId;

                                    cmd.Parameters.Add(
                                        "@CustomerId",
                                        SqlDbType.NVarChar, 50)
                                        .Value =
                                            facility.CustomerId.Trim();

                                    cmd.Parameters.Add(
                                        "@Nature",
                                        SqlDbType.NVarChar, 150)
                                        .Value =
                                            facility.NatureOfFacility.Trim();

                                    SqlParameter amountParam =
                                        cmd.Parameters.Add(
                                            "@Amount",
                                            SqlDbType.Decimal);

                                    amountParam.Precision = 18;
                                    amountParam.Scale = 2;
                                    amountParam.Value = facility.Amount;

                                    cmd.Parameters.Add(
                                        "@Validity",
                                        SqlDbType.Date)
                                        .Value = facility.Validity.Date;

                                    cmd.ExecuteNonQuery();
                                }
                            }

                            transaction.Commit();

                            return new SaveResult
                            {
                                Success = true,
                                Message =
                                    "Sanction saved successfully.",
                                SanctionId = sanctionId
                            };
                        }
                        catch
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log ex on the server using your logging framework.
                // Do not return database exception details to the client.

                return new SaveResult
                {
                    Success = false,
                    Message =
                        "Unable to save sanction details. Please try again."
                };
            }
        }
    }
}

4. Update the AJAX success handler

In your existing SanctionEntry.aspx, replace the AJAX success callback with this version to display the generated sanction ID.
javascript

success: function (response) {
    var result = response.d;

    if (result.Success) {
        $("#message")
            .css("color", "green")
            .text(
                result.Message +
                " Sanction ID: " + result.SanctionId
            );

        $("#form1")[0].reset();
        $("#facilityBody").empty();

        addFacilityRow();
    } else {
        $("#message")
            .css("color", "red")
            .text(result.Message);
    }
},

Keep the existing error and complete callbacks.
5. Test the saved data

After saving a sanction with multiple facility rows, run:
sql

SELECT *
FROM dbo.SanctionMaster
ORDER BY SanctionId DESC;

SELECT *
FROM dbo.SanctionFacility
ORDER BY FacilityId DESC;

The facility rows will share the same SanctionId as their master record.

Before production use: Also enforce field length and decimal limits on the server, verify the user's authorization to create sanctions, and ensure the database login has only the permissions it needs. If your application uses a different namespace or connection-string name, update those two values accordingly.