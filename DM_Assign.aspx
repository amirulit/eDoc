<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DM_Assign.aspx.cs" Inherits="DM_Assign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script type="text/javascript">

      $(document).ready(function () {



          $("#<%=Select1.ClientID%>").select2({

              placeholder: "<--Select-->",
              allowClear: true,
              width: '100%'


          });




          $('#btnSubmit').click(function () {




              //var currentValue = $("#lblID").text();
              var id = $("#lblID").text(); // Or get from an input field

              var $row = $("#row_" + id);


              var dm = $("#<%=Select1.ClientID%>").val();

              $.ajax({
                  type: "POST",
                  url: "DM_Assign.aspx/AssignDM", // Replace with your ASP.NET page name
                  data: JSON.stringify({ drawdown_id: id, dm: dm }), // Parameters matching your Web Method
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (response) {
                      // Check if the server responded with success
                      //if (response.d.includes("successfully")) {
                      if (response.d == "Database updated successfully!") {

                          alert('Assigned');
                          // --- OPTION A: Change background color directly ---
                          $row.css("background-color", "#d4edda"); // Soft green color

                          // --- OPTION B: Add a CSS class (Recommended) ---
                          // $row.addClass("row-updated");

                          // Optional: How to verify if that step was successful?
                          // You will see the row highlight in green immediately upon completion.
                      } else {
                          alert("Server error: " + response.d);
                      }
                  },
                  error: function (xhr, status, error) {
                      alert("Error: " + error);
                  }
              });




          });


      });




    </script>



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



            $("body").on("click", ".assign", function () {
                var edoc_id = $(this).attr("edoc-id");
                $("#lblID").text(edoc_id);
                alert(edoc_id);

                //var $row = $(element).closest("tr");


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
          						<h4 class="modal-title custom_align" id="Heading">Assign Documentation Manager</h4>
                            </div>
                            <div class="panel-body"> <!-- Start of modal body--> 

                            ID # <span id="lblID" class="badge  badge-success"></span>

                                <!--
                                <div class="form-group" id="divSubjectUpdate">
                                    <label for="">Subject</label>
                                    <input class="form-control" type="text" id="name1" name="name" autocomplete="off">
                                </div> 

                                -->

                                <div class="form-group" id="div1">
                                    <label for="">Documentation Manager</label>
                                     <select id="Select1"  class="form-control" runat="server" >
 

</select>
                                </div> 
                            </div><!--/.modal body-->
                            <div class="panel-footer bg-gray-light">
                                <input type="hidden" id="id" name="id" value="" >
                                <button type="button"   id="btnSubmit" class="btn btn-info" style="width: 100%;"><span class="glyphicon glyphicon-ok-sign"></span> Assign</button>         
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
<tr id="row_<%=TableData.Rows[data]["dd_id"]%>">
                        <td><%=TableData.Rows[data]["id"]%></td>
                        <td><%=TableData.Rows[data]["dd_id"]%></td>
                          <td><%=TableData.Rows[data]["cus_type"]%></td>
                        <td><%=TableData.Rows[data]["cus_id"]%></td>
                        <td><%=TableData.Rows[data]["cus_name_2"]%></td>
                          
                          <td><%=TableData.Rows[data]["loan_natures"]%></td>
                            <td><%=TableData.Rows[data]["securities"]%></td>
                              <td><%=TableData.Rows[data]["loan_amount"]%></td>
                                <td><%=TableData.Rows[data]["exp_date_2"]%></td>

                  
                        	
                        <td>        

                        <!--
                        <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>"  drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">Edit</a>                                    

                        <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">Document Upload</a>                                    
                        -->
                        <!--
                        <a href="#"  class="btn btn-info btn-xs upload" cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Upload</a>                                    
  


                        <a href="#"  class="btn btn-primary btn-xs view" cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">View</a>                                    
  


                        <a href="#"  class="btn btn-success btn-xs pdf" cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Pdf Gen</a>                                    
  
  -->


     <a href="#modalUpdateform"  class="btn btn-success btn-xs assign"  data-toggle="modal"  cus-id="<%=TableData.Rows[data]["cus_id"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Assign DM</a>                                    
  




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
