<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UserListing.aspx.cs" Inherits="UserListing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .updated-row {
            background-color: #d4edda !important;
            transition: background-color 0.3s ease;
        }


        

#employeeModal .select2-container {
    width: 100% !important;
}

#employeeModal .select2-container .select2-selection--single {
    height: 34px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

#employeeModal .select2-container--default
.select2-selection--single .select2-selection__rendered {
    line-height: 32px;
}

#employeeModal .select2-container--default
.select2-selection--single .select2-selection__arrow {
    height: 32px;
}
    </style>
    
 
    <script type="text/javascript">

        $(document).ready(function () {

            $("#ddlDivision, #ddlRole, #ddlBranch").select2({
                width: '100%',
                dropdownParent: $('#employeeModal'),
                placeholder: "Select an option",
                allowClear: true
            });


            var currentRow;
            var allRoles = [];

            $(document).on("click", ".edit-employee", function () {

                currentRow = $(this).closest("tr");


                $("#modalEmpId").text(currentRow.find(".emp-id").text().trim());

                $("#modalEmpCode").text(currentRow.find(".emp-code").text().trim());

                $("#modalEmpName").text(currentRow.find(".emp-name").text().trim());

                $("#modalDesignation").text(
                    currentRow.find(".emp-designation").text().trim()
                );

                var id = currentRow.attr("data-id");

                $("#employeeId").val(id);

                $("#ddlRole").html('<option value="">Loading...</option>');
                $("#ddlBranch").html('<option value="">Loading...</option>');

                $("#employeeModal").modal("show");

                $.ajax({
                    type: "POST",
                    url: "UserListing.aspx/GetEmployeeEditData",
                    data: JSON.stringify({ id: id }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var data = response.d;

                        if (!data.Success) {
                            alert(data.Message);
                            return;
                        }

                        // Store all roles
                         allRoles = data.Roles;

                        //console.log(allRoles);

                        // Populate Division dropdown
                        var divisions = [];

                        $.each(allRoles, function (i, item) {

                            if ($.inArray(item.Division, divisions) === -1) {
                                divisions.push(item.Division);
                            }

                        });

                        var divisionOptions = '<option value="">Select Division</option>';

                        $.each(divisions, function (i, division) {

                            divisionOptions += '<option value="' +
                                $('<div>').text(division).html() + '">' +
                                $('<div>').text(division).html() +
                                '</option>';

                        });

                        $("#ddlDivision").html(divisionOptions);


                        // Find current employee role's division
                        var currentRole = allRoles.find(function (item) {
                            return item.Id == data.RoleId;
                        });

                        if (currentRole) {

                            $("#ddlDivision").val(currentRole.Division);

                            loadRoles(currentRole.Division, data.RoleId);

                            console.log(currentRole.Division);

                            console.log(data.RoleId);

                        }

                        //$("#ddlRole").html(roleOptions);

                        // Populate branches
                        var branchOptions = '<option value="">Select Branch</option>';

                        $.each(data.Branches, function (i, item) {
                            branchOptions += '<option value="' + item.Id + '">' +
                                $('<div>').text(item.Name).html() +
                                '</option>';
                        });

                        $("#ddlBranch").html(branchOptions);

                        // Set current selections
                        $("#ddlRole").val(data.RoleId);
                        $("#ddlBranch").val(data.BranchId);

                        /*
                        $("#ddlDivision, #ddlRole, #ddlBranch").select2({
                            width: '100%',
                            dropdownParent: $('#employeeModal'),
                            placeholder: "Select an option",
                            allowClear: true
                        });
                        */

                        initializeSelect2();
                    },

                    error: function () {
                        alert("Unable to load employee details");
                    }
                });

            });

            function initializeSelect2() {

                $("#ddlDivision, #ddlRole, #ddlBranch").each(function () {

                    if ($(this).hasClass("select2-hidden-accessible")) {
                        $(this).select2("destroy");
                    }

                    $(this).select2({
                        width: "100%",
                        dropdownParent: $("#employeeModal"),
                        placeholder: "Select an option",
                        allowClear: true
                    });

                });

            }


            function loadRoles(division, selectedRoleId) {

                console.log("Selected division:", division);
                console.log("All roles:", allRoles);


                var roleOptions = '<option value="">Select Role</option>';

                $.each(allRoles, function (i, item) {

                    if (item.Division.trim().toLowerCase() ===
                        division.trim().toLowerCase()) {

                        roleOptions += '<option value="' +
                            item.Id + '">' +
                            $('<div>').text(item.Name).html() +
                            '</option>';
                    }

                });

                $("#ddlRole").html(roleOptions);

                if (selectedRoleId) {
                    $("#ddlRole").val(selectedRoleId);
                }

                console.log("Selected Division:", division);
                console.log("Available roles:", $("#ddlRole option").length - 1);
            }

            // Save changes
            $("#btnSaveEmployee").click(function () {

                var id = $("#employeeId").val();
                var roleId = $("#ddlRole").val();
                var branchId = $("#ddlBranch").val();

                if (!roleId) {
                    alert("Please select a role");
                    return;
                }

                if (!branchId) {
                    alert("Please select a branch");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "UserListing.aspx/UpdateEmployee",
                    data: JSON.stringify({
                        id: id,
                        roleId: roleId,
                        branchId: branchId
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d.Success) {

                            // Update respective row only
                            currentRow.find(".role-cell").text($("#ddlRole option:selected").text()).attr("data-role-id", roleId);

                            currentRow.find(".branch-code-cell").text($("#ddlBranch option:selected").val()).attr("data-branch-id", branchId);

                            currentRow.find(".branch-name-cell").text($("#ddlBranch option:selected").text());

                            // Highlight updated row
                            currentRow.addClass("updated-row");

                            alert('Updated successfully');


                            $("#employeeModal").modal("hide");

                        }
                        else {
                            alert(response.d.Message);
                        }
                    },

                    error: function () {
                        alert("Error updating employee");
                    }
                });

            });

            $(document).on("change", "#ddlDivision", function () {

                var division = $(this).val();

                loadRoles(division, null);

                $("#ddlRole").val(null).trigger("change");

            });

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



        });

                   </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content"> <!-- Start of table section -->



        <div class="modal" id="employeeModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title">Update Employee</h4>
            </div>

            <div class="modal-body">

                <input type="hidden" id="employeeId" />






                <div class="well well-sm">

    <div class="row">
        <div class="col-sm-6">
            <strong>ID:</strong>
            <span id="modalEmpId"></span>
        </div>

        <div class="col-sm-6">
            <strong>Employee ID:</strong>
            <span id="modalEmpCode"></span>
        </div>
    </div>

    <hr style="margin:8px 0;" />

    <div class="row">
        <div class="col-sm-6">
            <strong>Name:</strong>
            <span id="modalEmpName"></span>
        </div>

        <div class="col-sm-6">
            <strong>Designation:</strong>
            <span id="modalDesignation"></span>
        </div>
    </div>

