CREATE TABLE SecurityInfo
(
    EntryId BIGINT IDENTITY(1,1) PRIMARY KEY,
    ParentId BIGINT NOT NULL,
    KeyNo INT NOT NULL,

    Header01 NVARCHAR(500) NULL,
    Header02 NVARCHAR(500) NULL,
    Header03 NVARCHAR(500) NULL,
    Header04 NVARCHAR(500) NULL,

    CreatedBy NVARCHAR(100),
    CreatedDate DATETIME DEFAULT GETDATE()
);





CREATE TABLE SecurityInfoFieldConfig
(
    ConfigId INT IDENTITY(1,1) PRIMARY KEY,
    KeyNo INT NOT NULL,
    HeaderNo INT NOT NULL,
    FieldLabel NVARCHAR(200) NOT NULL,
    InputType VARCHAR(30) NOT NULL,
    IsRequired BIT DEFAULT 0,
    LookupGroup VARCHAR(50) NULL
);



INSERT INTO SecurityInfoFieldConfig
(KeyNo, HeaderNo, FieldLabel, InputType, IsRequired)
VALUES
(43, 1, 'Deed Number', 'number', 1),
(43, 2, 'Date', 'date', 1),

(44, 1, 'Original/Certified/Photocopy', 'select', 1),
(44, 2, 'Deed Number', 'number', 1),
(44, 3, 'Date', 'date', 1),

(45, 1, 'Deed Number', 'number', 1),
(45, 2, 'Date', 'date', 1),
(45, 3, 'SRO', 'select', 1),
(45, 4, 'Deed Delivery Date (Expected)', 'date', 0),

(53, 1, 'Khatian Number', 'number', 1),
(53, 2, 'DCR Number', 'number', 1),
(53, 3, 'DCR Page Number', 'number', 1),

(85, 1, 'Deed Number', 'number', 1),
(85, 2, 'Date', 'date', 1),
(85, 3, 'Amount', 'number', 1);


<div class="modal fade" id="infoModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 id="modalTitle">Add Information</h5>
                <button type="button"
                        class="close"
                        data-dismiss="modal">
                    &times;
                </button>
            </div>

            <div class="modal-body">

                <input type="hidden" id="parentId" value="1001" />
                <input type="hidden" id="keyNo" />

                <div id="dynamicFields"></div>

            </div>

            <div class="modal-footer">
                <button type="button"
                        class="btn btn-primary"
                        id="btnSave">
                    Save
                </button>
            </div>

        </div>
    </div>
</div>

<div id="savedInformation"></div>



var fieldConfig = {
    43: [
        { label: "Deed Number", type: "number" },
        { label: "Date", type: "date" }
    ],

    44: [
        {
            label: "Original/Certified/Photocopy",
            type: "select",
            options: ["Original", "Certified", "Photocopy"]
        },
        { label: "Deed Number", type: "number" },
        { label: "Date", type: "date" }
    ],

    45: [
        { label: "Deed Number", type: "number" },
        { label: "Date", type: "date" },
        {
            label: "SRO",
            type: "select",
            options: ["Dhaka", "Chattogram", "Other"]
        },
        { label: "Deed Delivery Date", type: "date" }
    ],

    53: [
        { label: "Khatian Number", type: "number" },
        { label: "DCR Number", type: "number" },
        { label: "DCR Page Number", type: "number" }
    ],

    85: [
        { label: "Deed Number", type: "number" },
        { label: "Date", type: "date" },
        { label: "Amount", type: "number" }
    ]
};



$(document).on("click", ".btnAdd", function () {

    var keyNo = $(this).data("key");

    $("#keyNo").val(keyNo);

    $("#modalTitle").text("Add Information - " + keyNo);

    $("#dynamicFields").empty();

    var fields = fieldConfig[keyNo];

    $.each(fields, function (i, field) {

        var html = '<div class="form-group">';

        html += '<label>' + field.label + '</label>';

        if (field.type === "select") {

            html += '<select class="form-control dynamicInput" ' +
                    'data-index="' + (i + 1) + '">';

            html += '<option value="">Select</option>';

            $.each(field.options, function (j, option) {
                html += '<option value="' + option + '">' +
                        option + '</option>';
            });

            html += '</select>';

        } else {

            html += '<input class="form-control dynamicInput" ' +
                    'type="' + field.type + '" ' +
                    'data-index="' + (i + 1) + '">';

        }

        html += '</div>';

        $("#dynamicFields").append(html);
    });

    $("#infoModal").modal("show");
});




