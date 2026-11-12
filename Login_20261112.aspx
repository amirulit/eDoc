<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login_20261112.aspx.cs" Inherits="Login_20261112" %>

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
        html, body
        {
            min-height: 100%;
            margin: 0;
            font-family: 'Segoe UI' , Arial, sans-serif;
            background: linear-gradient(135deg, #eaf2fb, #dce8f5);
        }
        /* Welcome banner */.welcome-banner
        {
            width: 100%;
            min-height: 190px;
            background: linear-gradient(120deg, #092c55, #1265a8, #1686c9);
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 25px;
            box-sizing: border-box;
            position: relative;
            overflow: hidden;
        }
        .welcome-banner h1
        {
            font-size: 32px;
            font-weight: 700;
            letter-spacing: .5px;
            margin: 0;
            line-height: 1.5;
        }
        .welcome-banner p
        {
            font-size: 15px;
            margin-top: 10px;
            color: #dceeff;
        }
        /* Main login wrapper */.login-wrapper
        {
            width: 100%;
            max-width: 650px;
            margin: -45px auto 40px;
            padding: 0 15px;
            position: relative;
            z-index: 2;
            box-sizing: border-box;
        }
        /* Login panel */.login-panel
        {
            width: 100%;
            border: none;
            border-radius: 12px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 12px 35px rgba(0, 35, 75, .16);
        }
        /* Panel heading */.login-panel .panel-heading
        {
            background: #fff;
            color: #123c67;
            padding: 25px 25px 10px;
            border: none;
            text-align: center;
        }
        .login-panel .panel-title
        {
            font-size: 25px;
            font-weight: 700;
        }
        /* Panel body */.login-panel .panel-body
        {
            padding: 20px 35px 25px;
        }
        .login-panel label
        {
            color: #34495e;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .login-panel .form-control
        {
            height: 45px;
            border-radius: 6px;
            border: 1px solid #d4deea;
            box-shadow: none;
            font-size: 15px;
        }
        .login-panel .form-control:focus
        {
            border-color: #1686c9;
            box-shadow: 0 0 6px rgba(22, 134, 201, .2);
        }
        /* Footer */.login-panel .panel-footer
        {
            background: #f7faff;
            padding: 22px 25px;
            border-top: 1px solid #e6edf5;
            text-align: center;
        }
        /* Role buttons */.role-btn
        {
            min-width: 85px;
            margin: 5px 3px;
            padding: 10px 15px;
            border-radius: 6px;
            font-weight: 600;
            border: none;
            transition: all .2s ease;
        }
        .role-btn:hover
        {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,.15);
        }
        /* Individual colors */.btn-rm
        {
            background: #2878b9;
            color: white;
        }
        .btn-cd
        {
            background: #16a085;
            color: white;
        }
        .btn-ci
        {
            background: #8e44ad;
            color: white;
        }
        .btn-hob
        {
            background: #e67e22;
            color: white;
        }
        .btn-admin
        {
            background: #34495e;
            color: white;
        }
        .btn-dm
        {
            background: #2980b9;
            color: white;
        }
        .btn-unit
        {
            background: #27ae60;
            color: white;
        }
        /* Footer links */.footer-link
        {
            display: inline-block;
            margin: 5px;
            padding: 11px 28px;
            border-radius: 6px;
            font-weight: 600;
            text-decoration: none !important;
        }
        /* Responsive */@media (max-width: 600px)
        {
            .welcome-banner
            {
                min-height: 150px;
            }
            .welcome-banner h1
            {
                font-size: 23px;
            }
            .login-wrapper
            {
                margin-top: -25px;
            }
            .login-panel .panel-body
            {
                padding: 20px;
            }
            .role-btn
            {
                min-width: 75px;
                padding: 9px 10px;
            }
        }
    </style>
</head>
<body onload="login()">
    <form id="form1" runat="server">
    <!-- Welcome Banner -->
    <div class="welcome-banner">
        <div>
            <h1>
                <i class="fa fa-folder-open"></i>MBPLC Document Management System
            </h1>
            <p>
                Secure Document Management &amp; Workflow Solution
            </p>
        </div>
    </div>
    <!-- Login Section -->
    <div class="login-wrapper">
        <div class="panel panel-default login-panel">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <i class="fa fa-sign-in"></i>Welcome Back
                </h3>
                <p style="color: #8998a9; margin-top: 8px;">
                    Please enter your credentials to continue
                </p>
            </div>
            <div class="panel-body">
                <!-- Domain ID -->
                <div class="form-group" id="divEmail">
                    <label>
                        <i class="fa fa-user"></i>Domain ID
                    </label>
                    <asp:TextBox ID="txtDomainID" runat="server" CssClass="form-control" placeholder="Enter your Domain ID">
                        </asp:TextBox>
                </div>
                <!-- Password -->
                <div class="form-group" id="divPassword">
                    <label>
                        <i class="fa fa-lock"></i>Password
                    </label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"
                        placeholder="Enter your password">
                        </asp:TextBox>
                </div>
            </div>
            <!-- Role Selection -->
            <div class="panel-footer">
                <h4 style="color: #34495e; font-weight: 600; margin-bottom: 15px;">
                    <i class="fa fa-users"></i>Login As
                </h4>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-info" OnClick="btnSubmit_Click"
                    Visible="false" />
                <asp:Button ID="btnRM" runat="server" Text="RM" OnClick="btnRM_Click" CssClass="role-btn btn-rm" />
                <asp:Button ID="btnCD" runat="server" Text="CD" OnClick="btnCD_Click" CssClass="role-btn btn-cd" />
                <asp:Button ID="btnCI" runat="server" Text="CI" OnClick="btnCI_Click" CssClass="role-btn btn-ci" />
                <asp:Button ID="btnMOP" runat="server" Text="MOP" OnClick="btnMOP_Click" CssClass="role-btn btn-hob"
                    Visible="false" />
                <asp:Button ID="btnHOB" runat="server" Text="HOB" OnClick="btnHOB_Click" CssClass="role-btn btn-hob" />
                <asp:Button ID="btnAdmin" runat="server" Text="Admin" OnClick="btnAdmin_Click" CssClass="role-btn btn-admin" />
                <asp:Button ID="btnDM" runat="server" Text="DM" OnClick="btnDM_Click" CssClass="role-btn btn-dm" />
                <asp:Button ID="btnUnitHead" runat="server" Text="Unit Head" OnClick="btnUnitHead_Click"
                    CssClass="role-btn btn-unit" />
                <hr />
                <div style="margin-top: 15px;">
                    <a href="New_Reg.aspx" class="btn btn-primary footer-link"><i class="fa fa-user-plus">
                    </i>New User? </a><a href="Login_V3.aspx" class="btn btn-success footer-link"><i
                        class="fa fa-sign-in"></i>Login </a>
                </div>
            </div>
        </div>
        <div style="text-align: center; color: #718096; font-size: 12px; margin-top: 20px;">
            MBPLC Document Management System
            <br />
            Secure &amp; Reliable Document Management
        </div>
    </div>
    </form>
</body>
