<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProfileCreate.aspx.cs" Inherits="ProfileCreate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="sweet_alert.js" type="text/javascript"></script>
    <link href="sweet_alert.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        $(document).ready(function () {


            $("#Checkbox1").click(function () {
                if ($(this).is(":checked")) {
                    $("#divSisterConcern").css("display", "block");
                    //$("#AddPassport").hide();
                } else {
                    $("#divSisterConcern").css("display", "none");
                    //$("#AddPassport").show();
                }
            });


            var c_type;

            $('#divCusDeatil').css("display", "none");
            $('#divCusIndvInfo').css("display", "none");
            $('#divCusPropInfo').css("display", "none");
            $('#divCusPartInfo').css("display", "none");
            $('#divCusComInfo').css("display", "none");
            $('#divCusJVInfo').css("display", "none");

            //$("#divFDR, #divSND").find(':text').prop('readonly', true);




            $("#btnJVCompanyInfoSave").click(function () {


                var cusid = $("#txtJVCompanyCustomerID").val();
                var name = $("#txtJVCompanyName").val();
                var address = $("#txtJVCompanyAddress").val();
                var phone = $("#txtJVCompanyPhone").val();

                alert(cusid + '-' + name + '-' + address + '-' + phone);

                var obj = {};




                obj.edocid = $("#txteDocID").val();
                obj.cusid = cusid;
                obj.name = name;
                obj.address = address;
                obj.phone = phone;


                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "ProfileCreate.aspx/JVCompanyInfo_Save",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function () {

                        alert("Data Saved Successfully.");

                        $("#txtJVCompanyCustomerID").val('');
                        $("#txtJVCompanyName").val('');
                        $("#txtJVCompanyAddress").val('');
                        $("#txtJVCompanyPhone").val('');
                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
                });
                return false;
            });



            $("#btnSaveConcernInfo").click(function () {


                var cusid = $("#txtConcernCustomerID").val();
                var name = $("#txtConcernName").val();
                var address = $("#txtConcernAddress").val();
                var phone = $("#txtConcernPhone").val();

                alert(cusid + '-' + name + '-' + address + '-' + phone);

                var obj = {};




                obj.edocid = $("#txteDocID").val();
                obj.cusid = cusid;
                obj.name = name;
                obj.address = address;
                obj.phone = phone;


                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "ProfileCreate.aspx/ConcernInfo_Save",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function () {

                        alert("Data Saved Successfully.");

                        $("#txtT24CustomerID").val('');
                        $("#txtConcernName").val('');
                        $("#txtConcernAddress").val('');
                        $("#txtConcernPhone").val('');


                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
                });
                return false;
            });

            $("#btnSavePropOwnerInfo").click(function () {


                var name = $("#txtPropOwnerName").val();
                var address = $("#txtPropOwnerAddress").val();
                var legalid = $("#txtPropOwnerLegalID").val();
                var legaliddocname = $("#txtPropOwnerLegalIDDocName").val();
                var phone = $("#txtPropOwnerPhone").val();

                alert(name + '-' + address + '-' + legalid + '-' + legaliddocname + '-' + phone);

                var obj = {};




                obj.edocid = $("#txteDocID").val();
                obj.name = name;
                obj.address = address;
                obj.legalid = legalid;
                obj.legaliddocname = legalid;
                obj.phone = phone;


                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "ProfileCreate.aspx/Prop_OwnerInfo_Save",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        alert("Data Saved Successfully.");

                        $("#txtPropOwnerName").val('');
                        $("#txtPropOwnerAddress").val('');
                        $("#txtPropOwnerLegalID").val('');
                        $("#txtPropOwnerLegalIDDocName").val('');
                        $("#txtPropOwnerPhone").val('');

                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
                });
                return false;
            });




            $("#btnSavePartnerInfo").click(function () {


                var name = $("#txtPartnerName").val();
                var address = $("#txtPartnerAddress").val();
                var phone = $("#txtPartnerPhone").val();


                var obj = {};




                obj.edocid = $("#txteDocID").val();
                obj.name = name;
                obj.address = address;
                obj.phone = phone;


                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "ProfileCreate.aspx/Part_PartnerInfo_Save",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        alert("Data Saved Successfully.");

                        $("#txtPartnerName").val('');
                        $("#txtPartnerAddress").val('');
                        $("#txtPartnerPhone").val('');
                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
                });
                return false;

            });



            $("#btnSaveCompOwnerInfo").click(function () {


                var name = $("#txtCompOwnerName").val();
                var role = $("#Select2").val();
                var address = $("#txtCompOwnerAddress").val();


                var phone = $("#txtCompOwnerPhone").val();

                //alert(name + '-' + role + '-' + address + '-' + '-' + phone);

                var obj = {};




                obj.edocid = $("#txteDocID").val();
                obj.name = name;
                obj.role = role;
                obj.address = address;

                obj.phone = phone;


                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "ProfileCreate.aspx/Comp_OwnerInfo_Save",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        alert("Data Saved Successfully.");

                        $("#txtCompOwnerName").val('');

                        $("#txtCompOwnerAddress").val('');
                        $("#txtCompOwnerPhone").val('');


                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
                });
                return false;
            });



            $("#btnSave").click(function () {

                var cus_type = $("#Select1").val();
                //var cus_code = $("#txtCustomerCode").val();
                //alert(type + '-' + cus_code);
                //getDetails(cus_type, cus_code)

                //alert(cus_type);

                /*
                var formData = new FormData();
                formData.append("edoc_id", $("#txteDocID").val());
                formData.append("cus_code", $("#txtCustomerCode").val());
                formData.append("name", $("#txtName").val());
                formData.append("fname", $("#txtFName").val());
                formData.append("mname", $("#txtMName").val());
                */

                var obj = {};





                obj.cus_type = c_type;
                obj.edoc_id = $("#txteDocID").val();
                obj.cus_code = $("#txtCustomerCode").val();

                if (c_type == 'INDV') {

                    obj.name = $("#txtName").val();
                    obj.fname = $("#txtFName").val();
                    obj.mname = $("#txtMName").val();

                    obj.legal_id = $("#txtLegalID").val();
                    obj.legal_doc_name = $("#txtLegalIDDocName").val();
                    obj.gender = $("#txtGender").val();
                    obj.tin = $("#txtTIN").val();

                    obj.pre_addr = $("#txtPreAddr").val();
                    obj.per_addr = $("#txtPerAddr").val();
                }

                if (c_type == 'PROP') {

                    obj.name = $("#txtNameProp").val();


                    obj.legal_id = $("#txtLegalIDProp").val();
                    obj.legal_doc_name = $("#txtLegalIDDocNameProp").val();


                    obj.pre_addr = $("#txtPreAddrProp").val();
                    obj.per_addr = $("#txtPerAddrProp").val();
                }

                if (c_type == 'PART') {

                    obj.name = $("#txtNamePart").val();


                    obj.legal_id = $("#txtLegalIDPart").val();
                    obj.legal_doc_name = $("#txtLegalIDDocNamePart").val();


                    obj.pre_addr = $("#txtPreAddrPart").val();
                    obj.per_addr = $("#txtPerAddrPart").val();
                }

                if (c_type == 'COMP') {

                    obj.name = $("#txtNameCom").val();


                    obj.legal_id = $("#txtLegalIDCom").val();
                    obj.legal_doc_name = $("#txtLegalIDDocNameCom").val();

                    obj.pre_addr = $("#txtPreAddrCom").val();
                    obj.per_addr = $("#txtPerAddrCom").val();
                }


                if (c_type == 'JV') {

                    obj.name = $("#txtNameJV").val();


                    obj.legal_id = $("#txtLegalIDJV").val();
                    obj.legal_doc_name = $("#txtLegalIDDocNameJV").val();


                    obj.pre_addr = $("#txtPreAddrJV").val();
                    obj.per_addr = $("#txtPerAddrJV").val();
                }

                $.ajax({

                    //cache: false,
                    //contentType: false,
                    //processData: false,

                    type: "POST",
                    url: "ProfileCreate.aspx/Profile_Create",
                    data: '{Obj: ' + JSON.stringify(obj) + '}',
                    //data: formData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (msg) {


                        //alert("Data Saved Successfully.");

                        if (msg.d = "Data Saved") {
                            swal("Success!", "Data Saved Successfully.", "success")
                            //$("#txtSubject").val('');
                            //$("#txtDetails").val('');


                            //clear();
                            //getDetails(loan_id);
                            //window.location = 'List.aspx'

                            $('#btnAddiInfo').attr("cus-type", c_type);
                            $("#btnAddiInfo").css({ "display": "block" });

                            if (c_type == 'INDV') {
                                $("#btnAddiInfo").css({ "display": "none" });
                            }
                            //else {
                            //$("#btnAddiInfo").css({ "display": "block" });
                            //}

                            if (c_type == 'PROP') {
                                //$("#btnAddiInfo").css({ "display": "block" }); 
                                $("#btnAddiInfo").html("Add Owner Info")
                            }
                            if (c_type == 'PART') {
                                //$("#btnAddiInfo").css({ "display": "block" });
                                $("#btnAddiInfo").html("Add Partner Info")
                            }
                            if (c_type == 'COMP') {
                                //$("#btnAddiInfo").css({ "display": "block" });
                                $("#btnAddiInfo").html("Add Company Management Info")
                            }
                            if (c_type == 'JV') {
                                //$("#btnAddiInfo").css({ "display": "block" });
                                $("#btnAddiInfo").html("Add Joint Company Info")
                            }

                            $("#btnUpload").attr("auto_id", $("#Hidden1").val());
                            $("#btnUpload").css("display", "block");
                        }
                        else {
                            swal("Error!", "Data not Saved!", "error")
                        }

                    },
                    error: function () {
                        //alert("Error while inserting data");
                        sweetAlert("Oops...", "Something went wrong!", "error");
                    }
                });
                return false;
            });


            $("#Select1").change(function () {
                $('#divCusDeatil').css("display", "none");
                c_type = $("#Select1").val()

                document.getElementById('cusType').innerHTML = c_type;
                //alert($(this).val());
                $("#divCustomer").css({ "display": "block" });
                var cus_type = $("#Select1").val();
                get_eDocID(cus_type);

            });


            $("#btnSearch").click(function () {

                $('#btnUpload').css("display", "none");
                $('#btnAddiInfo').css("display", "none");

                var cus_type = $("#Select1").val();

                var cus_code = $("#txtCustomerCode").val();
                //alert(type + '-' + cus_code);
                getDetails(cus_type, cus_code)

            });


            $("#btnAddiInfo").click(function () {

                //var cus_type = $("#Select1").val();

                //var cus_code = $("#txtCustomerCode").val();

                var cus_type = $(this).attr("cus-type");

                //alert(cus_type);

                var div = "#div" + cus_type;
                //alert(div);

                document.getElementById("PropreitorName").innerHTML = $("#txtNameProp").val();

                $(div).modal('show');

                //alert(cus_type);

                //getDetails(cus_type, cus_code)

            });

            $("#btnUpload").click(function () {

                //var cus_type = $("#Select1").val();
                //var cus_code = $("#txtCustomerCode").val();
                //alert(type + '-' + cus_code);
                //getDetails(cus_type, cus_code)

                var cus_type = $(this).attr("cus-type");
                var e_doc_id = $(this).attr("e-doc-id");
                var auto_id = $(this).attr("auto_id");
                var cus_id = $(this).attr("cus-id");

                alert(cus_type + '-' + e_doc_id + '-' + auto_id + '-' + cus_id);

                //url = "DocumentUpload_V2.aspx?var=" + cus_type + "&var2=" + auto_id + "&var3=" + e_doc_id;

                //url = "DocumentUpload_V3.aspx?var=" + cus_type + "&var2=" + auto_id + "&var3=" + e_doc_id;

                url = "DocumentUpload_V10_New_Mapping_CusTypeWise.aspx?var=" + cus_type + "&var2=" + auto_id + "&var3=" + e_doc_id + "&var4=" + cus_id;

                

                var width = screen.availWidth - 100;
                var height = screen.availHeight - 100;
                var left = parseInt((screen.availWidth / 2) - (width / 2));
                var top = parseInt((screen.availHeight / 2) - (height / 2));
                var windowFeatures = "width=" + width + ", height=" + height + ", status, resizable, screenX=" + left + ", screenY=" + top;

                //var NWin = window.open("PopUpHelper.aspx?txtBox='"+test+"'&var1="+test+"&var2="+test,'_blank', windowFeatures);
                //var NWin = window.open("Menu.aspx", windowFeatures);
                //alert(windowFeatures);
                //newwindow = window.open('Menu.aspx', 'name', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                //newwindow = window.open(pagename, '_blank', ' resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow = window.open(url, '_blank', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow.focus();


            });




            function getDetails(cus_type, cus_code) {

                $.ajax({

                    type: "POST",
                    contentType: "application/json; Get_CustomerInfo=utf-8",
                    url: "ProfileCreate.aspx/Get_CustomerInfo",
                    data: '{cus_code: "' + cus_code + '"}',

                    //data: '{"Loan_ID":"' + loan_id + '","Category":' + category + ',"MV":' + mv + ',"FSV":' + fsv + ',"Valuation_Date":"' + valuation_date + '"}',

                    //data: '{acc_type:"FDR",'acc_no: "' + acc_no + '"}',


                    dataType: "json",

                    success: function (data) {

                        //swal("Success!", acc_type + '-' + acc_no, "success")

                        //$('#dataTable tbody').remove();

                        //$('#dataTable').find('tbody').empty();

                        //console.log(data.d);

                        var sts = data.d.StatusCode;

                        if (sts == "2222") {
                            //$('#divFDR').css("display", "none");
                            //$('#divSND').css("display", "none");
                            alert('No records were found that matched the selection criteria');
                            return false;
                        }
                        //divCusDeatil

                        if (sts == "0000") {

                            $('#divCusDeatil').css("display", "block");

                            //$('#btnUpload').css("display", "block");

                            $('#btnUpload').attr("cus-type", cus_type);
                            $('#btnUpload').attr("e-doc-id", $("#txteDocID").val());
                            $('#btnUpload').attr("cus-id", $("#txtCustomerCode").val());


                            if (cus_type == "INDV") {

                                $('#divCusIndvInfo').css("display", "block");
                                $('#divCusPropInfo').css("display", "none");
                                $('#divCusPartInfo').css("display", "none");
                                $('#divCusComInfo').css("display", "none");
                                $('#divCusJVInfo').css("display", "none");

                                //$('#divSND').css("display", "none");

                                //alert(data.d.customerMnemonic);

                                //$("#Text1").val(data.d.customerMnemonic);
                                $("#txtName").val(data.d.shortName);
                                $("#txtFName").val(data.d.ltCusFathername);
                                $("#txtMName").val(data.d.ltCusMothername);
                                $("#txtPhoneNumber").val(data.d.smsNumber);
                                $("#txtGender").val(data.d.gender);
                                $("#txtTIN").val(data.d.tinId);
                                $("#txtLegalID").val(data.d.legalId);
                                $("#txtLegalIDDocName").val(data.d.legalDocumentName);
                                $("#txtPreAddr").val(data.d.presentAddress);
                                $("#txtPerAddr").val(data.d.ltCusPermanentAddress);

                                //$("#ContentPlaceHolder1_txtProposedRate").attr('readonly', false);
                                //$("#ContentPlaceHolder1_txtEffectiveFrom").attr('readonly', false);


                            }

                            if (cus_type == "PROP") {

                                $('#divCusIndvInfo').css("display", "none");
                                $('#divCusPropInfo').css("display", "block");
                                $('#divCusPartInfo').css("display", "none");
                                $('#divCusComInfo').css("display", "none");
                                $('#divCusJVInfo').css("display", "none");

                                $("#txtNameProp").val(data.d.shortName);

                                $("#txtPhoneNumberProp").val(data.d.smsNumber);

                                $("#txtTINProp").val(data.d.tinId);
                                $("#txtLegalIDProp").val(data.d.legalId);
                                $("#txtLegalIDDocNameProp").val(data.d.legalDocumentName);
                                $("#txtPreAddrProp").val(data.d.presentAddress);
                                $("#txtPerAddrProp").val(data.d.ltCusPermanentAddress);
                            }

                            if (cus_type == "PART") {

                                $('#divCusIndvInfo').css("display", "none");
                                $('#divCusPropInfo').css("display", "none");
                                $('#divCusPartInfo').css("display", "block");
                                $('#divCusComInfo').css("display", "none");
                                $('#divCusJVInfo').css("display", "none");

                                $("#txtNamePart").val(data.d.shortName);

                                $("#txtPhoneNumberPart").val(data.d.smsNumber);

                                $("#txtTINPart").val(data.d.tinId);
                                $("#txtLegalIDPart").val(data.d.legalId);
                                $("#txtLegalIDDocNamePart").val(data.d.legalDocumentName);
                                $("#txtPreAddrPart").val(data.d.presentAddress);
                                $("#txtPerAddrPart").val(data.d.ltCusPermanentAddress);

                            }

                            if (cus_type == "COMP") {

                                $('#divCusIndvInfo').css("display", "none");
                                $('#divCusPropInfo').css("display", "none");
                                $('#divCusPartInfo').css("display", "none");
                                $('#divCusComInfo').css("display", "block");
                                $('#divCusJVInfo').css("display", "none");

                                $("#txtNameCom").val(data.d.shortName);

                                $("#txtPhoneNumberCom").val(data.d.smsNumber);

                                $("#txtTINCom").val(data.d.tinId);
                                $("#txtLegalIDCom").val(data.d.legalId);
                                $("#txtLegalIDDocNameCom").val(data.d.legalDocumentName);
                                $("#txtPreAddrCom").val(data.d.presentAddress);
                                $("#txtPerAddrCom").val(data.d.ltCusPermanentAddress);

                            }

                            if (cus_type == "JV") {

                                $('#divCusIndvInfo').css("display", "none");
                                $('#divCusPropInfo').css("display", "none");
                                $('#divCusPartInfo').css("display", "none");
                                $('#divCusComInfo').css("display", "none");
                                $('#divCusJVInfo').css("display", "block");

                                $("#txtNameJV").val(data.d.shortName);

                                $("#txtPhoneNumberJV").val(data.d.smsNumber);

                                $("#txtTINJV").val(data.d.tinId);
                                $("#txtLegalIDJV").val(data.d.legalId);
                                $("#txtLegalIDDocNameJV").val(data.d.legalDocumentName);
                                $("#txtPreAddrJV").val(data.d.presentAddress);
                                $("#txtPerAddrJV").val(data.d.ltCusPermanentAddress);
                            }
                        }


                        /*
                        alert(data.d.ArrangementId);
                        alert(data.d.AccountNumber);
                        alert(data.d.AccountTitle);
                        alert(data.d.OpeningDate);
                        alert(data.d.LastRenewalDate);
                        alert(data.d.Principal);

                        */



                        /*
                        for (var i = 0; i < data.d.length; i++) {
                        $("#dataTable").append(
                        "<tr><td style='text-align:right;'>" + (i + 1) + "</td><td>" + data.d[i].Loan_ID + "</td><td>" + data.d[i].Date + "</td>" +
                        "<td style='text-align:right;'>" + data.d[i].RecovAmount + "</td><td style='text-align:right;'>" + data.d[i].NIActAmount + "</td><td style='text-align:right;'>" + data.d[i].ArthaRinAmount + "</td><td>" + data.d[i].EmployeeID + "</td>" +
                        "<td>" + data.d[i].Status + "</td>" +
                        "<td><input type='button' class='btn btn-danger deleteButton'  data-loan-id='" + data.d[i].Loan_ID + "' data-id='" + data.d[i].ID + "' name='submitButton' id='btnDelete' value='Delete'/></td></tr>");
                        }
                        */

                    },
                    error: function () {
                        alert("Error while Showing update data");
                    }
                });
            }

            function get_eDocID(cus_type) {

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ProfileCreate.aspx/Get_eDocID",
                    data: '{cus_type: "' + cus_type + '"}',
                    //data: '{"Loan_ID":"' + loan_id + '","Category":' + category + ',"MV":' + mv + ',"FSV":' + fsv + ',"Valuation_Date":"' + valuation_date + '"}',
                    //data: '{acc_type:"FDR",'acc_no: "' + acc_no + '"}',

                    dataType: "json",

                    success: function (data) {

                        //swal("Success!", acc_type + '-' + acc_no, "success")

                        //$('#dataTable tbody').remove();

                        //$('#dataTable').find('tbody').empty();

                        //console.log(data.d);

                        //var sts = data.d.StatusCode;

                        //data.d[0]
                        //alert(data.d[0] + '-' +data.d[1])


                        $("#txteDocID").val(data.d[0]);
                        $("#Hidden1").val(data.d[1]);


                    },
                    error: function () {
                        alert("Error while Showing update data");
                    }
                });
            }
        });

         
    </script>
    <script type="text/javascript">
        $(document).ready(function () {



        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
    	<h1>
        	Customer Profile
        </h1>
        <ol class="breadcrumb">
        	<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Profile</a></li>
    	</ol>
	</section>
    <section class="content">


      

       


    

       

    <div class="row">
         
            <div class="col-md-5">
             
              	<div class="box box-primary">
                	<div class="box-header with-border">
                  		<h3 class="box-title">Create</h3>
                	</div> 
                 
                 
                  		<div class="box-body">
                    		<div class="form-group" id="divSubject">
                      			<label for="">Customer Type</label>

<select id="Select1" class="form-control">
<option value=""><-Select-></option>
<option value="INDV">Individual</option>
<option  value="PROP">Propreitor</option>
<option  value="PART">Partnership</option>
<option  value="COMP">Company</option>
<option  value="JV">Joint Venture</option>


</select>
                      	 	</div>

                            <hr />
                            <table class="table table-bordered table-striped" id="divCustomer" style=" display:none;">
                    				<tbody>
                      					<tr>
                        					<td class="col-md-4">eDoc ID</td>
                        					<td><input id="txteDocID" type="text" class="form-control"/> 
                                            <input id="Hidden1" type="hidden" />
                                            </td>
                      					</tr>
                      					<tr>
                        					<td>T24 Customtor Code</td>
                        					<td><input id="txtCustomerCode" type="text"  class="form-control"/> </td>
                      					</tr>
                             			<tr>
                        					<td></td>
                        					<td>
                                            
                                            <input id="btnSearch" type="button" class="btn btn-primary" value="Search" /></td>
                      					</tr>

                                        </tbody>
                           </table>

                  		</div> 
                        
                  		</div>

                        </div>
                        
					   <div class="col-md-7" id="divCusDeatil">
                     
                     	<div class="box box-primary">
                	        <div class="box-header with-border">
                  		        <h3 class="box-title"><span id="cusType"></span></h3>
                	        </div> 
                 
                 
                  		<div class="box-body">
                           <table class="table table-bordered table-striped" id="divCusIndvInfo"  style="display:none;">
                    				<tbody>
                      					<tr>
                        					<td class="col-md-4">Name</td>
                        					<td id="name"><input id="txtName" type="text"  class="form-control"/></td>
                      					</tr>
                      					<tr>
                        					<td>fathers' Name</td>
                        					<td id="fname"><input id="txtFName" type="text"  class="form-control"/> </td>
                      					</tr>
                             			<tr>
                        					<td>Mothers' Name</td>
                        					<td id="mname"><input id="txtMName" type="text"  class="form-control"/> </td>
                      					</tr>
                                        <tr>
                        					<td>Phone Number</td>
                        					<td id="Td18"><input id="txtPhoneNumber" type="text"  class="form-control"/> </td>
                      					</tr>
                        				<tr>
                        					<td>Gender</td>
                        					<td id="gender"><input id="txtGender" type="text"  class="form-control"/></td>
                      					</tr>
                      					<tr>
                        					<td>TIN</td>
                        					<td id="tin"><input id="txtTIN" type="text"  class="form-control"/> </td>
                      					</tr>
                                       
                                         <tr>
                        					<td>Legal ID</td>
                        					<td id="Td2"><input id="txtLegalID" type="text"  class="form-control"/></td>
                      					</tr>
                                         <tr>
                        					<td>Legal DOC Name</td>
                        					<td id="Td3"><input id="txtLegalIDDocName" type="text"  class="form-control"/></td>
                      					</tr>
                                        <tr>
                        					<td>Present Address</td>
                        					<td id="pre_addr"><input id="txtPreAddr" type="text"  class="form-control" /></td>
                                      </tr>
                                      <tr>
                        					<td>Permanent Address</td>
                        					<td id="per_addr"><input id="txtPerAddr" type="text"  class="form-control" /></td>
                      					</tr>
                    				</tbody>
                  				</table>

                              
                                  <table class="table table-bordered table-striped" id="divCusPropInfo" style="display:none;">
                    				<tbody>
                      					<tr>
                        					<td class="col-md-4">Name</td>
                        					<td id="Td1"><input id="txtNameProp" type="text"  class="form-control"/></td>
                      					</tr> <tr>
                        					<td>Phone Number</td>
                        					<td id="phone"><input id="txtPhoneNumberProp" type="text"  class="form-control"/></td>
                      					</tr>
                                         <tr>
                        					<td>Legal ID</td>
                        					<td id="Td4"><input id="txtLegalIDProp" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Legal DOC Name</td>
                        					<td id="Td5"><input id="txtLegalIDDocNameProp" type="text"  class="form-control" /></td>
                      					</tr> 
                                       
                                        <tr>
                        					<td>Present Address</td>
                        					<td id="Td7"><input id="txtPreAddrProp" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Permanenet Address</td>
                        					<td id="Td8"><input id="txtPerAddrProp" type="text"  class="form-control" /></td>
                      					</tr>
                    				</tbody>
                  				</table>

                             

                                  <table class="table table-bordered table-striped" id="divCusPartInfo" style="display:none;">
                    				<tbody>
                      					<tr>
                        					<td class="col-md-4">Name</td>
                        					<td id="Td9"><input id="txtNamePart" type="text"  class="form-control"/></td>
                      					</tr> <tr>
                        					<td>Phone Number</td>
                        					<td id="Td19"><input id="txtPhoneNumberPart" type="text"  class="form-control"/></td>
                      					</tr>
                      					  <tr>
                        					<td>Legal ID</td>
                        					<td id="Td6"><input id="txtLegalIDPart" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Legal DOC Name</td>
                        					<td id="Td10"><input id="txtLegalIDDocNamePart" type="text"  class="form-control" /></td>
                      					</tr> 
                                        <tr>
                        					<td>Present Address</td>
                        					<td id="Td15"><input id="txtPreAddrPart" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Permanenet Address</td>
                        					<td id="Td16"><input id="txtPerAddrPart" type="text"  class="form-control" /></td>
                      					</tr>
                    				</tbody>
                  				</table>

                           

                                  <table class="table table-bordered table-striped" id="divCusComInfo" style="display:none;">
                    				<tbody>
                      					<tr>
                        					<td class="col-md-4">Name</td>
                        					<td id="Td17"><input id="txtNameCom" type="text"  class="form-control"/></td>
                      					</tr>

                                         <tr>
                        					<td>Phone Number</td>
                        					<td id="Td20"><input id="txtPhoneNumberCom" type="text"  class="form-control"/></td>
                      					</tr>


                      					  <tr>
                        					<td>Legal ID</td>
                        					<td id="Td11"><input id="txtLegalIDCom" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Legal DOC Name</td>
                        					<td id="Td12"><input id="txtLegalIDDocNameCom" type="text"  class="form-control" /></td>
                      					</tr> 
                                        <tr>
                        					<td>Present Address</td>
                        					<td id="Td23"><input id="txtPreAddrCom" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Permanenet Address</td>
                        					<td id="Td24"><input id="txtPerAddrCom" type="text"  class="form-control" /></td>
                      					</tr>
                    				</tbody>
                  				</table>
                              
                                 <table class="table table-bordered table-striped" id="divCusJVInfo" style="display:none;">
                    				<tbody>
                      					<tr>
                        					<td class="col-md-4">Name</td>
                        					<td id="Td25"><input id="txtNameJV" type="text"  class="form-control"/></td>
                      					</tr>

                                           <tr>
                        					<td>Phone Number</td>
                        					<td id="Td21"><input id="txtPhoneNumberJV" type="text"  class="form-control"/></td>
                      					</tr>




                      					  <tr>
                        					<td>Legal ID</td>
                        					<td id="Td13"><input id="txtLegalIDJV" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Legal DOC Name</td>
                        					<td id="Td14"><input id="txtLegalIDDocNameJV" type="text"  class="form-control" /></td>
                      					</tr> 
                                        <tr>
                        					<td>Present Address</td>
                        					<td id="Td31"><input id="txtPreAddrJV" type="text"  class="form-control" /></td>
                                      </tr>  <tr>
                        					<td>Permanenet Address</td>
                        					<td id="Td32"><input id="txtPerAddrJV" type="text"  class="form-control" /></td>
                      					</tr>
                    				</tbody>
                  				</table>
                         
                            </div>
                            <div class="box-footer">
					 
                            <button type="button"  id="btnSave" class="btn btn-primary">Submit</button>
                            <button type="button"  id="btnAddiInfo" class="btn btn-primary"  style="display:none;">Add Owner Info</button>
                            <button type="button"  id="btnUpload" class="btn btn-success" style="display:none;">Upload Docs</button>
                           

						</div>
                        </div>

                     </div>
				</div> 

                <!--Modal-->
                <!--Prop-->

                  <div class="modal fade" id="divPROP" tabindex="-1" role="dialog" data-backdrop="static"
        data-keyboard="false">
        <div class="modal-dialog modal-sm" style="width: 90%" role="document">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <h5 class="modal-title" id="tName">Propreitor Owner Info Add
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3">
                            <%--<img id="tImage" class="img-circle" style="width: 120px; height: 120px;">--%>
 <table class="table">
                                <tbody>
                                    
                                    <tr>
                                        <td>
                                            Propreitor
                                        </td>
                                        <td id="Td50"> 
                                        <span id="PropreitorName"></span>
                                        
                                         
                                        </td>
                                    </tr>

                                    </tbody>
                                    </table>

                        </div>
                        <div class="col-sm-9">
                            <table class="table">
                                <tbody>
                                     <tr>
                                        <td>
                                         Customer ID
                                        </td>
                                        <td> <input id="txtPropOwnerCustomerID" type="text"  class="form-control"/>
                                       <input id="btnGetT24CustomerInfo_PropOwner" type="button" value="Get T24 Info"  class="btn btn-primary" /> </td>
                                    </tr>
                                    <tr>
                                        <td>
                                          Name
                                        </td>
                                        <td id="tName1"> <input id="txtPropOwnerName" type="text"  class="form-control"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Address
                                        </td>
                                        <td id="tAddress"><input id="txtPropOwnerAddress" type="text"  class="form-control"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Legal ID
                                        </td>
                                        <td id="tGender"><input id="txtPropOwnerLegalID" type="text"  class="form-control" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            Legal ID Name
                                        </td>
                                        <td><input id="txtPropOwnerLegalIDDocName" type="text"  class="form-control" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Phone
                                        </td>
                                        <td id="tPhone"><input id="txtPropOwnerPhone" type="text"  class="form-control"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            
                                        </td>
                                        <td> <input id="btnSavePropOwnerInfo" type="button" value="Save" class="btn btn-primary" />
                                        </td>
                                    </tr>
                                 
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Part-->
    
                  <div class="modal fade" id="divPART" tabindex="-1" role="dialog" data-backdrop="static"
        data-keyboard="false">
        <div class="modal-dialog modal-lg" style="width: 90%" role="document">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <h5 class="modal-title" id="H1">Partnership Info Add
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3">
                           <%-- <img id="Img1" class="img-circle" style="width: 120px; height: 120px;">--%>
                        </div>
                        <div class="col-sm-9">
                            <table class="table">
                                <thead>
                                    <tr>
                                         <td>
                                            Customer ID
                                        </td>
                                     
                                        <td>
                                            Name
                                        </td>
                                        
                                        <td>
                                            Address
                                        </td>
                                        <td> Phone
                                        </td>
                                    
                                        <td>
                                           Action
                                        </td>
                                       
                                    </tr>
                                   
                                </thead>
                                  <tbody>
                                    <tr>
                                        
                                      <td>
                                          <input id="txtPartnerCustomerID" type="text"  class="form-control" />
     <input id="btnGetT24CustomerInfo_Partner" type="button" value="Get T24 Info"  class="btn btn-primary" /> </td>
                                  
                                       
                                        <td>
                                          <input id="txtPartnerName" type="text"  class="form-control" />
                                        </td>
                                        
                                        <td>
                                           <input id="txtPartnerAddress" type="text"  class="form-control" />
                                        </td>
                                        <td> <input id="txtPartnerPhone" type="text"  class="form-control" />
                                        </td>
                                    
                                        <td>

                                            <input id="btnSavePartnerInfo" type="button" value="Save" class="btn btn-primary" />
                                        </td>
                                       
                                    </tr>
                                   
                                </tbody>

                            </table>
                            <hr />

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Comp-->
    
                  <div class="modal fade" id="divCOMP" tabindex="-1" role="dialog" data-backdrop="static"   data-keyboard="false">
        <div class="modal-dialog modal-lg" style="width: 90%" role="document">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <h5 class="modal-title" id="H2">Company Management Info
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3">
                            <%--<img id="Img2" class="img-circle" style="width: 120px; height: 120px;">--%>
                        </div>
                        <div class="col-sm-9"><b>Owner Info : </b>
                             <table class="table">
                                <thead>
                                    <tr>
                                          <td>
                                            Customer ID
                                        </td>
                                     
                                        <td>
                                            Name
                                        </td>
                                         <td>
                                            Role
                                        </td>
                                        <td>
                                            Address
                                        </td>
                                        
                                        <td> Phone
                                        </td>
                                    
                                        <td>
                                           Action
                                        </td>
                                       
                                    </tr>
                                   
                                </thead>
                                  <tbody>
                                    <tr>
                                        
                                      <td>
                                          <input id="txtCompOwnerCustomerID" type="text"  class="form-control" />
     <input id="btnGetT24CustomerInfo_CompanyOwner" type="button" value="Get T24 Info"  class="btn btn-primary" /> </td>
                                  
                                       
                                       
                                        <td>
                                          <input id="txtCompOwnerName" type="text"  class="form-control" />
                                        </td>
                                         <td><select id="Select2"  class="form-control">

<option>Chairman</option>
<option>Managing Director</option>
<option>Director</option>
<option>Accountant</option>
<option>Secretary</option>

</select> 
                                        </td>
                                        <td>
                                           <input id="txtCompOwnerAddress" type="text"  class="form-control" />
                                        </td>
                                         
                                        <td> <input id="txtCompOwnerPhone" type="text"  class="form-control" />
                                        </td>
                                    
                                        <td>

                                            <input id="btnSaveCompOwnerInfo" type="button" value="Save" class="btn btn-primary" />
                                        </td>
                                        
                                    </tr>
                                   
                                </tbody>

                            </table>
                            <hr />

Is Group Customer ? <input id="Checkbox1" type="checkbox" />
<a href="#exampleModal" data-toggle="modal"   data-id="1">
        Test Modal </a>
        <br />
        <div id="divSisterConcern" style="display:none;">
        <b>Sister Concern Info : </b>
        <br />

         <table class="table">
                                <thead>
                                    <tr>
                                        <td>
                                            T24 Customer ID (Corporate)
                                        </td>
                                     
                                        <td>
                                            Concern Name
                                        </td>
                                         <td>
                                            Address
                                        </td>
                                       
                                        
                                        <td> Phone
                                        </td>
                                    
                                        <td>
                                           Action
                                        </td>
                                        
                                    </tr>
                                   
                                </thead>
                                  <tbody>
                                    <tr>
                                        
                                     
                                        <td>

                                        <div class="input-group mb-3">
                                            <input id="txtConcernCustomerID" type="text"  class="form-control" />
                                            <div class="input-group-append">
                                                <input id="btnGetT24Info_Concern" type="button" value="Get T24 Info"  class="btn btn-primary" />  
                                            </div>
                                         </div>


                                          
                                    </td>
                                        <td>
                                            <input id="txtConcernName" type="text"  class="form-control" />
                                        </td>
                                        <td>
                                           <input id="txtConcernAddress" type="text"  class="form-control" />
                                        </td>
                                        <td>
                                            <input id="txtConcernPhone" type="text"  class="form-control" />
                                        </td>
                                        <td>
                                            <input id="btnSaveConcernInfo" type="button" value="Save" class="btn btn-primary" />
                                        </td>
                                        
                                    </tr>
                                   
                                </tbody>

                            </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--JV-->
    
                  <div class="modal fade" id="divJV" tabindex="-1" role="dialog" data-backdrop="static"
        data-keyboard="false">
        <div class="modal-dialog modal-lg" style="width: 90%" role="document">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <h5 class="modal-title" id="H3">JV
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3">
                            <img id="Img3" class="img-circle" style="width: 120px; height: 120px;">
                        </div>
                        <div class="col-sm-9">
                             <table class="table">
                                <thead>
                                    <tr>
                                        <td>
                                            T24 Customer ID (Corporate)
                                        </td>
                                     
                                        <td>
                                            Company Name
                                        </td>
                                         <td>
                                            Address
                                        </td>
                                       
                                        
                                        <td> Phone
                                        </td>
                                    
                                        <td>
                                           Action
                                        </td>
                                        
                                    </tr>
                                   
                                </thead>
                                  <tbody>
                                    <tr>
                                        
                                     
                                        <td>

                                        <div class="input-group mb-3">
                                            <input id="txtJVCompanyCustomerID" type="text"  class="form-control" />
                                            <div class="input-group-append">
                                                <input id="btnGetT24Info_JVCompany" type="button" value="Get T24 Info"  class="btn btn-primary" />  
                                            </div>
                                         </div>


                                          
                                    </td>
                                        <td>
                                            <input id="txtJVCompanyName" type="text"  class="form-control" />
                                        </td>
                                        <td>
                                           <input id="txtJVCompanyAddress" type="text"  class="form-control" />
                                        </td>
                                        <td>
                                            <input id="txtJVCompanyPhone" type="text"  class="form-control" />
                                        </td>
                                        <td>
                                            <input id="btnJVCompanyInfoSave" type="button" value="Save" class="btn btn-primary" />
                                        </td>
                                        
                                    </tr>
                                   
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!---->

    <div class="modal fade" id="exampleModal" role="dialog"
            tabindex="-1"  data-backdrop="static"   data-keyboard="false"
            aria-labelledby="exampleModalLabel" 
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" 
                            id="exampleModalLabel">
                            Entered Data
                        </h5>
                        
                        <button type="button" 
                            class="close" 
                            data-dismiss="modal" 
                            aria-label="Close">

                            <span aria-hidden="true">
                                &times;
                            </span>
                        </button>
                    </div>

                    <div class="modal-body">

                        <!-- Data passed is displayed
                            in this part of the 
                            modal body -->
                        <p id="modal_body"></p>

                        <button type="button" 
                            class="btn btn-warning btn-sm" 
                            data-toggle="modal"
                            data-target="#exampleModal">
                            Proceed
                        </button>
                    </div>
                </div>
            </div>
            </div>
            


        <a href="#teacherDetails" data-toggle="modal" onclick="teacherDetails(this);" data-id="1">

        Test Modal </a>


         </section>
</asp:Content>
