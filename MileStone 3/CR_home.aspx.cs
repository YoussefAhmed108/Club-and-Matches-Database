using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MileStone_3
{
    public partial class CR_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
                SqlConnection conn = new SqlConnection(connStr);



                SqlCommand getter = new SqlCommand("getClub", conn);
                getter.CommandType = CommandType.StoredProcedure;
                getter.Parameters.Add(new SqlParameter("@ClubR", Session["user"]));
                SqlParameter id = getter.Parameters.Add("@Club_ID", SqlDbType.Int);
                SqlParameter name = getter.Parameters.Add("@Club_name", SqlDbType.VarChar, 20);
                SqlParameter location = getter.Parameters.Add("@location", SqlDbType.VarChar, 20);
                id.Direction = ParameterDirection.Output;
                name.Direction = ParameterDirection.Output;
                location.Direction = ParameterDirection.Output;
                conn.Open();
                getter.ExecuteNonQuery();
                conn.Close();

                Club_ID.Text = "Club ID : " + id.Value;
                Club_Name.Text = "Club Name : " + name.Value;
                Location.Text = "Location : " + location.Value;
            
                SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.upcomingMatchOfClub(@club_name)", conn);
                // cmd.CommandType=CommandType.StoredProcedure;  
                cmd.Parameters.AddWithValue("@club_name", name.Value);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                UpcomingMatches.DataSource = dt;
                UpcomingMatches.DataBind();
            }
        }


        protected void Send_Req(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);



            SqlCommand getter = new SqlCommand("getClub", conn);
            getter.CommandType = CommandType.StoredProcedure;
            getter.Parameters.Add(new SqlParameter("@ClubR", Session["user"]));
            SqlParameter id = getter.Parameters.Add("@Club_ID", SqlDbType.Int);
            SqlParameter name = getter.Parameters.Add("@Club_name", SqlDbType.VarChar, 20);
            SqlParameter location = getter.Parameters.Add("@location", SqlDbType.VarChar, 20);
            id.Direction = ParameterDirection.Output;
            name.Direction = ParameterDirection.Output;
            location.Direction = ParameterDirection.Output;
            conn.Open();
            getter.ExecuteNonQuery();
            conn.Close();


            SqlCommand addHostReq = new SqlCommand("addHostRequest", conn);
            addHostReq.CommandType = CommandType.StoredProcedure;
            addHostReq.Parameters.Add(new SqlParameter("@club_name", name.Value));
            addHostReq.Parameters.Add(new SqlParameter("@stadium_name", Stadium_Name.Text));
            addHostReq.Parameters.Add(new SqlParameter("@start_time", DateTime.Parse(Start_Time.Text)));
 
            conn.Open();
            addHostReq.ExecuteNonQuery();
            conn.Close();
            Confirm.Text = "Request Sent Succssfully";

        }

        protected void viewStadiums(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            DateTime date = DateTime.Parse(Date.Text);
            Response.Write(date);  
            SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.viewAvailableStadiumsOn(@date)", conn);
            // cmd.CommandType=CommandType.StoredProcedure;  
            cmd.Parameters.AddWithValue("@date", date);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            availableStadiums.DataSource = dt;
            availableStadiums.DataBind();
        }
    }
}