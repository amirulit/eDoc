<table id="tblCustomers" class="table table-bordered">
    <thead>
        <tr>
            <th>
                <input type="checkbox" id="chkSelectAll" />
            </th>
            <th>Customer ID</th>
            <th>Customer Name</th>
            <th>Loan Type</th>
            <th>Amount</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<button type="button" id="btnSave" disabled="disabled">
    Save Selected
</button>


using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Script.Services;

public class CustomerInfo
{
    public string CustomerId { get; set; }
    public string CustomerName { get; set; }
    public string LoanType { get; set; }
    public decimal Amount { get; set; }

    public string CusType { get; set; }
    public string SecurityType { get; set; }
    public string BranchCode { get; set; }
}

[WebMethod]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static List<CustomerInfo> GetCustomers()
{
    List<CustomerInfo> list = new List<CustomerInfo>();

    // Replace with database query results.
    list.Add(new CustomerInfo
    {
        CustomerId = "1001",
        CustomerName = "Customer A",
        LoanType = "Personal",
        Amount = 50000,
        CusType = "IND",
        SecurityType = "FDR",
        BranchCode = "001"
    });

    list.Add(new CustomerInfo
    {
        CustomerId = "1002",
        CustomerName = "Customer B",
        LoanType = "Business",
        Amount = 100000,
        CusType = "CORP",
        SecurityType = "LAND",
        BranchCode = "002"
    });

    return list;
}



$(document).ready(function () {

    loadCustomers();

    function loadCustomers() {

        $.ajax({
            type: "POST",
            url: "Customer.aspx/GetCustomers",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {

                var data = response.d;
                var $tbody = $("#tblCustomers tbody");

                $tbody.empty();

                $.each(data, function (i, item) {

                    var $row = $("<tr></tr>");

                    // Multiple data attributes
                    $row.attr("data-custype", item.CusType);
                    $row.attr("data-loantype", item.LoanType);
                    $row.attr("data-securitytype", item.SecurityType);
                    $row.attr("data-branchcode", item.BranchCode);

                    var $checkbox = $("<input>", {
                        type: "checkbox",
                        "class": "chkRow"
                    });

                    var $checkCell = $("<td></td>").append($checkbox);

                    $row.append($checkCell);
                    $row.append($("<td></td>").text(item.CustomerId));
                    $row.append($("<td></td>").text(item.CustomerName));
                    $row.append($("<td></td>").text(item.LoanType));
                    $row.append($("<td></td>").text(item.Amount));

                    $tbody.append($row);
                }
            },

            error: function (xhr) {
                alert("Unable to load customers.");
            }
        });
    }

    // Select all
    $("#chkSelectAll").on("change", function () {

        var checked = this.checked;

        $("#tblCustomers tbody .chkRow").prop("checked", checked);

        updateRows();
    });

    // Individual checkbox
    $("#tblCustomers").on("change", ".chkRow", function () {

        updateRows();

        var total = $("#tblCustomers tbody .chkRow").length;
        var selected = $("#tblCustomers tbody .chkRow:checked").length;

        $("#chkSelectAll").prop(
            "checked",
            total > 0 && total === selected
        );
    });

    function updateRows() {

        $("#tblCustomers tbody tr").each(function () {

            var checked = $(this).find(".chkRow").prop("checked");

            $(this).css(
                "background-color",
                checked ? "#d4edda" : ""
            );
        });

        $("#btnSave").prop(
            "disabled",
            $("#tblCustomers tbody .chkRow:checked").length === 0
        );
    }

});


$("#btnSave").on("click", function () {

    var customerTypes = [];
    var loanTypes = [];
    var securityTypes = [];
    var branchCodes = [];

    function addUnique(arr, value) {
        if ($.inArray(value, arr) === -1) {
            arr.push(value);
        }
    }

    $("#tblCustomers tbody .chkRow:checked").each(function () {

        var $row = $(this).closest("tr");

        addUnique(customerTypes, $row.attr("data-custype"));
        addUnique(loanTypes, $row.attr("data-loantype"));
        addUnique(securityTypes, $row.attr("data-securitytype"));
        addUnique(branchCodes, $row.attr("data-branchcode"));
    });

    var requestData = {
        customerTypes: customerTypes.join(","),
        loanTypes: loanTypes.join(","),
        securityTypes: securityTypes.join(","),
        branchCodes: branchCodes.join(",")
    };

    console.log(requestData);

    // Pass requestData to another ASP.NET WebMethod using AJAX.
});


*********************************


$("#btnSave").on("click", function () {

    var rowIds = [];
    var customerTypes = [];
    var loanTypes = [];
    var securityTypes = [];

    function addUnique(arr, value) {
        if (value && $.inArray(value, arr) === -1) {
            arr.push(value);
        }
    }

    $("#tblCustomers tbody .chkRow:checked").each(function () {

        var $row = $(this).closest("tr");

        // All selected row IDs
        addUnique(rowIds, $row.attr("data-id"));

        // Unique attribute values only
        addUnique(customerTypes, $row.attr("data-custype"));
        addUnique(loanTypes, $row.attr("data-loantype"));
        addUnique(securityTypes, $row.attr("data-securitytype"));
    });

    var requestData = {
        rowIds: rowIds.join(","),
        customerTypes: customerTypes.join(","),
        loanTypes: loanTypes.join(","),
        securityTypes: securityTypes.join(",")
    };

    $.ajax({
        type: "POST",
        url: "Customer.aspx/SaveSelected",
        data: JSON.stringify(requestData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            alert(response.d);
        },

        error: function (xhr) {
            alert("Error saving selected rows.");
        }
    });

});




[WebMethod]
public static string SaveSelected(
    string rowIds,
    string customerTypes,
    string loanTypes,
    string securityTypes)
{
    // Example:
    // rowIds         = "101,102,105"
    // customerTypes  = "IND,CORP"
    // loanTypes      = "Personal,Business"
    // securityTypes  = "FDR,LAND"

    // Perform server-side validation and database processing here.

    return "Data received successfully.";
}

