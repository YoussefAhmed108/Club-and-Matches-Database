<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="F_home.aspx.cs" Inherits="MileStone_3.F_home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
            <br />
        </div>
        <asp:GridView ID="Matches" runat="server" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand">
            <Columns>
                    <asp:BoundField DataField ="Host" HeaderText ="Host" />
                    <asp:BoundField DataField ="Visitor" HeaderText ="Visitor" />
                    <asp:BoundField DataField ="StartTime" HeaderText ="StartTime" />
                    <asp:BoundField DataField ="StadiumName" HeaderText ="Stadium Name" />
                    <asp:ButtonField Text="Purchase Ticket" ButtonType="Button" CommandName="purchase">
                        </asp:ButtonField>
            </Columns>
        </asp:GridView>
        <br />
        <asp:Label ID="message" runat="server" Text=""></asp:Label>
    </form>
</body>
</html>
