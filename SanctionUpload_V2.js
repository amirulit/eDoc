


$(document).ready(function () {

    loadCustomerCodes();
    loadLoanNatures();

    function loadCustomerCodes() {
        $.ajax({
            type: "POST",
            url: "SanctionUpload_V4.aspx/GetCustomerCodes",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {
                var ddl = $("#ddlCustomerCode");
                ddl.empty();
                ddl.append(new Option("-- Select Customer --", ""));

                $.each(response.d, function (i, item) {
                    ddl.append(new Option(item.Text, item.Value));
                });
            },

            error: function (xhr) {
                console.error(xhr.responseText);
                alert("Unable to load customer codes.");
            }
        });
    }

    function loadLoanNatures() {
        $.ajax({
            type: "POST",
            url: "SanctionUpload_V4.aspx/GetLoanNatures",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {
                var ddl = $("#ddlLoanNature");
                ddl.empty();
                ddl.append(new Option("-- Select Loan Nature --", ""));

                $.each(response.d, function (i, item) {
                    ddl.append(new Option(item.Text, item.Value));
                });
            },

            error: function (xhr) {
                console.error(xhr.responseText);
                alert("Unable to load loan natures.");
            }
        });
    }

    // Continue with your existing Add, Remove and Save All code here.



    var loans = [];

    // Add a loan row
    $("#btnAdd").on("click", function () {




        var customerCode = $.trim($("#ddlCustomerCode").val());
        var loanNature = $("#ddlLoanNature").val();
        var amount = $("#txtAmount").val();
        var validity = $("#txtValidity").val();


        //alert(customerCode + '-' + loanNature + '-' + amount + '-' + validity);

        if (!customerCode || !loanNature || !amount || !validity) {
            alert("Please fill in all fields.");
            return;
        }

        if (!Number.isFinite(Number(amount)) || Number(amount) <= 0) {
            alert("Please enter a valid amount greater than zero.");
            return;
        }

        loans.push({
            CustomerCode: customerCode,
            LoanNature: loanNature,
            Amount: Number(amount),
            Validity: validity
        });

        renderTable();

        // Clear fields after adding
        $("#ddlCustomerCode").val("");
        $("#ddlLoanNature").val("");
        $("#txtAmount").val("");
        $("#txtValidity").val("");
        $("#txtCustomerCode").focus();



    });


    // Render all rows safely
    function renderTable() {

        var tbody = $("#tblLoans tbody");
        tbody.empty();

        $.each(loans, function (index, loan) {

            var tr = $("<tr>");

            $("<td>").text(index + 1).appendTo(tr);
            $("<td>").text(loan.CustomerCode).appendTo(tr);
            $("<td>").text(loan.LoanNature).appendTo(tr);
            $("<td>").text(loan.Amount.toFixed(2)).appendTo(tr);
            $("<td>").text(loan.Validity).appendTo(tr);

            var removeButton = $("<button>", {
                type: "button",
                class: "btn btn-danger btn-sm",
                text: "Remove"
            });

            removeButton.on("click", function () {
                loans.splice(index, 1);
                renderTable();
            });

            $("<td>").append(removeButton).appendTo(tr);
            tbody.append(tr);
        });
    }



    // Save all rows through ASP.NET WebMethod
    $("#btnSaveAll").on("click", function () {

        if (loans.length === 0) {
            alert("Please add at least one loan.");
            return;
        }

        var button = $(this);
        button.prop("disabled", true);
        $("#lblMessage").text("Saving...");

        $.ajax({
            type: "POST",
            url: "SanctionUpload_V4.aspx/SaveAllLoans",
            data: JSON.stringify({ loans: loans }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {

                var result = response.d;

                if (result && result.Success) {
                    alert(result.Message);

                    loans = [];
                    renderTable();
                    $("#lblMessage").text(result.Message);
                } else {
                    $("#lblMessage").text(
                        result ? result.Message : "Unable to save."
                    );
                }
            },

            error: function (xhr) {
                console.error(xhr.responseText);
                $("#lblMessage").text("Error saving loan records.");
            },

            complete: function () {
                button.prop("disabled", false);
            }
        });
    });





});