<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login_20261108.aspx.cs" Inherits="Login" %>

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

 <style type="text/css">
    
    
/* =================================
   MBPLC DMS MODERN LOGIN
================================= */

body.login-page {
    background: linear-gradient(135deg, #172b4d 0%, #294c73 55%, #3c6387 100%);
    min-height: 100vh;
}

/* Login container */
.mbplc-login {
    width: 390px;
    margin: 4% auto 0;
}

/* Logo */
.mbplc-login .login-logo {
    margin-bottom: 22px;
    text-align: center;
}

.mbplc-login .login-logo a {
    color: #ffffff;
    font-size: 32px;
    font-weight: 300;
    text-decoration: none;
    letter-spacing: 1px;
}

.mbplc-login .login-logo a b {
    color: #55c0f0;
    font-weight: 700;
}

.login-subtitle {
    color: rgba(255,255,255,.75);
    font-size: 12px;
    margin-top: 7px;
    letter-spacing: 2px;
    text-transform: uppercase;
}

/* Login card */
.mbplc-login .login-box-body {
    background: #ffffff;
    padding: 28px 30px 25px;
    border-radius: 12px;
    box-shadow: 0 12px 40px rgba(0,0,0,.25);
}

/* Heading */
.login-heading {
    text-align: center;
    margin-bottom: 25px;
}

.login-heading h3 {
    font-size: 22px;
    font-weight: 600;
    color: #263b53;
    margin: 0 0 8px;
}

.login-heading p {
    font-size: 13px;
    color: #929eaa;
    margin: 0;
}

/* Input fields */
.mbplc-login .form-group {
    margin-bottom: 18px;
}

.mbplc-login .form-control {
    height: 44px;
    border-radius: 6px;
    border: 1px solid #dce3eb;
    padding-left: 14px;
    font-size: 14px;
    box-shadow: none;
}

.mbplc-login .form-control:focus {
    border-color: #3c8dbc;
    box-shadow: 0 0 0 2px rgba(60,141,188,.10);
}

.mbplc-login .form-control-feedback {
    line-height: 44px;
    color: #98a8b8;
    right: 5px;
}

/* Submit */
.login-submit {
    height: 44px;
    border-radius: 6px !important;
    font-weight: 600;
    letter-spacing: 1px;
    background: #287db5;
    border-color: #287db5;
}

/* Role section */
.role-section {
    margin-top: 30px;
}

.role-heading {
    display: table;
    width: 100%;
    margin-bottom: 17px;
    text-align: center;
}

.role-heading span {
    display: table-cell;
    width: 25%;
    vertical-align: middle;
    border-top: 1px solid #e7ecf1;
}

.role-heading label {
    display: table-cell;
    padding: 0 12px;
    color: #8191a2;
    font-size: 11px;
    letter-spacing: 1.2px;
    white-space: nowrap;
}

/* Role grid */
.role-grid {
    margin-left: -5px;
    margin-right: -5px;
}

.role-grid > div {
    padding-left: 5px;
    padding-right: 5px;
    margin-bottom: 10px;
}

/* Role buttons */
.role-btn {
    height: 39px;
    border-radius: 6px;
    border: 1px solid #dce5ee;
    background: #f8fafc;
    color: #40566d;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: .5px;
    transition: all .2s ease;
}

.role-btn:hover,
.role-btn:focus {
    background: #287db5;
    color: #ffffff;
    border-color: #287db5;
}

.role-admin {
    background: #fff7f7;
    color: #c0392b;
    border-color: #f1d5d2;
}

.role-admin:hover,
.role-admin:focus {
    background: #c0392b;
    color: #ffffff;
    border-color: #c0392b;
}

/* Divider */
.login-divider {
    border-top: 1px solid #edf0f3;
    margin: 15px 0;
}

/* Footer */
.footer-btn {
    height: 36px;
    border-radius: 5px;
    font-size: 12px;
    padding-top: 8px;
    font-weight: 600;
}

.login-copyright {
    text-align: center;
    color: rgba(255,255,255,.65);
    font-size: 11px;
    margin-top: 18px;
}

/* Responsive */
@media (max-width: 480px) {

    .mbplc-login {
        width: 92%;
        margin: 30px auto 0;
    }

    .mbplc-login .login-box-body {
        padding: 24px 20px;
    }

    .mbplc-login .login-logo a {
        font-size: 28px;
    }
}

    </style>
</head>
<body onload="login()">
    <form id="form1" runat="server">
    
<div class="login-box mbplc-login">

    <!-- Login Header -->
    <div class="login-logo">
        <a href="#">
            <b>MBPLC</b> DMS
        </a>
        <p class="login-subtitle">Document Management System</p>
    </div>

    <!-- Login Card -->
    <div class="login-box-body">

        <div class="login-heading">
            <h3>Welcome Back!</h3>
            <p>Sign in to access your account</p>
        </div>

        <!-- Domain ID -->
        <div class="form-group has-feedback" id="divEmail">

            <asp:TextBox ID="txtDomainID" runat="server"
                CssClass="form-control"
                placeholder="Domain ID">
            </asp:TextBox>

            <span class="glyphicon glyphicon-user form-control-feedback"></span>

        </div>

        <!-- Password -->
        <div class="form-group has-feedback" id="divPassword">

            <asp:TextBox ID="txtPassword" runat="server"
                CssClass="form-control"
                TextMode="Password"
                placeholder="Password">
            </asp:TextBox>

            <span class="glyphicon glyphicon-lock form-control-feedback"></span>

        </div>

        <input type="hidden" name="do" value="user_login" />

        <asp:Button ID="btnSubmit" runat="server"
            Text="SIGN IN"
            CssClass="btn btn-primary btn-block btn-flat login-submit"
            OnClick="btnSubmit_Click"
            Visible="false" />

        <!-- Role Switch Section -->
        <div class="role-section">

            <div class="role-heading">
                <span></span>
                <label>QUICK SWITCH ROLE</label>
                <span></span>
            </div>

            <div class="row role-grid">

                <div class="col-xs-6">
                    <asp:Button ID="btnRM" runat="server"
                        Text="RM"
                        OnClick="btnRM_Click"
                        CssClass="btn btn-default btn-block role-btn" />
                </div>

                <div class="col-xs-6">
                    <asp:Button ID="btnCD" runat="server"
                        Text="CD"
                        OnClick="btnCD_Click"
                        CssClass="btn btn-default btn-block role-btn" />
                </div>

                <div class="col-xs-6">
                    <asp:Button ID="btnCI" runat="server"
                        Text="CI"
                        OnClick="btnCI_Click"
                        CssClass="btn btn-default btn-block role-btn" />
                </div>

                <div class="col-xs-6">
                    <asp:Button ID="btnMOP" runat="server"
                        Text="MOP"
                        OnClick="btnMOP_Click"
                        CssClass="btn btn-default btn-block role-btn"
                        Visible="false" />
                </div>

                <div class="col-xs-6">
                    <asp:Button ID="btnHOB" runat="server"
                        Text="HOB"
                        OnClick="btnHOB_Click"
                        CssClass="btn btn-default btn-block role-btn" />
                </div>

                <div class="col-xs-6">
                    <asp:Button ID="btnAdmin" runat="server"
                        Text="ADMIN"
                        OnClick="btnAdmin_Click"
                        CssClass="btn btn-default btn-block role-btn role-admin" />
                </div>

                <div class="col-xs-6">
                    <asp:Button ID="btnDM" runat="server"
                        Text="DM"
                        OnClick="btnDM_Click"
                        CssClass="btn btn-default btn-block role-btn" />
                </div>

                <div class="col-xs-6">
                    <asp:Button ID="btnUnitHead" runat="server"
                        Text="UNIT HEAD"
                        OnClick="btnUnitHead_Click"
                        CssClass="btn btn-default btn-block role-btn" />
                </div>

            </div>

        </div>

        <div class="login-divider"></div>

        <!-- Bottom Navigation -->
        <div class="row login-footer">

            <div class="col-xs-6">
                <a href="New_V2.aspx"
                   class="btn btn-default btn-block footer-btn">
                    <i class="glyphicon glyphicon-plus"></i>
                    New?
                </a>
            </div>

            <div class="col-xs-6">
                <a href="Login_V3.aspx"
                   class="btn btn-success btn-block footer-btn">
                    Login V3
                    <i class="glyphicon glyphicon-arrow-right"></i>
                </a>
            </div>

        </div>

    </div>

    <div class="login-copyright">
        &copy; MBPLC DMS. All Rights Reserved.
    </div>

</div>

    </form>
</body>
