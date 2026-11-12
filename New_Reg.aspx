<%@ Page Language="C#" AutoEventWireup="true" CodeFile="New_Reg.aspx.cs" Inherits="New_Reg" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MBPLC DMS - Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap 3 -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css" />


    <!-- Custom CSS -->
    <style type="text/css">
        html, body
        {
            min-height: 100%;
            margin: 0;
            font-family: 'Segoe UI' , Arial, sans-serif;
            background: linear-gradient(135deg, #eaf2fb, #dce8f5);
        }
        /* Header */.welcome-banner
        {
            width: 100%;
            min-height: 155px;
            background: linear-gradient(120deg, #092c55, #1265a8, #1686c9);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
        }
        .welcome-banner h1
        {
            font-size: 30px;
            font-weight: 700;
            margin: 0;
        }
        .welcome-banner p
        {
            font-size: 14px;
            color: #dceeff;
            margin-top: 10px;
        }
        /* Main wrapper */.register-wrapper
        {
            width: 100%;
            max-width: 850px;
            margin: -35px auto 40px;
            padding: 0 15px;
            position: relative;
            z-index: 2;
        }
        /* Registration card */.register-panel
        {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 12px 35px rgba(0, 35, 75, .16);
        }
        .register-panel .panel-heading
        {
            background: #fff;
            border: none;
            text-align: center;
            padding: 25px 20px 10px;
        }
        .register-panel .panel-title
        {
            font-size: 25px;
            color: #123c67;
            font-weight: 700;
        }
        .register-panel .panel-body
        {
            padding: 25px 35px;
        }
        /* Labels */.register-panel label
        {
            color: #34495e;
            font-weight: 600;
            margin-bottom: 7px;
        }
        .required
        {
            color: #e74c3c;
        }
        /* Inputs */.register-panel .form-control
        {
            height: 42px;
            border-radius: 6px;
            border: 1px solid #d4deea;
            box-shadow: none;
            font-size: 14px;
        }
        .register-panel .form-control:focus
        {
            border-color: #1686c9;
            box-shadow: 0 0 6px rgba(22,134,201,.2);
        }
        .register-panel .form-group
        {
            margin-bottom: 18px;
        }
        /* Employee ID button */.btn-get-info
        {
            background: #1686c9;
            color: #fff;
            border: none;
            height: 42px;
            padding: 0 20px;
            font-weight: 600;
        }
        .btn-get-info:hover
        {
            background: #0d6ba8;
            color: #fff;
        }
        /* Signature */.signature-box
        {
            border: 2px dashed #cbd8e6;
            border-radius: 8px;
            padding: 15px;
            background: #f8fbff;
        }
        #profile_pic
        {
            width: 130px;
            height: 150px;
            object-fit: contain;
            border: 1px solid #d4deea;
            background: #fff;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        /* Footer */.register-panel .panel-footer
        {
            background: #f7faff;
            border-top: 1px solid #e6edf5;
            padding: 20px;
            text-align: center;
        }
        .btn-create
        {
            background: #1686c9;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 11px 30px;
            font-weight: 600;
        }
        .btn-create:hover
        {
            background: #0d6ba8;
            color: #fff;
        }
        .btn-login
        {
            background: #27ae60;
            color: #fff;
            border-radius: 6px;
            padding: 11px 30px;
            font-weight: 600;
        }
        .btn-login:hover
        {
            background: #219150;
            color: #fff;
        }
        .page-footer
        {
            text-align: center;
            color: #718096;
            font-size: 12px;
            margin: 20px 0;
        }
        /* Responsive */@media (max-width: 600px)
        {
            .welcome-banner h1
            {
                font-size: 22px;
            }
            .register-panel .panel-body
            {
                padding: 20px;
            }
            .register-wrapper
            {
                margin-top: -20px;
            }
        }
    </style>














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
    <script src="sweet_alert.js" type="text/javascript"></script>
    <link href="sweet_alert.css" rel="stylesheet" type="text/css" />
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
                $("#branchcode").show();
                $("#Select1").hide();

                var EmpId = $("#empid").val();

                $.ajax({


                    type: "POST",
                    url: "New_V2.aspx/GetEmpInfo",
                    //url: "http://10.10.100.82/HRM_API/HRM/GetEmpInfo/" + empid,
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

                        $("#branchname").val(response.d.POP);
                        $("#phone").val(response.d.PhoneNumber);
                        $("#domain").val(response.d.DOMAINID);


                        //$("#ddlRole").empty();

                        var role = response.d.EmpFunctionalDesignation;

                        var bc = response.d.POPCode;

                        $("#branchcode").val(response.d.POPCode);

                        if (bc != "BD0010100") {

                            if (role == 'HEAD OF BRANCH') {
                                //$("#ddlRole").val(20);
                                $("#ddlrole").empty().append('<option value="20">HOB</option>');
                            }
                            else if (role == 'UPOSHAKHA INCHARGE' || role == 'Uposhakha Incharge') {
                                //$("#ddlRole").val(15);
                                $("#ddlrole").empty().append('<option value="15">UPOSHAKHA INCHARGE</option>');
                            }
                            else {

                                var items = [

                                    { id: '', text: "<--Select->" },

                                    { id: 5, text: "Relationship Manager (RM)" },

                                    { id: 10, text: "Credit Incharge" },




                                ];

                                var sel = $("#ddlrole");

                                sel.empty();

                                $.each(items, function () {
                                    sel.append($("<option>").val(this.id).text(this.text));
                                });


                            }
                        } else {
                            changePOP();
                        }
                    }
                });
            });


            function changePOP() {

                var branchCode = $("#branchcode").val();

                //if (branchCode === "BD0010100") {
                $("#branchcode").hide();
                //$("#Select1").empty();
                $("#Select1").show();
                $("#ddlrole").empty();
                $("#ddlrole").html('<option value="">--Select--</option>');

                //}
                /* else {
                $("#Select1").hide();
                $("#branchcode").show();
                $("#ddlrole").html('<option value="">--Select--</option>');
                }*/
            }

            $("#Select1").on("change", function () {

                var selectedValue = $(this).val();

                $("#ddlrole").empty().append('<option value="">--Select--</option>');

                if (selectedValue === "CAD") {
                    $("#ddlrole").append('<option value="21">DM</option>');
                    $("#ddlrole").append('<option value="23">Unit Head</option>');
                } else {
                    $("#ddlrole").append('<option value="31">Dealing Officer</option>');
                    $("#ddlrole").append('<option value="33">Supervisor</option>');
                }
            });

            $("#btnCreateUser").click(function () {

                var bc = $("#branchcode").val();
                var bc_new = $("#Select1").val();


                if (bc == "BD0010100" && bc_new == "") {
                    alert('Please select POP');
                    return false;
                }

                if (bc == "BD0010100") {
                    bc = bc_new;
                }


                //bc = $("#Select1").val();



                var domain = $("#domain").val()

                //alert('fffff');

                //var EmpId = $("#empid").val();


                //var formData = new FormData();
                //formData.append("fileName", f.name);
                //formData.append("file", f);


                var formData = new FormData();

                var role = $("#ddlrole").val();

                if (role == "") {
                    alert('Please select a role');
                    return false;
                }


                //alert(role);
                // Add form fields
                //formData.append("empid", $("#empid").val());

                formData.append("empid", $("#empid").val());
                //formData.append("empid", empid);
                formData.append("name", $("#name").val());
                formData.append("designation", $("#designation").val());
                //formData.append("role", $("#ddlrole").val());
                formData.append("role", role);
                //formData.append("branchcode", $("#branchcode").val());
                formData.append("branchcode", bc);
                formData.append("branchname", $("#branchname").val());
                formData.append("phone", $("#phone").val());
                formData.append("domain", domain);




                // Add file
                var file = $("#image")[0].files[0];
                if (!file) {
                    alert("Please select a signature.");
                    return;
                }

                formData.append("SignatureFile", file);
                formData.append("fileName", file.name);

                //alert('tttt');



                $.ajax({


                    url: 'WebService1.asmx/CreateUser',
                    type: 'POST',
                    data: formData,

                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (Status) {

                        //$("#fileProgress").hide();

                        //$("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");

                        /*
                        swal("Success!", Status, "success");
                        $("#email1").val(domain)
                        $('#modalSignup').modal('hide');
                        */



                        if (Status.indexOf("1") !== -1) {

                            swal("Success!", Status, "success");
                            $("#email1").val(domain)
                            $('#modalSignup').modal('hide');

                        }

                        if (Status.indexOf("0") !== -1) {
                            swal("Error!", Status, "error");
                        }


                        // If response is already an object
                        /*
                        var result = Status.d;

                        if (result.status === 1) {
                        swal("Success!", result.message, "success");

                        $("#email1").val(domain);
                        $("#modalSignup").modal("hide");
                        }
                        else {
                        swal("Error!", result.message, "error");
                        }
                        */

                        //alert(Status);
                        /*
                        uploaded_files = uploaded_files + 1;

                        if (uploaded_files == total_files) {
                        uploaded_files = 0;
                        alert('ALL Files Uploaded Sequentially');
                        } else {
                        up(i + 1);
                        }
                        */
                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        //Check if upload property exists
                        if (fileXhr.upload) {

                            //update progressbar percent complete
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    //$("#statustxt").attr({ value: e.loaded, max: e.total });
                                    //console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    console.log(file.name + ' : ' + percentage + '%');
                                    //$("#statustxt").html(percentage + '%');
                                    //$("#file_" + i).html(percentage + '%');

                                    //$(this).parent().parent().css('backgroundColor', 'red');

                                    //$("#file_" + i).parent().parent().css('backgroundColor', 'yellow');

                                    //if (percentage >= 100)
                                    //$("#file_" + i).parent().parent().css('backgroundColor', 'green');

                                }
                            }, false);
                        }
                        return fileXhr;
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //$("#file_" + i + "").html('0%');
                        //$("#error_" + i + "").html(XMLHttpRequest.responseText + '-' + textStatus + '-' + errorThrown);
                        //$("#error_" + i + "").html(XMLHttpRequest.status + '-' + XMLHttpRequest.statusText);
                        alert("Whoops something went wrong!");
                    }


                });

            });

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <!-- Header -->
    <div class="welcome-banner">
        <div>
            <h1>
                <i class="fa fa-folder-open"></i>MBPLC Document Management System
            </h1>
            <p>
                User Registration Portal</p>
        </div>
    </div>
    <!-- Registration -->
    <div class="register-wrapper">
        <div class="panel panel-default register-panel">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <i class="fa fa-user-plus"></i>Create Your Account
                </h3>
                <p style="color: #8998a9; margin-top: 8px;">
                    Please provide your employee information
                </p>
            </div>
            <div class="panel-body">
                <!-- Employee ID -->
                <div class="form-group">
                    <label>
                        Employee ID <span class="required">*</span>
                    </label>
                    <div class="input-group">
                        <input type="text" class="form-control" name="empid" id="empid" placeholder="Enter Employee ID" />
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-get-info" id="btnGetEmpInfo">
                                <i class="fa fa-search"></i>Go!
                            </button>
                        </span>
                    </div>
                </div>
                <!-- Row 1 -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Full Name <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="name" placeholder="Full Name" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Designation <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="designation" placeholder="Designation" />
                        </div>
                    </div>
                </div>
                <!-- Row 2 -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Branch/POP Code <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="branchcode" placeholder="Branch Code" />
                            <select id="Select1" class="form-control" style="display: none;">
                                <option value="">Select</option>
                                <option value="CAD">CAD</option>
                                <option value="Credit(SME)">Credit(SME)</option>
                                <option value="Credit(Corporate)">Credit(Corporate)</option>
                                <option value="Credit(Retail)">Credit(Retail)</option>
                                <option value="Credit(Agri)">Credit(Agri)</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Branch/POP Name <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="branchname" placeholder="Branch Name" />
                        </div>
                    </div>
                </div>
                <!-- Row 3 -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Role <span class="required">*</span>
                            </label>
                            <select id="ddlrole" class="form-control">
                                <option value="">Select Role</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Phone <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="phone" placeholder="Phone Number" />
                        </div>
                    </div>
                </div>
                <!-- Row 4 -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Domain ID <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="domain" placeholder="Domain ID" />
                        </div>
                    </div>
                </div>
                <!-- Signature -->
                <div class="form-group">
                    <label>
                        <i class="fa fa-pencil"></i>Signature
                    </label>
                    <div class="signature-box" id="divImage">
                        <img id="profile_pic" alt="Signature Preview" src="uploads/signature-placeholder.png"
                            onerror="this.style.display='none';" />
                        <input type="file" name="fileName" id="image" class="form-control" accept="image/*" />
                        <small class="text-muted">Upload your signature image. </small>
                    </div>
                </div>
            </div>
            <!-- Footer -->
            <div class="panel-footer">
                <button type="button" id="btnCreateUser" class="btn btn-create">
                    <i class="fa fa-user-plus"></i>Create User
                </button>
                <a href="Login_20261112.aspx" class="btn btn-login"><i class="fa fa-sign-in"></i>Login
                </a>
            </div>
        </div>
        <div class="page-footer">
            MBPLC Document Management System
            <br />
            Secure &amp; Reliable Document Management
        </div>
    </div>
    </form>
    <!-- jQuery -->
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">

        // Signature preview
        $('#image').on('change', function () {

            var file = this.files[0];

            if (file) {

                var reader = new FileReader();

                reader.onload = function (e) {

                    $('#profile_pic')
                    .attr('src', e.target.result)
                    .show();

                };

                reader.readAsDataURL(file);
            }

        });

</script>
</body>
</html>
