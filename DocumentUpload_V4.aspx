<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentUpload_V4.aspx.cs"
    Inherits="DocumentUpload_V3" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<script src="Jquery/jquery.3.2.1.js" type="text/javascript"></script>
    <script src="JQuery/jquery-ui-1.8.12.custom.min.js" type="text/javascript"></script>
    <link href="JQuery/sunny/jquery-ui-1.8.9.custom.css" rel="stylesheet" type="text/css" />--%>
    <%-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css"
        rel="stylesheet" type="text/css" />--%>
    <link href="js/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui.js" type="text/javascript"></script>
    <script src="JQuery/Calendar.js" type="text/javascript"></script>
    <link href="CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="sweet_alert.css" rel="stylesheet" type="text/css" />
    <script src="sweet_alert.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#tabs").tabs();
        });
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

        $(document).ready(function () {



            var queryString = window.location.search;

            //alert(queryString);
            // Remove the leading '?' and split by '&'
            var params = queryString.substring(1).split('&');

            var cus_type = params[0].split('=')[1];
            //alert(cus_type);
            var customer_auto_id = params[1].split('=')[1];
            //alert(customer_auto_id);
            var customer_edoc_id = params[2].split('=')[1];
            //alert(customer_edoc_id);






            $('#Button1').click(function () {

                //var id = $(this).attr("data-id");

                //alert(id);


            });


            $("body").on("click", ".V", function () {


                var id = $(this).attr("data-id");
                var fn = $(this).attr("file-name");


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

    } //else {
    //swal("Cancelled", "Data not Deleted)", "error");
    //return false;
    //}

});
            });




            $("body").on("click", ".ViewPDF", function () {

                var fn = "72_7_41200004322_6_16 PM.pdf";


                alert(fn);

                //var cus_auto_id = $(this).attr("cus-auto-id");
                //var file_auto_id = $(this).attr("file-auto-id");
                //var fn = $(this).attr("file-name");
                //alert(cus_auto_id + '-' + file_auto_id + '-' + fn);

                //fn = cus_auto_id + "_" + file_auto_id + "_" + fn;

                var pdfUrl = "PDFHandler.ashx?filePath=" + fn;

                // Set the iframe source and open the dialog
                $("#pdfFrame").attr("src", pdfUrl);
                $("#pdfDialog").dialog("open");


            });


            $("body").on("click", ".ViewImage", function () {

                var fn = "72_7_feedback.jpg";

                alert(fn);
                //var filePath = encodeURIComponent("C:\\OutsideRoot\\example.jpg"); // Change this to the actual file path
                var imageUrl = "ImageHandler_V2.ashx?filePath=" + fn;

                // Set the image source and open the dialog
                $("#imageViewer").attr("src", imageUrl);
                $("#imageDialog").dialog("open");

            });

            $("body").on("click", ".Delete", function () {

                var fn = "";

                //var cus_auto_id = $(this).attr("cus-auto-id");
                //var file_auto_id = $(this).attr("file-auto-id");
                //var fn = $(this).attr("file-name");

                alert('Delete');

            });


            $("body").on("click", ".View", function () {

                var fn = "";

                var cus_auto_id = $(this).attr("cus-auto-id");
                var file_auto_id = $(this).attr("file-auto-id");
                var fn = $(this).attr("file-name");

                var ext = $(this).attr("file-ext");

                alert(cus_auto_id + '-' + file_auto_id + '-' + fn + '-' + ext);

                fn = cus_auto_id + "_" + file_auto_id + "_" + fn;

                if (ext == 'pdf' || ext == 'PDF') {
                    var pdfUrl = "PDFHandler.ashx?filePath=" + fn;

                    // Set the iframe source and open the dialog
                    $("#pdfFrame").attr("src", pdfUrl);
                    $("#pdfDialog").dialog("open");

                    return;
                }


                if (ext == 'JPG' || ext == 'jpg' || ext == 'jpeg' || ext == "JPEG") {


                    var imageUrl = "ImageHandler_V2.ashx?filePath=" + fn;

                    // Set the image source and open the dialog
                    $("#imageViewer").attr("src", imageUrl);
                    $("#imageDialog").dialog("open");

                    return;

                }

                //if (id == 1) {
                //$('#img').attr('src', "1_Saikot.jpg.jpg");
                //fn = "1_Saikot.jpg.jpg";
                //}
                //if (id == 2) {
                //$('#img').attr('src', "2_MOther in law.jpg.jpg");

                //fn = "2_MOther in law.jpg.jpg";
                //}

                //fn = "2_MOther in law.jpg.jpg";


                $.ajax({
                    type: "POST",
                    url: "DocumentUpload.aspx/GetDetails2",
                    data: '{"fn": "' + fn + '" }',
                    //data: "{fn: " + fn + " }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //$('#MyPopup').find('[id*=lblName]').html(response.d[1]);
                        $('#modal_dialog').find('[id=img]').attr('src', response.d[0]);
                        //$('#MyPopup').modal('show');

                        $("#modal_dialog").dialog({

                            title: "jQuery Modal Dialog Popup",

                            width: $(window).width(),
                            height: $(window).height(),
                            buttons: {
                                Close: function () {
                                    $(this).dialog('close');
                                }
                            },
                            modal: true

                        });


                    },
                    error: function (response) { alert(response.responseText); }
                });

                return false;

                //alert(id);
                /*
                $("#modal_dialog").dialog({
                title: "jQuery Modal Dialog Popup",

                width: $(window).width(),
                height: $(window).height(),
                buttons: {
                Close: function () {
                $(this).dialog('close');
                }
                },
                modal: true
                });
                return false;
                */
            });

            $("body").on("click", ".upload", function () {

                var file_auto_id = $(this).attr("data-id");

                var div_name = $(this).attr("div-name");

                //alert(file_auto_id + '-' + div_name);

                var ctrl = $("#fileInput_" + file_auto_id)[0];

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
                formData.append("customer_auto_id", customer_auto_id);
                formData.append("file_auto_id", file_auto_id);
                //formData.append("file", ctrl.files[0]);
                formData.append("file", fn);


                $.ajax({

                    url: 'WebService3.asmx/UploadFiles',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (fileName) {

                        $("#div" + div_name + "StatusText_" + file_auto_id).html('Uploaded');

                        //$("#fileProgress").hide();
                        //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");


                        $("#btnView" + div_name + "_" + file_auto_id).css("display", "block");
                        $("#btnView" + div_name + "_" + file_auto_id).attr("cus-auto-id", customer_auto_id);
                        $("#btnView" + div_name + "_" + file_auto_id).attr("file-auto-id", file_auto_id);
                        $("#btnView" + div_name + "_" + file_auto_id).attr("file-name", fn.name);
                        $("#btnView" + div_name + "_" + file_auto_id).attr("file-ext", extension);

                        $("#btnDelete" + div_name + "_" + file_auto_id).css("display", "block");



                        swal("Success!", "Uploaded", "success");



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
                                    $("#div" + div_name + "StatusText_" + file_auto_id).html(percentage + '%');

                                }
                            }, false);

                        }
                        return fileXhr;


                    }, error: function () {
                        alert("Whoops something went wrong!");
                    }
                });
            });


            function upload(ctrl, id, div_name) {

                //ctrl.files[0]

                //var div = "Basic";

                var div = div_name;

                var formData = new FormData();
                formData.append("filePrefix", id);
                //formData.append("fileName", ctrl.files[0].name);
                formData.append("file", ctrl.files[0]);
                //formData.append("file", $("#fileInput_" + id)[0].files[0]);
                //formData.append("file", $('#fileInput_' + id)[0]);

                //$("#file")[0].files[0]

                //alert('tttt');


                $.ajax({
                    url: 'WebService3.asmx/UploadFiles',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (fileName) {
                        //alert("#" + div + "_Status_Text_" + id);
                        $("#div" + div_name + "StatusText_" + id).html('Uploaded');
                        //$("#fileProgress").hide();
                        //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");


                        $("#btnView" + div_name + "_" + id).css("display", "block");

                        $("#btnView" + div_name + "_" + id).attr("data-myval", id);

                        $("#btnView" + div_name + "_" + id).attr("file-type", id);

                        //divBasicStatusText_7

                    },
                    xhr: function () {

                        var fileXhr = $.ajaxSettings.xhr();
                        //Check if upload property exists
                        if (fileXhr.upload) {

                            //update progressbar percent complete
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    //$("#Status_Text").attr({ value: e.loaded, max: e.total });
                                    console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    console.log(percentage + '%');
                                    $("#" + div + "StatusText_" + id).html(percentage + '%');

                                }
                            }, false);

                        }
                        return fileXhr;


                    }, error: function () {
                        alert("Whoops something went wrong!");
                    }
                });
            }



            //$('#uploadFiles').click(function () {
            $("body").on("click", ".BulkUpload", function () {



                var id = $(this).attr("data-count");

                var div_name = $(this).attr("div-name");

                alert(id + '-' + div_name);

                //$("#Basic").find("input[type='file']").each(function (index) {
                $("#" + div_name).find("input[type='file']").each(function (index) {

                    // Get the ID or class of the file input

                    var inputId = $(this).attr("id");

                    var inputName = $(this).attr("name");

                    var sl = $(this).attr("data-sl");

                    var ctrl = $(this)[0];

                    /*
                    if (ctrl.files.length <= 0) {
                    alert('No file selected')
                    return;
                    }
                    */

                    if (ctrl.files.length > 0) {
                        upload(ctrl, sl, div_name)
                    }


                    //alert(inputId + '-' + inputName);


                    // Check if a file is selected
                    //if (this.files.length > 0) {
                    //console.log(`File input ${inputId || index + 1}: File selected - "${this.files[0].name}"`);
                    //} else {
                    //console.log(`File input ${inputId || index + 1}: No file selected`);
                    //}


                });







                /*
                $("#Basic tbody tr").each(function (rowIndex) {


                $(this).find("td").each(function (colIndex) {

                /*
                var inputElement = $(this).find("input");
                if (inputElement.length > 0) {
                var inputType = inputElement.attr("type");

                      
                  

                });



                });
                */

                /*

                for (var i = 1; i <= 10; i++) {
                var fileInput = $('#fileInput_' + i)[0];

                if (fileInput.files.length > 0) {
                var formData = new FormData();
                formData.append('file', fileInput.files[0]);

                var progressBar = $('#progress' + i)[0];

                       
                var xhr = new XMLHttpRequest();

                       
                xhr.upload.addEventListener('progress', function (e) {
                if (e.lengthComputable) {
                var percent = (e.loaded / e.total) * 100;
                progressBar.value = percent;
                }
                });

                     
                xhr.open('POST', '/WebService.asmx/UploadFile', true);
                xhr.setRequestHeader('Accept', 'application/json');
                xhr.onload = function () {
                if (xhr.status === 200) {
                alert('File uploaded successfully!');
                } else {
                alert('Error uploading file');
                }
                };

                       
                xhr.send(formData);
                }
                }
                */
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 10px;">
        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
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
        <div id="tabs" style="width: 100%;">
            <ul>
                <%
                    for (int i = 0; i < TabsName.Length; i++)
                    {
                  
                %>
                <li><a href="#tabs-<%=i %>">
                    <%=TabsName[i]%></a></li>
                <%
                    }
                
                %>
            </ul>
            <%
                for (int i = 0; i < TabsName.Length; i++)
                {
                    var doc_Type = DocType[i];
                    
            %>
            <div id="tabs-<%=i %>">
                <%=TabsName[i]%>
                <br />
                <table class="<%=DocType[i]%>" id="<%=DocType[i]%>">
                    <thead>
                        <tr>
                            <th>
                                id
                            </th>
                            <th>
                                Name
                            </th>
                            <th>
                                Browse
                            </th>
                            <th>
                                Required
                            </th>
                            <th>
                                Obtained ?
                            </th>
                            <th>
                                Not Obtained Reason
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                    if (doc_Type == "Basic")
                    {
                        TableData = TableData_Basic;
                    }
                    if (doc_Type == "Charge")
                    {
                        TableData = TableData_Charge;
                    }
                    if (doc_Type == "Liability")
                    {
                        TableData = TableData_Liability;
                    }
                    if (doc_Type == "Loan")
                    {
                        TableData = TableData_Loan;
                    }
                    if (doc_Type == "Mortgage")
                    {
                        TableData = TableData_Mortgage;
                    }
                    if (doc_Type == "Other")
                    {
                        TableData = TableData_Other;
                    }
                    if (doc_Type == "Syndication")
                    {
                        TableData = TableData_Syndication;
                    }
                    if (doc_Type == "Undertaking")
                    {
                        TableData = TableData_Undertaking;
                    }

                    Int32 doc_id;

                    for (var data = 0; data < TableData.Rows.Count; data++)
                    {
                        doc_id = Convert.ToInt32(TableData.Rows[data]["SL"]);
            
                        %>
                        <tr>
                            <td>
                                <%=TableData.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <% 
                                //if (Admin != "Y")
                                   
                               //{ 
                                %>
                                <input type="file" class="file" id="fileInput_<%=doc_id %>" data-sl="<%=doc_id %>"
                                    name="fileInput_<%=doc_id %>" />
                                <span id="<%=DocType[i]%>_id_<%=doc_id %>" class="id">
                                    <%=doc_id%></span>
                                <input type="button" value="Upload" class="upload" data-id="<%=doc_id%>" div-name="<%=DocType[i]%>" />
                                <div id="div<%=DocType[i]%>StatusText_<%=doc_id %>">
                                    0%</div>
                                <%
                                    //}
                                %>
                                <input id="btnView<%=DocType[i]%>_<%=doc_id %>" type="button" value="View" class="View"
                                    style="display: none;" />
                                <input id="btnDelete<%=DocType[i]%>_<%=doc_id %>" type="button" value="Delete" class="Delete"
                                    style="display: none;" />
                                <% 
                        if (doc_Type == "Basic")
                        {

                            if (TableData.Rows[data]["file_name"].ToString() != "")
                            {
                                %>
                                <input id="Button2" type="button" value="View" file-name="<%=TableData.Rows[data]["file_name"]%>"
                                    data-id="<%=TableData.Rows[data]["id"]%>" class="V" />
                                <input id="Button3" type="button" value="Delete" data-id="<%=TableData.Rows[data]["id"]%>"
                                    class="D" />
                                <%=TableData.Rows[data]["file_name"].ToString()%>
                                <%
                            }
                        }
                                %>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["Obtained"]%>
                                <select id="ddl_<%=doc_id %>">
                                    <option>Obtained</option>
                                    <option>Not Obtained</option>
                                    <option>Partially Obtained</option>
                                </select>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["NotObtained_Reason"]%>
                                <input id="txtReason_<%=doc_id %>" type="text" />
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
                    
            %>
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
    <br />
    <br />
    </form>
</body>
</html>
