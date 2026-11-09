<div class="modal fade" id="infoModal" tabindex="-1">

    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle"></h5>

                <button type="button" class="close"
                        data-dismiss="modal">
                    &times;
                </button>
            </div>

            <!-- Input fields -->
            <div class="modal-body">

                <input type="hidden" id="keyNo" />

                <div id="dynamicFields" class="row"></div>

            </div>

            <!-- Saved records inside footer -->
            <div class="modal-footer d-block">

                <div class="mb-3">

                    <h6 class="border-bottom pb-2">
                        Saved Information
                    </h6>

                    <div id="modalSavedData">
                        Loading...
                    </div>

                </div>

                <div class="text-right">

                    <button type="button"
                            class="btn btn-primary"
                            id="btnSave">
                        Save
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

</div>


INSERT INTO dbo.SecurityInfoLookup
(GroupName, ValueText)
VALUES
('ApprovalAuthority', 'Bangladesh Bank'),
('ApprovalAuthority', 'Other Authority'),

('SRO', 'Dhaka'),
('SRO', 'Gazipur'),
('SRO', 'Narayanganj'),

('ValuationCompany', 'Valuation Company A'),
('ValuationCompany', 'Valuation Company B'),

('PreviousBank', 'Bank A'),
('PreviousBank', 'Bank B'),

('PreviousBranch', 'Main Branch'),
('PreviousBranch', 'Gulshan Branch'),

('ECAI', 'CRISL'),
('ECAI', 'Credit Rating Agency of Bangladesh'),

('Rating', 'AAA'),
('Rating', 'AA'),
('Rating', 'A'),
('Rating', 'BBB'),

('DocumentType', 'Original'),
('DocumentType', 'Certified'),

('DocumentCopyType', 'Original'),
('DocumentCopyType', 'Certified'),
('DocumentCopyType', 'Photocopy');




[WebMethod]
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
                if (field.Type != "select")
                    continue;

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

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            field.Options.Add(
                                dr["ValueText"].ToString()
                            );
                        }
                    }
                }
            }
        }
    }

    return config;
}





// Open modal
$(document).on("click", ".btnAdd", function () {

    var keyNo = parseInt($(this).attr("data-key"));

    var config = configByKey[keyNo];

    if (!config) return;

    $("#keyNo").val(keyNo);

    $("#modalTitle").text(config.Title);

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

            $.each(field.Options || [], function (j, option) {

                input.append(
                    $("<option/>", {
                        value: option,
                        text: option
                    })
                );

            });

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

        column.append(group);

        $("#dynamicFields").append(column);

    });

    // Load only this category's records
    $("#modalSavedData").html("Loading...");

    $("#infoModal").modal("show");

    loadModalSavedData(keyNo);

});


// Load records into modal footer
function loadModalSavedData(keyNo) {

    $.ajax({

        type: "POST",

        url: "SecurityInfo.aspx/GetInfo",

        data: JSON.stringify({

            parentId: parseInt($("#parentId").val()),

            keyNo: keyNo

        }),

        contentType: "application/json; charset=utf-8",

        dataType: "json",

        success: function (response) {

            renderModalSavedData(response.d, keyNo);

        },

        error: function () {

            $("#modalSavedData").text(
                "Unable to load saved information."
            );

        }

    });

}


