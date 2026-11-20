<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DM_Change_CMSME.aspx.cs" Inherits="DM_Change_CMSME" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .role-edit {
            min-width: 180px;
        }

            .role-edit select {
                margin-bottom: 5px;
            }

            .role-edit button {
                margin-right: 3px;
            }


            .current-status {
    font-weight: bold;
}

.current-status.active {
    color: green;
}

.current-status.inactive {
    color: red;
}


    </style>
    <script type="text/javascript">

        $(document).ready(function () {

            $("body").on("click", ".upload", function () {

                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");

                var cus_id = $(this).attr("cus-id");

                //alert(cus_type + '-' + e_doc_id);

                //url = "DocumentUpload_V8.aspx?var=" + cus_type + "&var3=" + cus_id;

                url = "DocumentUpload_V10_New_Mapping_CusTypeWise.aspx?var=" + cus_type + "&var2=&var3=" + cus_id;

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

            $(document).on("click", ".status", function (e) {

                e.preventDefault();

                var btn = $(this);
                var id = btn.attr("user-id");

                var currentStatus = btn.closest("td")
                                       .find(".current-status")
                                       .text().trim().toLowerCase();

                var newStatus = currentStatus === "active" ? "inactive" : "active";

                if (!confirm("Change status to " + newStatus + "?")) {
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "UserListing_CAD.aspx/ChangeStatus",
                    data: JSON.stringify({
                        id: id,
                        status: newStatus
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d === "success") {

                            btn.closest("td")
                               .find(".current-status")
                               .text(newStatus);


                            var statusElement = btn.closest("td").find(".current-status");

                            statusElement
                                .text(newStatus)
                                .removeClass("active inactive")
                                .addClass(newStatus);

                        }
                        else {
                            alert(response.d);
                        }
                    },

                    error: function () {
                        alert("Error updating status");
                    }
                });

            });

            $(document).on("click", ".change-dm", function () {

                var td = $(this).closest("td");

                var currentRole = td.find(".current-dm").text().trim();

                // Copy options from existing dropdown
                var options = $("#ContentPlaceHolder1_Select1").html();

                var select = td.find(".dm-select");

                select.html(options);

                // Select current role
                select.find("option").filter(function () {
                    return $(this).text().trim() === currentRole;
                }).prop("selected", true);

                td.find(".dm-display").hide();
                td.find(".dm-edit").show();

            });


            // Cancel button
            $(document).on("click", ".cancel-dm", function () {

                var td = $(this).closest("td");

                td.find(".dm-edit").hide();
                td.find(".dm-display").show();

            });


            // Update button
            $(document).on("click", ".update-dm", function () {

                var btn = $(this);
                var td = btn.closest("td");
                var tr = btn.closest("tr");

                var id = tr.find("td:first").text().trim();

                var dmSelect = td.find(".dm-select");

                var dmId = dmSelect.val();
                var dmName = dmSelect.find("option:selected").text();

                if (!dmId) {
                    alert("Please select a DM");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "DM_Change_CMSME.aspx/UpdateDM",
                    data: JSON.stringify({
                        id: id,
                        dmId: dmId,
                        dmName: dmName
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d === "success") {

                            td.find(".current-dm").text(dmName);

                            td.find(".dm-edit").hide();
                            td.find(".dm-display").show();

                            alert("DM updated successfully");

                        }
                        else {
                            alert(response.d);
                        }
                    },

                    error: function () {
                        alert("Error updating DM");
                    }
                });

            });

        });

                 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content"> <!-- Start of table section -->




        <select id="Select1"  runat="server"  class="form-control"  style="display:none;">
<option></option>

</select>
    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">DM Listing&nbsp; (CMSME)</h3>
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>ID</th>
                                <th>Branch Code</th>
                            	<th>Branch Name</th>
                             
                            	<th>DM Name</th>
                                
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
                         <td><%=TableData.Rows[data]["branch_code"]%></td>
                        <td><%=TableData.Rows[data]["branch_name"]%></td>
                        <td> 
                       
     
      
          <div class="dm-display">
            <span class="current-dm">
                <%=TableData.Rows[data]["emp_name"]%> 
            </span>

            <button type="button"
                class="btn btn-warning btn-xs change-dm">
                Change
            </button>
        </div>

        <div class="dm-edit" style="display:none;">
            <select class="form-control dm-select"></select>

            <button type="button"
                class="btn btn-primary btn-xs update-dm">
                Update
            </button>

            <button type="button"
                class="btn btn-danger btn-xs cancel-dm">
                Cancel
            </button>
        </div>
          
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
