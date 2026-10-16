<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SanctionUpload_V2.aspx.cs" Inherits="SanctionUpload_V2" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .select2-container--default .select2-selection--multiple .select2-selection__choice
        {
            color: blue !important;
        }
        
        
        
    </style>
    <script src="sweet_alert.js" type="text/javascript"></script>
    <link href="sweet_alert.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        $(document).ready(function () {


            var cusList = [];

            var loanNatureList = [];


            loadCusList();

            loadLoanNature();


            //addFacilityRow();

           

            function loadCusList() {

                $.ajax({
                    type: "POST",
                    url: "SanctionUpload_V2.aspx/GetCusList",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {
                        cusList = response.d;

                        // Add the first row after dropdown data loads
                        addFacilityRow();
                    },

                    error: function (xhr) {
                        alert("Unable to load facility types.");
                        console.log(xhr.responseText);
                    }
                });
            }

            function loadLoanNature() {
                $.ajax({
                    type: "POST",
                    url: "SanctionUpload_V2.aspx/LoadLoanNature",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        loanNatureList = response.d;
                        /*
                        var dropdown = $("#select3");

                        dropdown.empty();
                        dropdown.append(
                $("<option></option>")
                    .val("")
                    .text("-- Select Loan Nature --")
            );

                        $.each(response.d, function (i, item) {
                            dropdown.append(
                    $("<option></option>")
                        .val(item.short_name)
                        .text(item.name)
                );
                        });
                        */

                    },

                    error: function (xhr, status, error) {
                        console.error("Error loading loan nature:", error);
                    }
                });
            }

            //addFacilityRow();


            var facilityCounter = 0;

            function addFacilityRow() {

                facilityCounter++;

                var row =
        '<tr class="facility-row">' +

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
                });

                $dropdown = $row.find(".natureOfFacility");

                //Bind database records to the dropdown
                $.each(loanNatureList, function (index, item) {
                    $dropdown.append(
            $("<option></option>")
                .val(item.short_name)
                .text(item.name)
        );
                });


                $("#facilityBody").append($row);

                initializeDatepicker();

                // Initialize Select2 for this new row
                /*
                $row.find(".customerId").select2({
                    width: "200px",
                    placeholder: "Select Customer",
                    allowClear: true
                });
                */
                // Initialize Select2 for this new row
                /*
                $row.find(".natureOfFacility").select2({
                    width: "200px",
                    placeholder: "Select Facility",
                    allowClear: true
                });
                */

            }


            $("#facilityBody").on("click", ".remove-btn", function () {
                var $row = $(this).closest("tr");

                $row.find(".natureOfFacility").select2("destroy");
                $row.remove();
            });




            $("#btnAddMore").on("click", function () {
                addFacilityRow();
            });


            $("#<%=select1.ClientID%>,#select2,#<%=select3.ClientID%>").select2({
                placeholder: "<--Select-->",
                allowClear: true
            });



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
                $("#txtSancDate, .date").each(function () {
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

        });




    </script>
    <script type="text/javascript">


        $(document).ready(function () {



            $('#<%=select1.ClientID%>').on('change', function () {
                $('#hfSelected').val($(this).val());
            });

            $('#<%=select3.ClientID%>').on('change', function () {
                $('#hfSelectedLoanNature').val($(this).val());
            });





        });

    </script>
    <script type="text/javascript">


        $(document).ready(function () {


            $("#btnSave").click(function () {




                var cus_ids = $('#hfSelected').val();

                var sanc_ref = $('#txtSancRef').val();

                var sanc_date = $('#txtSancDate').val();

                var sanc_auth = $('#select2').val();

                var booking_branch = $('#ContentPlaceHolder1_select3').val();


                var formData = new FormData();

                formData.append("cus_ids", cus_ids);
                formData.append("sanction_reference", sanc_ref);
                formData.append("sanction_date", sanc_date);
                formData.append("sanction_authority", sanc_auth);
                formData.append("booking_branch", booking_branch);

                var file = $("#sanc_doc")[0].files[0];

                if (file) {
                    formData.append("sanction_doc", file);
                }



                $.ajax({
                    type: "POST",
                    url: "SanctionUploadHandler.ashx",
                    data: formData,
                    contentType: false,
                    processData: false,

                    success: function (response) {

                        if (response.message == "Data Saved") {
                            swal("Success!", "Data Saved Successfully", "success");
                        }
                        else {
                            swal("Error!", "Data not Saved!", "error");
                        }
                    },

                    error: function (xhr) {
                        console.log(xhr.responseText);
                        swal("Error!", "Data not Saved!", "error");
                    }
                });

            });


            $("#btnSave_22").click(function () {

                var file = $("#sanc_doc")[0].files[0];

                if (!file) {
                    swal("Error!", "Please select sanction document!", "error");
                    return false;
                }

                var formData = new FormData();
                formData.append("file", file);

                $.ajax({
                    type: "POST",
                    url: "UploadSanctionFile.ashx",
                    data: formData,
                    contentType: false,
                    processData: false,

                    success: function (response) {

                        var sanc_doc = response.fileName;

                        // Now call your existing WebMethod


                        var obj = {};


                        obj.cus_ids = cus_ids;
                        obj.sanction_reference = sanc_ref;
                        obj.sanction_date = sanc_date;
                        obj.sanction_authority = sanc_auth;
                        obj.booking_branch = booking_branch;
                        obj.sanction_doc = sanc_doc;

                        $.ajax({
                            type: "POST",
                            url: "SanctionUpload.aspx/Sanction_Upload",
                            data: JSON.stringify({ Obj: obj }),
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",

                            success: function (msg) {
                                // your existing success code
                            },

                            error: function () {
                                swal("Error!", "Data not Saved!", "error");
                            }
                        });
                    },

                    error: function () {
                        swal("Error!", "File upload failed!", "error");
                    }
                });

            });

            $("#btnSave_bk").click(function () {

                //alert('dddddddddd');

                var obj = {};

                var cus_ids = $('#hfSelected').val();

                var sanc_ref = $('#txtSancRef').val();

                var sanc_date = $('#txtSancDate').val();

                var sanc_auth = $('#select2').val();

                var booking_branch = $('#ContentPlaceHolder1_select3').val();

                var sanc_doc = "";





                //alert(cus_ids + '-' + loan_natures + '-' + securities);


                obj.cus_ids = cus_ids;
                obj.sanction_reference = sanc_ref;
                obj.sanction_date = sanc_date;
                obj.sanction_authority = sanc_auth;
                obj.booking_branch = booking_branch;
                obj.sanction_doc = sanc_doc;






                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "SanctionUpload.aspx/Sanction_Upload",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",

                    success: function (msg) {

                        var message = msg.d[0];
                        var dd_id = msg.d[1];


                        //alert("Data Saved Successfully.");

                        //alert(msg.d);

                        if (message == "Data Saved") {

                            swal("Success!", "Data Saved Successfully", "success");

                            //                            $("#btnUpload").css({ "display": "block" });

                            //                            $("#btnUpload").attr("drawdown-id", dd_id);


                            //                            $("#btnUpload").attr("cus-id", cus_ids);
                            //                            $("#btnUpload").attr("loan-natures", loan_natures);
                            //                            $("#btnUpload").attr("securities", securities);


                        }

                        else {
                            swal("Error!", "Data not Saved!", "error")
                        }




                    },
                    error: function () {
                        //alert("Error while inserting data");
                        //sweetAlert("Oops...", "Something went wrong!", "error");
                        //sweetAlert("Oops...", "Something went wrong!", "error");
                        swal("Error!", "Data not Saved!", "error")
                    }
                });

                return false;


            });


            $("#btnUpload").click(function () {

                //var cus_type = $("#Select1").val();
                //var cus_code = $("#txtCustomerCode").val();
                //alert(type + '-' + cus_code);
                //getDetails(cus_type, cus_code)

                var dd_id = $(this).attr("drawdown-id");
                var cus_id = $(this).attr("cus-id");
                //var loan_natures = $(this).attr("loan-natures");
                //var securities = $(this).attr("securities");


                //alert(dd_id + '-' + cus_id + '-' + loan_natures + '-' + securities);


                //var e_doc_id = $(this).attr("e-doc-id");
                //var auto_id = $(this).attr("auto_id");

                //alert(cus_type + '-' + e_doc_id + '-' + auto_id);

                //url = "DocumentUpload_V2.aspx?var=" + cus_type + "&var2=" + auto_id + "&var3=" + e_doc_id;

                //url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var2=" + auto_id + "&var3=" + e_doc_id;

                url = "DocumentUpload_V10_New_Mapping_Drawdown.aspx?var=" + dd_id + "&var3=" + cus_id;

                var width = screen.availWidth - 100;
                var height = screen.availHeight - 100;
                var left = parseInt((screen.availWidth / 2) - (width / 2));
                var top = parseInt((screen.availHeight / 2) - (height / 2));
                var windowFeatures = "width=" + width + ", height=" + height + ", status, resizable, screenX=" + left + ", screenY=" + top;

                //var NWin = window.open("PopUpHelper.aspx?txtBox='"+test+"'&var1="+test+"&var2="+test,'_blank', windowFeatures);
                //var NWin = window.open("Menu.aspx", windowFeatures);
                //alert(windowFeatures);
                //newwindow = window.open('Menu.aspx', 'name', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                //newwindow = window.open(pagename, '_blank', ' resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow = window.open(url, '_blank', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow.focus();


            });

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
    	<h1>
        	Sanction
        	 
        </h1>
        <ol class="breadcrumb">
        	<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Drawdown</a></li>
    	</ol>
	</section>
    <!-- Main content -->
    <section class="content">


    <div class="row">
        	<!-- left column -->
            <div class="col-md-10">
            	<!-- general form elements -->
              	<div class="box box-primary">
                	<div class="box-header with-border">
                  		<h3 class="box-title">New</h3>
                	</div><!-- /.box-header -->
                	<!--  //MSK-00097 form start -->
                            
                  		<div class="box-body">


                        <div class="row">
                        
                        
                        
                        <div class="col-md-6">
                        
                        
                        
                    		<div class="form-group"  >
                      	  <label for="ddlCustomer">Customer ID</label>
                  <select id="select1"   runat="server"  multiple    class="form-control">
                  
                   
                  
                   </select>
                   
                    
              <input id="hfSelected" type="hidden" />
              <input id="hfSelectedLoanNature" type="hidden" />
              <input id="hfSelectedSecurity" type="hidden" />
         </div>
                        
                        </div>



                            <div class="col-md-6">
                                <div class="form-group" >
                      			        <label for="">Sanction Reference</label>
                      			        <input type="text" class="form-control" id="txtSancRef" placeholder="Enter Santion Reference" name="name" autocomplete="off"/>
                    		    </div>

                            </div>


                        </div>
                   
                   <div class="row">
                   

                   <div class="col-md-6"> <div class="form-group"  >
                      			<label for="">Santion Date</label>
                      			<input type="text" class="form-control" id="txtSancDate" placeholder="Enter Santion Date" name="admission_fee" autocomplete="off"/>
                    		</div></div>
                   
                      <div class="col-md-6">    
                             <div class="form-group"  >
                      			<label for="">Sanction Authorty</label>
                      	   <select id="select2"         class="form-control">
                           
                           <option value=""><--Select--></option>
                           <option value="CRM">CRM</option>
                           
                           <option value="CBD">CBD</option>
                           <option value="Agri">Agri</option>

                           <option value="SME">SME</option>

                            </select>
             
                    		</div></div>
                   
                   </div>

                            
 <div class="row">
                   

                   <div class="col-md-6"></div>
                   
                      <div class="col-md-6"></div>
                   
                   </div>



                            


                        


                              <div class="form-group"  >
                      			<label for="">Booking Branch</label>
                      	        <select id="select3"   runat="server"       class="form-control">
                                </select>
                    		</div>

 
                             
                              <div class="form-group">
                  <label for="exampleInputFile">Upload Sanction Document</label>
                  <input type="file" id="sanc_doc"/>
                  
                </div>

                <hr />

                 <h3>Facility Details</h3>

    <button type="button" id="btnAddMore">+ Add More</button>

    <table>
        <thead>
            <tr>
                <th>Customer ID</th>
                <th>Nature of Facility</th>
                <th>Amount</th>
                <th>Validity</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="facilityBody"></tbody>
    </table>
                  		</div><!-- /.box-body -->
                  		<div class="box-footer">
                  			<input type="hidden" name="do" value="add_grade" />
                    		<button type="button" class="btn btn-primary" id="btnSave">Save</button>

                            <button type="button" class="btn btn-primary" id="btnUpload" style="  display:none;" >Upload</button>

                  		</div>
                	 
				</div><!-- /.box -->
			</div>
		</div>
      
    </section>
</asp:Content>
<asp:Content ID="aa" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript">


   





    </script>
</asp:Content>
