CREATE TABLE dbo.SecurityInfo
(
    EntryId BIGINT IDENTITY(1,1) PRIMARY KEY,
    ParentId BIGINT NOT NULL,
    KeyNo INT NOT NULL,

    Header01 NVARCHAR(500) NULL,
    Header02 NVARCHAR(500) NULL,
    Header03 NVARCHAR(500) NULL,
    Header04 NVARCHAR(500) NULL,

    CreatedBy NVARCHAR(100) NULL,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE INDEX IX_SecurityInfo_Parent_Key
ON dbo.SecurityInfo(ParentId, KeyNo);


CREATE TABLE dbo.SecurityInfoLookup
(
    LookupId INT IDENTITY(1,1) PRIMARY KEY,
    GroupName VARCHAR(50) NOT NULL,
    ValueText NVARCHAR(200) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE INDEX IX_SecurityInfoLookup_Group
ON dbo.SecurityInfoLookup(GroupName, IsActive);



INSERT INTO dbo.SecurityInfoLookup(GroupName, ValueText)
VALUES
('DocumentType', 'Original'),
('DocumentType', 'Certified'),
('DocumentCopyType', 'Original'),
('DocumentCopyType', 'Certified'),
('DocumentCopyType', 'Photocopy');


<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="SecurityInfo.aspx.cs"
    Inherits="SecurityInfo" %>

<!DOCTYPE html>
<html>
<head runat="server">

    <title>Security Information</title>

    <link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</head>

<body>

<form id="form1" runat="server">

<div class="container-fluid mt-4">

    <h4>Security Information</h4>

    <input type="hidden" id="parentId" value="1001" />

    <div id="keyButtons" class="mb-4"></div>

    <h5>Saved Information</h5>

    <div id="savedInformation"></div>

</div>

<!-- Common modal -->

<div class="modal fade" id="infoModal"
     tabindex="-1" role="dialog">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title" id="modalTitle">
                    Add Information
                </h5>

                <button type="button" class="close"
                        data-dismiss="modal">
                    &times;
                </button>

            </div>

            <div class="modal-body">

                <input type="hidden" id="keyNo" />

                <div id="dynamicFields" class="row"></div>

            </div>

            <div class="modal-footer">

                <button type="button"
                        class="btn btn-secondary"
                        data-dismiss="modal">
                    Cancel
                </button>

                <button type="button"
                        class="btn btn-primary"
                        id="btnSave">
                    Save
                </button>

            </div>

        </div>

    </div>

</div>

<script src="SecurityInfo.js"></script>

</form>

</body>
</html>


using System;
using System.Collections.Generic;

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

        list.Add(new KeyConfig {
            KeyNo = 7,
            Title = "Approval Authority",
            Fields = new List<FieldConfig> {
                F("Header01", "Approval Authority", "select", true, "ApprovalAuthority"),
                F("Header02", "Expiry", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 43,
            Title = "Deed Information",
            Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 44,
            Title = "Deed Copy Details",
            Fields = new List<FieldConfig> {
                F("Header01", "Original/Certified/Photocopy", "select", true, "DocumentCopyType"),
                F("Header02", "Deed Number", "number", true),
                F("Header03", "Date", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 45,
            Title = "Deed Registration",
            Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "SRO", "select", true, "SRO"),
                F("Header04", "Deed Delivery Date (Expected)", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 46,
            Title = "Deed Information",
            Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true)
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 49,
            Title = "Deed Information",
            Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 53,
            Title = "Khatian Information",
            Fields = new List<FieldConfig> {
                F("Header01", "Khatian Number", "number", true),
                F("Header02", "DCR Number", "number"),
                F("Header03", "DCR Page Number", "number")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 62,
            Title = "Valuation Company",
            Fields = new List<FieldConfig> {
                F("Header01", "Valuation Company", "select", true, "ValuationCompany"),
                F("Header02", "Date", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 74,
            Title = "Previous Bank",
            Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Previous Bank", "select", true, "PreviousBank"),
                F("Header04", "Previous Branch", "select", false, "PreviousBranch")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 80,
            Title = "Original/Certified",
            Fields = new List<FieldConfig> {
                F("Header01", "Original/Certified", "select", true, "DocumentType"),
                F("Header02", "Deed Number", "text"),
                F("Header03", "Date", "date"),
                F("Header04", "Withdrawal Date (if Certified Selected)", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 82,
            Title = "Original/Certified",
            Fields = new List<FieldConfig> {
                F("Header01", "Original/Certified", "select", true, "DocumentType"),
                F("Header02", "Deed Number", "text"),
                F("Header03", "Date", "date"),
                F("Header04", "Withdrawal Date (if Certified Selected)", "date")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 85,
            Title = "Deed Amount",
            Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 86,
            Title = "Deed Amount",
            Fields = new List<FieldConfig> {
                F("Header01", "Deed Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 143,
            Title = "Submission Details",
            Fields = new List<FieldConfig> {
                F("Header01", "Submission Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 145,
            Title = "Submission Details",
            Fields = new List<FieldConfig> {
                F("Header01", "Submission Number", "number", true),
                F("Header02", "Date", "date"),
                F("Header03", "Amount", "number")
            }
        });

        list.Add(new KeyConfig {
            KeyNo = 186,
            Title = "Guarantor Company",
            Fields = new List<FieldConfig> {
                F("Header01", "Guarantor Company", "text", true)
            }
        });

        list.Add(new KeyConfig {
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



using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;

public partial class SecurityInfo : System.Web.UI.Page
{
    private static string ConnectionString
    {
        get
        {
            return ConfigurationManager
                .ConnectionStrings["DBConnection"]
                .ConnectionString;
        }
    }

    // DTO for saved information

    public class SecurityInfoDto
    {
        public long EntryId { get; set; }
        public int KeyNo { get; set; }

        public string Header01 { get; set; }
        public string Header02 { get; set; }
        public string Header03 { get; set; }
        public string Header04 { get; set; }
    }

    // 1. Get all field configurations

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
                            cmd.Parameters.Add(
                                "@GroupName",
                                SqlDbType.VarChar, 50
                            ).Value = field.LookupGroup;

                            using (SqlDataReader dr =
                                cmd.ExecuteReader())
                            {
                                while (dr.Read())
                                {
                                    field.Options.Add(
                                        dr["ValueText"].ToString()
                                    );
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



private static bool IsValidLookup(
    string groupName,
    string value)
{
    using (SqlConnection con =
        new SqlConnection(ConnectionString))
    using (SqlCommand cmd = new SqlCommand(@"
        SELECT COUNT(1)
        FROM dbo.SecurityInfoLookup
        WHERE GroupName = @GroupName
          AND ValueText = @Value
          AND IsActive = 1", con))
    {
        cmd.Parameters.Add(
            "@GroupName", SqlDbType.VarChar, 50
        ).Value = groupName;

        cmd.Parameters.Add(
            "@Value", SqlDbType.NVarChar, 200
        ).Value = value;

        con.Open();

        return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
    }
}



if (field.Type == "select" &&
    !String.IsNullOrWhiteSpace(value))
{
    if (!IsValidLookup(field.LookupGroup, value))
        throw new Exception("Invalid " + field.Label);
}




var configByKey = {};
var isSaving = false;

// Page initialization
$(document).ready(function () {

    loadConfiguration();

});

// Load all 17 configurations

function loadConfiguration() {

    $.ajax({
        type: "POST",
        url: "SecurityInfo.aspx/GetConfiguration",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            var config = response.d;

            configByKey = {};

            $.each(config, function (i, item) {

                configByKey[item.KeyNo] = item;

            });

            renderKeyButtons(config);

            loadInformation();
        },

        error: function (xhr) {
            alert("Unable to load field configuration.");
        }
    });
}


// Generate Add buttons

function renderKeyButtons(config) {

    $("#keyButtons").empty();

    $.each(config, function (i, item) {

        var btn = $("<button/>", {
            type: "button",
            class: "btn btn-outline-primary btn-sm m-1 btnAdd",
            text: "Add - " + item.KeyNo
        });

        btn.attr("data-key", item.KeyNo);

        $("#keyButtons").append(btn);

    });
}


// Open modal

$(document).on("click", ".btnAdd", function () {

    var keyNo = parseInt($(this).attr("data-key"));

    var config = configByKey[keyNo];

    if (!config)
        return;

    $("#keyNo").val(keyNo);

    $("#modalTitle").text(
        config.Title + " (Key " + keyNo + ")"
    );

    $("#dynamicFields").empty();

    $.each(config.Fields, function (i, field) {

        var column = $("<div/>", {
            class: "col-md-6"
        });

        var group = $("<div/>", {
            class: "form-group"
        });

        var label = $("<label/>", {
            text: field.Label
        });

        var input;

        if (field.Type === "select") {

            input = $("<select/>", {
                class: "form-control dynamicInput"
            });

            input.append(
                $("<option/>", {
                    value: "",
                    text: "-- Select --"
                })
            );

            if (field.Options) {

                $.each(field.Options, function (j, option) {

                    input.append(
                        $("<option/>", {
                            value: option,
                            text: option
                        })
                    );

                });

            }

        } else {

            input = $("<input/>", {
                type: field.Type,
                class: "form-control dynamicInput"
            });

            if (field.Type === "number") {
                input.attr("step", "any");
            }
        }

        input.attr("data-header", field.Header);

        input.attr("data-required", field.Required);

        group.append(label);
        group.append(input);

        if (field.Required) {
            group.append(
                $("<small/>", {
                    class: "text-danger",
                    text: "Required"
                })
            );
        }

        column.append(group);

        $("#dynamicFields").append(column);

    });

    $("#infoModal").modal("show");

});


// Save information

$("#btnSave").click(function () {

    if (isSaving)
        return;

    var values = ["", "", "", ""];
    var valid = true;

    $(".dynamicInput").each(function () {

        var input = $(this);

        var header = input.attr("data-header");

        var index = parseInt(
            header.substring(6)
        ) - 1;

        var value = input.val();

        var required =
            input.attr("data-required") === "true";

        input.removeClass("is-invalid");

        if (required && !value) {

            input.addClass("is-invalid");

            valid = false;
        }

        values[index] = value || "";

    });

    if (!valid) {
        alert("Please fill in all required fields.");
        return;
    }

    isSaving = true;

    $("#btnSave").prop("disabled", true);

    $.ajax({

        type: "POST",

        url: "SecurityInfo.aspx/SaveInfo",

        data: JSON.stringify({

            parentId: parseInt($("#parentId").val()),

            keyNo: parseInt($("#keyNo").val()),

            values: values

        }),

        contentType: "application/json; charset=utf-8",

        dataType: "json",

        success: function (response) {

            if (response.d) {

                $("#infoModal").modal("hide");

                loadInformation();

            } else {

                alert("Information was not saved.");

            }

        },

        error: function (xhr) {

            var message = "Error saving information.";

            if (xhr.responseJSON &&
                xhr.responseJSON.Message) {

                message = xhr.responseJSON.Message;
            }

            alert(message);

        },

        complete: function () {

            isSaving = false;

            $("#btnSave").prop("disabled", false);

        }

    });

});


// Load saved information

function loadInformation() {

    $.ajax({

        type: "POST",

        url: "SecurityInfo.aspx/GetInfo",

        data: JSON.stringify({

            parentId: parseInt($("#parentId").val())

        }),

        contentType: "application/json; charset=utf-8",

        dataType: "json",

        success: function (response) {

            renderInformation(response.d);

        },

        error: function () {

            alert("Unable to load saved information.");

        }

    });

}


// Render saved records

function renderInformation(data) {

    var table = $("<table/>", {
        class: "table table-bordered table-striped table-sm"
    });

    var thead = $("<thead/>");

    var headerRow = $("<tr/>");

    headerRow.append("<th>Key No</th>");
    headerRow.append("<th>Field / Value</th>");
    headerRow.append("<th>Action</th>");

    thead.append(headerRow);

    table.append(thead);

    var tbody = $("<tbody/>");

    $.each(data, function (i, item) {

        var config = configByKey[item.KeyNo];

        var row = $("<tr/>");

        row.append(
            $("<td/>", {
                text: item.KeyNo
            })
        );

        var details = $("<td/>");

        if (config) {

            $.each(config.Fields, function (j, field) {

                var value = item[field.Header];

                if (value !== null &&
                    value !== undefined &&
                    value !== "") {

                    var line = $("<div/>");

                    line.append(
                        $("<strong/>", {
                            text: field.Label + ": "
                        })
                    );

                    line.append(
                        document.createTextNode(value)
                    );

                    details.append(line);
                }

            });

        }

        row.append(details);

        var action = $("<td/>");

        var deleteButton = $("<button/>", {
            type: "button",
            class: "btn btn-danger btn-sm btnDelete",
            text: "Delete"
        });

        deleteButton.attr("data-id", item.EntryId);

        action.append(deleteButton);

        row.append(action);

        tbody.append(row);

    });

    table.append(tbody);

    $("#savedInformation").empty().append(table);

}


// Delete record

$(document).on("click", ".btnDelete", function () {

    if (!confirm("Are you sure you want to delete this record?"))
        return;

    var entryId = parseInt(
        $(this).attr("data-id")
    );

    $.ajax({

        type: "POST",

        url: "SecurityInfo.aspx/DeleteInfo",

        data: JSON.stringify({

            entryId: entryId,

            parentId: parseInt($("#parentId").val())

        }),

        contentType: "application/json; charset=utf-8",

        dataType: "json",

        success: function (response) {

            if (response.d) {

                loadInformation();

            } else {

                alert("Record not found or already deleted.");

            }

        },

        error: function () {

            alert("Unable to delete record.");

        }

    });

});



<connectionStrings>
    <add name="DBConnection"
         connectionString="Data Source=YOUR_SERVER;
         Initial Catalog=YOUR_DATABASE;
         Integrated Security=True;"
         providerName="System.Data.SqlClient" />
</connectionStrings>