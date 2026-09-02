<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login_V3.aspx.cs" Inherits="Login_V2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
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
    <link href="plugins/select2/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="js/jquery-ui.css" rel="stylesheet" type="text/css" />
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
    <script src="plugins/jQueryUI/jquery-ui.js" type="text/javascript"></script>
    <!-- date-range-picker -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js">
    </script>
    <script type="text/javascript" src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- page script -->
    <script type="text/javascript">
        $(function () {

            $(".docTable").DataTable();
            $("#example1").DataTable();
            $('#example2').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": false,
                "ordering": true,
                "info": true,
                "autoWidth": false
            });
        });
    </script>
    <!-- Here is the End of page script-->
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->


   <style type="text/css">
        .center-container
        {
            min-height: calc(100vh - 50px);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .center-container > .col-md-6
        {
            float: none;
        }
        
        
        .form-control
        {
            border-radius: 6px !important;
        }
        .input-group .form-control
        {
            border-radius: 6px 0 0 6px !important;
        }
        .input-group .btn
        {
            border-radius: 0 6px 6px 0 !important;
        }
    </style>


</head>
<body class="hold-transition login-page">
    <form id="form1" runat="server">
    <div>
        <div class="content">
            <div class="row center-container">
                <div class="col-md-6">
                    <div class="content">
                        <div class="row center-container">
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title" style="text-align: center;">
                                        ! Login !</h3>
                                </div>
                                <div class="box-body">
                                    <!-- Row 1 -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>
                                                    Domain ID</label>
                                                <input type="text" class="form-control" id="name" placeholder="Domain ID" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>
                                                    Password</label>
                                                <input type="text" class="form-control" id="designation" placeholder="Password" />
                                            </div>
                                        </div>
                                    </div>
                            </div>
                            <div class="box-footer text-center">
                               
                                <button type="submit" class="btn btn-success">
                                    Login
                                </button>
                                 <button type="button" class="btn btn-primary">
                                    New?
                                </button>
                                <a href="New_V2.aspx" class="btn  btn-primary">New?</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </form>
</body>
</html>
