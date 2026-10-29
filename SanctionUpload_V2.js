


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
        var customerName = $("#ddlCustomerCode option:selected").text();
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
            CustomerName: customerName,
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
            $("<td>").text(loan.CustomerName).appendTo(tr);

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
    /*
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
    */

    $("#btnSaveAll").on("click", function () {



        var edoc_id = $("#ContentPlaceHolder1_txtEdocId").val();

        var branch = $("#ContentPlaceHolder1_select3").val();

        var sanc_ref = $("#txtSanctionReference").val();

        var sanc_date = $("#txtSanctionDate").val();

        var segment = $("#select2").val();

        var appr_auth = $("#select1").val();



        if (edoc_id == "" || branch == "" || sanc_ref == "" || sanc_date == "" || segment == "" || appr_auth == "") {
            alert('Sorry !!! input missing.');
            return;

        }



        var data = {};




        data.EdocId = edoc_id;
        data.Branch = branch;
        data.SanctionReference = sanc_ref;
        data.SanctionDate = sanc_date;
        data.Segment = segment;
        data.ApprovalAuthority = appr_auth;

















        var tot_amount = 0.00;

        var facilityDetails = [];

        // Iterate through each row in the table body
        $("#tblLoans tbody tr").each(function () {

            var $row = $(this);

            // Extract text from specific columns based on your renderTable structure:
            var customerCode = $row.find("td:eq(1)").text().trim();
            var customerName = $row.find("td:eq(2)").text().trim();

            var loanNature = $row.find("td:eq(3)").text().trim();
            var amountText = $row.find("td:eq(4)").text().trim();
            var validity = $row.find("td:eq(5)").text().trim();

            // Convert the amount string back to a float (removes commas if formatting added them)
            var amount = parseFloat(amountText.replace(/,/g, "")) || 0;

            tot_amount = tot_amount + amount

            customerName = customerName.split("-")[0];


            // Push the structured object into your loans array
            facilityDetails.push({
                CustomerCode: customerCode,
                CustomerName: customerName,
                LoanNature: loanNature,
                Amount: amount,
                Validity: validity
            });


        });


        data.TotalAmount = tot_amount;

        data.Facilities = facilityDetails;

        if (facilityDetails.length == 0) {
            alert('No Facility added');
            return;
        }

        console.log(data);



        var button = $(this);
        button.prop("disabled", true);
        $("#lblMessage").text("Saving...");



        $.ajax({
            type: "POST",
            url: "SanctionUpload_V4.aspx/SaveSanction_V2",
            data: JSON.stringify({ request: data }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {

                var result = response.d;

                if (result && result.Success) {
                    //alert(result.Message);

                    //loans = [];
                    //renderTable();
                    $("#lblMessage").text(result.Message);

                    swal("Success!", result.Message, "success");


                    $('#modalUpdateform').modal('show');

                    //var dd_id = $(this).attr("dd-id");

                    $("#lblID").text($("#ContentPlaceHolder1_txtEdocId").val());



                } else {
                    $("#lblMessage").text(result ? result.Message : "Unable to save.");
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

    $('#fileUploadID').on("change", function () {

        //uploadFile();

        var f_name = '';
        var f_size = '';

        document.getElementById('r').innerHTML = '';
        var filelists = '';

        var fileUploadID = document.getElementById("fileUploadID");
        var aryFiles = fileUploadID.files;
        total_files = aryFiles.length;
        for (var i = 0; i < aryFiles.length; i++) {

            f_name = aryFiles[i].name;
            f_size = (aryFiles[i].size / (1024 * 1024)).toFixed(2);


            filelists = filelists + "<tr><td>" + (i + 1) + "</td><td>" + f_name + "</td><td>" + f_size + "</td><td><span id='file_" + i + "'>0%</span><span id='error_" + i + "'></span></td></tr>";
            //filelists = filelists + "<tr><td>" + (i + 1) + "</td><td>" + aryFiles[i].name + "</td><td>" + aryFiles[i].size + "</td><td><span id='file_" + i + "'>0%</span></td></tr>";
            //alert(aryFiles[i].name);
        }
        filelists = "<table class='table'><thead><tr><th>SL</th><th>File Name</th><th>Size</th><th>Upload Status(%)</th></tr></thead>" + filelists + "</table>";
        document.getElementById('r').innerHTML = filelists;

    });



    $("#btnSubmit").click(function () {

        //var dd_id = $(this).attr("dd-id");

        var edoc_id = $("#ContentPlaceHolder1_txtEdocId").val();

        //alert(edoc_id);

        upload_sanction_letter(edoc_id);



    });






    function upload_sanction_letter(edoc_id) {

        var filelists = '';
        var fileUploadID = document.getElementById("fileUploadID");
        var aryFiles = fileUploadID.files;
        for (var i = 0; i < aryFiles.length; i++) {

            /*
            var fileName = aryFiles[i].name.startsWith("1111_");
            if (!fileName)
            alert("Please upload file with name starting with 1111_");
            else
            alert("Done.");
            */

            //alert(aryFiles[i].name);
            upload(aryFiles[i], i, edoc_id);
            //filelists = filelists + "<tr><td>" + aryFiles[i].name + "</td><td><span id='" + i + "'></span></td></tr>";

        }


        //return "OK";

        //MailSend(file_no, 22)

        //setTimeout(MailSend(file_no, 22), 20000);


    }






    function upload(f, i, edoc_id) {

        //alert(f.name);

        var doc_type = $('#ContentPlaceHolder1_select8').val()

        var formData = new FormData();

        formData.append("edoc_id", edoc_id);

        formData.append("doc_type", doc_type);

        formData.append("file", f);

        //alert('tttt'); 

        $.ajax({


            url: 'WebService3.asmx/UploadFiles_CD',
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (fileName) {

                $("#fileProgress").hide();

                $("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");

                uploaded_files = uploaded_files + 1;

                if (uploaded_files == total_files) {

                    alert(doc_type + ' Uploaded');

                    uploaded_files = 0;
                    //MailSend(file_no, 22);

                }
            },
            xhr: function () {
                var fileXhr = $.ajaxSettings.xhr();
                //Check if upload property exists
                if (fileXhr.upload) {
                    //update progressbar percent complete
                    fileXhr.upload.addEventListener("progress", function (e) {
                        if (e.lengthComputable) {
                            //$("#statustxt").attr({ value: e.loaded, max: e.total });
                            //console.log("Value = " + e.loaded + " :: Max =" + e.total);
                            var percentage = Math.floor((e.loaded / e.total) * 100);
                            console.log(f.name + ' : ' + percentage + '%');
                            $("#statustxt").html(percentage + '%');
                            $("#file_" + i + "").html(percentage + '%');
                        }
                    }, false);
                }
                return fileXhr;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("#file_" + i + "").html('0%');
                //$("#error_" + i + "").html(XMLHttpRequest.responseText + '-' + textStatus + '-' + errorThrown);
                $("#error_" + i + "").html(XMLHttpRequest.status + '-' + XMLHttpRequest.statusText);
                //alert("Whoops something went wrong!");

                alert("Upload failed for file: " + dd_id + "\n\nUploading has been stopped.");


            }
        });



    }


});