</div>

                <div class="form-group">
    <label>Working Group</label>
    <select id="ddlDivision" class="form-control">
        <option value="">Select Division</option>
    </select>
</div>

<div class="form-group">
    <label>Role</label>
    <select id="ddlRole" class="form-control">
        <option value="">Select Role</option>
    </select>
</div>

                <div class="form-group">
                    <label>Branch Code</label>
                    <select id="ddlBranch" class="form-control">
                        <option value="">Loading...</option>
                    </select>
                </div>

            </div>

           <div class="modal-footer text-center">

    <button type="button"
            class="btn btn-primary"
            id="btnSaveEmployee">
        <i class="fa fa-save"></i> Save Changes
    </button>

    <button type="button"
            class="btn btn-default"
            data-dismiss="modal">
        Cancel
    </button>

</div>

        </div>
    </div>
</div>




    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">User Listing </h3>
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>ID</th>
                                <th>EMP ID</th>
                            	<th>Name</th>
                            	<th>Designation</th>
                                <th>Domain ID</th>
                                <th>Role</th>
                                  <th>Branch Code</th>
                                  <th>Branch Name</th>
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
                            
%><tr data-id="<%=TableData.Rows[data]["id"]%>">

    <td class="emp-id">
        <%=TableData.Rows[data]["id"]%>
    </td>

    <td class="emp-code">
        <%=TableData.Rows[data]["empid"]%>
    </td>

    <td class="emp-name">
        <%=TableData.Rows[data]["name"]%>
    </td>

    <td class="emp-designation">
        <%=TableData.Rows[data]["designation"]%>
    </td>

    <td><%=TableData.Rows[data]["domain"]%></td>

    <td class="role-cell">
        <%=TableData.Rows[data]["role"]%>
    </td>

    <td class="branch-code-cell">
        <%=TableData.Rows[data]["branchcode"]%>
    </td>

    <td class="branch-name-cell">
        <%=TableData.Rows[data]["branchname"]%>
    </td>

    <td class="status-cell">
        <%=TableData.Rows[data]["Status"]%>
    </td>

    <td>
        <button type="button"
                class="btn btn-success btn-xs edit-employee">
            Update
        </button>
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
