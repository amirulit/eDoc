
<%@ Page Title="Document Information" Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="DocumentTabs.aspx.cs"
    Inherits="DocumentTabs" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="PageTitle"
    runat="server">
    Document Information
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

<style>

    .custom-tabs {
        border-bottom: 2px solid #1686c9;
        margin-bottom: 20px;
    }

    .custom-tabs > li > a {
        color: #34495e;
        font-weight: 600;
        padding: 13px 20px;
        border-radius: 5px 5px 0 0;
    }

    .custom-tabs > li.active > a,
    .custom-tabs > li.active > a:hover,
    .custom-tabs > li.active > a:focus {
        background: #1686c9;
        color: #fff;
        border: 1px solid #1686c9;
    }

    .custom-tabs > li > a:hover {
        background: #eaf2fb;
        border-color: #d4deea;
    }

    .tab-content {
        background: #fff;
        padding: 25px;
        border: 1px solid #e3eaf2;
        border-radius: 0 0 6px 6px;
        min-height: 300px;
    }

    .tab-heading {
        color: #123c67;
        font-weight: 600;
        font-size: 17px;
        margin: 0 0 20px;
        padding-bottom: 12px;
        border-bottom: 1px solid #e6edf5;
    }

    .tab-content label {
        color: #34495e;
        font-weight: 600;
    }

    .tab-content .form-control {
        border-radius: 5px;
        height: 40px;
        box-shadow: none;
    }

    .tab-content textarea.form-control {
        height: auto;
    }

    .tab-actions {
        margin-top: 20px;
        padding-top: 15px;
        border-top: 1px solid #eee;
        text-align: right;
    }

    .tab-actions .btn {
        min-width: 110px;
        margin-left: 5px;
    }

    @media(max-width: 600px) {
        .custom-tabs > li {
            width: 50%;
            text-align: center;
        }

        .custom-tabs > li > a {
            padding: 10px 5px;
            font-size: 12px;
        }

        .tab-content {
            padding: 15px;
        }
    }

</style>