$("#btnSave").click(function () {

    var values = ["", "", "", ""];

    var valid = true;

    $(".dynamicInput").each(function () {

        var index = parseInt($(this).data("index")) - 1;
        var value = $(this).val();

        if (value === "") {
            valid = false;
            $(this).addClass("is-invalid");
        } else {
            $(this).removeClass("is-invalid");
            values[index] = value;
        }
    });

    if (!valid) {
        alert("Please fill in required fields.");
        return;
    }

    $.ajax({
        type: "POST",
        url: "SecurityInfo.aspx/SaveInfo",
        data: JSON.stringify({
            parentId: parseInt($("#parentId").val()),
            keyNo: parseInt($("#keyNo").val()),
            header01: values[0],
            header02: values[1],
            header03: values[2],
            header04: values[3]
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            if (response.d) {

                $("#infoModal").modal("hide");

                loadInformation();
            }
        },

        error: function (xhr) {
            alert("Error saving information.");
        }
    });




});



using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;

public partial class SecurityInfo : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool SaveInfo(
        long parentId,
        int keyNo,
        string header01,
        string header02,
        string header03,
        string header04)
    {
        string cs = ConfigurationManager
                    .ConnectionStrings["DBConnection"]
                    .ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(@"
            INSERT INTO SecurityInfo
            (
                ParentId, KeyNo,
                Header01, Header02,
                Header03, Header04,
                CreatedBy
            )
            VALUES
            (
                @ParentId, @KeyNo,
                @Header01, @Header02,
                @Header03, @Header04,
                @CreatedBy
            )", con))
        {
            cmd.Parameters.AddWithValue("@ParentId", parentId);
            cmd.Parameters.AddWithValue("@KeyNo", keyNo);

            cmd.Parameters.AddWithValue("@Header01",
                (object)header01 ?? DBNull.Value);

            cmd.Parameters.AddWithValue("@Header02",
                (object)header02 ?? DBNull.Value);

            cmd.Parameters.AddWithValue("@Header03",
                (object)header03 ?? DBNull.Value);

            cmd.Parameters.AddWithValue("@Header04",
                (object)header04 ?? DBNull.Value);

            cmd.Parameters.AddWithValue("@CreatedBy", "CurrentUser");

            con.Open();

            return cmd.ExecuteNonQuery() > 0;
        }
    }
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



[WebMethod]
public static List<SecurityInfoDto> GetInfo(long parentId)
{
    var list = new List<SecurityInfoDto>();

    string cs = ConfigurationManager
                .ConnectionStrings["DBConnection"]
                .ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(@"
        SELECT EntryId, KeyNo,
               Header01, Header02,
               Header03, Header04
        FROM SecurityInfo
        WHERE ParentId = @ParentId
        ORDER BY EntryId DESC", con))
    {
        cmd.Parameters.AddWithValue("@ParentId", parentId);

        con.Open();

        using (SqlDataReader dr = cmd.ExecuteReader())
        {
            while (dr.Read())
            {
                list.Add(new SecurityInfoDto
                {
                    EntryId = Convert.ToInt64(dr["EntryId"]),
                    KeyNo = Convert.ToInt32(dr["KeyNo"]),

                    Header01 = dr["Header01"].ToString(),
                    Header02 = dr["Header02"].ToString(),
                    Header03 = dr["Header03"].ToString(),
                    Header04 = dr["Header04"].ToString()
                });
            }
        }
    }

    return list;
}



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

            var data = response.d;
            var html = "";

            html += '<table class="table table-bordered">';
            html += '<thead><tr>';
            html += '<th>Key No</th>';
            html += '<th>Details</th>';
            html += '<th>Action</th>';
            html += '</tr></thead><tbody>';

            $.each(data, function (i, item) {

                var details = [
                    item.Header01,
                    item.Header02,
                    item.Header03,
                    item.Header04
                ].filter(Boolean).join(" | ");

                html += '<tr>';
                html += '<td>' + item.KeyNo + '</td>';
                html += '<td>' + $('<div>').text(details).html() + '</td>';

                html += '<td>';
                html += '<button class="btn btn-danger btn-sm btnDelete" ' +
                        'data-id="' + item.EntryId + '">Delete</button>';
                html += '</td>';

                html += '</tr>';
            });

            html += '</tbody></table>';

            $("#savedInformation").html(html);
        }
    });
}



$(document).on("click", ".btnDelete", function () {

    if (!confirm("Are you sure you want to delete?"))
        return;

    var id = $(this).data("id");

    $.ajax({
        type: "POST",
        url: "SecurityInfo.aspx/DeleteInfo",
        data: JSON.stringify({
            entryId: id,
            parentId: parseInt($("#parentId").val())
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            if (response.d) {
                loadInformation();
            }
        }
    });

});

[WebMethod]
public static bool DeleteInfo(long entryId, long parentId)
{
    string cs = ConfigurationManager
                .ConnectionStrings["DBConnection"]
                .ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    using (SqlCommand cmd = new SqlCommand(@"
        DELETE FROM SecurityInfo
        WHERE EntryId = @EntryId
          AND ParentId = @ParentId", con))
    {
        cmd.Parameters.AddWithValue("@EntryId", entryId);
        cmd.Parameters.AddWithValue("@ParentId", parentId);

        con.Open();

        return cmd.ExecuteNonQuery() > 0;
    }
}