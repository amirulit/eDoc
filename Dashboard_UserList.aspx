<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard_UserList.aspx.cs" Inherits="Dashboard_UserList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Uploaded Sanction Information</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet" />

    <style>
        body {
            background-color: #f4f6f9;
        }

        .card {
            border-radius: 10px;
        }

        .card-header {
            background-color: #0d6efd !important;
            padding: 15px;
        }

        .table {
            margin-bottom: 0;
            font-size: 13px;
            white-space: nowrap;
        }

        .table th {
            background-color: #212529;
            color: white;
            text-align: center;
            vertical-align: middle;
            padding: 12px;
        }

        .table td {
            vertical-align: middle;
            padding: 10px;
        }

        .table-hover tbody tr:hover {
            background-color: #eaf2ff;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
     <div>
            <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>

            <div class="container-fluid mt-3">

                <div class="card shadow-sm border-0">

                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="bi bi-file-earmark-text"></i>
                            Uploaded Sanction Information
                        </h5>
                    </div>

                    <div class="card-body">

                        <div class="table-responsive">

                            <asp:GridView ID="GridView1"
                                runat="server"
                                AutoGenerateColumns="true"
                                CssClass="table table-bordered table-hover table-striped align-middle"
                                HeaderStyle-CssClass="table-dark"
                                RowStyle-CssClass="text-center"
                                GridLines="None"
                                EmptyDataText="No Data Found">
                            </asp:GridView>

                        </div>

                    </div>

                </div>

            </div>
        </div>
    </form>
</body>
</html>