<div class="box box-primary">

    <div class="box-header with-border">

        <h3 class="box-title">
            <i class="fa fa-file-text-o"></i>
            Document Management
        </h3>

        <div class="box-tools pull-right">

            <span class="label label-info">
                DMS-001
            </span>

        </div>

    </div>


    <div class="box-body">

        <!-- TABS -->
        <ul class="nav nav-tabs custom-tabs"
            role="tablist">

            <li class="active">
                <a href="#tabDetails"
                   data-toggle="tab">
                    <i class="fa fa-file-text"></i>
                    Document Details
                </a>
            </li>

            <li>
                <a href="#tabAttachment"
                   data-toggle="tab">
                    <i class="fa fa-paperclip"></i>
                    Attachment
                </a>
            </li>

            <li>
                <a href="#tabApproval"
                   data-toggle="tab">
                    <i class="fa fa-check-circle"></i>
                    Approval
                </a>
            </li>

            <li>
                <a href="#tabHistory"
                   data-toggle="tab">
                    <i class="fa fa-history"></i>
                    History
                </a>
            </li>

        </ul>


        <div class="tab-content">


            <!-- TAB 1: DETAILS -->
            <div class="tab-pane fade in active"
                 id="tabDetails">

                <h4 class="tab-heading">
                    <i class="fa fa-info-circle"></i>
                    General Information
                </h4>

                <div class="row">

                    <div class="col-md-6">
                        <div class="form-group">

                            <label>Document Type</label>

                            <asp:DropDownList ID="ddlDocumentType"
                                runat="server"
                                CssClass="form-control">

                                <asp:ListItem Value="">Select Type</asp:ListItem>
                                <asp:ListItem>Office Memo</asp:ListItem>
                                <asp:ListItem>Loan Proposal</asp:ListItem>
                                <asp:ListItem>Credit Proposal</asp:ListItem>
                                <asp:ListItem>Agreement</asp:ListItem>

                            </asp:DropDownList>

                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">

                            <label>Reference Number</label>

                            <asp:TextBox ID="txtReference"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>
                    </div>

                </div>


                <div class="row">

                    <div class="col-md-6">
                        <div class="form-group">

                            <label>Document Date</label>

                            <asp:TextBox ID="txtDocumentDate"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">

                            <label>Department</label>

                            <asp:DropDownList ID="ddlDepartment"
                                runat="server"
                                CssClass="form-control">

                                <asp:ListItem Value="">Select Department</asp:ListItem>
                                <asp:ListItem>CAD</asp:ListItem>
                                <asp:ListItem>Credit (SME)</asp:ListItem>
                                <asp:ListItem>Credit (Corporate)</asp:ListItem>

                            </asp:DropDownList>

                        </div>
                    </div>

                </div>


                <div class="form-group">

                    <label>Subject</label>

                    <asp:TextBox ID="txtSubject"
                        runat="server"
                        CssClass="form-control">
                    </asp:TextBox>

                </div>


                <div class="form-group">

                    <label>Remarks</label>

                    <asp:TextBox ID="txtRemarks"
                        runat="server"
                        TextMode="MultiLine"
                        Rows="3"
                        CssClass="form-control">
                    </asp:TextBox>

                </div>

                <div class="tab-actions">

                    <button type="button"
                            class="btn btn-primary"
                            onclick="goTab('tabAttachment')">

                        Next
                        <i class="fa fa-arrow-right"></i>

                    </button>

                </div>

            </div>


            <!-- TAB 2: ATTACHMENT -->
            <div class="tab-pane fade"
                 id="tabAttachment">

                <h4 class="tab-heading">
                    <i class="fa fa-paperclip"></i>
                    Document Attachments
                </h4>

                <div class="form-group">

                    <label>Upload Document</label>

                    <asp:FileUpload ID="fileDocument"
                        runat="server"
                        CssClass="form-control" />

                    <small class="text-muted">
                        PDF, DOC, DOCX, XLS, XLSX
                    </small>

                </div>

                <div class="alert alert-info">
                    <i class="fa fa-info-circle"></i>
                    Uploaded documents will be associated
                    with the selected document record.
                </div>

                <div class="tab-actions">

                    <button type="button"
                            class="btn btn-default"
                            onclick="goTab('tabDetails')">

                        <i class="fa fa-arrow-left"></i>
                        Previous

                    </button>

                    <button type="button"
                            class="btn btn-primary"
                            onclick="goTab('tabApproval')">

                        Next
                        <i class="fa fa-arrow-right"></i>

                    </button>

                </div>

            </div>


            <!-- TAB 3: APPROVAL -->
            <div class="tab-pane fade"
                 id="tabApproval">

                <h4 class="tab-heading">
                    <i class="fa fa-check-circle"></i>
                    Approval Information
                </h4>

                <div class="row">

                    <div class="col-md-6">

                        <div class="form-group">

                            <label>Forward To</label>

                            <asp:DropDownList ID="ddlForwardTo"
                                runat="server"
                                CssClass="form-control">

                                <asp:ListItem Value="">Select Approver</asp:ListItem>
                                <asp:ListItem>RM</asp:ListItem>
                                <asp:ListItem>HOB</asp:ListItem>
                                <asp:ListItem>Unit Head</asp:ListItem>

                            </asp:DropDownList>

                        </div>

                    </div>

                    <div class="col-md-6">

                        <div class="form-group">

                            <label>Priority</label>

                            <asp:DropDownList ID="ddlPriority"
                                runat="server"
                                CssClass="form-control">

                                <asp:ListItem>Normal</asp:ListItem>
                                <asp:ListItem>High</asp:ListItem>
                                <asp:ListItem>Urgent</asp:ListItem>

                            </asp:DropDownList>

                        </div>

                    </div>

                </div>

                <div class="form-group">

                    <label>Approval Remarks</label>

                    <asp:TextBox ID="txtApprovalRemarks"
                        runat="server"
                        TextMode="MultiLine"
                        Rows="3"
                        CssClass="form-control">
                    </asp:TextBox>

                </div>

                <div class="tab-actions">

                    <button type="button"
                            class="btn btn-default"
                            onclick="goTab('tabAttachment')">

                        <i class="fa fa-arrow-left"></i>
                        Previous

                    </button>

                    <button type="button"
                            class="btn btn-primary"
                            onclick="goTab('tabHistory')">

                        Next
                        <i class="fa fa-arrow-right"></i>

                    </button>

                </div>

            </div>


            <!-- TAB 4: HISTORY -->
            <div class="tab-pane fade"
                 id="tabHistory">

                <h4 class="tab-heading">
                    <i class="fa fa-history"></i>
                    Document History
                </h4>

                <div class="table-responsive">

                    <table class="table table-bordered table-hover">

                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Action By</th>
                                <th>Action</th>
                                <th>Remarks</th>
                            </tr>
                        </thead>

                        <tbody>

                            <tr>
                                <td>12-11-2026</td>
                                <td>Administrator</td>
                                <td>
                                    <span class="label label-info">
                                        Created
                                    </span>
                                </td>
                                <td>Document created</td>
                            </tr>

                            <tr>
                                <td>12-11-2026</td>
                                <td>RM</td>
                                <td>
                                    <span class="label label-warning">
                                        Forwarded
                                    </span>
                                </td>
                                <td>Forwarded for approval</td>
                            </tr>

                        </tbody>

                    </table>

                </div>

                <div class="tab-actions">

                    <button type="button"
                            class="btn btn-default"
                            onclick="goTab('tabApproval')">

                        <i class="fa fa-arrow-left"></i>
                        Previous

                    </button>

                </div>

            </div>

        </div>

    </div>


    <!-- MAIN FOOTER -->
    <div class="box-footer text-right">

        <asp:Button ID="btnSave"
            runat="server"
            Text="Save Document"
            CssClass="btn btn-primary"
             />

        <asp:Button ID="btnSubmit"
            runat="server"
            Text="Submit for Approval"
            CssClass="btn btn-success"
            />

        <asp:Button ID="btnReset"
            runat="server"
            Text="Reset"
            CssClass="btn btn-default"
            CausesValidation="false"
             />

    </div>

</div>

</asp:Content>


<asp:Content ID="Content3"
    ContentPlaceHolderID="Scripts"
    runat="server">

    <script type="text/javascript">

        function goTab(tabId) {

            $('a[href="#' + tabId + '"]').tab('show');

        }

    </script>

</asp:Content>
