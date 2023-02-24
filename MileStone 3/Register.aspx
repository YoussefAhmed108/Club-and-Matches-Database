<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MileStone_3.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" OnClick="SAM_register" Height="117px" Text="Sports Association Manager" Width="284px" />
            <asp:Button ID="Button2" runat="server" OnClick="CR_register" Height="119px" Text="Club Representative" Width="280px" />
        </div>
        <p>
            <asp:Button ID="Button3" runat="server" OnClick="SM_register" Height="120px" style="margin-right: 0px" Text="Stadium Manager" Width="281px" />
            <asp:Button ID="Button4" runat="server" OnClick="F_register" Height="121px" Text="Fan" Width="281px" />
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
