<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentUpload_V6.aspx.cs"
    Inherits="DocumentUpload_V6" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Document Upload</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <link href="CSS/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#accordion").accordion({ collapsible: true, active: false, animate: false });
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
            %>
            <h3>
                <%=section_name%></h3>
            <div id="<%=section_name%>">
                <p>
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
            <!--dssdfsdfsfsdsfsdfsafsadf-->
        </div>
    </div>
    </form>
</body>
</html>
