<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM_home.aspx.cs" Inherits="MileStone_3.SAM_home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label14" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Add a New Match : "></asp:Label>
&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Host"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Host2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label4" runat="server" Text="Start Time"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Start" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Visitor"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Visitor2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label5" runat="server" Text="End Time"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="End" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="addMatch" Height="45px" Text="Add Match" Width="132px" />
            &nbsp;&nbsp;&nbsp;
            <asp:Label ID="error2" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Delete Match :"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label7" runat="server" Text="Host"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Host" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label9" runat="server" Text="Start Time"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Start_Time" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label8" runat="server" Text="Visitor"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Visitor" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label10" runat="server" Text="End Time"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="End_Time" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="deleteMatch" Height="43px" Text="Delete Match" Width="134px" />
            &nbsp;&nbsp;&nbsp;
            <asp:Label ID="error" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" Text="All Upcoming Matches : "></asp:Label>
            <br />
            <asp:GridView ID="AllUpcomingMatches" runat="server" AutoGenerateColumns="false">
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
            <asp:Label ID="Label12" runat="server" Text="All Played Matches : "></asp:Label>
            <br />
            <asp:GridView ID="AllPlayedMatches" runat="server" AutoGenerateColumns="false">
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
            <asp:Label ID="Label13" runat="server" Text="Clubs Never Played : "></asp:Label>
            <br />
            <br />
            <asp:GridView ID="ClubsNeverPlayed" runat="server" AutoGenerateColumns ="false">
                <Columns>
                    <asp:BoundField DataField ="Host" HeaderText ="Host" />
                 <asp:BoundField DataField ="Visitor" HeaderText ="Visitor" />
                </Columns>
            </asp:GridView>
            <br />
        </div>
    </form>
</body>
</html>
