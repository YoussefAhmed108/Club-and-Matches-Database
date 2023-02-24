<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM_register.aspx.cs" Inherits="MileStone_3.SAM_register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name</div>
        <p>
            <asp:TextBox ID="Name" runat="server" style="margin-top: 2px; margin-bottom: 0px"></asp:TextBox>
        </p>
        <p>
            Username</p>
        <p>
            <asp:TextBox ID="Username" runat="server"></asp:TextBox>
        </p>
        <p>
            Password</p>
        <p>
            <asp:TextBox ID="Password" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="add_SAM" Height="56px" Text="Register" Width="153px" />
        </p>
    </form>
</body>
</html>
