<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentUpload_V10_New_Mapping_CusTypeWise.aspx.cs"
    Inherits="DocumentUpload_V10_New_Mapping_CusTypeWise" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Document Upload</title>
    <link href="bootstrap4/bootstrap.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <link href="CSS/Style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css" />
    <%--

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>--%>
    <%-- <link href="js/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui.js" type="text/javascript"></script>--%>
    <script src="jquery-3.7.1.js" type="text/javascript"></script>
    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript" src="plugins/datatables/jquery.dataTables.min.js">
    </script>
    <script type="text/javascript" src="plugins/datatables/dataTables.bootstrap.min.js">
    </script>


     <script language="javascript" type="text/javascript">
         $(document).ready(function () {
             // Initialize the jQuery dialog

             $("#imageDialog").dialog({
                 autoOpen: false,
                 width: $(window).width(),
                 height: $(window).height(),

                 buttons: {
                     Close: function () {
                         $(this).dialog('close');
                     }
                 },

                 modal: true
             });


             $("#pdfDialog").dialog({
                 autoOpen: false,
                 width: $(window).width(),
                 height: $(window).height(),

                 buttons: {
                     Close: function () {
                         $(this).dialog('close');
                     }
                 },


                 modal: true
             });

         });
    </script>


    <script type="text/javascript">

        $(function () {


            //$(".docTable").DataTable();



        });

    </script>
    <script type="text/javascript">

        $(function () {

            $("#accordion").accordion({ collapsible: true, active: false, animate: false });

        });

    </script>
    <script type="text/javascript">

        $(function () {
            $(".datepicker").datepicker({ appendText: "(dd/mm/yy)",
                dateFormat: "dd/mm/yy",
                altField: "#datepicker-4",
                altFormat: "DD, d MM, yy",
                showOn: "both",
                buttonImageOnly: true,
                buttonImage: "calender.gif",
                buttonText: "Calendar",
                changeMonth: true,
                changeYear: true,
                yearRange: "1900:2050"
            });
        });

    </script>
    <script type="text/javascript">

        $(document).ready(function () {
            //$("input[name='opt_req']").change(function () {


            $("input[class='rdo']").change(function () {
                var data_id = $(this).attr("data-id");
                //alert(data_id);
                //alert("You selected: " + $(this).val());
            });

        });

    </script>
    <script type="text/javascript">

        $(document).ready(function () {
            //$("input[name='opt_req']").change(function () {

            //$(".save").css("display", "none");


            $("#ddlAnyDoc").change(function () {

            });

            $(".ddlStatus").change(function () {


                //alert('hhhh');

                //$(".ddlStatus").closest("tr").removeClass("row-highlight");

                // Highlight the selected row

                $(this).closest("tr").addClass("row-highlight");



                var data_id = $(this).attr("data-id");




                //alert(data_id);
                //alert("You selected: " + $(this).val());

                var sts = $(this).val();

                //alert("You selected: " + sts);




                $("#btnSave_" + data_id).css("display", "block");

                if (sts == "Obtained") {
                    $("#Obtained_" + data_id).css("display", "block");
                    $("#Not_" + data_id).css("display", "none");
                    $("#Part_" + data_id).css("display", "none");
                    $("#btnSave_" + data_id).css("display", "none");
                }

                if (sts == "Not") {
                    $("#Obtained_" + data_id).css("display", "none");
                    $("#Not_" + data_id).css("display", "block");
                    $("#Part_" + data_id).css("display", "none");
                }

                if (sts == "Part") {
                    $("#Obtained_" + data_id).css("display", "none");
                    $("#Not_" + data_id).css("display", "none");
                    $("#Part_" + data_id).css("display", "block");
                }
            });




            $(".save").click(function () {



                //var cus_id = "";
                var data_id = $(this).attr("data-id");
                var div_name = $(this).attr("div-name");


                alert(data_id);
                alert(cus_id);

                //alert(div_name);


                var required = $('input[name="opt_req_' + data_id + '"]:checked').val();

                alert(required);


                var ddl = $("#ddl_" + data_id).val()

                //alert(ddl);

                var obj = {};

                obj.cus_id = cus_id;
                obj.required = required;

                obj.status = ddl;
                //obj.remarks = 1; // $("#txteDocID").val();
                obj.doc_id = data_id; // $("#txtCustomerCode").val();

                //obj.details = '';

                var not_reason = $("#txtNotObtained_" + data_id).val();
                var part_reason = $("#txtPartiallyObtained_" + data_id).val();
                var part_deadline = $("#txtDeadline_" + data_id).val();

                if (ddl == 'Not') {
                    obj.details = not_reason;
                    if (not_reason == '') {
                        alert('Pls put reason');
                        return false;
                    }
                }

                if (ddl == 'Part') {
                    obj.details = part_reason;
                    obj.deadline = part_deadline
                    if (part_reason == '' || part_deadline == '') {
                        alert('Pls put reason & deadline');
                        return false;
                    }
                }







                //alert(obj.toString());

                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "DocumentUpload_V10_New_Mapping_CusTypeWise.aspx/Save_DocumentUpload_Customer",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (msg) {


                        //alert("Data Saved Successfully.");

                        if (msg.d = "Data Saved") {
                            //swal("Success!", "Data Saved Successfully.", "success")
                            //$("#txtSubject").val('');
                            //$("#txtDetails").val('');

                            alert("Data Saved Successfully.");


                            LoadDocStatus_Exception();


                        }
                        else {
                            //swal("Error!", "Data not Saved!", "error")
                            alert('ERROR');
                        }

                    },
                    error: function () {

                        alert("Error while inserting data");
                        //sweetAlert("Oops...", "Something went wrong!", "error");
                    }
                });


                return false;


            });


            function LoadDocStatus_Exception() {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "DocumentUpload_V9.aspx/GetData",
                    data: {},
                    dataType: "json",
                    success: function (data) {
                        //$('#tblException tbody').remove();
                        //console.log(data.d);

                        $('#tblException').find('tbody').empty();


                        for (var i = 0; i < data.d.length; i++) {
                            $("#tblException").append(
                                "<tr><td>" + data.d[i].doc_sl + "</td><td>" + data.d[i].doc_name + "</td><td>" + data.d[i].status + "</td><td>" + data.d[i].details + "</td><td>" + data.d[i].deadline + "</td></tr>");
                        }
                    },
                    error: function () {
                        alert("Error while Showing update data");
                    }
                });



            }


            $("#ddlAnyDoc").change(function () {


                //alert('sdasd');

                var sts = $(this).val();

                //alert("You selected: " + sts);




                if (sts == "Obtained") {
                    $("#Obtained").css("display", "block");
                    $("#Not").css("display", "none");
                    $("#Part").css("display", "none");
                }

                if (sts == "Not") {
                    $("#Obtained").css("display", "none");
                    $("#Not").css("display", "block");
                    $("#Part").css("display", "none");
                }

                if (sts == "Part") {
                    $("#Obtained").css("display", "none");
                    $("#Not").css("display", "none");
                    $("#Part").css("display", "block");
                }

            });





            $("#btnAnyDocSave").click(function () {


                //var data_id = $(this).attr("data-id");
                //var div_name = $(this).attr("div-name");

                //alert(data_id);
                //alert(div_name);

                var anyDocName = $("#txtAnyDocName").val()
                var ddlAnyDocStatus = $("#ddlAnyDoc").val()
                //var anyDocName = $("#txtAnyDocName").val()

                if (anyDocName == '') {
                    alert('Pls put a document name');
                    return false;
                }

                //alert(ddl);

                var obj = {};

                obj.doc_name = anyDocName
                obj.status = ddlAnyDocStatus;
                obj.drawdown_id = 1; // $("#txteDocID").val();
                //obj.doc_sl = data_id; // $("#txtCustomerCode").val();

                var not_reason = $("#txtAnyDocReason").val();
                var part_reason = $("#txtAnyDocPart").val();
                var part_deadline = $("#txtAnyDocDeadline").val();

                obj.details = '';
                obj.deadline = '';

                if (ddlAnyDocStatus == 'Not') {
                    obj.details = not_reason; // $("#txtAnyDocReason").val();
                    if (not_reason == '') {
                        alert('Pls put reason');
                        return false;
                    }
                }
                if (ddlAnyDocStatus == 'Part') {
                    obj.details = part_reason; //$("#txtAnyDocPart").val();
                    obj.deadline = part_deadline; //$("#txtAnyDocDeadline").val();
                    if (part_reason == '' || part_deadline == '') {
                        alert('Pls put reason');
                        return false;
                    }
                }



                //alert(anyDocName);
                //alert(ddlAnyDocStatus);
                //alert(obj.details);
                //alert(obj.deadline);


                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "DocumentUpload_V9.aspx/Save_AnyDoc",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (msg) {


                        //alert("Data Saved Successfully.");

                        if (msg.d = "Data Saved") {
                            //swal("Success!", "Data Saved Successfully.", "success")
                            //$("#txtSubject").val('');
                            //$("#txtDetails").val('');

                            alert("Data Saved Successfully.");

                            if (ddlAnyDocStatus == 'Obtained') {
                                Load_AnyOthDoc_Status();
                            }
                            if (ddlAnyDocStatus == 'Not' || ddlAnyDocStatus == 'Part') {
                                LoadDocStatus_Exception();
                            }


                        }
                        else {
                            //swal("Error!", "Data not Saved!", "error")
                            alert('ERROR');
                        }

                    },
                    error: function () {

                        alert("Error while inserting data");
                        //sweetAlert("Oops...", "Something went wrong!", "error");
                    }
                });


                return false;

            });


            function Load_AnyOthDoc_Status() {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "DocumentUpload_V9.aspx/GetDataAnyOthDoc",
                    data: {},
                    dataType: "json",
                    success: function (data) {
                        //$('#tblAnyOthDoc tbody').remove();
                        $('#tblAnyOthDoc').find('tbody').empty();
                        //console.log(data.d);
                        for (var i = 0; i < data.d.length; i++) {
                            $("#tblAnyOthDoc").append(
                                "<tr><td>" + data.d[i].doc_sl + "</td><td>" + data.d[i].doc_name + "</td><td>" + data.d[i].status + "</td><td>" + data.d[i].details + "</td><td>" + data.d[i].deadline + "</td></tr>");
                        }
                    },
                    error: function () {
                        alert("Error while Showing update data");
                    }

                });



            }

            $(".confirm").click(function () {

                var data_id = $(this).attr("data-id");



                //alert(data_id);

                //var effect_from = row.find("td:eq(11)").text();  // Third cell (Age)
                //var day_basis = row.find("td:eq(14)").text();  // Third cell (Age)
                var rdo_conf = "";



                var reason = $("#txtCon_" + data_id).val();

                var rdo_conf = $("input[name='rdo_conf_" + data_id + "']:checked").val();
                if (rdo_conf) {
                    //alert("Selected option: " + selectedValue);
                    if (rdo_conf == "N") {
                        if (reason == "") {
                            alert("Pls put reason!");
                            return false;
                        }
                    }
                } else {
                    alert("No option selected!");
                    return false;
                }

                //alert(data_id + '-' + rdo_conf + '-' + reason);

                //return false;


                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "DocumentUpload_V9.aspx/SaveConfirmation",
                    data: '{dd_id:' + 1 + ',question_id: ' + data_id + ',reply:"' + rdo_conf + '",reason:"' + reason + '"}',

                    //data: '{"Loan_ID":"' + loan_id + '","Category":' + category + ',"MV":' + mv + ',"FSV":' + fsv + ',"Valuation_Date":"' + valuation_date + '"}',

                    //data: '{acc_type:"FDR",'acc_no: "' + acc_no + '"}',


                    dataType: "json",

                    success: function (msg) {

                        //swal("Success!", acc_type + '-' + acc_no, "success")

                        //$('#dataTable tbody').remove();

                        //$('#dataTable').find('tbody').empty();

                        //console.log(data.d);

                        //var sts = data.d.StatusCode;
                        //var msg = data.d.StatusText;
                        if (msg.d = "Data Saved") {
                            alert('Data Saved');
                        }

                    },

                    error: function () {
                        alert("Error while retreiving account status");
                    }

                });

            });

        });

    </script>
    <script type="text/javascript">


        var cus_type;
        var cus_id;

        $(function () {

            var queryString = window.location.search;

            //alert(queryString);
            //Remove the leading '?' and split by '&'
            var params = queryString.substring(1).split('&');

            cus_type = params[0].split('=')[1];
            alert(cus_type);
            var customer_auto_id = params[1].split('=')[1];
            //alert(customer_auto_id);
            var customer_edoc_id = params[2].split('=')[1];
            //alert(customer_edoc_id);
            cus_id = params[3].split('=')[1];
            alert(cus_id);

            //File Upload

            //$("body").on("click", ".upload", function () {

            $(".upload").click(function () {

                var doc_id = $(this).attr("data-id");

                var div_name = $(this).attr("div-name");



                var required = $('input[name="opt_req_' + doc_id + '"]:checked').val();

                alert(required);

                alert(doc_id + '-' + div_name);

                var ctrl = $("#fileInput_" + doc_id)[0];

                if (ctrl.files.length <= 0) {
                    alert('No file selected')
                    return;
                }

                //alert(ctrl.files[0].name);

                var fn = ctrl.files[0];

                //var extension = fn.name.substring(fn.lastIndexOf('.') + 1);

                var extension = fn.name.split('.').pop();

                //alert(extension);

                var formData = new FormData();
                //formData.append("customer_auto_id", customer_auto_id);
                //formData.append("customer_auto_id", 72);
                formData.append("doc_id", doc_id);
                //formData.append("file", ctrl.files[0]);
                formData.append("cus_id", cus_id);
                formData.append("file", fn);
                formData.append("required", required);


                $.ajax({

                    url: 'WebService3.asmx/UploadFiles_5',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (fileName) {

                        $("#div" + div_name + "StatusText_" + doc_id).html('Uploaded');

                        //$("#fileProgress").hide();
                        //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");


                        $("#btnView" + div_name + "_" + doc_id).css("display", "block");
                        $("#btnView" + div_name + "_" + doc_id).attr("cus-id", cus_id);
                        $("#btnView" + div_name + "_" + doc_id).attr("doc-id", doc_id);
                        $("#btnView" + div_name + "_" + doc_id).attr("file-name", fileName);
                        $("#btnView" + div_name + "_" + doc_id).attr("file-ext", extension);

                        $("#btnDelete" + div_name + "_" + doc_id).css("display", "block");



                        //swal("Success!", "Uploaded", "success");



                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        //Check if upload property exists
                        if (fileXhr.upload) {

                            //update progressbar percent complete
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    //$("#Status_Text").attr({ value: e.loaded, max: e.total });
                                    //console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    //console.log(percentage + '%');
                                    $("#div" + div_name + "StatusText_" + doc_id).html(percentage + '%');

                                }
                            }, false);

                        }
                        return fileXhr;


                    }, error: function () {
                        alert("Whoops something went wrong!");
                    }
                });
            });

        });

        



    </script>
    <script type="text/javascript">

        $(function () {

            //$("body").on("click", ".V", function () {


            //$(".V").click(function () {
            $(".View").click(function () {



                var id = $(this).attr("doc-id");
                var fn = $(this).attr("file-name");

                alert(fn);

                var extension = fn.split('.').pop();

                alert(extension);

                if (extension == 'JPG' || extension == 'jpg' || extension == 'jpeg' || extension == "JPEG") {


                    var imageUrl = "ImageHandler_V2.ashx?filePath=" + fn;

                    // Set the image source and open the dialog
                    $("#imageViewer").attr("src", imageUrl);
                    $("#imageDialog").dialog("open");

                    return;

                }

                if (extension == 'pdf' || extension == "PDF") {


                    var pdfUrl = "PDFHandler.ashx?filePath=" + fn;

                    // Set the iframe source and open the dialog
                    $("#pdfFrame").attr("src", pdfUrl);
                    $("#pdfDialog").dialog("open");

                    return;

                }

                //alert('View ?' + id);

            });


            $("body").on("click", ".D", function () {

                var id = $(this).attr("data-id");



                //alert('Delete ?' + id);

                swal({
                    title: "Are you sure to delete?" + id,
                    text: "You will not be able to recover this entry!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Yes, delete it!",
                    cancelButtonText: "No, cancel pls!",
                    closeOnConfirm: true,
                    closeOnCancel: true
                },


function (isConfirm) {
    if (isConfirm) {


        var formData = new FormData();
        formData.append("id", id);


        $.ajax({

            url: 'WebService3.asmx/DeleteFile',
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (fileName) {
                swal("Success!", "Deleted", "success")
                //window.location.reload(); 
                location.reload(true);
            },
            error: function () {
                alert("Whoops something went wrong!");
            }
        });

    }



    //else {
    //swal("Cancelled", "Data not Deleted)", "error");
    //return false;
    //}

});
            });

        });

    </script>
    <style type="text/css">
        body
        {
            font-size: 12px;
        }
    </style>
    <style type="text/css">
        fieldset
        {
            display: inline;
        }
    </style>
    <style type="text/css">
        input[type="text"]
        {
            height: 20px;
            vertical-align: top;
        }
        .field_wrapper div
        {
            margin-bottom: 10px;
        }
        .add_button
        {
            margin-top: 10px;
            margin-left: 10px;
            vertical-align: text-bottom;
        }
        .remove_button
        {
            margin-top: 10px;
            margin-left: 10px;
            vertical-align: text-bottom;
        }
        
        .row-highlight 
        {
            
    background-color: #fff3cd !important;
}


    </style>
    <style type="text/css">
        table
        {
            border-collapse: collapse;
        }
        td, th
        {
            border: 1px solid #007bff;
        }
        .ui-accordion-content
        {
            height: auto !important;
        }
        
        
        .docTable td
        {
        }
        
        .details input, button
        {
            display: inline-block;
            width: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 10px; padding: 10px;">
        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
      

        <input  type="button" value="Close" onclick="window.close();"/>
        <br />   <br />
        <table>
            <tr>
                <td>
                    Customer Type
                </td>
                <td>
                    <asp:TextBox ID="txtCustomerType" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    eDOC ID
                </td>
                <td>
                    <asp:TextBox ID="txteDOCID" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />

        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>



        <br />
        <div id="accordion" style="width: auto;">
            <%
                for (int i = 0; i < TabsName.Length; i++)
                {
                    var section_name = TabsName[i];

                    var doc_Type = DocType[i];

                    var DocPosition = DocSerial[i];
            %>
            <% 
                    if (doc_Type == "GENERAL")
                    {
                        TableData = TableData_GENERAL;
                    }
                    if (doc_Type == "MORTGAGE")
                    {
                        TableData = TableData_MORTGAGE;
                    }
                    if (doc_Type == "LIABILITY")
                    {
                        TableData = TableData_LIABILITY;
                    }
                    if (doc_Type == "HYPOTHECATION")
                    {
                        TableData = TableData_HYPOTHECATION;
                    }
                    if (doc_Type == "PLEDGE")
                    {
                        TableData = TableData_PLEDGE;
                    }
                    if (doc_Type == "ASSIGNMENT")
                    {
                        TableData = TableData_ASSIGNMENT;
                    }
                    if (doc_Type == "LIEN")
                    {
                        TableData = TableData_LIEN;
                    }
                    if (doc_Type == "SET")
                    {
                        TableData = TableData_SET;
                    }
                    if (doc_Type == "CHARGE")
                    {
                        TableData = TableData_CHARGE;
                    }
                    if (doc_Type == "SYNDICATION")
                    {
                        TableData = TableData_SYNDICATION;
                    }
                    if (doc_Type == "INSURANCE")
                    {
                        TableData = TableData_INSURANCE;
                    }
                    if (doc_Type == "UNDERTAKING")
                    {
                        TableData = TableData_UNDERTAKING;
                    }
                    if (doc_Type == "LETTER")
                    {
                        TableData = TableData_LETTER;
                    }
                    if (doc_Type == "IDBP")
                    {
                        TableData = TableData_IDBP;
                    }
                    if (doc_Type == "OTHER")
                    {
                        TableData = TableData_OTHER;
                    }



                    Int32 doc_id;

                    String file_name;

                    String status;

                    String remarks;

                    String date;

                    if (TableData.Rows.Count > 0)
                    {
                        
            %>
            <h3>
                <%=DocPosition%>
              
                <%=section_name%></h3>
            <div id="<%=section_name%>">
                <table class="<%=DocType[i]%>  docTable" id="<%=DocType[i]%>" style="width: 100%">
                    <thead>
                        <tr>
                            <th>
                                id
                            </th>
                            <th>
                                Name
                            </th>
                            <th>
                                Required ?
                            </th>
                            <th>
                                Document Obtained Status
                            </th>
                            <th>
                                Details <span id="statusDetails"></span>
                            </th>
                         
                            <th>
                                Action
                            </th>   <th>Upload Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for (var data = 0; data < TableData.Rows.Count; data++)
                        {
                            doc_id = Convert.ToInt32(TableData.Rows[data]["primary_key"]);

                            file_name = (TableData.Rows[data]["file_name"]).ToString();

                            status = (TableData.Rows[data]["c_status"]).ToString();

                            if (status == null || status == "")
                            {
                                status = "Obtained";
                            }
                            remarks = (TableData.Rows[data]["c_remarks"]).ToString();
                            date = (TableData.Rows[data]["c_date"]).ToString();
                            
                        %>
                        <tr>
                            <td>
                                <%=TableData.Rows[data]["primary_key"]%>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <%-- <%=TableData.Rows[data]["Required"]%>--%>
                                <input type="radio" class="rdo" name="opt_req_<%=TableData.Rows[data]["primary_key"]%>" data-id="<%=TableData.Rows[data]["primary_key"]%>"
                                    value="Y" <%=TableData.Rows[data]["Required"].ToString()=="Yes"?"checked":""%> />
                                Yes
                                <input type="radio" class="rdo" name="opt_req_<%=TableData.Rows[data]["primary_key"]%>" data-id="<%=TableData.Rows[data]["primary_key"]%>"
                                    value="N" />No
                            </td>
                            <td>
                                <%--<%=TableData.Rows[data]["Obtained"]%>--%>
                                <select id="ddl_<%=doc_id %>" data-id="<%=TableData.Rows[data]["primary_key"]%>" class="ddlStatus">
                                    

                                      <option value="Obtained" <%= status == "Obtained" ? "selected" : "" %>>
        Obtained
    </option>

    <option value="Not" <%= status == "Not" ? "selected" : "" %>>
        Not Obtained
    </option>

    <option value="Part" <%= status == "Part" ? "selected" : "" %>>
        Partially Obtained
    </option>

                                </select>
                            </td>
                            <td style="white-space: nowrap;" class="details">
                                <div id="Obtained_<%=doc_id%>"     style="<%= status == "Obtained" ? "" : "display:none;" %>" >
                                    <input type="file" class="file" id="fileInput_<%=doc_id %>" data-id="c" name="fileInput_<%=doc_id %>" />
                                    <span id="<%=DocType[i]%>_id_<%=doc_id %>" class="id">
                                        <%=doc_id%></span>
                                    <input type="button" value="Upload" class="upload" data-id="<%=doc_id%>" div-name="<%=DocType[i]%>" />
                                    <span id="div<%=DocType[i]%>StatusText_<%=doc_id %>">0%</span>
                                </div>
                                <div id="Not_<%=doc_id%>"   style="<%= status == "Not" ? "" : "display:none;" %>" >
                                    Not Obtained Reasons :
                                    <%=TableData.Rows[data]["remarks"]%>
                                    <input id="txtNotObtained_<%=doc_id %>" type="text" value="<%=remarks %>"/>
                                </div>
                                <div id="Part_<%=doc_id%>"  style="<%= status == "Part" ? "" : "display:none;" %>">
                                    <%=TableData.Rows[data]["remarks"]%>
                                    Partially Obtained Reasons :
                                    <input id="txtPartiallyObtained_<%=doc_id %>" type="text"   value="<%=remarks %>" />
                                    Deadline :
                                    <input id="txtDeadline_<%=doc_id %>" type="text" class="datepicker"   value="<%=date %>"  />
                                </div>

                                <input type="button" value="Save" id="btnSave_<%=doc_id%>"   class="save" data-id="<%=doc_id%>" div-name="<%=DocType[i]%>"  style="<%= status == "Obtained" ? "display:none;" : "" %>"   />
                                
                                
                                 
                                
                               


                            </td>



                            <td>

                        
                                <input id="btnView<%=DocType[i]%>_<%=doc_id %>" type="button" value="View" class="View" data-id="<%=doc_id%>"

                                 file-name="<%=file_name%>"

                                     <%  if (file_name!=""){ %>
                                    style="display: block;"

                                     <%
                            }
                            else
                            {
                                        
                                        
                                         %>

                                         style="display: none;" 

                                         <%} %>
                                          />


                                <input id="btnDelete<%=DocType[i]%>_<%=doc_id %>" type="button" value="Delete" class="Delete" data-id="<%=doc_id%>"   file-name="<%=file_name%>"
                                   
                                     <%  if (file_name!=""){
                                     
                                      %>
                                    style="display: block;"

                                     <%
                            }
                            else
                            {
                                        
                                        
                                         %>

                                         style="display: none;" 

                                         <%} %>
                                          />

                                   
                                <% 
                            /*
                                    if (doc_Type == "GENERAL")
                            {
                            */

 
                                    /*
                                }
                                     */
                            
                                %>
                            </td>


                            <td>
                               <% =TableData.Rows[data]["upload_date_time"].ToString()%>
                            </td>
                        </tr>
                        <%
                        }
                            
            
                        %>
                    </tbody>
                </table>
                <input type="button" class="BulkUpload" value="Upload ALL" data-count="<%=TableData.Rows.Count %>"
                    div-name="<%=DocType[i]%>" />
                <input id="Button1" type="button" value="button" class="ViewPDF" /><br />
                <input id="showImageBtn" class="ViewImage" value="button" type="button" />
            </div>
            <%
                    }

                }
                
            %>
            <!--dssdfsdfsfsdsfsdfsafsadf-->
        </div>
        <br />
        <hr />
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <i class="fa fa-bar-chart-o"></i>Any Other Document</h3>
            </div>
            <div class="panel-body">
                <table class="table table-condensed">
                    <tr>
                        <td>
                            Document Details
                        </td>
                        <td>
                            Status
                        </td>
                        <td>
                            Reason/Explanation
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <textarea id="txtAnyDocName" cols="20" rows="2"></textarea>
                        </td>
                        <td>
                            <select id="ddlAnyDoc">
                                <option value="Obtained">Obtained</option>
                                <option value="Not">Not Obtained</option>
                                <option value="Part">Partially Obtained</option>
                            </select>
                        </td>
                        <td>
                            <div id="Obtained" style="display: block;">
                                <input id="File1" type="file" /></div>
                            <div id="Not" style="display: none;">
                                Not Obtained Reasons :<input type="text" id="txtAnyDocReason" />
                            </div>
                            <div id="Part" style="display: none;">
                                Partially Obtained Reasons :
                                <input type="text" id="txtAnyDocPart" />
                                Deadline :
                                <input type="text" id="txtAnyDocDeadline" class="datepicker" /></div>
                            <input type="button" value="Save" id="btnAnyDocSave" />
                        </td>
                    </tr>
                </table>
               </div>
        </div>
        <br />
        <div id="modal_dialog" style="display: none">
            This is a Modal Background popup
            <img alt="" src="1_Saikot.jpg.jpg" id="img" />
        </div>
        <br />
        <div id="pdfDialog" title="PDF Viewer" style="display: none;">
            <iframe id="pdfFrame" style="width: 100%; height: 100%;" frameborder="0"></iframe>
        </div>
        <br />
        <!-- Hidden Div for Dialog -->
        <div id="imageDialog" title="Image Viewer" style="display: none;">
            <img id="imageViewer" src="" alt="Image" style="width: 100%; height: auto;" />
        </div>
    </div>
    </form>
</body>
</html>
