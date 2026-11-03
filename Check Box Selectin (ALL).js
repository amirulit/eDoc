<table id="tblCustomers" class="table table-bordered">
    <thead>
        <tr>
            <th>Select</th>
            <th>Customer ID</th>
            <th>Loan Type</th>
            <th>Security Type</th>
        </tr>
    </thead>
    <tbody>
        <tr data-custype="C001"
            data-loantype="Personal"
            data-securitytype="Mortgage">
            <td><input type="checkbox" class="rowCheck" /></td>
            <td>C001</td>
            <td>Personal</td>
            <td>Mortgage</td>
        </tr>

        <tr data-custype="C002"
            data-loantype="Business"
            data-securitytype="FDR">
            <td><input type="checkbox" class="rowCheck" /></td>
            <td>C002</td>
            <td>Business</td>
            <td>FDR</td>
        </tr>

        <tr data-custype="C003"
            data-loantype="Personal"
            data-securitytype="Land">
            <td><input type="checkbox" class="rowCheck" /></td>
            <td>C003</td>
            <td>Personal</td>
            <td>Land</td>
        </tr>
    </tbody>
</table>

<button type="button" id="btnSave">Save Selected</button>

$("#btnSave").on("click", function () {

    var selectedRows = [];

    $("#tblCustomers tbody tr").each(function () {

        var row = $(this);

        if (row.find(".rowCheck").is(":checked")) {

            selectedRows.push({
                Custype: row.attr("data-custype"),
                LoanType: row.attr("data-loantype"),
                SecurityType: row.attr("data-securitytype")
            });
        }
    });

    if (selectedRows.length === 0) {
        alert("Please select at least one row.");
        return;
    }

    $.ajax({
        type: "POST",
        url: "YourPage.aspx/SaveSelectedRows",
        data: JSON.stringify({ rows: selectedRows }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            alert(response.d);
        },

        error: function (xhr) {
            console.log(xhr.responseText);
            alert("Error saving selected rows.");
        }
    });
});



using System;
using System.Collections.Generic;
using System.Web.Services;

public partial class YourPage : System.Web.UI.Page
{
    public class SelectedRow
    {
        public string Custype { get; set; }
        public string LoanType { get; set; }
        public string SecurityType { get; set; }
    }

    [WebMethod]
    public static string SaveSelectedRows(List<SelectedRow> rows)
    {
        if (rows == null || rows.Count == 0)
        {
            return "No rows selected.";
        }

        foreach (SelectedRow item in rows)
        {
            string custype = item.Custype;
            string loanType = item.LoanType;
            string securityType = item.SecurityType;

            // Perform your database processing here.
        }

        return "Selected rows received successfully.";
    }
}