// Display saved records without empty headers
function renderModalSavedData(data, keyNo) {

    var config = configByKey[keyNo];

    var container = $("#modalSavedData");

    container.empty();

    if (!data || data.length === 0) {

        container.text("No records found.");

        return;
    }

    $.each(data, function (i, item) {

        var card = $("<div/>", {
            class: "border rounded p-2 mb-2"
        });

        var top = $("<div/>", {
            class: "d-flex justify-content-between align-items-center"
        });

        top.append(
            $("<strong/>", {
                text: "Record " + (i + 1)
            })
        );

        var del = $("<button/>", {
            type: "button",
            class: "btn btn-danger btn-sm btnDelete",
            text: "Delete"
        });

        del.attr("data-id", item.EntryId);
        del.attr("data-key", keyNo);

        top.append(del);

        card.append(top);

        $.each(config.Fields, function (j, field) {

            var value = item[field.Header];

            if (value !== null &&
                value !== undefined &&
                value !== "") {

                var line = $("<div/>", {
                    class: "small mt-1"
                });

                line.append(
                    $("<strong/>", {
                        text: field.Label + ": "
                    })
                );

                line.append(
                    document.createTextNode(value)
                );

                card.append(line);
            }

        });

        container.append(card);

    });

}


var isSaving = false;

$("#btnSave").click(function () {

    if (isSaving) return;

    var values = ["", "", "", ""];
    var valid = true;

    $(".dynamicInput").each(function () {

        var input = $(this);

        var header = input.attr("data-header");

        var index = parseInt(header.substring(6)) - 1;

        var value = input.val() || "";

        if (input.attr("data-required") === "true" &&
            value === "") {

            input.addClass("is-invalid");

            valid = false;

        } else {

            input.removeClass("is-invalid");

        }

        values[index] = value;

    });

    if (!valid) {

        alert("Please enter required fields.");

        return;
    }

    isSaving = true;

    $("#btnSave").prop("disabled", true);

    var keyNo = parseInt($("#keyNo").val());

    $.ajax({

        type: "POST",

        url: "SecurityInfo.aspx/SaveInfo",

        data: JSON.stringify({

            parentId: parseInt($("#parentId").val()),

            keyNo: keyNo,

            values: values

        }),

        contentType: "application/json; charset=utf-8",

        dataType: "json",

        success: function (response) {

            if (response.d) {

                // Clear inputs after successful insert
                $(".dynamicInput").val("");

                // Keep modal open and refresh footer
                loadModalSavedData(keyNo);

            }

        },

        error: function (xhr) {

            alert("Unable to save information.");

        },

        complete: function () {

            isSaving = false;

            $("#btnSave").prop("disabled", false);

        }

    });

});

$(document).on("click", ".btnDelete", function () {

    if (!confirm("Delete this record?"))
        return;

    var entryId = parseInt($(this).attr("data-id"));

    var keyNo = parseInt($(this).attr("data-key"));

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

                loadModalSavedData(keyNo);

            }

        },

        error: function () {

            alert("Unable to delete record.");

        }

    });

});





[WebMethod]
public static List<SecurityInfoDto> GetInfo(
    long parentId,
    int keyNo)
{
    List<SecurityInfoDto> list =
        new List<SecurityInfoDto>();

    using (SqlConnection con =
        new SqlConnection(ConnectionString))
    using (SqlCommand cmd = new SqlCommand(@"
        SELECT EntryId, KeyNo,
               Header01, Header02,
               Header03, Header04
        FROM dbo.SecurityInfo
        WHERE ParentId = @ParentId
          AND KeyNo = @KeyNo
        ORDER BY EntryId DESC", con))
    {
        cmd.Parameters.Add(
            "@ParentId", SqlDbType.BigInt
        ).Value = parentId;

        cmd.Parameters.Add(
            "@KeyNo", SqlDbType.Int
        ).Value = keyNo;

        con.Open();

        using (SqlDataReader dr = cmd.ExecuteReader())
        {
            while (dr.Read())
            {
                list.Add(new SecurityInfoDto
                {
                    EntryId = Convert.ToInt64(dr["EntryId"]),
                    KeyNo = Convert.ToInt32(dr["KeyNo"]),

                    Header01 = ReadValue(dr, "Header01"),
                    Header02 = ReadValue(dr, "Header02"),
                    Header03 = ReadValue(dr, "Header03"),
                    Header04 = ReadValue(dr, "Header04")
                });
            }
        }
    }

    return list;
}