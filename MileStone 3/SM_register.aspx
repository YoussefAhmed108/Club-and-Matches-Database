<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SM_register.aspx.cs" Inherits="MileStone_3.SM_register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
        </div>
        <p>
            <asp:TextBox ID="Name" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label2" runat="server" Text="Username"></asp:Label>
        <p>
            <asp:TextBox ID="Username" runat="server"></asp:TextBox>
            <asp:Label ID="user_error" runat="server" Text=""></asp:Label>
        </p>
        <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
        <p>
            <asp:TextBox ID="Password" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label4" runat="server" Text="Stadium Name"></asp:Label>
        <p>
            <asp:TextBox ID="Stadium_Name" runat="server"></asp:TextBox>
            <asp:Label ID="stadium_error" runat="server" Text=""></asp:Label>
        </p>
        <asp:Button ID="Button1" runat="server" OnClick ="add_SM" Height="49px" Text="Register" Width="131px" />
    </form>
</body>
</html>
