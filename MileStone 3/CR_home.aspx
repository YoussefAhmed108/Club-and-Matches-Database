<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CR_home.aspx.cs" Inherits="MileStone_3.CR_home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Club_ID" runat="server" Text=""></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Label ID="Club_Name" runat="server" Text=""></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Label ID="Location" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="My Upcoming Matches : "></asp:Label>
        </div>
        <asp:GridView ID="UpcomingMatches" runat="server" AutoGenerateColumns="False">
            <Columns>
                    <asp:TemplateField HeaderText="Host">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Host") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Visitor">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Visitor") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="StartTime">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("StartTime") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EndTime">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("EndTime") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <asp:Label ID="Label7" runat="server" Text="Available Stadiums to Reserve : "></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:GridView ID="availableStadiums" runat="server"  AutoGenerateColumns="false">
             <Columns>
                 <asp:BoundField DataField ="StadiumName" HeaderText ="Stadium Name" />
                 <asp:BoundField DataField ="StadiumLocation" HeaderText ="Location" />
                  <asp:BoundField DataField ="Capacity" HeaderText ="Capacity" />
             </Columns>
             
        </asp:GridView>
        <br />
        <asp:Label ID="Label8" runat="server" Text="Enter a date : "></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="Date" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" Text="View Stadiums" OnClick="viewStadiums" />
        <br />
        <br />
        <br />
        <asp:Label ID="Label9" runat="server" Text="Send A Request : "></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Stadium Name"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="Stadium_Name" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Start Time"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="Start_Time" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Height="51px" Text="Send Request" Width="180px" OnClick="Send_Req" />
        &nbsp;&nbsp;&nbsp;
        <br />
        <asp:Label ID="Confirm" runat="server" Text=""></asp:Label>
        <br />
    </form>
</body>
</html>
