<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DrawdownCreate_V2.aspx.cs" Inherits="DrawdownCreate_V2"  Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">



<style>


.select2-container--default .select2-selection--multiple .select2-selection__choice {
    color: blue !important;
}
</style>
    <script src="sweet_alert.js" type="text/javascript"></script>
    <link href="sweet_alert.css" rel="stylesheet" type="text/css" />




    <script type="text/javascript">

        $(document).ready(function () {
            $("#<%=select1.ClientID%>,#select2,#<%=select3.ClientID%>,#<%=select4.ClientID%>").select2({
                placeholder: "<--Select-->",
                allowClear: true
            });




            $("#txtSancDate").datepicker
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

                $('#<%=select4.ClientID%>').on('change', function () {
                    $('#hfSelectedSecurity').val($(this).val());
                });


                

            });

 </script>

    <script type="text/javascript">


        $(document).ready(function () {

            $("#btnSave").click(function () {

                //alert('dddddddddd');

                var obj = {};

                var cus_ids = $('#hfSelected').val();

                var loan_natures = $('#hfSelectedLoanNature').val();

                var securities = $('#hfSelectedSecurity').val();

                alert(cus_ids + '-' + loan_natures + '-' + securities);


                obj.cus_ids = cus_ids;
                obj.loan_natures = loan_natures;
                obj.securities = securities;
                obj.sanc_auth = $("#select2").val();
                obj.sanc_ref = $("#txtSancRef").val();
                obj.sanc_date = $("#txtSancDate").val();
                obj.liab_pos = $("#txtLiabPos").val();
                obj.tot_exp = $("#txtExposure").val();
                obj.cib_sts = $("#txtCIBSts").val();




                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "DrawdownCreate_V2.aspx/Drawdown_Save",
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

                            swal("Success!", "Data Saved Successfully. Drawdown ID : " + dd_id, "success");

                            $("#btnUpload").css({ "display": "block" });

                            $("#btnUpload").attr("drawdown-id", dd_id);


                            $("#btnUpload").attr("cus-id", cus_ids);
                            $("#btnUpload").attr("loan-natures", loan_natures);
                            $("#btnUpload").attr("securities", securities);


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
        	Drawdown
        	 
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
            <div class="col-md-6">
            	<!-- general form elements -->
              	<div class="box box-primary">
                	<div class="box-header with-border">
                  		<h3 class="box-title">New</h3>
                	</div><!-- /.box-header -->
                	<!--  //MSK-00097 form start -->
                            
                  		<div class="box-body">
                    		<div class="form-group"  >
                      	  <label for="ddlCustomer">Customer ID</label>
                  <select id="select1"   runat="server"  multiple    class="form-control">
                  
                   
                  
                   </select>

                    
              <input id="hfSelected" type="hidden" />
              <input id="hfSelectedLoanNature" type="hidden" />
              <input id="hfSelectedSecurity" type="hidden" />
       
                   
                            
                             <div class="form-group"  >
                      			<label for="">Sanction Authorty</label>
                      	   <select id="select2"         class="form-control">
                           
                           <option value=""><--Select--></option>
                           <option value="CRM">CRM</option>
                           
                           <option value="CBD">CBD</option>
                           <option value="Agri">Agri</option>

                           <option value="SME">SME</option>

                            </select>
             
                    		</div>


                              <div class="form-group"  >
                      			<label for="">Loan Nature</label>
                      	     <select id="select3"   runat="server"  multiple    class="form-control">
                  
                   
                  
                   </select>

                       
             
                    		</div>


                              <div class="form-group"  >
                      			<label for="">Security</label>
                      	     <select id="select4"   runat="server"  multiple    class="form-control">
                  
                   
                  
                   </select>

                       
             
                    		</div>

                            <div class="form-group" >
                      			<label for="">Sanction Refrence</label>
                      			<input type="text" class="form-control" id="txtSancRef" placeholder="Enter Santion Reference" name="name" autocomplete="off"/>
                    		</div>
                            <div class="form-group"  >
                      			<label for="">Santion Date</label>
                      			<input type="text" class="form-control" id="txtSancDate" placeholder="Enter Santion Date" name="admission_fee" autocomplete="off"/>
                    		</div>
                             <div class="form-group"  >
                      			<label for="">Liability Position</label>
                      		
 <textarea id="txtLiabPos" rows="2" cols="20"  class="form-control" placeholder="Enter Liability Position"></textarea>

                    		</div>

                              <div class="form-group" >
                      			<label for="">Total Exposure</label>
                      		
 <input id="txtExposure" type="text" class="form-control" />

                    		</div>

                              <div class="form-group"  >
                      			<label for="">CIB Status</label>
                      		
 <input id="txtCIBSts" type="text" class="form-control" />

                    		</div>

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
