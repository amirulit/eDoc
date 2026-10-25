
$(document).ready(function () {

    var cusList = [];
    var loanNatureList = [];

    loadDropdownData();

    function loadDropdownData() {
        $.ajax({
            type: "POST",
            url: "SanctionUpload_V3.aspx/GetDropdownData",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {

                cusList = response.d.cusList;
                loanNatureList = response.d.loanNatureList;

                // Both lists are now available
                addFacilityRow();
            },

            error: function (xhr, status, error) {
                alert("Unable to load dropdown data.");
                console.error(xhr.responseText);
            }
        });
    }

    //addFacilityRow();


    var facilityCounter = 1;

    function addFacilityRow() {

        facilityCounter++;

        var row =
        '<tr class="facility-row"><td class="sl-no"></td>' +

            '<td>' +
                '<select type="text" class="customerId" ' +
                'placeholder="Customer ID" required</select>' +
            '</td>' +

            '<td>' +
                '<select class="natureOfFacility" required ' +
        //                'style="width:200px">' +
        //                    '<option value="">Select Facility</option>' +
        //                    '<option value="Term Loan">Term Loan</option>' +
        //                    '<option value="Overdraft">Overdraft</option>' +
        //                    '<option value="Bank Guarantee">Bank Guarantee</option>' +
        //                    '<option value="Letter of Credit">Letter of Credit</option>' +
                '</select>' +
            '</td>' +

            '<td>' +
                '<input type="number" class="amount" ' +
                'placeholder="Amount" min="0" step="0.01" required />' +
            '</td>' +

            '<td>' +
                '<input type="text" class="validity date" required />' +
            '</td>' +

            '<td>' +
                '<button type="button" class="remove-btn">Remove</button>' +
            '</td>' +

        '</tr>';

        var $row = $(row);


        var $dropdown = $row.find(".customerId");

        //Bind database records to the dropdown
        $.each(cusList, function (index, item) {
            $dropdown.append(
            $("<option></option>")
                .val(item.id)
                .text(item.text)
        );


            

         ("#ddlCustomerCode").append(
            $("<option></option>")
                .val(item.id)
                .text(item.text)
        );


        });

        $dropdown = $row.find(".natureOfFacility");

        //Bind database records to the dropdown
        $.each(loanNatureList, function (index, item) {
            $dropdown.append(
            $("<option></option>")
                .val(item.short_name)
                .text(item.name)
        );


        ("#ddlLoanNature").append(
            $("<option></option>")
                .val(item.short_name)
                .text(item.name)
        );



        });


        $("#facilityBody").append($row);

        updateSerialNumbers();

        initializeDatepicker();

        // Initialize Select2 for this new row

        $row.find(".customerId").select2({
            width: "200px",
            placeholder: "Select Customer",
            allowClear: true
        });

        // Initialize Select2 for this new row

        $row.find(".natureOfFacility").select2({
            width: "200px",
            placeholder: "Select Facility",
            allowClear: true
        });


    }


    $("#facilityBody").on("click", ".remove-btn", function () {

        var $row = $(this).closest("tr");

        //$row.find(".natureOfFacility").select2("destroy");
        $row.remove();

        //facilityCounter--;

        //alert(facilityCounter);

        updateSerialNumbers();
    });




    $("#btnAddMore").on("click", function () {
        addFacilityRow();
    });

    function updateSerialNumbers() {
        $("#facilityBody tr").each(function (index) {
            $(this).find(".sl-no").text(index + 1);
        });
    }






    /*
    $("#txtSancDate,.date").datepicker
    ({
    appendText: "(dd/mm/yy)",
    dateFormat: "dd/mm/yy",
    altField: "#datepicker-4",
    altFormat: "DD, d MM, yy",
    showOn: "both",
    buttonImageOnly: true,
    buttonImage: "calender.gif",
    buttonText: "Calendar",
    changeMonth: true,
    changeYear: true

    });
    */

    initializeDatepicker();


    function initializeDatepicker() {
        $(".date").each(function () {
            if (!$(this).hasClass("hasDatepicker")) {
                $(this).datepicker({
                    //appendText: "(dd/mm/yy)",
                    dateFormat: "dd/mm/yy",
                    altField: "#datepicker-4",
                    altFormat: "DD, d MM, yy",
                    showOn: "both",
                    buttonImageOnly: true,
                    buttonImage: "calender.gif",
                    buttonText: "Calendar",
                    changeMonth: true,
                    changeYear: true
                });
            }
        });
    }




    // Final Save
    $("#btnSave2").on("click", function () {

        var edocId = $("#txtEdocId").val().trim();
        var branch = $("#ContentPlaceHolder1_select3").val().trim();
        var reference = $("#txtSanctionReference").val().trim();

        var sanctionDate = $("#txtSanctionDate").val();
        var authority = $("#select2").val().trim();
        var approval = $("#select1").val().trim();


        if (!branch || !reference || !sanctionDate || !authority || !approval) {
            alert("Please fill in all sanction details.");
            return;
        }

        var facilities = [];
        var invalid = false;

        $("#facilityBody .facility-row").each(function () {

            var row = $(this);

            var customerId = row.find(".customerId").val().trim();
            var nature = row.find(".natureOfFacility").val().trim();
            var amountText = row.find(".amount").val();
            var validity = row.find(".validity").val();
            var amount = Number(amountText);

            if (!customerId || !nature || !amountText || !validity || !Number.isFinite(amount) || amount < 0) {
                invalid = true;
                return false;
            }

            facilities.push({
                EdocId: edocId,
                CustomerId: customerId,
                NatureOfFacility: nature,
                Amount: amount,
                Validity: validity
            });

        });

        if (invalid || facilities.length === 0) {
            alert("Please complete every facility row.");
            return;
        }

        var data = {
            Branch: branch,
            SanctionReference: reference,
            SanctionDate: sanctionDate,
            Segment: segment,
            ApprovalAuthority: authority,
            Facilities: facilities
        };

        $("#btnSave").prop("disabled", true);
        $("#message").text("Saving...");

        $.ajax({
            type: "POST",
            url: "SanctionUpload_V3.aspx/SaveSanction",
            data: JSON.stringify({ request: data }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {

                var result = response.d;

                if (result.Success) {
                    $("#message").css("color", "green").text(result.Message);

                    $("#form1")[0].reset();
                    $("#facilityBody").empty();
                    addFacilityRow();
                } else {
                    $("#message").css("color", "red").text(result.Message);
                }
            },

            error: function (xhr) {
                $("#message").css("color", "red").text("Save failed. Please try again.");
                console.error(xhr.responseText);
            },

            complete: function () {
                $("#btnSave").prop("disabled", false);
            }
        });
    });


});