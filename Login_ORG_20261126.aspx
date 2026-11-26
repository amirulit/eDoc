<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login_ORG_20261126.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
        name="viewport" />
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css" />
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="plugins/colorpicker/bootstrap-colorpicker.min.css" />
    <!-- jvectormap -->
    <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css" />
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" />
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css">
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css" />
    <link rel="icon" href="uploads/logo3.png">
    <!-- jQuery 2.1.4 -->
    <script type="text/javascript" src="plugins/jQuery/jQuery-2.1.4.min.js">
    </script>
    <!-- Bootstrap 3.3.5 -->
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js">
    </script>
    <!-- DataTables -->
    <script type="text/javascript" src="plugins/datatables/jquery.dataTables.min.js">
    </script>
    <script type="text/javascript" src="plugins/datatables/dataTables.bootstrap.min.js">
    </script>
    <!-- iCheck 1.0.1 -->
    <script type="text/javascript" src="plugins/iCheck/icheck.min.js">
    </script>
    <!-- AdminLTE App -->
    <script type="text/javascript" src="dist/js/app.min.js">
    </script>
    <!-- AdminLTE for demo purposes -->
    <script type="text/javascript" src="dist/js/demo.js">
    </script>
    <!-- Chart JS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.bundle.js">
    </script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.js">
    </script>
    <!-- Select2 -->
    <script type="text/javascript" src="plugins/select2/select2.full.min.js">
    </script>
    <!-- InputMask -->
    <script type="text/javascript" src="plugins/input-mask/jquery.inputmask.js">
    </script>
    <script type="text/javascript" src="plugins/input-mask/jquery.inputmask.date.extensions.js">
    </script>
    <script type="text/javascript" src="plugins/input-mask/jquery.inputmask.extensions.js">
    </script>
    <!-- date-range-picker -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js">
    </script>
    <script type="text/javascript" src="plugins/daterangepicker/daterangepicker.js"></script>
    <script type="text/javascript">


        function login() {
            //document.ready(function{	

            $('#loginFrom').modal({
                backdrop: 'static',
                keyboard: false
            });


            $('#loginFrom').modal('show');
        };



    </script>
    <style type="text/css">
        #loginFrom .modal-dialog
        {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            margin: 0;
            width: 100%;
            max-width: 500px;
        }
    </style>
    <style type="text/css">
        html, body
        {
            height: 100%;
            margin: 0;
        }
        
        
        .login-wrapper
        {
            width: 33%;
            height: auto;
            margin: 100px auto 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        
        
        .login-panel
        {
            width: 100%;
        }
        
        
        .welcome-banner
        {
            width: 100%;
            height: 200px;
            background-color: #0d6efd;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            padding: 10px 20px;
            box-sizing: border-box;
            margin-bottom: 0;
        }
    </style>
</head>
<body onload="login()">
    <form id="form1" runat="server">
    <div class="welcome-banner">
        <h1>
            Welcome to MBPLC Document Management System (DMS)</h1>
    </div>
    <div class="login-wrapper">
        <div class="panel panel-primary login-panel">
            <div class="panel-heading">
                <h3 class="panel-title">
                    Login</h3>
            </div>
            <div class="panel-body">
                <div class="form-group" id="divEmail">
                    <label>
                        Domain ID</label>
                    <asp:TextBox ID="txtDomainID" runat="server" CssClass="form-control">
                    </asp:TextBox>
                </div>
                <div class="form-group" id="divPassword">
                    <label>
                        Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password">
                    </asp:TextBox>
                </div>
            </div>
            <div class="panel-footer">
                <input type="hidden" name="do" value="user_login" />
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-info" OnClick="btnSubmit_Click"
                    Visible="false" />
                Credit Division:
                <asp:Button ID="btnCD_RM_CBD" runat="server" Text="CD RM (CBD)" 
                    CssClass="btn btn-primary" onclick="btnCD_CBD_Click"  />

                <asp:Button ID="btnCD_UH_CBD"   CssClass="btn btn-primary"  runat="server" Text="CD UH (CBD)" OnClick="btnCD_UH_CBD_Click" />

                    <asp:Button ID="btnCD_RM_SME" runat="server" Text="CD RM (SME)" 
                    CssClass="btn btn-info" onclick="btnCD_SME_Click"   />

                 <asp:Button ID="btnCD_UH_SME"   CssClass="btn btn-info"  runat="server" Text="CD UH (SME)" OnClick="btnCD_UH_SME_Click" />

                    <asp:Button ID="btnCD_RM_Retail" runat="server" Text="CD RM (Retail)" 
                    CssClass="btn btn-success" onclick="btnCD_Retail_Click"   />


                 <asp:Button ID="btnCD_UH_Retail"   CssClass="btn btn-success" runat="server" Text="CD UH (Retail)" OnClick="btnCD_UH_Retail_Click" />

                    <asp:Button ID="btnCD_RM_Agri" runat="server" Text="CD RM (Agri)" 
                    CssClass="btn   btn-warning  " onclick="btnCD_Agri_Click"   />


                  <asp:Button ID="btnCD_UH_Agri"   CssClass="btn   btn-warning  " runat="server" Text="CD UH (Agri)" OnClick="btnCD_UH_Agri_Click" />


                <hr />
                <!--

                  SAMD:
                <asp:Button ID="btnCD_CBD_SAMD" runat="server" Text="RM-SAMD (CBD)" 
                    CssClass="btn btn-info" onclick="btnCD_CBD_SAMD_Click"   />

                    <asp:Button ID="btnCD_SME_SAMD" runat="server" Text="RM-SAMD (SME)" 
                    CssClass="btn btn-info" onclick="btnCD_SME_SAMD_Click"   />

                    <asp:Button ID="btnCD_Retail_SAMD" runat="server" Text="RM-SAMD (Retail)" 
                    CssClass="btn btn-info" onclick="btnCD_Retail_SAMD_Click"  />

                    <asp:Button ID="btnCD_Agri_SAMD" runat="server" Text="RM-SAMD (Agri)" 
                    CssClass="btn btn-info" onclick="btnCD_Agri_SAMD_Click"    />
                <hr />
                -->


                Branch:
                <asp:Button ID="btnRM" runat="server" Text="RM(Main)" OnClick="btnRM_Click" CssClass="btn btn-default " />
                <asp:Button ID="btnCI" runat="server" Text="CI(Main)" CssClass="btn btn-default" OnClick="btnCI_Click" />
                <asp:Button ID="btnHOB" runat="server" Text="HOB(Main)" CssClass="btn btn-default" OnClick="btnHOB_Click" />
                <hr />

                  Branch:
                <asp:Button ID="Button1" runat="server" Text="RM(Dhanmomdi)" CssClass="btn btn-default " OnClick="Button1_Click" />
                <asp:Button ID="Button2" runat="server" Text="CI(Dhanmomdi)" CssClass="btn btn-default " OnClick="Button2_Click" />
                <asp:Button ID="Button3" runat="server" Text="HOB(Dhanmomdi)" CssClass="btn btn-default " OnClick="Button3_Click" />


                <hr />


                CAD:

                <asp:Button ID="btnCAD_DM_CBD" runat="server" Text="CAD DM CBD" 
                    onclick="btnCAD_DM_CBD_Click" CssClass="btn btn-primary"  />
                <asp:Button ID="btnCAD_UH_CBD" runat="server" Text="CAD Unit Head CBD" 
                    onclick="btnCAD_UH_CBD_Click"  CssClass="btn btn-primary" />

                <hr />

                <asp:Button ID="btnCAD_DM_SME" runat="server" Text="CAD DM SME & Agri" 
                    onclick="btnCAD_DM_SME_Click"  CssClass="btn btn-success" />
                <asp:Button ID="btnCAD_UH_SME" runat="server" Text="CAD Unit Head SME & Agri" 
                    onclick="btnCAD_UH_SME_Click"  CssClass="btn btn-success"/>

                <hr />
                <asp:Button ID="btnCAD_DM_Retail" runat="server" Text="CAD DM Retail" 
                    onclick="btnCAD_DM_Retail_Click"  CssClass="btn btn-warning" />
                <asp:Button ID="btnCAD_UH_Retail" runat="server" Text="CAD Unit Head Retail" 
                    onclick="btnCAD_UH_Retail_Click"  CssClass="btn btn-warning"/>
                <hr />
              <%--  <asp:Button ID="btnCAD_DM_Agri" runat="server" Text="CAD DM Agri" 
                    onclick="btnCAD_DM_Agri_Click"  CssClass="btn btn-primary" />
                <asp:Button ID="btnCAD_UH_Agri" runat="server" Text="CAD Unit Head Agri" 
                    onclick="btnCAD_UH_Agri_Click"  CssClass="btn btn-success"/>--%>
                <hr />

                <asp:Button ID="Button4" runat="server" Text="Limit Manager" OnClick="Button4_Click"  CssClass="btn btn-primary"/>
                <asp:Button ID="Button5" runat="server" Text="Limit UnitHead" OnClick="Button5_Click"  CssClass="btn btn-primary"/>

                <hr />
                Admin:
                <asp:Button ID="btnDHead" runat="server" Text="DHOD-CAD" CssClass="btn btn-danger" OnClick="btnDHead_Click"
                    />
                <asp:Button ID="btnHead" runat="server" Text="HOD-CAD" CssClass="btn btn-danger" OnClick="btnHead_Click"  />
                <hr />
                <a href="New_V2.aspx" class="btn  btn-primary">New?</a> <a href="Login_V3.aspx" class="btn btn-success">
                    Login</a>
            </div>
        </div>
    </div>
    </form>
</body>
