 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MileStone_3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="margin-bottom: 197px">
    <form id="form1" runat="server">
        <div>
            Username:</div>
        <p> 
            <asp:TextBox ID="Username" runat="server" required ="true"></asp:TextBox>
        </p>
        <p>
            Password:</p>
        <p>
            <asp:TextBox ID="Password" runat="server" required ="true"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Submit" runat="server" OnClick="login" Text="Login" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="error" runat="server" Text=""></asp:Label>
        </p>
        
        <asp:Button ID="Button1" runat="server" OnClick="Register" Text="SIGN UP" />
        
    </form>
</body>
</html>
