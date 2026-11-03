<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SecurityInfo_V2.aspx.cs"
    Inherits="SecurityInfo_V2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="table table-bordered">
            <tr>
                <th>
                    Key No.
                </th>
                <th>
                    Description
                </th>
                <th>
                    Action
                </th>
            </tr>
            <tr>
                <td>
                    7
                </td>
                <td>
                    Any other approval from competent authority
                </td>
                <td>
                    <button type="button" class="btn btn-primary btnChecklist" data-key="7">
                        Add Details
                    </button>
                </td>
            </tr>
            <tr>
                <td>
                    43
                </td>
                <td>
                    Deposit of Original Title Deed
                </td>
                <td>
                    <button type="button" class="btn btn-primary btnChecklist" data-key="43">
                        Add Details
                    </button>
                </td>
            </tr>
            <tr>
                <td>
                    44
                </td>
                <td>
                    Original/Certified Copy of Bia Deeds
                </td>
                <td>
                    <button type="button" class="btn btn-primary btnChecklist" data-key="44">
                        Add Details
                    </button>
                </td>
            </tr>
        </table>
        <div class="modal  " id="myChecklistModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            Checklist Entry - Key No: <span id="lblKeyNo"></span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal">
                            &times;
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="hdnId" value="0" />
                        <input type="hidden" id="hdnKeyNo" />
                        <!-- Dynamic input fields -->
                        <div class="row" id="divEntryFields">
                        </div>
                        <hr />
                        <button type="button" id="btnSave" class="btn btn-success">
                            Save
                        </button>
                        <button type="button" id="btnReset" class="btn btn-secondary">
                            Clear
                        </button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">
                            Close
                        </button>
                        <hr />
                        <h5>
                            Saved Information</h5>
                        <div id="divSavedRecords">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">


        var keyFields = {
            "7": [
        { name: "ApprovalAuthority", label: "Approval Authority", type: "text" },
        { name: "Expiry", label: "Expiry", type: "date" }
    ],

            "43": [
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" }
    ],

            "44": [
        { name: "DocumentType", label: "Original/Certified/Photocopy", type: "select",
            options: ["Original", "Certified", "Photocopy"]
        },
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" }
    ],

            "45": [
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" },
        { name: "SRO", label: "SRO", type: "text" },
        { name: "DeedDeliveryDate", label: "Deed Delivery Date (Expected)", type: "date" }
    ],

            "46": [
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" }
    ],

            "49": [
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" }
    ],

            "53": [
        { name: "KhatianNumber", label: "Khatian Number", type: "number" },
        { name: "DCRNumber", label: "DCR Number", type: "number" },
        { name: "DCRPageNumber", label: "DCR Page Number", type: "number" }
    ],

            "62": [
        { name: "ValuationCompany", label: "Valuation Company", type: "select",
            options: ["Company A", "Company B", "Company C"]
        },
        { name: "Date", label: "Date", type: "date" }
    ],

            "74": [
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" },
        { name: "PreviousBank", label: "Previous Bank", type: "text" },
        { name: "PreviousBranch", label: "Previous Branch", type: "text" }
    ],

            "80": [
        { name: "DocumentType", label: "Original/Certified", type: "select",
            options: ["Original", "Certified"]
        },
        { name: "DeedNumber", label: "Deed Number", type: "text" },
        { name: "Date", label: "Date", type: "date" },
        { name: "WithdrawalDate", label: "Withdrawal Date", type: "date",
            conditional: true
        }
    ],

            "82": [
        { name: "DocumentType", label: "Original/Certified", type: "select",
            options: ["Original", "Certified"]
        },
        { name: "DeedNumber", label: "Deed Number", type: "text" },
        { name: "Date", label: "Date", type: "date" },
        { name: "WithdrawalDate", label: "Withdrawal Date", type: "date",
            conditional: true
        }
    ],

            "85": [
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" },
        { name: "Amount", label: "Amount", type: "number" }
    ],

            "86": [
        { name: "DeedNumber", label: "Deed Number", type: "number" },
        { name: "Date", label: "Date", type: "date" },
        { name: "Amount", label: "Amount", type: "number" }
    ],

            "143": [
        { name: "SubmissionNumber", label: "Submission Number", type: "number" },
        { name: "Date", label: "Date", type: "date" },
        { name: "Amount", label: "Amount", type: "number" }
    ],

            "145": [
        { name: "SubmissionNumber", label: "Submission Number", type: "number" },
        { name: "Date", label: "Date", type: "date" },
        { name: "Amount", label: "Amount", type: "number" }
    ],

            "186": [
        { name: "GuarantorCompany", label: "Guarantor Company", type: "text" }
    ],

            "211": [
        { name: "CreditRating", label: "Credit Rating", type: "text" },
        { name: "RatingDate", label: "Rating Date", type: "date" }
    ]
        };
    
    
    
    
    </script>
    <script type="text/javascript">


        $(document).ready(function () {

            $(document).on("click", ".btnChecklist", function () {

                var keyNo = $(this).attr("data-key");

                $("#hdnKeyNo").val(keyNo);
                $("#lblKeyNo").text(keyNo);

                $("#hdnId").val("0");

                generateFields(keyNo);

                loadSavedRecords(keyNo);

                $("#myChecklistModal").modal("show");

            });



            function generateFields(keyNo) {

                var fields = keyFields[keyNo];

                var html = "";

                $("#hdnId").val("0");

                $.each(fields, function (i, field) {

                    html += '<div class="col-md-6 mb-3">';

                    html += '<label>' + field.label + '</label>';

                    if (field.type == "select") {

                        html += '<select class="form-control entryField" data-name="' +
                    field.name + '">';

                        html += '<option value="">Select</option>';

                        $.each(field.options, function (j, option) {
                            html += '<option value="' + option + '">' +
                        option + '</option>';
                        });

                        html += '</select>';

                    } else {

                        html += '<input type="' + field.type +
                    '" class="form-control entryField" data-name="' +
                    field.name + '" />';

                    }

                    html += '</div>';

                });

                $("#divEntryFields").html(html);

                $("#divEntryFields").on("change", "select", function () {

                    if ($(this).val() == "Certified") {
                        // Withdrawal date is applicable
                        $('[data-name="WithdrawalDate"]').closest(".col-md-6").show();
                    } else {
                        $('[data-name="WithdrawalDate"]').val("");
                        $('[data-name="WithdrawalDate"]').closest(".col-md-6").hide();
                    }

                });

            }


            $("#btnSave").click(function () {

                var details = {};

                $(".entryField").each(function () {

                    var name = $(this).attr("data-name");

                    details[name] = $(this).val();

                });

                var model = {
                    id: $("#hdnId").val(),
                    applicationId: 1001,
                    keyNo: $("#hdnKeyNo").val(),
                    detailsJson: JSON.stringify(details)
                };

                $.ajax({

                    type: "POST",

                    url: "SecurityInfo_V2.aspx/SaveChecklist",

                    data: JSON.stringify(model),

                    contentType: "application/json; charset=utf-8",

                    dataType: "json",

                    success: function (response) {

                        alert(response.d.Message);

                        if (response.d.Success) {

                            $("#hdnId").val("0");

                            generateFields($("#hdnKeyNo").val());

                            loadSavedRecords($("#hdnKeyNo").val());

                        }

                    },

                    error: function () {
                        alert("Error saving information");
                    }

                });

            });

            function loadSavedRecords(keyNo) {

                $.ajax({

                    type: "POST",

                    url: "SecurityInfo_V2.aspx/GetChecklist",

                    data: JSON.stringify({
                        applicationId: 1001,
                        keyNo: keyNo
                    }),

                    contentType: "application/json; charset=utf-8",

                    dataType: "json",

                    success: function (response) {

                        var data = response.d;

                        var html = '';

                        html += '<table class="table table-bordered table-sm">';

                        html += '<thead><tr>';
                        html += '<th>Details</th>';
                        html += '<th width="130">Action</th>';
                        html += '</tr></thead><tbody>';

                        $.each(data, function (i, item) {

                            var details = JSON.parse(item.DetailsJson);

                            html += '<tr><td>';

                            $.each(details, function (key, value) {
                                html += '<b>' + key + ':</b> ' + $('<div>').text(value || '').html() + '<br>';
                            });

                            html += '</td><td>';

                            html += '<button class="btn btn-info btn-sm btnEdit" ' + 'data-id="' + item.Id + '">Edit</button> ';

                            html += '<button type="button"  class="btn btn-danger btn-sm btnDelete" ' + 'data-id="' + item.Id + '">Delete</button>';

                            html += '</td></tr>';

                        });

                        html += '</tbody></table>';

                        $("#divSavedRecords").html(html);

                    }

                });

            }


            $(document).on("click", ".btnDelete", function (e) {

                e.preventDefault();
                e.stopPropagation();

                var id = $(this).attr("data-id");
                var keyNo = $("#hdnKeyNo").val();

                if (!confirm("Are you sure you want to delete?")) {
                    return false;
                }

                $.ajax({
                    type: "POST",
                    url: "SecurityInfo_V2.aspx/DeleteChecklist",
                    data: JSON.stringify({
                        id: id,
                        applicationId: 1001
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d.Success) {
                            loadSavedRecords(keyNo);
                        } else {
                            alert(response.d.Message);
                        }

                    },

                    error: function (xhr, status, error) {
                        console.log(xhr.responseText);
                        alert("Error deleting record");
                    }

                });

                return false;
            });

        });
          
          
    </script>
    </form>
</body>
</html>
