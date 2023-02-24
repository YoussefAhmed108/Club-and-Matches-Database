using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace MileStone_3
{
    public partial class SAM_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
                string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
                SqlConnection conn = new SqlConnection(connStr);


                SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.allupcomingMatches()", conn);
                // cmd.CommandType=CommandType.StoredProcedure;  
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                AllUpcomingMatches.DataSource = dt;
                AllUpcomingMatches.DataBind();

                SqlCommand cmd2 = new SqlCommand("SELECT * FROM dbo.allPlayedMatches()", conn);
                // cmd.CommandType=CommandType.StoredProcedure;  
                SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
                DataTable dt2 = new DataTable();
                da2.Fill(dt2);
                AllPlayedMatches.DataSource = dt2;
                AllPlayedMatches.DataBind();

                SqlCommand cmd3 = new SqlCommand("SELECT * FROM clubsNeverMatched", conn);
                // cmd.CommandType=CommandType.StoredProcedure;  
                SqlDataAdapter da3 = new SqlDataAdapter(cmd3);
                DataTable dt3 = new DataTable();
                da3.Fill(dt3);
                ClubsNeverPlayed.DataSource = dt3;
                ClubsNeverPlayed.DataBind();

            
        }

        protected void deleteMatch(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String host = Host.Text;
            String visitor = Visitor.Text;
            String start = Start_Time.Text;
            String end = End_Time.Text;
            SqlCommand checker = new SqlCommand("Matchexists", conn);
            checker.CommandType = CommandType.StoredProcedure;
            checker.Parameters.Add(new SqlParameter("@host_name", host));
            checker.Parameters.Add(new SqlParameter("@visitor_name", visitor));
            checker.Parameters.Add(new SqlParameter("@start_time",DateTime.Parse(start)));
            checker.Parameters.Add(new SqlParameter("@end_time", DateTime.Parse(end)));
            SqlParameter exist = checker.Parameters.Add("@Exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            conn.Open();
            checker.ExecuteNonQuery();
            conn.Close();

            if (exist.Value.ToString() == "1")
            {
                SqlCommand getter = new SqlCommand("deleteMatch", conn);
                getter.CommandType = CommandType.StoredProcedure;
                getter.Parameters.Add(new SqlParameter("@host_name", host));
                getter.Parameters.Add(new SqlParameter("@guest_club", visitor));
                getter.Parameters.Add(new SqlParameter("@start_time", DateTime.Parse(start)));
                getter.Parameters.Add(new SqlParameter("@end_time", DateTime.Parse(end)));
                conn.Open();
                getter.ExecuteNonQuery();
                conn.Close();
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                error.Text = "The Match you are trying to delete doesnt exist";
                error.ForeColor = Color.Red;
            }

            
        }

        protected void addMatch(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String host = Host2.Text;
            String visitor = Visitor2.Text;
            String start = Start.Text;
            String end = End.Text;

            SqlCommand checker = new SqlCommand("Clubexists", conn);
            checker.CommandType= CommandType.StoredProcedure;
            checker.Parameters.Add(new SqlParameter("@club", host));
            SqlParameter exist = checker.Parameters.Add("@Exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            SqlCommand checker2 = new SqlCommand("Clubexists", conn);
            checker2.CommandType = CommandType.StoredProcedure;
            checker2.Parameters.Add(new SqlParameter("@club", visitor));
            SqlParameter exist2 = checker2.Parameters.Add("@Exist", SqlDbType.Int);
            exist2.Direction = ParameterDirection.Output;

            conn.Open();
            checker.ExecuteNonQuery();
            checker2.ExecuteNonQuery();
            conn.Close();

            if (exist.Value.ToString() == "1" && exist2.Value.ToString() == "1")
            {
                SqlCommand getter = new SqlCommand("addNewMatch", conn);
                getter.CommandType = CommandType.StoredProcedure;
                getter.Parameters.Add(new SqlParameter("@host_name", host));
                getter.Parameters.Add(new SqlParameter("@guest_club", visitor));
                getter.Parameters.Add(new SqlParameter("@start_time", DateTime.Parse(start)));
                getter.Parameters.Add(new SqlParameter("@end_time", DateTime.Parse(end)));
                conn.Open();
                getter.ExecuteNonQuery();
                conn.Close();

                error2.Text = "Match added sucessfully";
                error.ForeColor = Color.Green;
            }
            else
            {
                error2.Text = "Club doesnt exist";
                error.ForeColor = Color.Red;
            }
        }
    }
}