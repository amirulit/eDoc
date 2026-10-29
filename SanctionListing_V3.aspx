<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SanctionListing_V3.aspx.cs" Inherits="SanctionListing_V3" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .select2-container--default .select2-selection--multiple .select2-selection__choice
        {
            color: blue !important;
        }
        
        .modal-footer
        {
            text-align: center;
        }
        
        .modal-footer .btn
        {
            float: none;
            display: inline-block;
        }
    </style>


    <script src="sweet_alert.js" type="text/javascript"></script>
    <link href="sweet_alert.css" rel="stylesheet" type="text/css" />


    <script type="text/javascript">

        $(document).ready(function () {


            $('#<%=select4.ClientID%>').on('change', function () {
                $('#hfSelectedSecurity').val($(this).val());
            });

            $("#<%=select4.ClientID%>").select2({
                placeholder: "<--Select-->",
                allowClear: true,
                width: "100%"
            });




            /*
            $("#btnSave").on("click", function () {
            getSelectedSanctions();

            });
            */



            $("body").on("click", ".view", function () {


                var id = $(this).data("id");

                alert(id);

                /*
                var row = $(this).closest('tr');

                var id = row.find('td').eq(0).text().trim();
                var edoc_refno = row.find('td').eq(1).text().trim();
                var booking_branch = row.find('td').eq(2).text().trim();
                var sanction_reference = row.find('td').eq(3).text().trim();
                var sanction_date = row.find('td').eq(4).text().trim();
                var sanction_segment = row.find('td').eq(5).text().trim();
                var approval_authority = row.find('td').eq(6).text().trim();
                var customer_name = row.find('td').eq(7).text().trim();
                var total_amount = row.find('td').eq(8).text().trim();
                */

                //Get clicked row from the source table
                var sourceRow = $(this).closest('tr');
                var sourceTd = sourceRow.find('td');

                // Get target table TDs by position
                var targetTd = $('#tblSummary tr td');

                targetTd.eq(0).text(sourceTd.eq(0).text().trim()); // ID
                targetTd.eq(1).text(sourceTd.eq(1).text().trim()); // EDOC Ref NO#
                targetTd.eq(2).text(sourceTd.eq(2).text().trim()); // Branch
                targetTd.eq(3).text(sourceTd.eq(4).text().trim()); // Date
                targetTd.eq(4).text(sourceTd.eq(5).text().trim()); // Segment
                targetTd.eq(5).text(sourceTd.eq(6).text().trim()); // Authority
                targetTd.eq(6).text(sourceTd.eq(3).text().trim()); // Authority

                //jQuery('#sanctionModal').modal('show');

                openSanctionModal_V2(id);


            });



            function openSanctionModal_V2(id) {




                $('#sanctionModal').modal('show');
                $('#sanctionLoading').show();
                $('#sanctionTableBody').empty();





                $.ajax({

                    type: "POST",
                    url: "SanctionListing_V3.aspx/GetSanctionDetails",
                    data: '{id: ' + id + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",



                    success: function (response) {

                        var data = response.d || [];

                        var html = '';


                        //var $tbody = $("#sanctionTableBody");

                        //$tbody.empty();



                        $.each(data, function (i, item) {



                            html += '<tr data-id="' + item.id + '" data-custype="' + item.cus_type + '" data-loantype="' + item.short_form + '">';

                            html += '<td><input type="checkbox" class="row-checkbox" value="' + item.id + '"></td>';

                            html += '<td>' + (item.id == null ? '' : item.id) + '</td>';

                            html += '<td>' + (item.customer_id == null ? '' : item.customer_id) + '</td>';
                            html += '<td>' + (item.customer_name == null ? '' : item.customer_name) + '</td>';
                            html += '<td>' + (item.loan_nature == null ? '' : item.loan_nature) + '</td>';
                            //html += '<td>' + (item.loan_nature_edoc == null ? '' : item.loan_nature_edoc) + '</td>';
                            html += '<td>' + (item.currency == null ? '' : item.currency) + '</td>';
                            html += '<td>' + (item.amount == null ? '' : item.amount) + '</td>';
                            html += '<td>' + (item.validity == null ? '' : item.validity) + '</td>';

                            html += '</tr>';



                            //console.log(html);

                            /*
                            var $row = $("<tr></tr>");


                            $row.attr("data-id", item.id);
                            $row.attr("data-custype", item.cus_type);
                            $row.attr("data-loantype", item.short_form);


                            var $checkbox = $("<input>", { type: "checkbox", "class": "chkRow" });

                            var $checkCell = $("<td></td>").append($checkbox);

                            $row.append($checkCell);

                            $row.append($("<td></td>").text(item.id));
                            $row.append($("<td></td>").text(item.customer_id));
                            $row.append($("<td></td>").text(item.customer_name));
                            $row.append($("<td></td>").text(item.loan_nature));
                            $row.append($("<td></td>").text(item.currency));
                            $row.append($("<td></td>").text(item.amount));
                            $row.append($("<td></td>").text(item.validity));

                            $tbody.append($row);

                            console.log($row);

                            */




                        });

                        console.log(html);

                        $('#sanctionTableBody').empty().append(html);

                        $('#chkSelectAll').prop('checked', false);

                        updateSelectedCount();




                    },


                    error: function (xhr) {
                        alert('Error loading sanction records.');
                        console.error(xhr.responseText);
                    },

                    complete: function () {
                        $('#sanctionLoading').hide();
                    }


                });
            }


            function openSanctionModal() {







                $('#sanctionModal').modal('show');
                $('#sanctionLoading').show();
                $('#sanctionTableBody').empty();

                $.ajax({
                    type: "POST",
                    url: "SanctionListing_V3.aspx/GetSanctionDetails",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {
                        var data = response.d || [];
                        var tbody = $('#sanctionTableBody');

                        $.each(data, function (i, item) {
                            var tr = $('<tr>');

                            $('<td>').append($('<input>', { type: 'checkbox', class: 'row-checkbox', value: item.id })).appendTo(tr);

                            [
                    item.id,
                            //item.edoc_id,
                            //item.edoc_refno,
                            //item.sanction_reference,
                    item.customer_id,
                    item.customer_name,
                    item.loan_nature,
                    item.loan_nature_edoc,
                    item.currency,
                    item.amount,
                    item.validity
                ].forEach(function (value) {
                    $('<td>')
                        .text(value == null ? '' : value)
                        .appendTo(tr);
                });

                            tbody.append(tr);


                        });

                        $('#chkSelectAll').prop('checked', false);

                        updateSelectedCount();


                    },

                    error: function (xhr) {
                        alert('Error loading sanction records.');
                        console.error(xhr.responseText);
                    },

                    complete: function () {
                        $('#sanctionLoading').hide();
                    }
                });
            }






            // Select all rows
            $(document).on('change', '#chkSelectAll', function () {

                $('.row-checkbox').prop('checked', this.checked);


                updateSelectedCount();

            });

            // Individual row selection
            $(document).on('change', '.row-checkbox', function () {



                var total = $('.row-checkbox').length;

                var checked = $('.row-checkbox:checked').length;

                $('#chkSelectAll').prop('checked', total > 0 && total === checked);

                updateColor();

                updateSelectedCount();

                updateAmount();


            });

            function updateColor() {


                $("#sanctionTableBody tr").each(function () {

                    //alert('clicked');

                    var checked = $(this).find(".row-checkbox").prop("checked");

                    $(this).css("background-color", checked ? "#d4edda" : "");

                });

            }


            // Selected count
            function updateSelectedCount() {

                $('#selectedCount').text($('.row-checkbox:checked').length + ' selected');

                updateColor();

                updateAmount();




            }

            function updateAmount() {

                var tot_amt = 0.00;


                $("#sanctionTableBody .row-checkbox:checked").each(function () {

                    var $row = $(this).closest("tr");



                    var amt = $row.find('td').eq(6).text().trim();

                    tot_amt = tot_amt + parseFloat(amt);



                });

                document.getElementById("spnAmount").textContent = tot_amt;

            }


            $("#btnSave").on("click", function () {

                var selectedIds = [];

                $('.row-checkbox:checked').each(function () {
                    selectedIds.push(parseInt(this.value, 10));
                });

                if (selectedIds.length === 0) {
                    alert('Please select at least one facility.');
                    return;
                }




                var v_sec = $('#hfSelectedSecurity').val();

                if (v_sec == "") {
                    alert('Please select at least one security.');
                    return;
                }


                var tot_amt = 0.00;

                var rowIds = [];
                var customerIds = [];
                var customerTypes = [];
                var loanTypes = [];
                var securityTypes = [];








                //var targetTd = $('#tblSummary');



                //var sanc_id = '';
                //var edco_refno = '';
                //var sanc_date = '';
                //var sanc_id = '';



                var td = document.querySelectorAll("#tblSummary td");

                var id = td[0].innerText.trim();
                var edocRefNo = td[1].innerText.trim();
                var branch = td[2].innerText.trim();
                var date = td[3].innerText.trim();
                var segment = td[4].innerText.trim();
                var authority = td[5].innerText.trim();
                var sanctionRefNo = td[6].innerText.trim();


                function addUnique(arr, value) {
                    if (value && $.inArray(value, arr) === -1) {
                        arr.push(value);
                    }
                }

                $("#sanctionTableBody .row-checkbox:checked").each(function () {

                    var $row = $(this).closest("tr");


                    var cus_id = $row.find('td').eq(2).text().trim();



                    // All selected row IDs
                    addUnique(rowIds, $row.attr("data-id"));

                    // Unique attribute values only
                    addUnique(customerIds, cus_id);
                    addUnique(customerTypes, $row.attr("data-custype"));
                    addUnique(loanTypes, $row.attr("data-loantype"));
                    addUnique(securityTypes, $row.attr("data-securitytype"));


                    var amt = $row.find('td').eq(6).text().trim();

                    tot_amt = tot_amt + parseFloat(amt);






                });

                var requestData = {



                    id: id,
                    edocRefNo: edocRefNo,
                    branch: branch,
                    date: date,
                    segment: segment,
                    authority: authority,
                    sanctionRefNo: sanctionRefNo,

                    amount: tot_amt,





                    rowIds: rowIds.join(","),
                    customerIds: customerIds.join(","),
                    customerTypes: customerTypes.join(","),
                    loanTypes: loanTypes.join(","),
                    securityTypes: v_sec
                };


                console.log(requestData);








                $.ajax({
                    type: "POST",
                    url: "SanctionListing_V3.aspx/Drawdown_Save_V2",
                    data: JSON.stringify(requestData),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    /*
                    success: function (response) {
                    alert(response.d);
                    },

                    error: function (xhr) {
                    alert("Error saving selected rows.");
                    }
                    */
                    success: function (msg) {
                        var status = msg.d[0];
                        var message = msg.d[1];
                        var dd_id = msg.d[2];


                        //alert("Data Saved Successfully.");

                        //alert(msg.d);

                        if (status == 1) {

                            //if (message == "Data Saved") {

                            swal("Success!", "Data Saved Successfully. Drawdown ID : " + dd_id, "success");






                            //$("#btnUpload").css("display", "inline-block");

                            $("#btnGenerate").attr("drawdown-id", dd_id);

                            $("#btnGenerate").css("display", "inline-block");


                            //$("#btnUpload").attr("cus-id", cus_ids);

                            //$("#btnUpload").attr("loan-natures", loan_natures);

                            //$("#btnUpload").attr("securities", securities);


                            $('#modalUpdateform').modal('show');

                            //var dd_id = $(this).attr("dd-id");

                            $("#lblID").text(dd_id);


                        }

                        else {

                            swal("Error!", "Data not Saved : " + message, "error");

                        }



                    },
                    error: function () {
                        //alert("Error while inserting data");
                        //sweetAlert("Oops...", "Something went wrong!", "error");
                        //sweetAlert("Oops...", "Something went wrong!", "error");
                        swal("Error!", "Data not Saved!", "error")
                    }
                });

            });




            $("#btnGenerate").click(function () {

                var drawdown_id = $(this).attr("drawdown-id");

                alert(drawdown_id);

                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "SanctionListing_V3.aspx/Checklist_Generate",
                    data: '{drawdown_id: ' + drawdown_id + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",

                    success: function (msg) {

                        var status = msg.d[0];
                        var message = msg.d[1];
                        //var dd_id = msg.d[2];


                        //alert("Data Saved Successfully.");

                        //alert(msg.d);

                        if (status == 1) {
                            //if (message == "Data Saved") {

                            swal("Success!", message, "success");

                            $("#btnUpload").css({ "display": "inline-block" });

                            $("#btnUpload").attr("drawdown-id", drawdown_id);


                            //$("#btnUpload").attr("cus-id", cus_ids);
                            //$("#btnUpload").attr("loan-natures", loan_natures);
                            //$("#btnUpload").attr("securities", securities);


                        }

                        else {

                            swal("Error!", "Data not Saved : " + message, "error");



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

            //Retrieve selected IDs



            function getSelectedSanctions() {

                var selectedIds = [];

                $('.row-checkbox:checked').each(function () {
                    selectedIds.push(parseInt(this.value, 10));
                });

                if (selectedIds.length === 0) {
                    alert('Please select at least one record.');
                    return;
                }

                console.log(selectedIds);


                var v = $('#hfSelectedSecurity').val();

                console.log(v);

                // Example: [1, 3, 5]
                // Send these IDs to another WebMethod if required.

                //$('#sanctionModal').modal('hide');
            }



            $("body").on("click", ".upload", function () {

                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);

                url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

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
    <section class="content">
    
    <!-- Start of table section -->


    



    <div class="modal" id="sanctionModal" tabindex="-1" role="dialog" aria-labelledby="sanctionModalLabel">

    <div class="modal-dialog  modal-lg " role="document" >

        <div class="modal-content">

            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="sanctionModalLabel">Select Facility
                </h4>
            </div>

            <div class="modal-body">
                <p id="sanctionLoading" style="display:none;">
                    Loading records...
                </p>

                <div class="row">
                <div class="col-md-4">

                <table id="tblSummary" class="table  table-responsive " >
                <tr>
                <th>ID</th><td></td> </tr>
                <tr> <th>EDOC Ref NO#</th><td></td> </tr>
                <tr> <th>Branch</th><td></td> </tr>
                <tr> <th>Date</th><td></td> </tr>
                <tr> <th>Segment</th><td></td> </tr>
                <tr> <th>Authority</th><td></td> </tr>
                  <tr> <th>Sanction Ref NO#</th><td></td> </tr>
                
               
                
                </table>
                </div>
                 </div>

                <div class="table-responsive">
                    <table class="table table-bordered table-striped"
                           id="tblSanction">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox"
                                           id="chkSelectAll" />
                                </th>
                                <th>ID</th>
                               
                                <th>Customer ID</th>
                                <th>Customer Name</th>
                                <th>Loan Nature</th>
                              
                                <th>Currency</th>
                                <th>Amount</th>
                                <th>Validity</th>
                            </tr>
                        </thead>
                        <tbody id="sanctionTableBody"></tbody>
                    </table>
                </div>

                <strong id="selectedCount">0 selected</strong>


                <br />

                <b>Amount: </b> <span id="spnAmount"></span>

                <br />

                <b>Securities : </b>


                  <select id="select4"   runat="server"  multiple    class="form-control"></select>


                  <input id="hfSelectedSecurity" type="hidden" />    

            </div>
            <div class="modal-footer text-center" style=" justify-content: center;">

                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                <button type="button" class="btn btn-primary" id="btnSave">Save</button>
 

                <button type="button" class="btn btn-primary" id="btnGenerate" style="display:none;" >Checkist Generate</button>


                <button type="button" class="btn btn-primary" id="btnUpload" style="display:none;" >Upload</button>

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
                                <th>Ref NO#</th>
                            	<th>Branch</th>
                            	<th>Sanction Ref NO#</th>
                            	<th>Sanction Date</th>

                                <th>Sanction Segment</th>
                                <th>Sanction Authority</th>
                                <th>Customer Name</th>
                                <th>Total Amount</th>
                                <th>Status</th>

                                <th>Action</th>
                             </tr>
                        	</thead>
                         
                        	<tbody>
    <%
                    
        //var sts = "";
        //var css = "";

        //var last_renew_dt = "";

        Int32 id;


        if (TableData.Rows.Count > 0)
        {
            for (var data = 0; data < TableData.Rows.Count; data++)
            {
                id = Convert.ToInt32(TableData.Rows[data]["edoc_id"]);
%>
<tr id ="row_<%=id %>">


                        <td><%=TableData.Rows[data]["edoc_id"]%></td>
                        <td><%=TableData.Rows[data]["edoc_refno"]%></td>
                        <td><%=TableData.Rows[data]["booking_branch"]%></td>
                        <td><%=TableData.Rows[data]["sanction_reference"]%></td>
                        <td><%=TableData.Rows[data]["sanction_date"]%></td>

                        <td><%=TableData.Rows[data]["sanction_segment"]%></td>
                        <td><%=TableData.Rows[data]["sanction_approval_authority"]%></td>
                        <td><%=TableData.Rows[data]["cus_name"]%></td>
                        <td><%=TableData.Rows[data]["total_amount"]%></td>
                        <td><%=TableData.Rows[data]["status"]%></td>
                        	
                        <td>        


                        <a href="javascript:void(0);" onclick="openSanctionModal();">Click Me</a>


                        <!--
                        <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["id"]%>"  drawdown-id="<%=TableData.Rows[data]["id"]%>">Edit</a>                                    

                        <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["id"]%>" drawdown-id="<%=TableData.Rows[data]["id"]%>">Document Upload</a>                                    
  
  -->


  <a href="#"  class="btn btn-info btn-xs view"  id="btnView_<%=id %>"  data-id="<%=TableData.Rows[data]["edoc_id"]%>">View</a>                                    


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
       </section>
</asp:Content>
