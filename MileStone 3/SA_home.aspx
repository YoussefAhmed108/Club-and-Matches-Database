<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SA_home.aspx.cs" Inherits="MileStone_3.SA_home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Add Club"></asp:Label>
            <br />
            <br />
        </div>
        <asp:Label ID="Label12" runat="server" Text="Club Name : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="Cname" runat="server"></asp:TextBox>
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <asp:Label ID="Label13" runat="server" Text="Location : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="Clocation" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="addClub" Text="Add Club" Height="38px" Width="121px" />
        &nbsp;&nbsp;&nbsp;
        <asp:Label ID="errorAdd" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Delete Club : "></asp:Label>
        <br />
        <br />
&nbsp;<asp:Label ID="Label14" runat="server" Text="Club Name : "></asp:Label>
&nbsp;&nbsp;
        <asp:TextBox ID="Cname2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" OnClick ="DeleteClub" Text="Delete Club" />
        <br />
        <asp:Label ID="errorDelete" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Add Stadium : "></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Stadium Name : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="StadiumName" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label7" runat="server" Text="Location : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="StadiumLocation" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Capacity : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="StadiumCapacity" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button3" runat="server" OnClick="addStadium" Text="Add Stadium" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="erroraddStadium" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="Delete Stadium : "></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label9" runat="server" Text="Stadium Name : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="StadiumName2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button4" runat="server" OnClick="deleteStadium" Text="Delete Stadium " />
        <br />
        <asp:Label ID="errorStadium" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label ID="Label10" runat="server" Text="Block Fan : "></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label11" runat="server" Text="Natinol ID : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="NatID" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button5" runat="server" OnClick="blockFan" Text="Block Fan" />
        <br />
        <asp:Label ID="errorFan" runat="server" Text=""></asp:Label>
    </form>
</body>
</html>