$("#btnSave").on("click", function () {

    var custypeArray = [];
    var loanTypeArray = [];
    var securityTypeArray = [];

    $("#tblCustomers tbody tr").each(function () {

        var row = $(this);

        if (row.find(".rowCheck").is(":checked")) {

            var custype = row.attr("data-custype");
            var loanType = row.attr("data-loantype");
            var securityType = row.attr("data-securitytype");

            // Add unique values only
            if (custype && !custypeArray.includes(custype)) {
                custypeArray.push(custype);
            }

            if (loanType && !loanTypeArray.includes(loanType)) {
                loanTypeArray.push(loanType);
            }

            if (securityType &&
                !securityTypeArray.includes(securityType)) {
                securityTypeArray.push(securityType);
            }
        }
    });

    // Convert arrays to comma-separated strings
    var custype = custypeArray.join(",");
    var loanType = loanTypeArray.join(",");
    var securityType = securityTypeArray.join(",");

    $.ajax({
        type: "POST",
        url: "YourPage.aspx/SaveSelectedRows",
        data: JSON.stringify({
            custype: custype,
            loanType: loanType,
            securityType: securityType
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            alert(response.d);
        },

        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
});


custypeArray      = ["C001", "C002"];
loanTypeArray     = ["Personal", "Business"];
securityTypeArray = ["Mortgage", "FDR"];



using System.Web.Services;

[WebMethod]
public static string SaveSelectedRows(
    string custype,
    string loanType,
    string securityType)
{
    // Comma-separated unique values received here

    // Example:
    // custype = "C001,C002"
    // loanType = "Personal,Business"
    // securityType = "Mortgage,FDR"

    // Perform your database processing here.

    return "Data received successfully.";
}


$("#btnSave").on("click", function () {

    var custypeArray = [];
    var loanTypeArray = [];
    var securityTypeArray = [];

    $("#tblCustomers tbody tr").each(function () {

        var row = $(this);

        if (row.find(".rowCheck").is(":checked")) {

            var custype = row.attr("data-custype");
            var loanType = row.attr("data-loantype");
            var securityType = row.attr("data-securitytype");

            // Unique Customer Types
            if (custype && custypeArray.indexOf(custype) === -1) {
                custypeArray.push(custype);
            }

            // Unique Loan Types
            if (loanType && loanTypeArray.indexOf(loanType) === -1) {
                loanTypeArray.push(loanType);
            }

            // Unique Security Types
            if (securityType &&
                securityTypeArray.indexOf(securityType) === -1) {
                securityTypeArray.push(securityType);
            }
        }
    });

    if (custypeArray.length === 0) {
        alert("Please select at least one row.");
        return;
    }

    // Convert arrays to comma-separated strings
    var custype = custypeArray.join(",");
    var loanType = loanTypeArray.join(",");
    var securityType = securityTypeArray.join(",");

    $.ajax({
        type: "POST",
        url: "YourPage.aspx/SaveSelectedRows",
        data: JSON.stringify({
            custype: custype,
            loanType: loanType,
            securityType: securityType
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            alert(response.d);
        },

        error: function (xhr) {
            console.log(xhr.responseText);
            alert("Error occurred.");
        }
    });

});



[System.Web.Services.WebMethod]
public static string SaveSelectedRows(
    string custype,
    string loanType,
    string securityType)
{
    string[] customerTypes = string.IsNullOrEmpty(custype)
        ? new string[0]
        : custype.Split(',');

    string[] loanTypes = string.IsNullOrEmpty(loanType)
        ? new string[0]
        : loanType.Split(',');

    string[] securityTypes = string.IsNullOrEmpty(securityType)
        ? new string[0]
        : securityType.Split(',');

    // Process arrays or pass them to your business logic.

    return "Success";
}



/*************ALL**************/



<table id="tblCustomers" class="table table-bordered">
    <thead>
        <tr>
            <th>
                <input type="checkbox" id="chkSelectAll" />
                Select All
            </th>
            <th>Customer ID</th>
            <th>Loan Type</th>
            <th>Security Type</th>
        </tr>
    </thead>
    <tbody>
        <tr data-custype="C001"
            data-loantype="Personal"
            data-securitytype="Mortgage">
            <td><input type="checkbox" class="rowCheck" /></td>
            <td>C001</td>
            <td>Personal</td>
            <td>Mortgage</td>
        </tr>

        <tr data-custype="C002"
            data-loantype="Business"
            data-securitytype="FDR">
            <td><input type="checkbox" class="rowCheck" /></td>
            <td>C002</td>
            <td>Business</td>
            <td>FDR</td>
        </tr>

        <tr data-custype="C003"
            data-loantype="Personal"
            data-securitytype="Land">
            <td><input type="checkbox" class="rowCheck" /></td>
            <td>C003</td>
            <td>Personal</td>
            <td>Land</td>
        </tr>
    </tbody>
</table>

<button type="button" id="btnSave" disabled>Save</button>

#tblCustomers tbody tr.row-selected {
    background-color: #d4edda !important;
}

$(document).ready(function () {

    // Initially disable Save
    $("#btnSave").prop("disabled", true);

    // Update row colors, Select All state, and Save button
    function updateSelection() {

        var total = $("#tblCustomers tbody .rowCheck").length;

        var selected = $("#tblCustomers tbody .rowCheck:checked").length;

        // Highlight selected rows
        $("#tblCustomers tbody tr").each(function () {
            var chk = $(this).find(".rowCheck");

            $(this).toggleClass(
                "row-selected",
                chk.is(":checked")
            );
        });

        // Select All checkbox state
        $("#chkSelectAll").prop(
            "checked",
            total > 0 && selected === total
        );

        // Activate Save if at least one row is selected
        $("#btnSave").prop("disabled", selected === 0);
    }

    // Select All / Deselect All
    $("#chkSelectAll").on("change", function () {

        var checked = $(this).is(":checked");

        $("#tblCustomers tbody .rowCheck").prop(
            "checked",
            checked
        );

        updateSelection();
    });

    // Individual row checkbox
    $("#tblCustomers tbody").on(
        "change",
        ".rowCheck",
        function () {
            updateSelection();
        }
    );

    // Save selected rows
    $("#btnSave").on("click", function () {

        var custypeArray = [];
        var loanTypeArray = [];
        var securityTypeArray = [];

        $("#tblCustomers tbody tr").each(function () {

            var row = $(this);

            if (row.find(".rowCheck").is(":checked")) {

                var custype = row.attr("data-custype");
                var loanType = row.attr("data-loantype");
                var securityType = row.attr("data-securitytype");

                if (custype &&
                    custypeArray.indexOf(custype) === -1) {
                    custypeArray.push(custype);
                }

                if (loanType &&
                    loanTypeArray.indexOf(loanType) === -1) {
                    loanTypeArray.push(loanType);
                }

                if (securityType &&
                    securityTypeArray.indexOf(securityType) === -1) {
                    securityTypeArray.push(securityType);
                }
            }
        });

        var custype = custypeArray.join(",");
        var loanType = loanTypeArray.join(",");
        var securityType = securityTypeArray.join(",");

        $.ajax({
            type: "POST",
            url: "YourPage.aspx/SaveSelectedRows",
            data: JSON.stringify({
                custype: custype,
                loanType: loanType,
                securityType: securityType
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {
                alert(response.d);
            },

            error: function (xhr) {
                console.log(xhr.responseText);
                alert("Error saving data.");
            }
        });
    });

    // Initialize state
    updateSelection();

});


