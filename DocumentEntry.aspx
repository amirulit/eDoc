
<%@ Page Title="New Document" Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="DocumentEntry.aspx.cs"
    Inherits="DocumentEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle"
    runat="server">
    New Document
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="box box-primary">

        <div class="box-header with-border">

            <h3 class="box-title">
                <i class="fa fa-file-text-o"></i>
                Document Information
            </h3>

        </div>


        <div class="box-body">

            <div class="row">

                <div class="col-md-6">

                    <div class="form-group">

                        <label>Document Type <span style="color:red">*</span></label>

                        <asp:DropDownList ID="ddlDocumentType"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Value="">-- Select Type --</asp:ListItem>
                            <asp:ListItem>Office Memo</asp:ListItem>
                            <asp:ListItem>Loan Proposal</asp:ListItem>
                            <asp:ListItem>Credit Proposal</asp:ListItem>
                            <asp:ListItem>Agreement</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>

                        </asp:DropDownList>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="form-group">

                        <label>Reference Number</label>

                        <asp:TextBox ID="txtReference"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Document Reference Number">
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
                            CssClass="form-control"
                            TextMode="Date">
                        </asp:TextBox>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="form-group">

                        <label>Department</label>

                        <asp:DropDownList ID="ddlDepartment"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Value="">-- Select Department --</asp:ListItem>
                            <asp:ListItem>CAD</asp:ListItem>
                            <asp:ListItem>Credit (SME)</asp:ListItem>
                            <asp:ListItem>Credit (Corporate)</asp:ListItem>
                            <asp:ListItem>Credit (Retail)</asp:ListItem>
                            <asp:ListItem>Credit (Agri)</asp:ListItem>

                        </asp:DropDownList>

                    </div>

                </div>

            </div>


            <div class="form-group">

                <label>Subject</label>

                <asp:TextBox ID="txtSubject"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Enter document subject">
                </asp:TextBox>

            </div>


            <div class="form-group">

                <label>Remarks</label>

                <asp:TextBox ID="txtRemarks"
                    runat="server"
                    CssClass="form-control"
                    TextMode="MultiLine"
                    Rows="4"
                    placeholder="Enter remarks">
                </asp:TextBox>

            </div>


            <div class="form-group">

                <label>Upload Document</label>

                <asp:FileUpload ID="fileDocument"
                    runat="server"
                    CssClass="form-control" />

                <small class="text-muted">
                    Allowed formats: PDF, DOC, DOCX, XLS, XLSX.
                    Apply server-side file type and size validation.
                </small>

            </div>

        </div>


        <div class="box-footer">

            <asp:Button ID="btnSave"
                runat="server"
                Text="Save Document"
                CssClass="btn btn-primary"
                 />

            <asp:Button ID="btnReset"
                runat="server"
                Text="Reset"
                CssClass="btn btn-default"
                CausesValidation="false"
                />

            <a href="DocumentList.aspx"
               class="btn btn-success pull-right">
                <i class="fa fa-list"></i>
                View Documents
            </a>

        </div>

    </div>

</asp:Content>
