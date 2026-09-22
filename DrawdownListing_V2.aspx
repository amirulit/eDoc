<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DrawdownListing_V2.aspx.cs" Inherits="DrawdownListing_V2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            $("body").on("click", ".upload", function () {

                var cus_id = $(this).attr("cus-id");
                //var auto_id = $(this).attr("auto-id");
                //var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);
                //DocumentUpload_V10_New_Mapping_Drawdown.aspx
                //url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                url = "DocumentUpload_V10_New_Mapping_Drawdown.aspx?var=" + drawdown_id + "&var1=" + cus_id;


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


            $("body").on("click", ".reason", function () {

                var dd_id = $(this).attr("drawdown-id");

                $("#lblID").text(dd_id);


                $.ajax({
                    type: "POST",
                    url: "DrawdownListing_V2.aspx/GetReason",
                    data: JSON.stringify({
                        drawdown_id: dd_id
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {
                    /*
                        var item = response.d;

                        var row = "<tr>" +
            "<td>" + item.id + "</td>" +
            "<td>" + item.cus_name + "</td>" +
            "<td>" + item.cr_incharge_decline_reason + "</td>" +
            "<td>" + item.hob_decline_reason + "</td>" +
            "<td>" + item.dm_decline_reason + "</td>" +
            "<td>" + item.unit_head_decline_reason + "</td>" +
            "</tr>";

            $("#reasonTable").html(row);
            */


                        var data = response.d;
                        var html = "";

                        $.each(data, function (key, value) {

                            html += "<tr>";
                            html += "<th>" + key + "</th>";
                            html += "<td>" + (value == null ? "" : value) + "</td>";
                            html += "</tr>";

                        });


                        $("#reasonTable").html(html);
                        
                    },

                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });


                $('#modalUpdateform').modal('show');




            });


            $("body").on("click", ".view", function () {

                var cus_id = $(this).attr("cus-id");
                //var auto_id = $(this).attr("auto-id");
                //var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);
                //DocumentUpload_V10_New_Mapping_Drawdown.aspx
                //url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                url = "Checklist_View_V2.aspx?var=" + drawdown_id + "&var1=" + cus_id;


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




            $("body").on("click", ".pdf", function () {

                var cus_id = $(this).attr("cus-id");
                //var auto_id = $(this).attr("auto-id");
                //var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);
                //DocumentUpload_V10_New_Mapping_Drawdown.aspx
                //url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                url = "Checklist_View_V2_PdfGen.aspx?var=" + drawdown_id + "&var1=" + cus_id;


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
    <section class="content"> <!-- Start of table section -->


    
    <div class="modal" id="modalUpdateform" tabindex="-1" role="dialog" aria-labelledby="modalUpdateform" aria-hidden="true">  
  		<div class="modal-dialog">
    		<div class="container">
            	<div class="row ">	
           			<div class="col-md-6">
                		<div class="panel">
        					<div class="panel-heading bg-orange">                 
        						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          						<h4 class="modal-title custom_align" id="Heading">Decline Reason</h4>
                            </div>
                            <div class="panel-body"> <!-- Start of modal body--> 


                             ID # <span id="lblID" class="badge  badge-success"></span>


                             <hr />
                           
                            <!--
                                <div class="form-group" id="divSubjectUpdate">
                                    <label for="">Subject</label>
                                    <input class="form-control" type="text" id="name1" name="name" autocomplete="off"/>
                                </div> 
                              
                                 <div class="form-group" id="div2">
                                 Please upload following documents :

                                 <ul>
                                 
                                    <li>Checklist Scancopy</li>
                                    <li>Accepted Scancopy</li>
                                    <li>Board Resolution</li>
                                    <li>Others</li>


                                 </ul>
                                 </div>

 
                                <div class="form-group" id="div1">
                                     <input id="fileUploadID" type="file"  multiple />
 
                                </div> 

                                  <div id='r'>
                        </div>
                          -->

                        <table id="reasonTable" class="table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Department</th>
            <th>Salary</th>
             <th>Department</th>
              <th>Department</th>
        </tr>
    </thead>

    <tbody id="employeeBody">
    </tbody>
</table>


                            </div><!--/.modal body-->
                            <div class="panel-footer bg-gray-light">
                                <input type="hidden" id="id" name="id" value="" />
                                <button type="button"   id="btnSubmit" class="btn btn-info" style="width: 100%;"><span class="glyphicon   glyphicon-upload"></span>Upload</button>         
        	  				</div><!--/.panel-footer--> 
            			</div><!--/.panel-->
            		</div><!--/.col-md-6-->
            	</div><!--/.row-->                                        
        	</div><!-- /.modal-content -->  		 
		</div><!-- /.modal-dialog -->            
	</div><!--/.Modal-Update form -->   



    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">Drawdown Listing </h3>
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>ID</th>
                                <th>Drawdown ID</th>
                                <th>Customer Type</th>
                            	<th>Customer ID</th>
                            	<th>Customer Name</th>
                                <th>Loan Natures</th>
                                <th>Securities</th>
                                   <th>Loan Amount</th>
                                      <th>Expiry Date</th>
                                       <th>Status</th>


                            	<th>Action</th>
                                   </tr>
                        	</thead>
                         
                        	<tbody>
    <%
                    
        //var sts = "";
        //var id = "";
        //var css = "";

        //var last_renew_dt = "";


        if (TableData.Rows.Count > 0)
        {
            for (var data = 0; data < TableData.Rows.Count; data++)
            {
                            
%>
<tr>
                        <td><%=TableData.Rows[data]["id"]%></td>
                        <td><%=TableData.Rows[data]["dd_id"]%></td>
                          <td><%=TableData.Rows[data]["cus_type"]%></td>
                        <td><%=TableData.Rows[data]["cus_id"]%></td>
                        <td><%=TableData.Rows[data]["cus_name_2"]%></td>
                          
                          <td><%=TableData.Rows[data]["loan_natures"]%></td>
                            <td><%=TableData.Rows[data]["securities"]%></td>
                              <td><%=TableData.Rows[data]["loan_amount"]%></td>
                                <td><%=TableData.Rows[data]["exp_date_2"]%></td>

                                 <td><%=TableData.Rows[data]["status_desc"]%></td>

                  
                        	
                        <td>        

                        <!--
                        <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>"  drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">Edit</a>                                    

                        <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">Document Upload</a>                                    
                        -->

                        <a href="#"  class="btn btn-info btn-xs upload" cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Upload</a>                                    
  

                        <a href="#"  class="btn btn-primary btn-xs view" cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">View</a>                                    
  
                        
                        <a href="#"  class="btn btn-primary btn-xs reason" cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">View</a>                                    
  

                        <a href="#"  class="btn btn-success btn-xs pdf" cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Pdf Gen</a>                                    
  
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
