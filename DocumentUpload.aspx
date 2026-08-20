<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentUpload.aspx.cs" Inherits="DocumentUpload" %>

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
                        $("#" + div_name + "_Status_Text_" + id).html('Uploaded');
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
                                    //$("#Status_Text").attr({ value: e.loaded, max: e.total });
                                    console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    console.log(percentage + '%');
                                    $("#" + div_name + "_Status_Text_" + id).html(percentage + '%');

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
                        $("#" + div + "_Status_Text_" + id).html('Uploaded');
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
                                    //$("#Status_Text").attr({ value: e.loaded, max: e.total });
                                    console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    console.log(percentage + '%');
                                    $("#" + div + "_Status_Text_" + id).html(percentage + '%');

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
                <li><a href="#tabs-1">Basic Documents</a> </li>
                <li><a href="#tabs-2">Charge Documents</a></li>
                <li><a href="#tabs-3">Liability Takeover</a></li>
                <li><a href="#tabs-4">Loan Documents</a> </li>
                <li><a href="#tabs-5">Mortgage Document</a></li>
                <li><a href="#tabs-6">Other Documents</a></li>
                <li><a href="#tabs-7">Syndication/Pledge Doc.</a></li>
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
                            Int32 doc_id;
                            for (var data = 1; data <= TableData_Basic.Rows.Count; data++)
                            {
                                doc_id = Convert.ToInt32(TableData_Basic.Rows[data]["SL"]);
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Basic.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Basic.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="fileInput_<%=doc_id %>" data-sl="<%=doc_id %>" name="fileInput_<%=doc_id %>" />
                                <span id="BasicID_<%=doc_id %>" class="id"><%=doc_id%></span>
                                <input type="button" value="Upload" class="upload" data-id="<%=doc_id%>" div-name="Basic" />
                                <div id="divBasicStatusText_<%=doc_id %>">0%</div>
                                <input id="btnViewBasic_<%=doc_id %>" type="button" value="View" class="View" style="display: none;"/>
                            </td>
                            <td>
                                <%=TableData_Basic.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Basic.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Basic.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
                <input id="uploadFiles" type="button" value="Upload" data-id="<%=TableData_Basic.Rows.Count %>" div-name="Charge" />
                <br />
            </div>
            <div id="tabs-2">
                Charge Documents
                <br />
                <table class="Charge" id="Charge">
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
        
                            for (var data = 1; data <= TableData_Charge.Rows.Count; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Charge.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Charge.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="file1" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="ChargeID_<%=data %>" class="id"><%=data %></span>
                                <input type="button" value="Upload" class="upload" data-id="<%=data %>" div-name="Charge" />
                                <div id="divChargeStatusText_<%=data %>">0%</div>
                                <input id="btnViewCharge_<%=data %>" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData_Charge.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Charge.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Charge.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
                <input id="Button2" type="button" value="Upload" data-id="<%=TableData_Charge.Rows.Count %>" div-name="Liability" />
                <br />
            </div>
            <div id="tabs-3">
                Liability Takeover
                <br />
                <table class="Liability" id="Liability">
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
        
                            for (var data = 1; data <= TableData_Liability.Rows.Count; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Liability.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Liability.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="file2" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="LiabilityID_<%=data %>" class="id"><%=data %></span>
                                <input type="button" value="Upload" class="upload" data-id="<%=data %>"  div-name="Liability" />
                                <div id="divLiabilityStatusText_<%=data %>">0%</div>
                                <input id="btnViewLiability_<%=data %>" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData_Liability.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Liability.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Liability.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
                <input id="Button3" type="button" value="Upload" data-id="<%=TableData_Liability.Rows.Count %>" div-name="Basic" />
                <br />
            </div>
            <div id="tabs-4">
                Loan Documents
                <br />
                <table class="Loan" id="Loan">
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
        
                            for (var data = 1; data <= TableData_Loan.Rows.Count; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Loan.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Loan.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="file3" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="LoanID_<%=data %>" class="id"><%=data %></span>
                                <input  type="button" value="Upload" class="upload" data-id="<%=data %>" div-name="Loan" />
                                <div id="divLoanStatusText_">0%</div>
                                <input id="btnViewLoan<%=data %>" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData_Loan.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Loan.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Loan.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
                <input id="Button5" type="button" value="Upload" data-id="<%=TableData_Loan.Rows.Count %>" div-name="Loan" />
                <br />
            </div>
            <div id="tabs-5">
                Mortgage Document
               <br />
                <table class="Mortgage" id="Mortgage">
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
        
                            for (var data = 1; data <= TableData_Mortgage.Rows.Count; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Mortgage.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Mortgage.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="file4" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="Span3" class="id"><%=data %></span>
                              
                                <input id="Button6" type="button" value="Upload" class="upload" data-id="<%=data %>" div-name="Liability" />
                                <div id="Div2">0%</div>
                                <input id="Button7" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData_Mortgage.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Mortgage.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Mortgage.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
                <input id="Button8" type="button" value="Upload" data-id="<%=TableData_Mortgage.Rows.Count %>" div-name="Basic" />
                <br />
            </div>
            <div id="tabs-6">
                Other Documents
                <br />
                <table class="Other" id="Other">
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
        
                            for (var data = 1; data <= TableData_Other.Rows.Count; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Other.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Other.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="file5" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="Span4" class="id">
                                    <%=data %></span>
                             
                                <input id="Button9" type="button" value="Upload" class="upload" data-id="<%=data %>"
                                    div-name="Other" />
                                <div id="Div3">
                                    0%</div>
                                <input id="Button10" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData_Other.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Other.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Other.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
                <input id="Button11" type="button" value="Upload" data-id="<%=TableData_Other.Rows.Count %>" div-name="Basic" />
                <br />
            </div>
            <div id="tabs-7">
                Syndication/Pledge Doc.
              <br />
                <table class="Syndication" id="Syndication">
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
        
                            for (var data = 1; data <= TableData_Syndication.Rows.Count; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Syndication.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Syndication.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="file6" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="Span5" class="id">
                                    <%=data %></span>
                             
                                <input id="Button12" type="button" value="Upload" class="upload" data-id="<%=data %>"
                                    div-name="Syndication" />
                                <div id="Div4">
                                    0%</div>
                                <input id="Button13" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData_Syndication.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Syndication.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Syndication.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
             <input id="Button14" type="button" value="Upload" data-id="<%=TableData_Syndication.Rows.Count %>" div-name="Syndication" />
                <br />
            </div>
            <div id="tabs-8">
                Undertaking
              <br />
                <table class="Undertaking" id="Undertaking">
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
        
                            for (var data = 1; data <= TableData_Undertaking.Rows.Count; data++)
                            {
            
                        %>
                        <tr>
                            <td>
                                <%=TableData_Undertaking.Rows[data]["SL"]%>
                            </td>
                            <td>
                                <%=TableData_Undertaking.Rows[data]["Name"]%>
                            </td>
                            <td>
                                <input type="file" class="file" id="file7" data-sl="<%=data %>" name="fileInput_<%=data %>" />
                                <span id="Span6" class="id">
                                    <%=data %></span>
                              
                                <input id="Button15" type="button" value="Upload" class="upload" data-id="<%=data %>"
                                    div-name="Syndication" />
                                <div id="Div5">
                                    0%</div>
                                <input id="Button16" type="button" value="View" class="View" style="display: none;"></input>
                            </td>
                            <td>
                                <%=TableData_Undertaking.Rows[data]["Required"]%>
                            </td>
                            <td>
                                <%=TableData_Undertaking.Rows[data]["Obtained"]%>
                            </td>
                            <td>
                                <%=TableData_Undertaking.Rows[data]["NotObtained_Reason"]%>
                            </td>
                        </tr>
                        <%
                            }
            
                        %>
                    </tbody>
                </table>
             <input id="Button17" type="button" value="Upload" data-id="<%=TableData_Undertaking.Rows.Count %>" div-name="Undertaking" />
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
