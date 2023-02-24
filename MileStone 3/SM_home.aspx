<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SM_home.aspx.cs" Inherits="MileStone_3.SM_home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 113px;
            width: 677px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 675px">
            <asp:Label ID="Stadium_ID" runat="server" Text=""></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Location" runat="server" Text=""></asp:Label>
            &nbsp;<br />
            <br />
            <asp:Label ID="Stadium_Name" runat="server" Text=""></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Status" runat="server" Text=""></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Label ID="Capacity" runat="server" Text=""></asp:Label>
            <br />
        </div>
         <br />
            <br />
        <asp:Label ID="Label1" runat="server" Text="My Pending Requests:"></asp:Label>
            <asp:GridView ID="Pending_Requests" runat="server" AutoGenerateColumns="False" OnRowCommand="Pending_Requests_RowCommand" >
                <Columns>
                    <asp:BoundField DataField ="ClubRepresentativeName" HeaderText ="ClubRepresentativeName" />
                    <asp:BoundField DataField ="Host" HeaderText ="Host" />
                    <asp:BoundField DataField ="Visitor" HeaderText ="Visitor" />
                    <asp:BoundField DataField ="StartTime" HeaderText ="StartTime" />
                    <asp:BoundField DataField ="EndTime" HeaderText ="EndTime" />
                    <asp:ButtonField Text="Accept" ButtonType="Button" CommandName="accept"  >
                    <ControlStyle BackColor="#66FF33" />
                    </asp:ButtonField>
                    <asp:ButtonField ButtonType="Button" CommandName="reject" Text="Reject">
                    <ControlStyle BackColor="#FF3300" />
                    </asp:ButtonField>
                </Columns>
                 
            </asp:GridView>
            <br />
    </form>
</body>
</html>
