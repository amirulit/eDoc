CREATE TABLE dbo.PK_Details
(
    RecordId BIGINT IDENTITY(1,1) PRIMARY KEY,
    PKNo INT NOT NULL,
    Value01 NVARCHAR(500) NULL,
    Value02 NVARCHAR(500) NULL,
    Value03 NVARCHAR(500) NULL,
    Value04 NVARCHAR(500) NULL,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.PK_Lookup
(
    LookupId INT IDENTITY(1,1) PRIMARY KEY,
    LookupType VARCHAR(50) NOT NULL,
    LookupValue NVARCHAR(250) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

CREATE INDEX IX_PK_Details_PKNo
ON dbo.PK_Details(PKNo);


INSERT INTO dbo.PK_Lookup (LookupType, LookupValue)
VALUES
('APPROVAL', 'Board'),
('APPROVAL', 'Managing Director'),
('APPROVAL', 'Head Office'),

('ORIGINAL_TYPE', 'Original'),
('ORIGINAL_TYPE', 'Certified'),
('ORIGINAL_TYPE', 'Photocopy');



<div class="modal fade" id="detailModal">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <div class="modal-header">
                <h5>Document Details</h5>
                <button type="button" class="close"
                    data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body">

                <div class="form-group">
                    <label>Primary Key No.</label>
                    <select id="ddlPK" class="form-control">
                        <option value="">Select Primary Key</option>
                        <option value="7">7 - Approval Authority</option>
                        <option value="43">43 - Deed Number</option>
                        <option value="44">44 - Original/Certified/Photocopy</option>
                        <option value="45">45 - Deed Number</option>
                        <option value="46">46 - Deed Number</option>
                        <option value="49">49 - Deed Number</option>
                        <option value="53">53 - Khatian Number</option>
                        <option value="62">62 - Valuation Company</option>
                        <option value="74">74 - Deed Number</option>
                        <option value="80">80 - Original/Certified</option>
                        <option value="82">82 - Original/Certified</option>
                        <option value="85">85 - Deed Number</option>
                        <option value="86">86 - Deed Number</option>
                        <option value="143">143 - Submission Number</option>
                        <option value="145">145 - Submission Number</option>
                        <option value="186">186 - Guarantor Company</option>
                        <option value="211">211 - ECAI Name</option>
                    </select>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered"
                           id="tblInput">
                        <thead>
                            <tr id="inputHeader"></tr>
                        </thead>
                        <tbody>
                            <tr id="inputRow"></tr>
                        </tbody>
                    </table>
                </div>

                <div class="text-right mb-3">
                    <button type="button" id="btnAdd"
                            class="btn btn-primary" disabled>
                        Add Record
                    </button>
                </div>

                <hr />

                <h6>Saved Records</h6>

                <div id="savedRecords"></div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>



public class FieldInfo
{
    public string Name { get; set; }
    public string Type { get; set; }
    public string LookupType { get; set; }
}

public class RecordInfo
{
    public long RecordId { get; set; }
    public int PKNo { get; set; }
    public string Value01 { get; set; }
    public string Value02 { get; set; }
    public string Value03 { get; set; }
    public string Value04 { get; set; }
}

public static List<FieldInfo> GetFieldConfig(int pk)
{
    List<FieldInfo> fields = new List<FieldInfo>();

    Action<string, string, string> add =
        (name, type, lookup) =>
        {
            fields.Add(new FieldInfo
            {
                Name = name,
                Type = type,
                LookupType = lookup
            });
        };

    switch (pk)
    {
        case 7:
            add("Approval Authority", "select", "APPROVAL");
            add("Expiry", "date", "");
            break;

        case 43:
            add("Deed Number", "number", "");
            add("Date", "date", "");
            break;

        case 44:
            add("Original/Certified/Photocopy",
                "select", "ORIGINAL_TYPE");
            add("Deed Number", "number", "");
            add("Date", "date", "");
            break;

        case 45:
            add("Deed Number", "number", "");
            add("Date", "date", "");
            add("SRO", "select", "SRO");
            add("Deed Delivery Date", "date", "");
            break;

        case 46:
        case 49:
            add("Deed Number", "number", "");
            add("Date", "date", "");
            break;

        case 53:
            add("Khatian Number", "number", "");
            add("DCR Number", "number", "");
            add("DCR Page Number", "number", "");
            break;

        case 62:
            add("Valuation Company", "select", "VALUATION");
            add("Date", "date", "");
            break;

        case 74:
            add("Deed Number", "number", "");
            add("Date", "date", "");
            add("Previous Bank", "select", "BANK");
            add("Previous Branch", "text", "");
            break;

        case 80:
        case 82:
            add("Original/Certified", "select", "ORIGINAL_TYPE");
            add("Deed Number", "number", "");
            add("Date", "date", "");
            add("Withdrawal Date", "date", "");
            break;

        case 85:
        case 86:
            add("Deed Number", "number", "");
            add("Date", "date", "");
            add("Amount", "number", "");
            break;

        case 143:
        case 145:
            add("Submission Number", "number", "");
            add("Date", "date", "");
            add("Amount", "number", "");
            break;

        case 186:
            add("Guarantor Company", "text", "");
            break;

        case 211:
            add("ECAI Name", "select", "ECAI");
            add("Expiry", "date", "");
            add("Rating", "select", "RATING");
            break;
    }

    return fields;
}

<connectionStrings>
  <add name="constr"
       connectionString="Data Source=.;Initial Catalog=YourDB;Integrated Security=True"
       providerName="System.Data.SqlClient"/>
</connectionStrings>


using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;



[WebMethod(EnableSession = true)]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static List<FieldInfo> LoadFields(int pk)
{
    return GetFieldConfig(pk);
}


[WebMethod(EnableSession = true)]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static List<string> LoadLookup(string lookupType)
{
    List<string> result = new List<string>();

    string cs = ConfigurationManager
        .ConnectionStrings["constr"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(@"
        SELECT LookupValue
        FROM dbo.PK_Lookup
        WHERE LookupType = @Type
          AND IsActive = 1
        ORDER BY LookupValue", con))
    {
        cmd.Parameters.Add("@Type", SqlDbType.VarChar, 50)
            .Value = lookupType;

        con.Open();

        using (SqlDataReader dr = cmd.ExecuteReader())
        {
            while (dr.Read())
                result.Add(Convert.ToString(dr["LookupValue"]));
        }
    }

    return result;
}

[WebMethod(EnableSession = true)]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static bool SaveRecord(int pk, string[] values)
{
    List<FieldInfo> fields = GetFieldConfig(pk);

    if (fields.Count == 0 ||
        values == null ||
        values.Length != fields.Count)
        throw new Exception("Invalid input.");

    for (int i = 0; i < values.Length; i++)
    {
        if (String.IsNullOrWhiteSpace(values[i]))
            throw new Exception(fields[i].Name + " is required.");
    }

    string[] dbValues = new string[4];

    for (int i = 0; i < 4; i++)
        dbValues[i] = i < values.Length ? values[i] : null;

    string cs = ConfigurationManager
        .ConnectionStrings["constr"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(@"
        INSERT INTO dbo.PK_Details
        (PKNo, Value01, Value02, Value03, Value04)
        VALUES
        (@PK, @V1, @V2, @V3, @V4)", con))
    {
        cmd.Parameters.Add("@PK", SqlDbType.Int).Value = pk;

        for (int i = 0; i < 4; i++)
        {
            cmd.Parameters.Add("@V" + (i + 1),
                SqlDbType.NVarChar, 500).Value =
                (object)dbValues[i] ?? DBNull.Value;
        }

        con.Open();
        cmd.ExecuteNonQuery();
    }

    return true;
}

[WebMethod(EnableSession = true)]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static List<RecordInfo> LoadRecords(int pk)
{
    List<RecordInfo> result = new List<RecordInfo>();

    string cs = ConfigurationManager
        .ConnectionStrings["constr"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(@"
        SELECT RecordId, PKNo,
               Value01, Value02, Value03, Value04
        FROM dbo.PK_Details
        WHERE PKNo = @PK
        ORDER BY RecordId DESC", con))
    {
        cmd.Parameters.Add("@PK", SqlDbType.Int).Value = pk;

        con.Open();

        using (SqlDataReader dr = cmd.ExecuteReader())
        {
            while (dr.Read())
            {
                result.Add(new RecordInfo
                {
                    RecordId = Convert.ToInt64(dr["RecordId"]),
                    PKNo = Convert.ToInt32(dr["PKNo"]),
                    Value01 = Convert.ToString(dr["Value01"]),
                    Value02 = Convert.ToString(dr["Value02"]),
                    Value03 = Convert.ToString(dr["Value03"]),
                    Value04 = Convert.ToString(dr["Value04"])
                });
            }
        }
    }

    return result;
}

[WebMethod(EnableSession = true)]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static bool DeleteRecord(long recordId)
{
    string cs = ConfigurationManager
        .ConnectionStrings["constr"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(@"
        DELETE FROM dbo.PK_Details
        WHERE RecordId = @ID", con))
    {
        cmd.Parameters.Add("@ID", SqlDbType.BigInt).Value = recordId;

        con.Open();

        return cmd.ExecuteNonQuery() > 0;
    }
}


var currentFields = [];

$('#ddlPK').change(function () {

    var pk = $(this).val();

    $('#inputHeader').empty();
    $('#inputRow').empty();
    $('#savedRecords').empty();
    $('#btnAdd').prop('disabled', true);

    if (!pk) return;

    $.ajax({
        type: "POST",
        url: "YourPage.aspx/LoadFields",
        data: JSON.stringify({ pk: parseInt(pk, 10) }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (res) {

            currentFields = res.d;

            $.each(currentFields, function (i, field) {

                $('#inputHeader').append(
                    $('<th>').text(field.Name)
                );

                var input;

                if (field.Type === 'select') {

                    input = $('<select class="form-control">')
                        .append('<option value="">Select</option>');

                    $.ajax({
                        type: "POST",
                        url: "YourPage.aspx/LoadLookup",
                        data: JSON.stringify({
                            lookupType: field.LookupType
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,

                        success: function (r) {
                            $.each(r.d, function (j, value) {
                                input.append(
                                    $('<option>').val(value).text(value)
                                );
                            });
                        }
                    });

                } else {

                    input = $('<input class="form-control">')
                        .attr('type', field.Type === 'date'
                            ? 'date'
                            : field.Type === 'number'
                                ? 'number'
                                : 'text');
                }

                $('#inputRow').append(
                    $('<td>').append(input)
                );
            });

            $('#btnAdd').prop('disabled', false);

            loadSavedRecords(pk);
        }
    });

$('#btnAdd').click(function () {

    var pk = parseInt($('#ddlPK').val(), 10);
    var values = [];
    var valid = true;

    $('#inputRow input, #inputRow select').each(function (i) {

        var value = $(this).val();

        if (!value) {
            alert(currentFields[i].Name + ' is required.');
            valid = false;
            return false;
        }

        values.push(value);
    });

    if (!valid) return;

    $.ajax({
        type: "POST",
        url: "YourPage.aspx/SaveRecord",
        data: JSON.stringify({
            pk: pk,
            values: values
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (res) {

            if (res.d) {

                $('#inputRow input, #inputRow select').val('');

                loadSavedRecords(pk);
            }
        },

        error: function (xhr) {
            alert(xhr.responseJSON &&
                  xhr.responseJSON.Message
                  ? xhr.responseJSON.Message
                  : 'Unable to save record.');
        }
    });
});




});



function loadSavedRecords(pk) {

    $.ajax({
        type: "POST",
        url: "YourPage.aspx/LoadRecords",
        data: JSON.stringify({ pk: parseInt(pk, 10) }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (res) {

            var html = '';

            if (res.d.length === 0) {
                $('#savedRecords').html(
                    '<p>No saved records.</p>'
                );
                return;
            }

            html += '<div class="table-responsive">';
            html += '<table class="table table-bordered table-sm">';
            html += '<thead><tr>';

            $.each(currentFields, function (i, f) {
                html += '<th>' + $('<div>').text(f.Name).html() + '</th>';
            });

            html += '<th>Action</th></tr></thead><tbody>';

            $.each(res.d, function (i, r) {

                html += '<tr>';

                for (var j = 1; j <= currentFields.length; j++) {

                    var value = r['Value0' + j] || '';

                    html += '<td>' +
                        $('<div>').text(value).html() +
                        '</td>';
                }

                html += '<td>';
                html += '<button type="button" ';
                html += 'class="btn btn-danger btn-sm btnDelete" ';
                html += 'data-id="' + r.RecordId + '">';
                html += 'Delete</button></td>';

                html += '</tr>';
            });

            html += '</tbody></table></div>';

            $('#savedRecords').html(html);
        }
    });
}