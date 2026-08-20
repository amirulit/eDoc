<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JqueryTAB.aspx.cs" Inherits="JqueryTAB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--   <script src="Jquery/jquery.3.2.1.js" type="text/javascript"></script>
    <script src="JQuery/jquery-ui-1.8.12.custom.min.js" type="text/javascript"></script>
    <link href="JQuery/sunny/jquery-ui-1.8.9.custom.css" rel="stylesheet" type="text/css" />--%>


    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css"
        rel="stylesheet" type="text/css" />
    <script src="JQuery/Calendar.js" type="text/javascript"></script>
    <link href="CSS/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            $("#tabs").tabs();
        });
    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $('#Button1').click(function () {

                //var id = $(this).attr("data-id");

                //alert(id);


            });

            $("body").on("click", ".View", function () {

                var fn = "";

                var id = $(this).attr("data-myval");

                //alert(id);

                if (id == 1) {
                    //$('#img').attr('src', "1_Saikot.jpg.jpg");
                    fn = "1_Saikot.jpg.jpg";
                }
                if (id == 2) {
                    //$('#img').attr('src', "2_MOther in law.jpg.jpg");

                    fn = "2_MOther in law.jpg.jpg";
                }


                $.ajax({
                    type: "POST",
                    url: "JqueryTAB.aspx/GetDetails2",
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

                var id = $(this).attr("data-id");

                var div_name = $(this).attr("div-name");

                //alert(id);

                var ctrl = $("#fileInput_" + id)[0];

                if (ctrl.files.length <= 0) {
                    alert('No file selected')
                    return;
                }

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
                        $("#" + div_name + "_statustxt_" + id).html('Uploaded');
                        //$("#fileProgress").hide();
                        //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");


                        $("#" + div_name + "_View_" + id).css("display", "block");
                        $("#" + div_name + "_View_" + id).attr("data-myval", id);


                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        //Check if upload property exists
                        if (fileXhr.upload) {

                            //update progressbar percent complete
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    //$("#statustxt").attr({ value: e.loaded, max: e.total });
                                    console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    console.log(percentage + '%');
                                    $("#" + div_name + "_statustxt_" + id).html(percentage + '%');

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
                        //alert("#" + div + "_statustxt_" + id);
                        $("#" + div + "_statustxt_" + id).html('Uploaded');
                        //$("#fileProgress").hide();
                        //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");


                        $("#" + div + "_View_" + id).css("display", "block");

                        $("#" + div + "_View_" + id).attr("data-myval", id);



                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        //Check if upload property exists
                        if (fileXhr.upload) {

                            //update progressbar percent complete
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    //$("#statustxt").attr({ value: e.loaded, max: e.total });
                                    console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    console.log(percentage + '%');
                                    $("#" + div + "_statustxt_" + id).html(percentage + '%');

                                }
                            }, false);

                        }
                        return fileXhr;


                    }, error: function () {
                        alert("Whoops something went wrong!");
                    }
                });
            }



            $('#uploadFiles').click(function () {

                var id = $(this).attr("data-id");

                var div_name = $(this).attr("div-name");

                //alert(id + '-' + name);

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
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 10px;">
        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
        <table>
            <tr>
                <td>
                    Company Code
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <div id="tabs" style="width: 100%;">
            <ul>
                <li><a href="#tabs-1">Basic Documents</a> </li>
                <li><a href="#tabs-2">Charge Documents</a></li>
                <li><a href="#tabs-3">Liability takeover</a></li>
                <li><a href="#tabs-4">Loan Documents</a> </li>
                <li><a href="#tabs-5">Mortgage Document</a></li>
                <li><a href="#tabs-6">Other Documents</a></li>
                <li><a href="#tabs-7">Syndication/Pledge Doc.</a> </li>
                <li><a href="#tabs-8">Undertaking</a></li>
            </ul>
            <div id="tabs-1">
                Basic Documents
                <br />
                <table class="Basic" id="Basic">
                    <thead>
                        <tr>
                            <th>
                                SL
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
                                Obtained
                            </th>
                            <th>
                                Not Obtained Reason
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
        
                            for (var data = 1; data <= 10; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="fileInput_<%=data %>" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="id_<%=data %>" class="id">
                                    <%=data %></span>
                                <%--<progress id="progress_<%=data %>" value="0" max="100"></progress>--%>
                                <input id="Button1" type="button" value="Upload" class="upload" data-id="<%=data %>"
                                    div-name="Basic" />
                                <div id="Basic_statustxt_<%=data %>">
                                    0%</div>
                                <input id="Basic_View_<%=data %>" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
                <input id="uploadFiles" type="button" value="Upload" data-id="10" div-name="Basic" />
                <br />
            </div>
            <div id="tabs-2">
                Charge Documents
                <br />
            </div>
            <div id="tabs-3">
                Liability takeover
                <br />
            </div>
            <div id="tabs-4">
                Loan Documents
                <br />
            </div>
            <div id="tabs-5">
                Mortgage Document
                <br />
            </div>
            <div id="tabs-6">
                Other Documents
                <br />
            </div>
            <div id="tabs-7">
                Syndication/Pledge Doc.
                <br />
            </div>
            <div id="tabs-8">
                Undertaking
                <br />
            </div>
        </div>
    </div>
    <br />
    <div id="modal_dialog" style="display: none">
        This is a Modal Background popup
        <img alt="" src="1_Saikot.jpg.jpg" id="img" />
    </div>
    </form>
</body>
</html>
