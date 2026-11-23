<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProfileListing.aspx.cs" Inherits="ProfileListing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            var cus_type;
            var cus_id;



            


            
            $("#Button1").click(function () {

                //var cus_code = $("#txtCompOwnerCustomerID").val();
                var cus_code = $("#ContentPlaceHolder1_Select4").val();
                //var name = $("#txtCompOwnerName").val();
                var role = $("#Select1").val();
                //var address = $("#txtCompOwnerAddress").val();


                //var phone = $("#txtCompOwnerPhone").val();

                //alert(name + '-' + role + '-' + address + '-' + '-' + phone);

                var obj = {};

                var edocid = $("#tblMaster tbody tr:eq(1) td:eq(1)").text();


                obj.edocid = edocid;
                obj.company_cus_code = cus_id;
                //obj.owner_cus_code = $("#txtCompOwnerCustomerID").val();
                obj.owner_cus_code = cus_code;

                //obj.name = name;
                obj.role = role;
                //obj.address = address;

                //obj.phone = phone;


                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "ProfileCreate.aspx/Comp_OwnerInfo_Save",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function () {


                        alert("Data Saved Successfully.");

                        //$("#txtCompOwnerName").val('');
                        //$("#txtCompOwnerAddress").val('');
                        //$("#txtCompOwnerPhone").val('');

                        //("#customerModal").modal("hide");

                        OpenCustomerModal(cus_type, cus_id);


                    },

                    error: function () {
                        alert("Error while inserting data");
                    }


                });

                return false;


            });


            $("body").on("click", ".edit", function () {

                cus_type = $(this).attr("cus-type");
                cus_id = $(this).attr("cus-id");

                // Set value in second footer column
                $('#tblDetails tfoot tr th:eq(1)').text(cus_id);

                /*
                $('#tblDetails tfoot tr th:eq(1)').html(
    '<input type="text" class="form-control" value="' + cus_id + '">'
);
*/


                OpenCustomerModal(cus_type, cus_id);



                $("#customerModal").modal('show');

                $('#customerModal').on('shown.bs.modal', function () {

                    $('#ContentPlaceHolder1_Select4,#Select1').select2({
                        dropdownParent: $('#customerModal'),
                        width: '100%' // Prevents 0px width bugs when initialized inside hidden containers
                    });


                });
                


                //$('#tblDetails').hide();

                //alert(cus_type);

                if (cus_type == 'IND') {
                    //$('#tblDetails').show();

                  

                    //$('#dvMaster').removeClass('col-md-4').addClass('col-md-8');
                    $('#divDetail').css("display", "none");

                } else {
                   
                  //$('#dvMaster').removeClass('col-md-8').addClass('col-md-4');
                    $('#divDetail').css("display", "block");
                }


            });

            $("#ContentPlaceHolder1_Select4").on("change", function () {

                var selectedValue = $(this).find("option:selected").text();

                selectedValue = selectedValue.split('-')[0];

                // Set value in next TH
                $(this).closest("th").next("th").text(selectedValue);

            });


            $("#tblDetails").on("click", ".btnDelete", function () {

                var id = $(this).data("id");

                if (!confirm("Are you sure you want to delete?"))
                    return;

                $.ajax({

                    type: "POST",

                    url: "ProfileListing.aspx/DeleteCustomerDetail",

                    data: JSON.stringify({ id: id }),

                    contentType: "application/json; charset=utf-8",

                    dataType: "json",

                    success: function (response) {

                        if (response.d === "success") {

                            // Remove deleted row
                            $("#tblDetails tbody")
                                .find("button[data-id='" + id + "']")
                                .closest("tr")
                                .remove();

                        }

                    },

                    error: function () {
                        alert("Delete failed.");
                    }

                });

            });

            function OpenCustomerModal(cus_type,customerId) {

                $.ajax({
                    type: "POST",
                    url: "ProfileListing.aspx/GetCustomerDetails",
                    data: JSON.stringify({  cus_type: cus_type ,customerId: customerId}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {


                        var data = response.d;

                        // First result set
                        BindMasterForm(data.Master);

                        // Second result set
                        BindDetailTable(data.Details);




                        $("#customerModal").modal("show");




                        /*
                        
                        $.each(data.Master[0], function (key, value) {

    console.log(key);
    console.log(value);

});



$.each(data.Details, function (i, row) {

    console.log(row.DetailId);
    console.log(row.ProductName);

});
                        
                        */
                    },



                    error: function (xhr, status, error) {
                        console.log(xhr.responseText);
                        console.log(error);
                        alert("Unable to load customer details.");
                    }
                });
            }

            function BindMasterForm(data) {

                var html = "";

                if (!data || data.length === 0) {
                    $("#divMaster").html("<div class='col-12'>No data found</div>");
                    return;
                }

                html +=
                    "<div class='table-responsive'>" +
                        "<table class='table table-bordered table-striped'  id='tblMaster'>" +
                            "<tbody>";

                $.each(data[0], function (key, value) {

                    html +=
                        "<tr>" +
                            "<th style='width:30%;'>" + escapeHtml(key) + "</th>" +
                            "<td>" + escapeHtml(value == null ? "" : value) + "</td>" +
                        "</tr>";

                });

                html +=
                            "</tbody>" +
                        "</table>" +
                    "</div>";

                $("#divMaster").html(html);
            }


            function BindMasterForm_old(data) {

                var html = "";

                if (!data || data.length === 0) {
                    $("#divMaster").html("<div class='col-12'>No data found</div>");
                    return;
                }

                $.each(data[0], function (key, value) {

                    html +=
                        "<div class='col-md-6 mb-3'>" +
                            "<label class='font-weight-bold'>" + escapeHtml(key) + "</label>" +
                            "<input type='text' class='form-control' " +
                            "value='" + escapeHtml(value == null ? "" : value) + "' " +
                            "readonly='readonly' />" +
                        "</div>";

                });

                $("#divMaster").html(html);
            }




            function BindDetailTable(data) {

                var html = "";

                if (!data || data.length === 0) {
                    html = "<tr><td colspan='4' class='text-center'>No data found</td></tr>";
                    $("#tblDetails tbody").html(html);
                    return;
                }

                $.each(data, function (i, row) {

                    html +=
                        "<tr>" +
                            "<td>" + escapeHtml(row.id == null ? "" : row.id) + "</td>" +
                            "<td>" + escapeHtml(row.company_cus_code == null ? "" : row.company_cus_code) + "</td>" +
                            "<td>" + escapeHtml(row.owner_cus_code == null ? "" : row.owner_cus_code) + "</td>" +
                            "<td>" + escapeHtml(row.name == null ? "" : row.name) + "</td>" +
                            "<td>" + escapeHtml(row.role == null ? "" : row.role) + "</td>" +
                            //"<td>" + escapeHtml(row.address == null ? "" : row.address) + "</td>" +

  //"<td>" + escapeHtml(row.phone == null ? "" : row.phone) + "</td>" +

  "<td>" +
                                "<button type='button' " +
                                    "class='btn btn-danger btn-sm btnDelete' " +
                                    "data-id='" + escapeHtml(row.id) + "'>" +
                                    "Delete" +
                                "</button>" +
                            "</td>" +
                        "</tr>";

                });

                $("#tblDetails tbody").html(html);
            }



            function escapeHtml(value) {

                return $("<div/>")
                    .text(value == null ? "" : value)
                    .html();
            }



            $("body").on("click", ".upload", function () {

                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");

                var cus_id = $(this).attr("cus-id");

                //alert(cus_type + '-' + e_doc_id);

                //url = "DocumentUpload_V8.aspx?var=" + cus_type + "&var3=" + cus_id;

                url = "DocumentUpload_V10_New_Mapping_CusTypeWise.aspx?var=" + cus_type + "&var2=&var3=&var4=" + cus_id;

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


    <style  type="text/css">

        .modal-xl {
    width: 90%;
    max-width: 1400px;
}



        @media (min-width: 768px) {
    .modal-xl {
        width: 90%;
    }
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <section class="content-header">
    	<h1>
        	Customer Profile <a href="ProfileCreate.aspx" class="btn btn-success"> <i class="fa fa-plus"></i></a>
        </h1>
        <ol class="breadcrumb">
        	<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Profile</a></li>
    	</ol>
	</section>


    <section class="content"> <!-- Start of table section -->

        <div class="modal" id="customerModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <div class="modal-header" style="background:#3c8dbc; color:white; padding:15px 20px;">

                <button type="button" class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        style="color:white; opacity:1; font-size:28px; margin-top:-5px;">
                    <span aria-hidden="true">&times;</span>
                </button>

                <h4 class="modal-title" style="font-weight:bold;">
                    <i class="fa fa-user-circle"></i> Customer Details
                </h4>

            </div>

            <div class="modal-body">

                <!-- First result set: Dynamic form -->
               <%-- <h6 class="font-weight-bold">Customer Information</h6>--%>

                <div  class="row">
                <div  class="col-md-4" id="dvMaster"><div id="divMaster">
                </div></div><div class="col-md-8"  id="divDetail">Owner Info:<div class="table-responsive">
                    <table class="table table-bordered table-sm"
                           id="tblDetails">

                        <thead class="thead-light">
                            <tr>
                                <th>id#</th>
                                <th>company cus code</th>
                                <th>owner cus code</th>
                                <th>name</th>
                                <th>role</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody></tbody>

                        <tfoot>
                            <tr>
                                <th></th>
                                   <th></th>
                                <th><select id="Select4"  runat="server" class="form-control">
<option></option>

</select></th>
                                <th></th>
                                 
                                <th><select id="Select1" class="form-control">

                                             <option>Propreitorship owner</option>

                                             <option>Partner</option>
                                              <option>JV</option>

                                           

<option>Chairman</option>
<option>Managing Director</option>
<option>Director</option>
<option>Accountant</option>
<option>Secretary</option>
                                             <option>Others</option>

</select> </th>
                               
                              <th><input id="Button1" type="button" value="Save"  class="btn btn-primary"/></th>


                            </tr>



                        </tfoot>

                    </table>
                </div></div>
               
                    
                </div>
                <hr />

                <!-- Second result set: Fixed table -->
               <%-- <h6 class="font-weight-bold">Customer Items</h6>--%>

                

            </div>





            <div class="modal-footer" style="background:#f4f4f4;">

                <button type="button" class="btn btn-default btn-lg"
                        data-dismiss="modal">
                    <i class="fa fa-times"></i> Close
                </button>

              <%--  <button type="button" class="btn btn-primary btn-lg" id="btnSave">
                    <i class="fa fa-save"></i> Save
                </button>--%>

            </div>
        </div>
    </div>
</div>

    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">Customer Listing </h3> 
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>Cus ID</th>
                            	<th>Cus Name</th>
                            	<th>Cus Type</th>
                                <th>Total Sanction</th>
                                <th>Pending Drawdown</th>
                                <th>Taken Drawdown</th>
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
                        <td><%=TableData.Rows[data]["cus_code"]%></td>
                        <td><%=TableData.Rows[data]["cus_name"]%></td>
                        <td><%=TableData.Rows[data]["cus_type"]%></td>
                        <td><%=TableData.Rows[data]["total_sanction"]%></td>
                        <td><%=TableData.Rows[data]["pending_drawdown"]%></td>
                        <td><%=TableData.Rows[data]["already_taken_drawdown"]%></td>
                        	
                        <td>        

                                    <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["cus_type"]%>" cus-id="<%=TableData.Rows[data]["cus_code"]%>" >View</a>                                    

                                    <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["cus_type"]%>"   cus-id="<%=TableData.Rows[data]["cus_code"]%>">Document Upload</a>                                    


                                    <%  if (Role == 3)
                                        { 
                                            %>

                                    <a href="SanctionUpload_V4.aspx?CusID=<%=TableData.Rows[data]["cus_code"]%>"  class="btn btn-success btn-xs sanction" cus-type="<%=TableData.Rows[data]["cus_type"]%>"   cus-id="<%=TableData.Rows[data]["cus_code"]%>">New Sanction</a>                                    

                                    <%
                                        }
                                        
                                        
                                         %>

  
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
