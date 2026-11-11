
$(document).ready(function () {


    LoadNextRefNo();
    loadCustomerCodes();
    loadLoanNatures();


    function LoadNextRefNo() {

        $.ajax({
            type: "POST",
            url: "SanctionUpload_V4.aspx/LoadNextRefNo",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {
                $('#ContentPlaceHolder1_txtEdocId').val(response.d);

                //$('#' + edocTextBoxId).val(response.d);


            },

            error: function (xhr, status, error) {
                console.log(error);
                alert("Unable to generate eDoc reference number.");
            }
        });

    }

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


});