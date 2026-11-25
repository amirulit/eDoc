<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SSCCreation.aspx.cs" Inherits="SSCCreation"   Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content"> <!-- Start of table section -->    
    <div>
        <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
        
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click"></asp:Button>
        <asp:Button ID="btnDownload" runat="server" Text="Centralized Un-Conditional SSC" 
            onclick="btnDownload_Click" />



        <asp:Button ID="btnDownloadCond" runat="server" Text="Centralized Conditional SSC" 
            onclick="btnDownloadCond_Click" />

        <asp:Button ID="btnDownloadUnConDeCenSSC" runat="server" Text="De-Centralized Un-Conditional SSC" 
            onclick="btnDownloadUnConDeCenSSC_Click" />

        <asp:Button ID="btnDownloadConDeCenSSC" runat="server" Text="De-Centralized Conditional SSC" 
            onclick="btnDownloadConDeCenSSC_Click" />
    </div>
    </section>
</asp:Content>

