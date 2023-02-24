<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CR_register.aspx.cs" Inherits="MileStone_3.CR_register" %>

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
            <asp:TextBox ID="Name" runat="server"></asp:TextBox>
        </p>
        Username<p>
            <asp:TextBox ID="Username" runat="server"></asp:TextBox>
        </p>
        Password<p>
            <asp:TextBox ID="Password" runat="server"></asp:TextBox>
        </p>
        Club Name<p>
            <asp:TextBox ID="ClubName" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="SignUp" runat="server" OnClick ="add_CR" Height="46px" Text="Register" Width="170px" />
    </form>
</body>
</html>
