<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    Account Title
                </td>
                <td>
                    Facility
                </td>
                <td>
                    Amount
                </td>
                <td>
                    Validity
                </td>
                <td>
                    Purpose
                </td>
                <td>
                    Marign
                </td>
                <td>
                    Tender Type
                </td>
                <td>
                    Interest Rate
                </td>
                <td>
                    No Of Payorder
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtAccTitle" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:DropDownList ID="ddlFacilityType" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
                </td>  <td>
                    
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>  </td>
                <td>
                    <asp:TextBox ID="txtPurpose" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtMargin" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:DropDownList ID="ddlTenderType" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="txtIntRate" runat="server"></asp:TextBox>
                </td>
              
                <td><asp:TextBox ID="txtNofoPO" runat="server"></asp:TextBox>
                     </td>
                     <td>
                                         <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
                                         </td>
                
            </tr>
        </table>
        <br />
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
        <br />
        <table>
            <tr>
                <td>
                    Account Name
                </td>
                <td>
                    Facility Type
                </td>
                <td>
                    Limit
                </td>
                <td>
                    Outstanding
                </td>
                <td>
                    Validity
                </td>
                <td>
                    Overdue
                </td>
                <td>
                    Present Expo
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtAccountName" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:DropDownList ID="ddlFaciliType" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="txtLimit" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="OtxtOutstanding" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtValidity" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtOverDue" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtPresentExpo" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
