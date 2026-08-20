<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="bootstrap4/boostrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">


        $(function () {


            var d = new Date();

            //alert(d);
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <a href="#teacherDetails" data-toggle="modal" onclick="teacherDetails(this);" data-id="1">
        Test Modal </a>
    <div class="modal fade" id="teacherDetails" tabindex="-1" role="dialog" data-backdrop="static"
        data-keyboard="false">
        <div class="modal-dialog modal-lg" style="width: 90%" role="document">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <h5 class="modal-title" id="tName">
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3">
                            <img id="tImage" class="img-circle" style="width: 120px; height: 120px;">
                        </div>
                        <div class="col-sm-9">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td>
                                            Index Number
                                        </td>
                                        <td id="tIndex">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Name
                                        </td>
                                        <td id="tName1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Address
                                        </td>
                                        <td id="tAddress">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Gender
                                        </td>
                                        <td id="tGender">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Phone
                                        </td>
                                        <td id="tPhone">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Email
                                        </td>
                                        <td id="tEmail">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Register Date
                                        </td>
                                        <td id="tRegDate">
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
</asp:Content>
