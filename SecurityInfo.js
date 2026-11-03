

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
