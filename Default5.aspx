<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default5.aspx.cs" Inherits="Default5"
    Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .tbl td
        {
            padding: 5px;
            border-bottom: 1px solid blue;
        }
    </style>
    <script src="jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#Button1').click(function () {

                var id = $(this).attr("data-id");

                alert(id);


            });


            $('#uploadFiles').click(function () {




                for (var i = 1; i <= 10; i++) {
                    var fileInput = $('#fileInput' + i)[0];

                    if (fileInput.files.length > 0) {
                        var formData = new FormData();
                        formData.append('file', fileInput.files[0]);

                        var progressBar = $('#progress' + i)[0];

                        // Create the AJAX request for file upload
                        var xhr = new XMLHttpRequest();

                        // Update progress bar during file upload
                        xhr.upload.addEventListener('progress', function (e) {
                            if (e.lengthComputable) {
                                var percent = (e.loaded / e.total) * 100;
                                progressBar.value = percent;
                            }
                        });

                        // Send the file via the web service
                        xhr.open('POST', '/FileUploadService.asmx/UploadFile', true);
                        xhr.setRequestHeader('Accept', 'application/json');
                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                alert('File uploaded successfully!');
                            } else {
                                alert('Error uploading file');
                            }
                        };

                        // Send the data
                        xhr.send(formData);
                    }
                }
            });

        });
        
        
        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
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
        
                    for (var data = 0; data < TableData.Rows.Count; data++)
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
                        <input type="file" id="fileInput_<%=data %>" name="fileInput_<%=data %>" />
                        <progress id="progress_<%=data %>" value="0" max="100"></progress>
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
        <input id="Button1" type="button" value="Upload" data-id="<%=TableData.Rows.Count %>" />
        <asp:Label ID="lblError" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    </div>
    </form>
</body>
</html>
