<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentUpload_V8.aspx.cs"
    Inherits="DocumentUpload_V8" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Document Upload</title>

    <%--<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>--%>


    <script src="jquery-3.7.1.js" type="text/javascript"></script>
    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="jquery-ui.js" type="text/javascript"></script>

    <link rel="stylesheet" href="/resources/demos/style.css" />
    <link href="CSS/Style.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        $(function () {


            $("#accordion").accordion({ collapsible: true, active: false, animate: false });


        });
    </script>

    
    <script type="text/javascript">

        $(function () {

            //$("body").on("click", ".V", function () {


            //$(".V").click(function () {
            $(".View").click(function () {

                //file-name

                var id = $(this).attr("data-id");
                var fn = $(this).attr("file-name");

                //alert(id);
                //alert(fn);

                var extension = fn.split('.').pop();

                //alert(extension);

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
            //$("input[name='opt_req']").change(function () {


            $("input[class='rdo']").change(function () {
            


                var data_id = $(this).attr("data-id");
                alert(data_id);
                alert("You selected: " + $(this).val());
            });











        });
    </script>

     <script type="text/javascript">

         $(function () {

             var queryString = window.location.search;

             //alert(queryString);
             //Remove the leading '?' and split by '&'
             var params = queryString.substring(1).split('&');

             var cus_type = params[0].split('=')[1];
             //alert(cus_type);
             var cust_id = params[1].split('=')[1];
             //alert(cust_id);


             //File Upload

             //$("body").on("click", ".upload", function () {

             $(".upload").click(function () {

                 var file_auto_id = $(this).attr("data-id");

                 var div_name = $(this).attr("div-name");

                 alert(file_auto_id + '-' + div_name);

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
                 //formData.append("customer_auto_id", customer_auto_id);
                 //formData.append("customer_auto_id", 72);
                 formData.append("file_auto_id", file_auto_id);
                 //formData.append("file", ctrl.files[0]);
                 formData.append("cust_id", cust_id);
                 formData.append("file", fn);


                 $.ajax({

                     url: 'WebService3.asmx/UploadFiles_4',
                     type: 'POST',
                     data: formData,
                     cache: false,
                     contentType: false,
                     processData: false,
                     success: function (fileName) {

                         $("#div" + div_name + "StatusText_" + file_auto_id).html('Uploaded');

                         //$("#fileProgress").hide();
                         //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");


                         alert(fileName);

                         alert(div_name);

                         $("#btnView" + div_name + "_" + file_auto_id).css("display", "block");
                         //$("#btnView" + div_name + "_" + file_auto_id).attr("cus-auto-id", customer_auto_id);
                         $("#btnView" + div_name + "_" + file_auto_id).attr("file-auto-id", file_auto_id);
                         //$("#btnView" + div_name + "_" + file_auto_id).attr("file-name", fn.name);
                         $("#btnView" + div_name + "_" + file_auto_id).attr("file-name", fileName);
                         //$("#btnView" + div_name + "_" + file_auto_id).attr("file-ext", extension);

                         $("#btnDelete" + div_name + "_" + file_auto_id).css("display", "block");



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
        .ui-accordion-content
        {
            height: auto !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 10px; padding: 10px;">
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



                   //Int32 doc_id;

                   if (TableData.Rows.Count > 0)
                   {
                        
            %>
            <h3>
                <%=DocPosition%>
                )
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
                                    Browse
                                </th>
                            </tr>
                        </thead>
                        <tbody>

                   


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
                                    <input type="button" value="Upload & Save" class="upload" data-id="<%=doc_id%>" div-name="<%=DocType[i]%>" />

                                    <div id="div<%=DocType[i]%>StatusText_<%=doc_id %>">
                                        0%</div>
                                    <%
                                    //}
                                    %>
                                    <input id="btnView<%=DocType[i]%>_<%=doc_id %>" type="button" value="View" class="View" style="display: none;" />
                                    <input id="btnDelete<%=DocType[i]%>_<%=doc_id %>" type="button" value="Delete" class="Delete" style="display: none;" />
                                    <% 
                           

                           if (TableData.Rows[data]["file_name"].ToString() != "")
                           {
                                  
                                 %>
                                    <input id="Button2" type="button" value="View" file-name="<%=TableData.Rows[data]["file_name"]%>" data-id="<%=TableData.Rows[data]["id"]%>" class="View" />
                                    <input id="Button3" type="button" value="Delete" data-id="<%=TableData.Rows[data]["id"]%>"  class="Delete" />
                                    <%=TableData.Rows[data]["file_name"].ToString()%>
                                    <%
                           }
                          
                                    %>
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

        <input  type="button" value="Close" onclick="window.close();"/>

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
