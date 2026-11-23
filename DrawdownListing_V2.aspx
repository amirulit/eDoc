<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DrawdownListing_V2.aspx.cs" Inherits="DrawdownListing_V2"
    Debug="true" %>

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

    <script src="View.js" type="text/javascript"></script>



    <script type="text/javascript">


        $(document).ready(function () {


            $("body").on("click", ".lli", function () {


                var drawdown_id = $(this).attr("drawdown-id");

                //$("#btnSSCGenerate").attr("edoc-id", edoc_id);

                //var edoc_id = $("#btnSSCGenerate").attr("edoc-id");


                //$("#lblIDSSC").text(edoc_id);

                //alert(drawdown_id);

                //LoadFacilities(drawdown_id);

                LoadFacilities_V2(drawdown_id);
                

            });
           

            var facilityData = [];

            function LoadFacilities(drawdown_id) {

                $.ajax({
                    type: "POST",
                    url: "LLI_Generate.aspx/GetFacilities",
                    data: JSON.stringify({
                        drawdown_id: drawdown_id
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        facilityData = response.d;

                        var table = $("#tblFacilities");

                        table.find("thead").empty();
                        table.find("tbody").empty();

                        if (!facilityData || facilityData.length === 0)
                            return;

                        var columns = Object.keys(facilityData[0]);

                        // Header
                        var header = $("<tr>");

                        $.each(columns, function (i, col) {
                            header.append($("<th>").text(col));
                        });

                        table.find("thead").append(header);

                        // Body with input fields
                        // Body
                        $.each(facilityData, function (i, row) {

                            var tr = $("<tr>");

                            $.each(columns, function (j, col) {

                                // First column: Normal text
                                if (j === 0) {

                                    tr.append(
                                        $("<td>")
                                            .text(row[col] == null ? "" : row[col])
                                    );

                                }
                                    // Remaining columns: Editable textbox
                                else {

                                    var input = $("<input>", {
                                        type: "text",
                                        class: "form-control facility-input",
                                        "data-row": i,
                                        "data-column": col
                                    });

                                    input.val(row[col] == null ? "" : row[col]);

                                    tr.append(
                                        $("<td>").append(input)
                                    );
                                }

                            });

                            table.find("tbody").append(tr);

                        });

                        /*
                        var modal = new bootstrap.Modal(
                            document.getElementById("facilityModal")
                        );
    
                        modal.show();
                        */


                        $("#facilityModal").modal("show");
                    },

                    error: function (xhr) {
                        alert(xhr.responseText);
                    }
                });
            }



            function LoadFacilities_V2(drawdown_id) {

                $.ajax({
                    type: "POST",
                    url: "LLI_Generate.aspx/GetFacilities_V2",
                    data: JSON.stringify({
                        drawdown_id: drawdown_id
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var data = response.d;

                        BindDynamicTable("tblFacilities", data.Facilities);

                        BindDynamicTable("tblOtherDetails", data.Master);

                        BindDynamicTable("tblAdditionalDetails", data.Group);

                        


                        $("#facilityModal").modal("show");
                    },

                    error: function (xhr) {
                        console.log(xhr.responseText);
                        alert("Error loading data");
                    }

                });
            }

            function BindDynamicTable(tableId, data) {

                var table = $("#" + tableId);

                table.find("thead").empty();
                table.find("tbody").empty();

                if (!data || data.length === 0)
                    return;

                var columns = Object.keys(data[0]);

                // Header
                var header = $("<tr>");

                $.each(columns, function (i, col) {
                    header.append($("<th>").text(col));
                });

                table.find("thead").append(header);

                // Body

                if (tableId == 'tblOtherDetails' || tableId == 'tblAdditionalDetails') {
                    $.each(data, function (i, row) {

                        var tr = $("<tr>");

                        $.each(columns, function (j, col) {

                            tr.append(
                                $("<td>").text(row[col] == null ? "" : row[col])
                            );

                        });

                        table.find("tbody").append(tr);

                    });
                }
                else {

                    $.each(data, function (i, row) {

                        var tr = $("<tr>");

                        $.each(columns, function (j, col) {

                            if (j === 0) {
                                tr.append(
                                    $("<td>").text(row[col] == null ? "" : row[col])
                                );
                            }
                            else {

                                var input = $("<input>", {
                                    type: "text",
                                    class: "form-control facility-input",
                                    "data-row": i,
                                    "data-column": col
                                });

                                input.val(row[col] == null ? "" : row[col]);

                                tr.append(
                                    $("<td>").append(input)
                                );
                            }

                        });

                        table.find("tbody").append(tr);

                    });
                }
            }

            $("#btnSaevLLI").click(function () {
                SaveFacilities();
            });

            function SaveFacilities() {

                var updatedData = [];

                var headers = [];

                $("#tblFacilities thead th").each(function () {
                    headers.push($(this).text().trim());
                });

                // Skip first header (FieldName)
                var facilityColumns = headers.slice(1);

                facilityColumns.forEach(function (facility) {

                    var facilityObj = {};

                    $("#tblFacilities tbody tr").each(function () {

                        var fieldName = $(this).find("td:first").text().trim();

                        var input = $(this).find(
                            '.facility-input[data-column="' + facility + '"]'
                        );

                        facilityObj[fieldName] = input.val() || "";

                    });

                    updatedData.push(facilityObj);

                });

                console.log(updatedData);
            }

            $("body").on("click", ".ssc", function () {

                //alert('sss');

                var edoc_id = $(this).attr("edoc-id");

                $("#btnSSCGenerate").attr("edoc-id", edoc_id);

                //var edoc_id = $("#btnSSCGenerate").attr("edoc-id");


                $("#lblIDSSC").text(edoc_id);
                //alert(edoc_id);

                //var $row = $(element).closest("tr");


                //LoadSSCConditions();


            });

            $("#btnSSCGenerate").click(function () {

                var edoc_id = $("#btnSSCGenerate").attr("edoc-id");
                alert(edoc_id);

            });

            $("input[name='conditionType']").change(function () {

                var conditionType = $(this).val();

                if (conditionType == "Yes") {

                    $("#divConditionsEntry").show();

                    LoadSSCConditions();

                }
                else {

                    $("#divConditionsEntry").hide();

                    $("#Text1").val("");

                }

            });

            // Load records when page/modal opens
            //LoadSSCConditions();

            // SAVE
            $("#btnSaveConditions").click(function () {

                var drawdown_id = parseInt($("#lblIDSSC").text().trim());
                var conditions = $("#Text1").val().trim();
                var status = $("#Select1").val().trim();
                var reason = $("#Text2").val().trim();
                var deadline = $("#Text3").val().trim();
                //var office_note = $("#Text3").val().trim();

                if (isNaN(drawdown_id) || drawdown_id <= 0) {
                    alert("Invalid Drawdown ID");
                    return;
                }

                if (conditions == "") {
                    alert("Please enter Conditions");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "DrawdownListing_V2.aspx/SaveSSCConditions",
                    data: JSON.stringify({
                        drawdown_id: drawdown_id,
                        conditions: conditions,
                        status: status,
                        reason: reason,
                        deadline: deadline
                      
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d == "Success") {

                            alert("Saved successfully!");

                            $("#Text1").val("");
                            $("#Text2").val("");
                            $("#Text3").val("");

                            LoadSSCConditions();
                        }
                        else {
                            alert(response.d);
                        }
                    },

                    error: function (xhr) {
                        alert("Error saving record");
                    }
                });

            });


            // LOAD TABLE
            function LoadSSCConditions() {


                $("#tbodyConditions").empty();

                var drawdown_id = parseInt($("#lblIDSSC").text().trim());

                if (isNaN(drawdown_id) || drawdown_id <= 0)
                    return;

                $.ajax({
                    type: "POST",
                    url: "DrawdownListing_V2.aspx/GetSSCConditions",
                    data: JSON.stringify({
                        drawdown_id: drawdown_id
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var data = response.d;
                        var html = "";

                        if (data.length > 0) {

                            $.each(data, function (i, item) {

                                var tr = $("<tr>");

                                $("<td>").text(i + 1).appendTo(tr);
                                $("<td>").text(item.conditions).appendTo(tr);
                                $("<td>").text(item.status).appendTo(tr);
                                $("<td>").text(item.reason).appendTo(tr);
                                $("<td>").text(item.deadline).appendTo(tr);
                              

                                var deleteBtn = $("<button>")
                                    .attr("type", "button")
                                    .addClass("btn btn-danger btn-sm btnDelete")
                                    .text("Delete")
                                    .attr("data-id", item.condition_id);

                                $("<td>").append(deleteBtn).appendTo(tr);

                                $("#tbodyConditions").append(tr);
                            });

                        }
                        else {
                            html = '<tr><td colspan="6" class="text-center">No records found</td></tr>';
                            $("#tbodyConditions").html(html);
                        }

                    },

                    error: function () {
                        alert("Error loading conditions");
                    }
                });

            }

            $("#btnSSC_Office_Note_Save").click(function () {

                var drawdown_id = parseInt($("#lblIDSSC").text().trim());
                //var conditions = $("#Text1").val().trim();
                //var status = $("#Select1").val().trim();
                //var reason = $("#Text2").val().trim();
                //var deadline = $("#Text3").val().trim();
                var office_note = $("#Text4").val().trim();

                if (isNaN(drawdown_id) || drawdown_id <= 0) {
                    alert("Invalid Drawdown ID");
                    return;
                }

                if (office_note == "") {
                    alert("Please enter office_note");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "DrawdownListing_V2.aspx/SaveSSC_Office_Note",
                    data: JSON.stringify({
                        drawdown_id: drawdown_id,
                        //conditions: conditions,
                        //status: status,
                        //reason: reason,
                        office_note: office_note

                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d == "Success") {

                            alert("Office saved successfully!");

                            //$("#Text1").val("");

                            //LoadSSCConditions();
                        }
                        else {
                            alert(response.d);
                        }
                    },

                    error: function (xhr) {
                        alert("Error saving record");
                    }
                });

            });


            // DELETE
            $(document).on("click", ".btnDelete", function () {

                var btn = $(this);

                var condition_id = parseInt(btn.attr("data-id"));
                var drawdown_id = parseInt($("#lblIDSSC").text().trim());

                if (!confirm("Are you sure you want to delete this condition?"))
                    return;

                $.ajax({
                    type: "POST",
                    url: "DrawdownListing_V2.aspx/DeleteSSCConditions",
                    data: JSON.stringify({
                        condition_id: condition_id,
                        drawdown_id: drawdown_id
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        if (response.d == "Success") {

                            //alert("Deleted successfully!");

                            // Remove nearest table row
                            btn.closest("tr").remove();

                        }
                        else {
                            alert(response.d);
                        }
                    },

                    error: function () {
                        alert("Error deleting record");
                    }
                });

            });

        });

    </script>


    <script type="text/javascript">

        $(document).ready(function () {








            $("body").on("click", ".upload", function () {

                var cus_ids = $(this).attr("cus-id");
                //var auto_id = $(this).attr("auto-id");
                //var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);
                //DocumentUpload_V10_New_Mapping_Drawdown.aspx
                //url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                url = "DocumentUpload_V10_New_Mapping_Drawdown.aspx?var=" + drawdown_id + "&var1=" + cus_ids;


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



            $(document).on("click", ".query", function () {

                var drawdown_id = $(this).attr("data-drawdown-id");

                $.ajax({
                    type: "POST",
                    url: "DrawdownListing_V2.aspx/GetQueryDetails",
                    data: JSON.stringify({ drawdown_id: parseInt(drawdown_id) }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var data = response.d;

                        var html = "";

                        if (data.length > 0) {

                            $.each(data, function (i, item) {

                                html += "<tr>";

                                html += "<td>" + (i + 1) + "</td>";
                                html += "<td>" + $("<div>").text(item.query).html() + "</td>";
                                html += "<td>" + $("<div>").text(item.query_by_role).html() + "</td>";
                                html += "<td>" + $("<div>").text(item.create_date).html() + "</td>";
                                html += "<td>" + $("<div>").text(item.create_by).html() + "</td>";

                                html += "</tr>";

                            });

                        }
                        else {

                            html = "<tr><td colspan='5' class='text-center'>No Query Found</td></tr>";

                        }

                        $("#queryDetails").html(html);

                        $("#queryModal").modal("show");

                    },

                    error: function () {
                        alert("Error loading query details.");
                    }
                });

            });

            $("body").on("click", ".view", function () {

                var cus_ids = $(this).attr("cus-id");
                //var auto_id = $(this).attr("auto-id");
                //var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);
                //DocumentUpload_V10_New_Mapping_Drawdown.aspx
                //url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                url = "Checklist_View_V2.aspx?var=" + drawdown_id + "&var1=" + cus_ids;


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

                var cus_ids = $(this).attr("cus-id");
                //var auto_id = $(this).attr("auto-id");
                //var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);
                //DocumentUpload_V10_New_Mapping_Drawdown.aspx
                //url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

                url = "Checklist_View_V2_PdfGen.aspx?var=" + drawdown_id + "&var1=" + cus_ids;


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


            $(document).on("click", ".show", function () {

                var drawdown_id = $(this).attr("data-drawdown-id");

                $.ajax({
                    type: "POST",
                    url: "DrawdownListing_V2.aspx/GetDeclineReason",
                    data: JSON.stringify({ drawdown_id: drawdown_id }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var data = response.d;

                        if (data != null) {

                            $("#cus_name").text(data.cus_name || "");
                            $("#cr_reason").text(data.cr_reason || "");
                            $("#hob_reason").text(data.hob_reason || "");
                            $("#dm_reason").text(data.dm_reason || "");
                            $("#unit_reason").text(data.unit_reason || "");

                            $("#reasonModal").modal("show");
                        }
                        else {
                            alert("No decline reason found.");
                        }
                    },

                    error: function () {
                        alert("Error loading decline reasons.");
                    }
                });

            });

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content"> <!-- Start of table section -->



   <div class="modal" id="facilityModal" tabindex="-1">
    <div class="modal-dialog">
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

                <div class="table-responsive">
                                <table class="table table-bordered" id="tblFacilities_Org">
                                    <thead class="table-light"></thead>
                                    <tbody></tbody>
                                </table>
                            </div>




                 <h6 class="text-primary">1. Facility Details</h6>
                <table class="table table-bordered" id="tblFacilities">
                    <thead></thead>
                    <tbody></tbody>
                </table>

                <button type="button" id="btnSaevLLI">Save</button>

                <hr />

                <h6 class="text-primary">2. Other Details</h6>
                <table class="table table-bordered" id="tblOtherDetails">
                    <thead></thead>
                    <tbody></tbody>
                </table>

                <hr />

                <h6 class="text-primary">3. Additional Details</h6>
                <table class="table table-bordered" id="tblAdditionalDetails">
                    <thead></thead>
                    <tbody></tbody>
                </table>




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
            </div>
         

            <div class="modal" id="modalSSCGen" tabindex="-1" role="dialog" aria-labelledby="modalUpdateform" aria-hidden="true">  
  		<div class="modal-dialog ">
    		<div class="container">
            	<div class="row ">	
           			<div class="col-md-6">
                		<div class="panel">
        					<div class="panel-heading bg-orange">                 
        						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          						<h4 class="modal-title custom_align" id="Heading">SSC Generation</h4>
                            </div>
                           <div class="panel-body">
    ID # <span id="lblIDSSC" class="badge badge-success"></span>







                               <div class="form-group">
    <label>Condition Type</label>
    <br />

    <label class="radio-inline">
        <input type="radio" name="conditionType"
               id="rdoConditional" value="Yes" />
        Conditional
    </label>

    &nbsp;&nbsp;

    <label class="radio-inline">
        <input type="radio" name="conditionType"
               id="rdoClean" value="No" />
        Unconditional
    </label>
</div>

<!-- Show only when Conditional = Yes -->
<div id="divConditionsEntry" style="display:none;">


    <table class="table table-condensed table-responsive "><tr><td>Conditions</td><td>Status</td><td>Reason</td><td>Deadline</td><td> </td></tr>

        <tr><td> <input id="Text1" type="text" class="form-control" /></td><td><select id="Select1" class="form-control">
<option>Obtained</option>

            <option>Not Obtained</option>
</select></td><td><input id="Text2" type="text" class="form-control" /></td><td><input id="Text3" type="text" class="form-control" /></td><td><div class="form-group">
        <button type="button" id="btnSaveConditions"
                class="btn btn-success">
            <i class="fa fa-save"></i>Save
        </button>
         </div></td></tr>




    </table>
  
        
    <h4>Saved Conditions</h4>

    <table class="table table-bordered table-striped" id="tblConditions">
        <thead>
            <tr>
                <th>SL</th>
                <th>Conditions</th>
                 <th>Status</th>
                 <th>Reason</th>
                <th>Deadline</th>
              
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="tbodyConditions">
        </tbody>
    </table>
       <hr />

    <div class="form-group">
        <label>Office Note NO#</label>
           <input id="Text4" type="text" class="form-control" />
    </div>

   
        <div class="form-group">
        <button type="button" id="btnSSC_Office_Note_Save"
                class="btn btn-warning">
            <i class="fa fa-save"></i>Office Note Save
        </button>
         </div>
       
   


    </div>

                               </div>
                            
                            <div class="panel-footer bg-gray-light">
                                <input type="hidden" id="id" name="id" value="" />
                                  <div class="row">
                                
                                 <div class="col-md-6">
            <button type="button" id="btnSSCGenerate" class="btn btn-info" style="width: 100%;">
                <span class="glyphicon glyphicon-upload"></span> Generate SSC
            </button>
        </div>

        <div class="col-md-6">
            <button type="button" class="btn btn-danger" data-dismiss="modal" style="width: 100%;">
                <span class="glyphicon glyphicon-remove"></span> Close
            </button>
        </div>
                                
                               </div> 
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                      
        	  				</div><!--/.panel-footer--> 
            			</div><!--/.panel-->
            		</div><!--/.col-md-6-->
            	</div><!--/.row-->                                        
        	</div><!-- /.modal-content -->  		 
		</div><!-- /.modal-dialog -->            
	</div><!--/.Modal-Update form -->   

    
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
                                <button type="button"   id="btnSubmit" class="btn btn-info" style="width: 100%;"><span class="glyphicon   glyphicon-upload"></span>Geneate</button>         
        	  				</div><!--/.panel-footer--> 
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
        <div class="modal" id="queryModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title">Query Details</h4>
            </div>

            <div class="modal-body">

                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>SL</th>
                            <th>Query</th>
                            <th>Query By Role</th>
                            <th>Create Date</th>
                            <th>Create By</th>
                        </tr>
                    </thead>

                    <tbody id="queryDetails">
                    </tbody>
                </table>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

        <div class="modal" id="reasonModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title">Decline Reasons</h4>
            </div>

            <div class="modal-body">

                <table class="table table-bordered">
                    <tr>
                        <th>Customer Name</th>
                        <td id="cus_name"></td>
                    </tr>

                    <tr>
                        <th>CR Incharge Decline Reason</th>
                        <td id="cr_reason"></td>
                    </tr>

                    <tr>
                        <th>HOB Decline Reason</th>
                        <td id="hob_reason"></td>
                    </tr>

                    <tr>
                        <th>DM Decline Reason</th>
                        <td id="dm_reason"></td>
                    </tr>

                    <tr>
                        <th>Unit Head Decline Reason</th>
                        <td id="unit_reason"></td>
                    </tr>
                </table>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">Drawdown Listing </h3>
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>ID</th>
                                <th>Drawdown ID</th>
                                <th>Customer Type</th>
                            	<th>Customer ID</th>
                            	<th>Customer Name</th>
                                <th>Loan Natures</th>
                                <th>Branch Code</th>
                                   <th>Loan Amount</th>
                                   <%--   <th>Expiry Date</th>--%>
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
        int status;

        if (TableData.Rows.Count > 0)
        {
            for (var data = 0; data < TableData.Rows.Count; data++)
            {

                status = Convert.ToInt32(TableData.Rows[data]["status"]);
                            
%>


<tr>


                        <td><%=TableData.Rows[data]["id"]%></td>
                        <td><%=TableData.Rows[data]["dd_id"]%></td>
                        <td><%=TableData.Rows[data]["cus_types"]%></td>
                        <td><%=TableData.Rows[data]["cus_ids"]%></td>
                        <td><%=TableData.Rows[data]["cus_names"]%></td>
                          
                        <td><%=TableData.Rows[data]["loan_natures"]%></td>
                        <td><%=TableData.Rows[data]["branch_code"]%></td>
                        <td><%=TableData.Rows[data]["loan_amount"]%></td>
                     <%--   <td><%=TableData.Rows[data]["exp_date_2"]%></td>--%>

                       <td>

                           <% if (status == 17 || status == 20 || status == 28 || status == 33)
                              {%>

    <a href="javascript:void(0);"
       class="btn btn-success btn-xs show"
       data-drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">
        Reason
    </a>

                           <%} %>


                           <% if (status == 51)
                              {%>

    <a href="javascript:void(0);"
       class="btn btn-success btn-xs query"
       data-drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">
        Query
    </a>

                           <%} %>




    <%=TableData.Rows[data]["status_desc"]%>
</td>

                  
                        	
                        <td>        

                        <!--
                        <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>"  drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">Edit</a>                                    

                        <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["drawdown_id"]%>">Document Upload</a>                                    
                        -->

                         <%--  <%=Role %><%=status %>--%>
                            
                        <%  if (((Role == 57 || Role == 61 || Role == 65) && (status == 10 || status == 13 || status == 30)) ||

                                ((Role == 5 || Role == 7) && (status == 9 || status == 15 || status == 17 || status == 20 || status == 28 || status == 34)))
                            {
                            
                            
                        
                                           
                                           %>
                             

                            <a href="#"  class="btn btn-info btn-xs lli" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">LLI</a>                                    

                        <a href="#"  class="btn btn-info btn-xs upload" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Update</a>                                    
  
                         

                            <%
                            }
                               %>



                        <a href="#"  class="btn btn-primary btn-xs view" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">View</a>                                    


                        <a href="#"  class="btn btn-success btn-xs pdf" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Checklist(PDF)</a>                                    


                         
                        <a  href="javascript:void(0);"  class="btn btn-info btn-xs docview"  cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>"  sanction-id="<%=TableData.Rows[data]["sanction_ids"]%>"   >View(Uploaded Docs)</a>                                    
 



                        <%  if ((Role == 59 || Role == 63 || Role == 67) && status == 36)
                            {
                                
                                
                                %>
                        
                         <a href="#modalSSCGen" data-toggle="modal" class="btn btn-success btn-xs ssc" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">SSC Creation</a>                                    
  

                        <a href="SSCCreation.aspx?v=<%=TableData.Rows[data]["drawdown_id"]%>"  class="btn btn-success btn-xs ssc" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">SSC Creation</a>                                    
  

  <% 
                            }
      
       %>


  
  <!--
                        <a href="#"  class="btn btn-primary btn-xs reason" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">View</a>                                    
  

                        <a href="#"  class="btn btn-success btn-xs pdf" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">Pdf Gen</a>                                    
  

                        <a href="SSCCreation.aspx?v=<%=TableData.Rows[data]["drawdown_id"]%>"  class="btn btn-success btn-xs ssc" cus-id="<%=TableData.Rows[data]["cus_ids"]%>" cus-type="<%=TableData.Rows[data]["drawdown_id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["drawdown_id"]%>" drawdown-id="<%=TableData.Rows[data]["dd_id"]%>">SSC Creation</a>                                    
  
  -->



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
