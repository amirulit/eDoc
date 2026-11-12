
<%@ Page Title="Dashboard" Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs"
    Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle"
    runat="server">
    Dashboard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent"
    runat="server">

    <!-- STATISTICS -->
    <div class="row">

        <div class="col-lg-3 col-xs-6">

            <div class="small-box bg-aqua">

                <div class="inner">
                    <h3>1250</h3>
                    <p>Total Documents</p>
                </div>

                <div class="icon">
                    <i class="fa fa-folder-open"></i>
                </div>

                <a href="DocumentList.aspx"
                   class="small-box-footer">
                    View Details
                    <i class="fa fa-arrow-circle-right"></i>
                </a>

            </div>

        </div>


        <div class="col-lg-3 col-xs-6">

            <div class="small-box bg-yellow">

                <div class="inner">
                    <h3>125</h3>
                    <p>Pending Documents</p>
                </div>

                <div class="icon">
                    <i class="fa fa-clock-o"></i>
                </div>

                <a href="DocumentList.aspx?status=Pending"
                   class="small-box-footer">
                    View Details
                    <i class="fa fa-arrow-circle-right"></i>
                </a>

            </div>

        </div>


        <div class="col-lg-3 col-xs-6">

            <div class="small-box bg-green">

                <div class="inner">
                    <h3>980</h3>
                    <p>Approved Documents</p>
                </div>

                <div class="icon">
                    <i class="fa fa-check-circle"></i>
                </div>

                <a href="DocumentList.aspx?status=Approved"
                   class="small-box-footer">
                    View Details
                    <i class="fa fa-arrow-circle-right"></i>
                </a>

            </div>

        </div>


        <div class="col-lg-3 col-xs-6">

            <div class="small-box bg-red">

                <div class="inner">
                    <h3>145</h3>
                    <p>Rejected Documents</p>
                </div>

                <div class="icon">
                    <i class="fa fa-times-circle"></i>
                </div>

                <a href="DocumentList.aspx?status=Rejected"
                   class="small-box-footer">
                    View Details
                    <i class="fa fa-arrow-circle-right"></i>
                </a>

            </div>

        </div>

    </div>


    <!-- SECOND ROW -->
    <div class="row">

        <div class="col-md-7">

            <div class="box box-primary">

                <div class="box-header with-border">

                    <h3 class="box-title">
                        <i class="fa fa-file-text"></i>
                        Recent Documents
                    </h3>

                    <div class="box-tools pull-right">

                        <a href="DocumentList.aspx"
                           class="btn btn-primary btn-sm">
                            View All
                        </a>

                    </div>

                </div>

                <div class="box-body table-responsive">

                    <table class="table table-bordered table-hover">

                        <thead>
                            <tr>
                                <th>Document ID</th>
                                <th>Subject</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>

                        <tbody>

                            <tr>
                                <td>DMS-001</td>
                                <td>Loan Proposal</td>
                                <td>12-11-2026</td>
                                <td>
                                    <span class="label label-success">
                                        Approved
                                    </span>
                                </td>
                            </tr>

                            <tr>
                                <td>DMS-002</td>
                                <td>Office Memo</td>
                                <td>11-11-2026</td>
                                <td>
                                    <span class="label label-warning">
                                        Pending
                                    </span>
                                </td>
                            </tr>

                            <tr>
                                <td>DMS-003</td>
                                <td>Credit Proposal</td>
                                <td>10-11-2026</td>
                                <td>
                                    <span class="label label-danger">
                                        Rejected
                                    </span>
                                </td>
                            </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>


        <div class="col-md-5">

            <div class="box box-primary">

                <div class="box-header with-border">

                    <h3 class="box-title">
                        <i class="fa fa-bolt"></i>
                        Quick Actions
                    </h3>

                </div>

                <div class="box-body">

                    <a href="DocumentEntry.aspx"
                       class="btn btn-primary btn-block btn-lg">

                        <i class="fa fa-plus-circle"></i>
                        Create New Document

                    </a>

                    <br />

                    <a href="DocumentList.aspx"
                       class="btn btn-success btn-block">

                        <i class="fa fa-list"></i>
                        Browse Documents

                    </a>

                    <br />

                    <a href="Reports.aspx"
                       class="btn btn-info btn-block">

                        <i class="fa fa-bar-chart"></i>
                        Document Reports

                    </a>

                </div>

            </div>

        </div>

    </div>

</asp:Content>
