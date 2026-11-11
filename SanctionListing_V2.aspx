<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SanctionListing_V2.aspx.cs" Inherits="SanctionListing_V2" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <style type="text/css">
    
    @media (min-width: 768px) {
    .modal-extra-lg {
        width: 95%;
    }
}

@media (min-width: 1200px) {
    .modal-extra-lg {
        width: 90%;
        max-width: 1600px;
    }
}


    </style>



    <script src="FileUpload.js" type="text/javascript"></script>
    <script type="text/javascript">

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


                var edoc_id = $(this).data("edocid");

                $("#lblID").text(edoc_id);




                //$('#sanctionModal').modal('show');


                ViewSanctionDetails(edoc_id);

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


            function ViewSanctionDetails(id) {

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

                            $("#mSanctionReference").text(data.Master.sanction_reference);

                            $("#mSanctionDate").text(data.Master.sanction_date);

                            $("#mSanctionSegment").text(data.Master.sanction_segment);

                            $("#mApprovalAuthority").text(data.Master.sanction_approval_authority);

                        }

                        // =========================
                        // DETAIL INFORMATION
                        // =========================

                        $("#tbodySanctionDetails").empty();

                        $.each(data.Details, function (i, item) {

                            var tr = $("<tr>");

                            $("<td>").text(i + 1).appendTo(tr);

                            $("<td>").text(item.customer_id).appendTo(tr);

                            $("<td>").text(item.customer_name).appendTo(tr);

                            $("<td>").text(item.loan_nature_name).appendTo(tr);

                            $("<td>").text(item.currency).appendTo(tr);

                            $("<td>").text(Number(item.amount).toLocaleString()).appendTo(tr);

                            $("<td>").text(item.validity).appendTo(tr);

                            // Delete button
                            $("<td>").append(
                    $("<button>", {
                        type: "button",
                        class: "btn btn-danger btn-xs btnDeleteDetail",
                        text: "Delete"
                    }).attr("data-id", item.id)
                ).appendTo(tr);

                            $("#tbodySanctionDetails").append(tr);

                        });

                        // Show modal
                        $("#sanctionModal").modal("show");

                    },

                    error: function (xhr) {

                        console.log(xhr.responseText);

                        alert("Unable to load sanction details.");

                    }
                });
            }


            $(document).on("click", ".btnDeleteDetail", function () {

                var detailId = $(this).attr("data-id");

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

                        if (response.d === "success") {

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

                <!-- Master Information -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Master Information</h3>
                    </div>

                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-3">
                                <label>eDoc ID</label>
                                <p id="mEdocId"></p>
                            </div>

                            <div class="col-md-3">
                                <label>Booking Branch</label>
                                <p id="mBookingBranch"></p>
                            </div>

                            <div class="col-md-3">
                                <label>Sanction Reference</label>
                                <p id="mSanctionReference"></p>
                            </div>

                            <div class="col-md-3">
                                <label>Sanction Date</label>
                                <p id="mSanctionDate"></p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <label>Sanction Segment</label>
                                <p id="mSanctionSegment"></p>
                            </div>

                            <div class="col-md-6">
                                <label>Approval Authority</label>
                                <p id="mApprovalAuthority"></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detail Information -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Loan / Facility Details</h3>
                    </div>

                    <div class="box-body table-responsive">
                        <table class="table table-bordered table-striped" id="tblSanctionDetails">
                            <thead>
                                <tr>
                                    <th>SL</th>
                                    <th>Customer Code</th>
                                    <th>Customer Name</th>
                                    <th>Loan Nature</th>
                                    <th>Currency</th>
                                    <th>Amount</th>
                                    <th>Validity</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody id="tbodySanctionDetails"></tbody>
                        </table>
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


  <a href="#"  class="btn btn-success btn-xs view" data-edocid="<%=TableData.Rows[data]["edoc_id"]%>"  data-id="<%=TableData.Rows[data]["id"]%>">View</a>                                    

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
