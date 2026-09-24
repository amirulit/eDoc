<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SSCCreation.aspx.cs" Inherits="CAD.DataAccess.SSCCreation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content"> <!-- Start of table section -->    
    <div>
        <asp:Button ID="btnDownload" runat="server" Text="Centralized Un-Conditional SSC" 
            onclick="btnDownload_Click" />

        <asp:Button ID="btnDownloadCond" runat="server" Text="Centralized Conditional SSC" 
            onclick="btnDownloadCond_Click" />
    </div>
    </section>
</asp:Content>

