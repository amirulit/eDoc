<%@ Page Language="C#" AutoEventWireup="true" CodeFile="New_V2.aspx.cs" Inherits="New" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
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
    <%--<link rel="icon" href="uploads/logo3.png">--%>
    <link href="plugins/select2/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="js/jquery-ui.css" rel="stylesheet" type="text/css" />
    <!-- jQuery 2.1.4 -->
    <%--<script type="text/javascript" src="plugins/jQuery/jQuery-2.1.4.min.js">
    </script>--%>
    <script type="text/javascript" src="jquery3/jquery.js"></script>
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
    <script type="text/javascript">
        $(function () {

            $('#image').change(function () {

                var fileSize = this.files[0].size;
                var maxSize = 1000000; // bytes
                var filename = $(this).val();


                //alert(fileSize);

                //alert(maxSize);

                //alert(filename);


                var ext = filename.split('.').pop();


                if ($.inArray(ext, ['png', 'jpg', 'jpeg']) == -1) {
                    //The file type is not allowed

                    $('#profile_pic').attr("src", "../uploads/image_error.png");
                    $('#pImage').remove();
                    $('#divImage').append('<p id="pImage" style="color:red;"><small>The file type is not allowed.</small></p>');
                    $("#btnSubmit").attr("disabled", true);

                } else {

                    if (fileSize > maxSize) {
                        //The file size is too large
                        $('#profile_pic').attr("src", "../uploads/image_error.png");
                        $('#pImage').remove();
                        $('#divImage').append('<p id="pImage" style="color:red;"><small>The file size is too large.</small></p>');
                        $("#btnSubmit").attr("disabled", true);

                    } else {
                        //Display the selected image
                        $('#pImage').remove();
                        $("#btnSubmit").attr("disabled", false);
                        document.getElementById('profile_pic').src = URL.createObjectURL(this.files[0]);

                    }
                }

            });





            $("#btnGetEmpInfo").click(function () {

                //alert('fffff');

                var EmpId = $("#empid").val();

                $.ajax({


                    type: "POST",
                    url: "New_V2.aspx/GetEmpInfo",
                    //url: "http://10.10.100.68/HRM_API/HRM/GetEmpInfo/" + empid,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ EmpId: EmpId }),
                    success: function (response) {

                        //alert(response.d);

                        //account_no = SODNo;

                        //alert(response.d.EmployeeName);



                        $("#name").val(response.d.EmployeeName);
                        $("#designation").val(response.d.EmpDesignation);
                        $("#role").val(response.d.EmpFunctionalDesignation);
                        //$("#ddlRole").empty();

                        var role = response.d.EmpFunctionalDesignation;
                        if (role == 'HEAD OF BRANCH')
                        //$("#ddlRole").val(20);
                            $("#ddlrole").empty().append('<option value="20">HOB</option>');

                        else if (role == 'UPOSHAKHA INCHARGE')
                        //$("#ddlRole").val(15);
                            $("#ddlrole").empty().append('<option value="15">MOP</option>');
                        else {

                            var items = [
                                    { id: '', text: "<--Select->" },
                                    { id: 15, text: "MOP" },
                                    { id: 10, text: "Credit Incharge" },
                                    { id: 5, text: "Cerdit Officer" }
                                ];

                            var sel = $("#ddlrole");
                            sel.empty();

                            $.each(items, function () {
                                sel.append($("<option>").val(this.id).text(this.text));
                            });
                        }

                        $("#branchcode").val(response.d.POPCode);
                        $("#branchname").val(response.d.POP);
                        $("#phone").val(response.d.PhoneNumber);
                        $("#domain").val(response.d.DOMAINID);






                    }
                });
            });

        });
    </script>
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
<body class="hold-transition register-page">
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
                                        ! Register !</h3>
                                </div>
                                <div class="box-body">
                                    <!-- Employee ID - Full Width -->
                                    <div class="form-group">
                                        <label>
                                            Employee ID</label>
                                        <div class="input-group input-group-sm">
                                            <input type="text" class="form-control" name="empid" id="empid" />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-info btn-flat" id="btnGetEmpInfo">
                                                    Go!
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                    <!-- Row 1 -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Full Name</label>
                                                <input type="text" class="form-control" id="name" placeholder="Full Name" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Designation</label>
                                                <input type="text" class="form-control" id="designation" placeholder="Designation" />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Row 2 -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Role</label>
                                                <select id="ddlrole" class="form-control">
                                                    <option value=""><--Select--></option>
                                                    <option value="13">HOB</option>
                                                    <option value="12">MOP</option>
                                                    <option value="11">Credit Incharge</option>
                                                    <option value="10">Credit Officer</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Branch Code</label>
                                                <input type="text" class="form-control" id="branchcode" placeholder="Branch Code" />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Row 3 -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Branch Name</label>
                                                <input type="text" class="form-control" id="branchname" placeholder="Branch Name" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Phone</label>
                                                <input type="text" class="form-control" id="phone" placeholder="Phone" />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Row 4 -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Domain ID</label>
                                                <input type="text" class="form-control" id="domain" placeholder="Domain ID" />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Signature - Full Width -->
                                    <div class="form-group">
                                        <label for="image">
                                            Signature</label>
                                        <div id="divImage">
                                            <img id="profile_pic" style="width: 130px; height: 150px; margin-bottom: 5px;" />
                                            <input type="file" name="image" id="image" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer text-center">
                                    <button type="submit" class="btn btn-primary">
                                        Submit
                                    </button>
                                    <button type="submit" class="btn btn-success">
                                        Login
                                    </button>
                                    <a href="Login_V3.aspx" class="btn btn-success">Login</a>
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
