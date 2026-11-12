<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SanctionListing_V2.aspx.cs" Inherits="SanctionListing_V2" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
          
    </style>
    <script src="FileUpload.js" type="text/javascript"></script>
    <script type="text/javascript">


        var edoc_id;

        var edoc_refno;


        var sanc_refno;


        $(document).ready(function () {



     

            $("#Button1").click(function () {

                var customer = $("#ContentPlaceHolder1_Select4").val();

                var customerName = $("#ContentPlaceHolder1_Select4 option:selected").text();

                //alert(customerName);

                customerName = customerName.split('-');

                customerName = customerName[0].trim();


                var loanNature = $("#ContentPlaceHolder1_Select5").val();
                var currency = $("#Select6").val();
                var amount = $("#Text1").val();
                var validity = $("#Text2").val();

                // Validation
                if (customer == "" || loanNature == "" || amount == "" || validity == "") {

                    alert("Please fill all fields.");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "SanctionListing_V2.aspx/SaveSanctionDetails",
                    data: JSON.stringify({
                        edoc_id: edoc_id,
                        edoc_refno: edoc_refno,
                        sanc_refno: sanc_refno,
                        customer: customer,
                        customerName: customerName,
                        loanNature: loanNature,
                        currency: currency,
                        amount: amount,
                        validity: validity
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var id = response.d.id;

                        if (response.d.message == "Success") {
                            alert("Data saved successfully : " + id);



                            // Clear fields
                            /*
                            $("#Select4").val("");
                            $("#Select5").val("");
                            $("#Select6").val("BDT");
                            $("#Text1").val("");
                            $("#Text2").val("");

                            */

                            var row = '<tr id="row_' + id + '">' +
    '<td>' + ($("#tblSanctionDetails tbody tr").length + 1) + '</td>' +
    '<td>' + $("#ContentPlaceHolder1_Select4 option:selected").text() + '</td>' +
    '<td>' + $("#ContentPlaceHolder1_Select5 option:selected").text() + '</td>' +
    '<td>' + $("#Select6").val() + '</td>' +
    '<td>' + $("#Text1").val() + '</td>' +
    '<td>' + $("#Text2").val() + '</td>' +
    '<td>' +
        '<button type="button" class="btn btn-danger btn-xs" onclick="DeleteSanction(' + id + ')">' +
            'Delete' +
        '</button>' +
    '</td>' +
'</tr>';

                            console.log(row);

                            $("#tbodySanctionDetails").append(row);





                        }
                        else {
                            alert(response.d);
                        }
                    },

                    error: function (xhr, status, error) {
                        alert("Error saving data: " + error);
                    }
                });

            });



        });


        function DeleteSanction(id) {

            if (!confirm("Are you sure you want to delete this record?"))
                return;

            $.ajax({
                type: "POST",
                url: "SanctionListing_V2.aspx/DeleteDetail",
                data: JSON.stringify({ id: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (response) {

                    if (response.d == "Success") {

                        $("#row_" + id).remove();

                        alert("Deleted successfully!");
                    }
                    else {
                        alert("Record not found!");
                    }
                },

                error: function () {
                    alert("Delete failed!");
                }
            });
        }



    </script>
    <script type="text/javascript">


        $(document).ready(function () {


            $(document).on("click", "#btnEditMaster", function () {



                $('.display').hide();
                $('.edit2').show();

                $('.ui-datepicker-trigger').show();
                $('.ui-datepicker-append').show();




                // Change buttons
                $("#masterAction").html(
    '<button type="button" class="btn btn-success btn-xs" id="btnSaveMaster">' +
        '<i class="fa fa-save"></i> Update' +
    '</button>' +

    '<button type="button" class="btn btn-default btn-xs" id="btnCancelMaster">' +
        'Cancel' +
    '</button>'
);

            });



            $(document).on("click", "#btnCancelMaster", function () {

                $('.display').show();
                $('.edit2').hide();
                $('.ui-datepicker-trigger').hide();
                $('.ui-datepicker-append').hide();

                $("#masterAction").html(
        '<button type="button" class="btn btn-primary btn-xs" id="btnEditMaster">' +
            '<i class="fa fa-edit"></i> Edit' +
        '</button>'
    );

            });


            $(document).on("click", "#btnSaveMaster", function () {



                var dataObj = {
                    edoc_id: edoc_id,
                    booking_branch: $("#ContentPlaceHolder1_select3").val(),
                    sanction_reference: $("#txtSanctionReference").val(),
                    sanction_date: $("#txtSanctionDate").val(),
                    sanction_segment: $("#select2").val(),
                    sanction_approval_authority: $("#select1").val()
                };

                // 2. Perform AJAX call to the WebMethod
                $.ajax({
                    type: "POST",
                    url: "SanctionListing_V2.aspx/UpdateMaster", // Replace "YourPageName.aspx" with your actual aspx page name
                    data: JSON.stringify(dataObj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // response.d holds the string returned by your WebMethod
                        if (response.d.message === "Success") {
                            alert("Master updated successfully!");
                            // Optional: Refresh your table or toggle UI back to display mode

                            ViewSanctionDetails(edoc_id);


                        } else {
                            alert("Error: " + response.d);
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("An AJAX error occurred: " + error);
                    }
                });


            });

            $("#txtSanctionDate,#txtValidity,.txtValidity,.date").datepicker
            ({
                //appendText: "(dd/mm/yy)",
                //dateFormat: "dd/mm/yy",

                appendText: "(yy-mm-dd)",
                dateFormat: "yy-mm-dd",

                altField: "#datepicker-4",
                altFormat: "DD, d MM, yy",
                showOn: "both",
                buttonImageOnly: true,
                buttonImage: "calender.gif",
                buttonText: "Calendar",
                changeMonth: true,
                changeYear: true

            });


            $('#sanctionModal').on('shown.bs.modal', function () {

                $('#ui-datepicker-div').appendTo('#sanctionModal');
                $('.ui-datepicker-trigger').hide();
                $('.ui-datepicker-append').hide();


            });



            //            $("#ContentPlaceHolder1_select3 option[value='']").length ||
            //    $("#ContentPlaceHolder1_select3").prepend('<option value=""></option>');

            //              $("#select1,#select2,#ContentPlaceHolder1_select3,#ddlCustomerCode,#ddlLoanNature,#select8,#ddlCurrency").select2({
            //                  placeholder: "<--Select-->",
            //                  allowClear: true,
            //                  width: "100%"
            //              });



            //              $('#select1>').on('change', function () {
            //                  $('#hfSelected').val($(this).val());
            //              });

            //              $('#<%=select3.ClientID%>').on('change', function () {
            //                  $('#hfSelectedLoanNature').val($(this).val());
            //              });





        });

    </script>
    <script type="text/javascript">




        function ViewSanctionDetails(id) {

            $('.display').show();
            $('.edit2').hide();

            $("#masterAction").html(
        '<button type="button" class="btn btn-primary btn-xs" id="btnEditMaster">' +
            '<i class="fa fa-edit"></i> Edit' +
        '</button>'
    );






            $.ajax({
                type: "POST",
                url: "SanctionUpload_V4.aspx/GetMasterDetail",
                data: JSON.stringify({ id: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (response) {

                    var data = response.d;


                    //masterData = data.Master;
                    //renderMaster(masterData);



                    // =========================
                    // MASTER INFORMATION
                    // =========================

                    if (data.Master) {

                        $("#mEdocId").text(data.Master.edoc_id);

                        $("#mBookingBranch").text(data.Master.booking_branch);
                        $("#ContentPlaceHolder1_select3").val(data.Master.booking_branch).trigger("change");


                        $("#mSanctionReference").text(data.Master.sanction_reference);
                        $("#txtSanctionReference").val(data.Master.sanction_reference);

                        $("#mSanctionDate").text(data.Master.sanction_date);
                        $("#txtSanctionDate").val(data.Master.sanction_date);

                        $("#mSanctionSegment").text(data.Master.sanction_segment);
                        $("#select2").val(data.Master.sanction_segment).trigger("change");

                        $("#mApprovalAuthority").text(data.Master.sanction_approval_authority);
                        $("#select1").val(data.Master.sanction_approval_authority).trigger("change");

                    }

                    // =========================
                    // DETAIL INFORMATION
                    // =========================

                    $("#tbodySanctionDetails").empty();

                    $.each(data.Details, function (i, item) {

                        var tr = $("<tr>").attr("data-id", item.id);

                        $("<td>").text(i + 1).appendTo(tr);

                        $("<td>").addClass("customer").text(item.customer_id + '-' + item.customer_name).appendTo(tr);

                        $("<td>").addClass("loan_nature_name")
            .text(item.loan_nature_name).appendTo(tr);

                        $("<td>").addClass("currency")
            .text(item.currency).appendTo(tr);

                        $("<td>").addClass("amount")
            .text(Number(item.amount).toLocaleString()).appendTo(tr);

                        $("<td>").addClass("validity")
            .text(item.validity).appendTo(tr);

                        // Action buttons
                        var actionTd = $("<td>");

                        $("<button>", {
                            type: "button",
                            class: "btn btn-primary btn-xs btnEdit",
                            text: "Edit"
                        }).appendTo(actionTd);

                        $("<button>", {
                            type: "button",
                            class: "btn btn-success btn-xs btnSave",
                            text: "Save"
                        }).hide().appendTo(actionTd);

                        $("<button>", {
                            type: "button",
                            class: "btn btn-warning btn-xs btnCancel",
                            text: "Cancel"
                        }).hide().appendTo(actionTd);

                        $("<button>", {
                            type: "button",
                            class: "btn btn-danger btn-xs btnDeleteDetail",
                            text: "Delete"
                        }).attr("data-id", item.id).appendTo(actionTd);

                        actionTd.appendTo(tr);

                        // Store original values
                        tr.data("original", {
                            customer: item.customer_id + '-' + item.customer_name,
                            loan_nature_name: item.loan_nature_name,
                            currency: item.currency,
                            amount: item.amount,
                            validity: item.validity
                        });

                        $("#tbodySanctionDetails").append(tr);

                    });

                    // Show modal







                    //$("#sanctionModal").modal("show");






                },

                error: function (xhr) {

                    console.log(xhr.responseText);

                    alert("Unable to load sanction details.");

                }
            });
        }


        $(document).ready(function () {




            $(document).on('click', '.delete', function (e) {

                e.preventDefault();

                var btn = $(this);
                var id = btn.data('id');

                if (!confirm("Are you sure you want to delete this record?")) {
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "SanctionUpload_V4.aspx/DeleteEDoc",
                    data: JSON.stringify({ id: id }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d === "success") {

                            //alert("Record deleted successfully!");

                            // Remove the corresponding table row
                            btn.closest("tr").fadeOut(300, function () {
                                $(this).remove();
                            });

                        }
                        else if (response.d === "notfound") {
                            alert("Record not found.");
                        }
                    },

                    error: function (xhr, status, error) {
                        console.log(xhr.responseText);
                        alert("Error deleting record.");
                    }
                });

            });

            $("body").on("click", ".upload", function () {


                var edoc_id = $(this).data("edocid");

                $("#lblID").text(edoc_id);

                $('#modalUpdateform').modal('show');

                /*
                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

          

                url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                var width = screen.availWidth - 100;
                var height = screen.availHeight - 100;
                var left = parseInt((screen.availWidth / 2) - (width / 2));
                var top = parseInt((screen.availHeight / 2) - (height / 2));
                var windowFeatures = "width=" + width + ", height=" + height + ", status, resizable, screenX=" + left + ", screenY=" + top;

             
                newwindow = window.open(url, '_blank', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow.focus();


                */


            });


            // Upload View click
            $(document).on('click', '.docview', function (e) {

                e.preventDefault();

                var edocId = $(this).attr('data-edocid');

                $('#documentModal').modal('show');

                $('#documentListSection').show();
                $('#pdfViewerSection').hide();

                $('#pdfFrame').attr('src', '');

                $('#documentList').html('<tr><td colspan="6" class="text-center">Loading...</td></tr>');

                $.ajax({
                    type: "POST",
                    url: "SanctionListing_V2.aspx/GetUploadedDocuments",
                    data: JSON.stringify({ edocId: edocId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var data = response.d;
                        var html = '';

                        if (data.length === 0) {

                            html = '<tr><td colspan="6" class="text-center">' + 'No documents found.</td></tr>';

                        } else {

                            $.each(data, function (i, item) {

                                html += '<tr>';

                                html += '<td>' + (i + 1) + '</td>';
                                html += '<td>' + $('<div>').text(item.FileType || '').html() + '</td>';
                                html += '<td>' + $('<div>').text(item.FileName || '').html() + '</td>';
                                html += '<td>' + $('<div>').text(item.UploadBy || '').html() + '</td>';
                                html += '<td>' + $('<div>').text(item.UploadTime || '').html() + '</td>';

                                html += '<td>';

                                if (item.FileName && item.FileName.toLowerCase().endsWith('.pdf')) {

                                    html += '<button type="button" ' + 'class="btn btn-success btn-xs viewPDF" ' + 'data-url="' + $('<div>').text(item.FileUrl).html() + '">' + '<i class="fa fa-file-pdf-o"></i> View PDF' + '</button>';

                                } else {

                                    html += '<span class="text-muted">Not PDF</span>';

                                }

                                html += '</td></tr>';

                            });

                        }

                        $('#documentList').html(html);

                    },

                    error: function (xhr) {

                        console.log(xhr.responseText);

                        $('#documentList').html('<tr><td colspan="6" class="text-danger text-center">' + 'Unable to load documents.</td></tr>');

                    }
                });

            });


            // View PDF inside modal
            $(document).on('click', '.viewPDF', function () {

                var fileUrl = $(this).attr('data-url');

                $('#pdfFrame').attr('src', fileUrl);

                $('#documentListSection').hide();
                $('#pdfViewerSection').show();

            });


            // Back to document list
            $(document).on('click', '#btnBackDocuments', function () {

                $('#pdfFrame').attr('src', '');

                $('#pdfViewerSection').hide();
                $('#documentListSection').show();

            });


            // Clear PDF when modal closes
            $(document).on('hidden.bs.modal', '#documentModal', function () {

                $('#pdfFrame').attr('src', '');

                $('#pdfViewerSection').hide();
                $('#documentListSection').show();

            });

            $("body").on("click", ".view", function () {


                edoc_id = $(this).data("edocid");

                edoc_refno = $(this).data("edocrefno");

                sanc_refno = $(this).data("sancrefno");


                $('.display').show();
                $('.edit2').hide();

                $("#masterAction").html(
        '<button type="button" class="btn btn-primary btn-xs" id="btnEditMaster">' +
            '<i class="fa fa-edit"></i> Edit' +
        '</button>'
    );



                $("#lblID").text(edoc_id);




                //$('#sanctionModal').modal('show');


                ViewSanctionDetails(edoc_id);



                $("#sanctionModal").modal("show");





                /*
                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

          

                url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                var width = screen.availWidth - 100;
                var height = screen.availHeight - 100;
                var left = parseInt((screen.availWidth / 2) - (width / 2));
                var top = parseInt((screen.availHeight / 2) - (height / 2));
                var windowFeatures = "width=" + width + ", height=" + height + ", status, resizable, screenX=" + left + ", screenY=" + top;

             
                newwindow = window.open(url, '_blank', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow.focus();


                */


            });


            $(document).on("click", ".btnEdit", function () {

                var tr = $(this).closest("tr");

                var original = tr.data("original");




                tr.find(".customer").html(
        $("<input>", {
            type: "text",
            class: "form-control txtCustomer"
        }).val(original.customer)
    );



                tr.find(".loan_nature_name").html(
        $("<input>", {
            type: "text",
            class: "form-control txtLoanNature"
        }).val(original.loan_nature_name)
    );

                tr.find(".currency").html(
        $("<input>", {
            type: "text",
            class: "form-control txtCurrency"
        }).val(original.currency)
    );

                tr.find(".amount").html(
        $("<input>", {
            type: "text",
            class: "form-control txtAmount"
        }).val(original.amount)
    );

                tr.find(".validity").html(
        $("<input>", {
            type: "text",
            class: "form-control date"
        }).val(original.validity)
    );

                tr.find(".btnEdit, .btnDeleteDetail").hide();
                tr.find(".btnSave, .btnCancel").show();



                $('.date').datepicker({
                    dateFormat: 'yy-mm-dd',
                    yearRange: "-50:+10",
                    changeMonth: true,
                    changeYear: true
                });



            });


            $(document).on("click", ".btnCancel", function () {

                var tr = $(this).closest("tr");
                var original = tr.data("original");

                tr.find(".customer").text(original.customer);
                tr.find(".loan_nature_name").text(original.loan_nature_name);
                tr.find(".currency").text(original.currency);
                tr.find(".amount").text(Number(original.amount).toLocaleString());
                tr.find(".validity").text(original.validity);

                tr.find(".btnSave, .btnCancel").hide();
                tr.find(".btnEdit, .btnDeleteDetail").show();

            });

            $(document).on("click", ".btnSave", function () {

                var tr = $(this).closest("tr");

                var obj = {
                    id: tr.attr("data-id"),
                    loan_nature_name: tr.find(".txtLoanNature").val(),
                    currency: tr.find(".txtCurrency").val(),
                    amount: tr.find(".txtAmount").val(),
                    validity: tr.find(".txtValidity").val()
                };

                $.ajax({
                    type: "POST",
                    url: "YourPage.aspx/UpdateSanctionDetail",
                    data: JSON.stringify({ obj: obj }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d === "success") {

                            tr.find(".loan_nature_name").text(obj.loan_nature_name);
                            tr.find(".currency").text(obj.currency);
                            tr.find(".amount").text(Number(obj.amount).toLocaleString());
                            tr.find(".validity").text(obj.validity);

                            // Update original values
                            tr.data("original", {
                                loan_nature_name: obj.loan_nature_name,
                                currency: obj.currency,
                                amount: obj.amount,
                                validity: obj.validity
                            });

                            tr.find(".btnSave, .btnCancel").hide();
                            tr.find(".btnEdit, .btnDeleteDetail").show();

                            alert("Updated successfully!");

                        } else {
                            alert(response.d);
                        }
                    },

                    error: function (xhr) {
                        alert("Error updating record: " + xhr.responseText);
                    }
                });

            });



            $(document).on("click", ".btnDeleteDetail", function () {

                var detailId = $(this).attr("data-id");

                alert('det id :' + detailId);

                if (!confirm("Are you sure you want to delete this detail?")) {
                    return;
                }

                $.ajax({

                    type: "POST",

                    url: "SanctionListing_V2.aspx/DeleteDetail",

                    data: JSON.stringify({ id: parseInt(detailId) }),

                    contentType: "application/json; charset=utf-8",

                    dataType: "json",

                    success: function (response) {

                        if (response.d === "Success") {

                            //alert("Detail deleted successfully.");

                            // Remove deleted row
                            $(".btnDeleteDetail[data-id='" + detailId + "']").closest("tr").remove();

                            // Recalculate SL
                            $("#tbodySanctionDetails tr").each(function (i) {
                                $(this).find("td:first").text(i + 1);
                            });

                        }
                        else {
                            alert(response.d);
                        }

                    },

                    error: function (xhr) {

                        console.log(xhr.responseText);

                        alert("Unable to delete detail.");

                    }

                });

            });

            $("body").on("click", ".edit", function () {


                var edoc_id = $(this).data("edocid");

                //alert(edoc_id);

                url = "SanctionUpload_V4.aspx?id=" + edoc_id;

                var width = screen.availWidth - 100;
                var height = screen.availHeight - 100;
                var left = parseInt((screen.availWidth / 2) - (width / 2));
                var top = parseInt((screen.availHeight / 2) - (height / 2));
                var windowFeatures = "width=" + width + ", height=" + height + ", status, resizable, screenX=" + left + ", screenY=" + top;


                newwindow = window.open(url, '_self', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow.focus();

                //$("#lblID").text(edoc_id);

                //$('#modalUpdateform').modal('show');

                /*
                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

          

                url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

              
             
                newwindow = window.open(url, '_blank', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow.focus();


                */


            });

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">



    <section class="content"> <!-- Start of table section -->



    
    
    <div class="modal" id="modalUpdateform" tabindex="-1" role="dialog" aria-labelledby="modalUpdateform" aria-hidden="true">  
  		<div class="modal-dialog">
    		<div class="container">
            	<div class="row ">	
           			<div class="col-md-6">
                		<div class="panel">
        					<div class="panel-heading bg-orange">                 
        						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          						<h4 class="modal-title custom_align" id="Heading">Document Upload</h4>
                            </div>
                            <div class="panel-body"> <!-- Start of modal body--> 




                            ID # <span id="lblID" class="badge  badge-success"></span>



                            <!--
                                <div class="form-group" id="divSubjectUpdate">
                                    <label for="">Subject</label>
                                    <input class="form-control" type="text" id="name1" name="name" autocomplete="off"/>
                                </div> 
                                -->
                                <%-- <div class="form-group" id="div2">
                                 Please upload following documents :

                                 <ul>
                                 
                                    <li>Checklist Scancopy</li>
                                    <li>Accepted Scancopy</li>
                                    <li>Board Resolution</li>
                                    <li>Others</li>


                                 </ul>
                                 </div>--%>


                                  <div class="form-group"  >
                      			<label for="">Document Type</label>
                      	     <select id="select8"        class="form-control">


                   <option value="Sanction Document">Sanction Document</option>
                   <option value="Others">Others</option>
                  
                   
                  
                   </select>

                       
             
                    		</div>

 
                                <div class="form-group" id="div1">
                                     <input id="fileUploadID" type="file"  multiple />
 
                                </div> 

                                  <div id='r'>
                        </div>



                            </div><!--/.modal body-->
                         

                          <div class="panel-footer bg-gray-light">

                                <input type="hidden" id="id" name="id" value="" />

                                <div class="row">
        <div class="col-md-6">
            <button type="button" id="btnSubmit" class="btn btn-info" style="width: 100%;">
                <span class="glyphicon glyphicon-upload"></span> Upload
            </button>
        </div>

        <div class="col-md-6">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="width: 100%;">
                <span class="glyphicon glyphicon-remove"></span> Close
            </button>
        </div>
    </div>
</div>



            			</div><!--/.panel-->
            		</div><!--/.col-md-6-->
            	</div><!--/.row-->                                        
        	</div><!-- /.modal-content -->  		 
		</div><!-- /.modal-dialog -->            
	</div><!--/.Modal-Update form -->   
  <div class="modal" id="documentModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">

        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title">Uploaded Documents</h4>
            </div>

            <div class="modal-body">

                <!-- Document List -->
                <div id="documentListSection">

                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>SL</th>
                                <th>File Type</th>
                                <th>File Name</th>
                                <th>Upload By</th>
                                <th>Upload Time</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody id="documentList"></tbody>
                    </table>

                </div>

                <!-- PDF Viewer -->
                <div id="pdfViewerSection" style="display:none;">

                    <button type="button"
                            class="btn btn-default btn-sm"
                            id="btnBackDocuments">
                        <i class="fa fa-arrow-left"></i> Back to Documents
                    </button>

                    <hr />

                    <iframe id="pdfFrame"
                            style="width:100%; height:550px; border:1px solid #ddd;"
                            frameborder="0">
                    </iframe>

                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">
                    Close
                </button>
            </div>

        </div>
    </div>
</div>



 <div class="modal" id="sanctionModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg modal-extra-lg" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title">Sanction Details</h4>
            </div>

            <div class="modal-body">

               
<div class="row">

    <!-- Master Information - Left Side -->
    <div class="col-md-3">

        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">Master Information</h3>

                <div class="box-tools pull-right" id="masterAction">
                    <button type="button" class="btn btn-primary btn-xs" id="btnEditMaster">
                        <i class="fa fa-edit"></i> Edit
                    </button>
                </div>
            </div>

            <div class="box-body">

                <div class="row">

                    <div class="col-md-12">
                        <label>eDoc ID</label>
                        <p id="mEdocId"></p>
                    </div>

                    <div class="col-md-12">
                        <label>Booking Branch</label>
                        <p id="mBookingBranch" class="display"></p>
                        <select id="select3" runat="server" class="form-control edit2">
                            <option></option>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label>Sanction Reference</label>
                        <p id="mSanctionReference" class="display"></p>
                        <input type="text" class="form-control edit2"
                               id="txtSanctionReference"
                               placeholder="Enter Santion Reference"
                               name="name" autocomplete="off"/>
                    </div>

                    <div class="col-md-12">
                        <label>Sanction Date</label>
                        <p id="mSanctionDate" class="display"></p>
                        <input type="text" class="form-control edit2 date"
                               id="txtSanctionDate"
                               placeholder="Enter Santion Date"
                               name="admission_fee" autocomplete="off"/>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-12">
                        <label>Sanction Segment</label>
                        <p id="mSanctionSegment" class="display"></p>

                        <select id="select2" class="form-control edit2">
                            <option value=""><--Select--></option>
                            <option value="Corporate">Corporate</option>
                            <option value="CMSME">CMSME</option>
                            <option value="Retail">Retail</option>
                            <option value="Agriculture">Agriculture</option>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label>Approval Authority</label>
                        <p id="mApprovalAuthority" class="display"></p>

                        <select id="select1" class="form-control edit2">
                            <option value=""><--Select--></option>
                            <option value="Management">Management</option>
                            <option value="EC">EC</option>
                            <option value="Board">Board</option>
                        </select>
                    </div>

                </div>

            </div>
        </div>

    </div>


    <!-- Loan / Facility Details - Right Side -->
    <div class="col-md-9">

        <div class="box box-primary">

            <div class="box-header with-border">
                <h3 class="box-title">Loan / Facility Details</h3>
            </div>

            <div class="box-body table-responsive">

                <table class="table table-bordered table-striped"
                       id="tblSanctionDetails">

                    <thead>
                        <tr>
                            <th>SL</th>
                            <th>Customer</th>
                            <th>Loan Nature</th>
                            <th>Currency</th>
                            <th>Amount</th>
                            <th>Validity</th>
                            <th>Action</th>
                        </tr>

                        <tr>
                            <td></td>

                            <td>
                                <select id="Select4" class="form-control" runat="server">
                                    <option></option>
                                </select>
                            </td>

                            <td>
                                <select id="Select5" class="form-control" runat="server">
                                    <option></option>
                                </select>
                            </td>

                            <td>
                                <select id="Select6" class="form-control">
                                    <option value="BDT">BDT</option>
                                    <option value="USD">USD</option>
                                    <option value="CAD">CAD</option>
                                </select>
                            </td>

                            <td>
                                <input id="Text1" type="text" class="form-control"/>
                            </td>

                            <td>
                                <input id="Text2" type="text" class="form-control date"/>
                            </td>

                            <td>
                                <input id="Button1" type="button"
                                       class="btn btn-success" value="Save"/>
                            </td>
                        </tr>

                    </thead>

                    <tbody id="tbodySanctionDetails"></tbody>

                </table>

            </div>
        </div>

    </div>

</div>


            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove"></span> Close
                </button>
            </div>

        </div>
    </div>
</div>

    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">Sanction Listing </h3>
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>ID</th>
                                <th>Reference</th>
                            	<th>Date</th>
                            	<th>Authority</th>
                            	<th>Branch</th>
                                <th>Action</th>
                             </tr>
                        	</thead>
                         
                        	<tbody>
    <%
                    
        //var sts = "";
        //var css = "";

        //var last_renew_dt = "";


        if (TableData.Rows.Count > 0)
        {
            for (var data = 0; data < TableData.Rows.Count; data++)
            {
                            
%>
<tr>
                        <td><%=TableData.Rows[data]["id"]%></td>
                        <td><%=TableData.Rows[data]["sanction_reference"]%></td>
                        <td><%=TableData.Rows[data]["sanction_date"]%></td>
                        <td><%=TableData.Rows[data]["sanction_authority"]%></td>
                        <td><%=TableData.Rows[data]["booking_branch"]%></td>
                        	
                        <td>        


                        <!--
                        <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["id"]%>"  drawdown-id="<%=TableData.Rows[data]["id"]%>">Edit</a>                                    

                        <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["id"]%>" drawdown-id="<%=TableData.Rows[data]["id"]%>">Document Upload</a>                                    
  
  -->


  <a href="#"  class="btn btn-success btn-xs view"  data-sancrefno="<%=TableData.Rows[data]["sanction_reference"]%>" data-edocrefno="<%=TableData.Rows[data]["edoc_refno"]%>" data-edocid="<%=TableData.Rows[data]["edoc_id"]%>"  data-id="<%=TableData.Rows[data]["id"]%>">View</a>                                    

  <a href="#"  class="btn btn-danger btn-xs delete" data-edocid="<%=TableData.Rows[data]["edoc_id"]%>"  data-id="<%=TableData.Rows[data]["id"]%>">Delete</a>                                    
   
  <a href="#"  class="btn btn-success btn-xs edit" data-edocid="<%=TableData.Rows[data]["edoc_id"]%>"  data-id="<%=TableData.Rows[data]["id"]%>">Edit</a>                                    

  <a href="#"  class="btn btn-info btn-xs upload" data-edocid="<%=TableData.Rows[data]["edoc_id"]%>"  data-id="<%=TableData.Rows[data]["id"]%>">Upload</a>                                    

  <a  href="javascript:void(0);"  class="btn btn-primary btn-xs docview" data-edocid="<%=TableData.Rows[data]["edoc_id"]%>"  data-id="<%=TableData.Rows[data]["id"]%>">View Upload</a>                                    


<%  
                if (Role == 1)
                { 
        %>
                        <a href="DrawdownCreate_V3.aspx?id=<%=TableData.Rows[data]["id"]%>&ref=<%=TableData.Rows[data]["sanction_reference"]%>"  class="btn btn-success btn-xs" cus-type="<%=TableData.Rows[data]["id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["id"]%>" drawdown-id="<%=TableData.Rows[data]["id"]%>">Initiate Checklist</a>                                    


                        <%
                }
                            
                             %>
                            <%if (Role == 2)
                              { %>

                            <a href="DrawdownCreate_V3_DM.aspx?id=<%=TableData.Rows[data]["id"]%>&ref=<%=TableData.Rows[data]["sanction_reference"]%>"  class="btn btn-success btn-xs" cus-type="<%=TableData.Rows[data]["id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["id"]%>" drawdown-id="<%=TableData.Rows[data]["id"]%>">Initiate Checklist</a>                                    


                            <%} %>
                              



                        </td>                                
</tr>
     <%
            }

        }
                                                   %>
                        	</tbody>
                    	</table>	                
               		</div>
              	</div>
            </div>
		</div>
</asp:Content>
