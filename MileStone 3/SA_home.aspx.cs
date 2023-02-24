using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Drawing;
using System.Xml.Linq;

namespace MileStone_3
{
    public partial class SA_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = "WELCOME " + Session["User"];
        }

        protected void addClub(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string club = Cname.Text;
            string loc = Clocation.Text;

            SqlCommand getter = new SqlCommand("Clubexists", conn);
            getter.CommandType = CommandType.StoredProcedure;
            getter.Parameters.Add(new SqlParameter("@club", club));
            SqlParameter exist = getter.Parameters.Add("@Exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            conn.Open();
            getter.ExecuteNonQuery();
            conn.Close();

            if(exist.Value.ToString() == "1")
            {
                errorAdd.Text = "Club with that name already exists";
                errorAdd .ForeColor = Color.Red;
            }
            else
            {
                SqlCommand insert = new SqlCommand("addClub", conn);
                insert.CommandType = CommandType.StoredProcedure;
                insert.Parameters.Add(new SqlParameter("@club_name", club));
                insert.Parameters.Add(new SqlParameter("@location", loc));
                conn.Open();
                insert.ExecuteNonQuery();
                conn.Close();
            }
        }

        protected void DeleteClub(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string club = Cname2.Text;

            SqlCommand getter = new SqlCommand("Clubexists", conn);
            getter.CommandType = CommandType.StoredProcedure;
            getter.Parameters.Add(new SqlParameter("@club", club));
            SqlParameter exist = getter.Parameters.Add("@Exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            conn.Open();
            getter.ExecuteNonQuery();
            conn.Close();

            if (exist.Value.ToString() == "0")
            {
                errorDelete.Text = "Club you are trying to delete doesnt exist";
                errorDelete.ForeColor = Color.Red;
            }
            else
            {
                SqlCommand insert = new SqlCommand("deleteClub", conn);
                insert.CommandType = CommandType.StoredProcedure;
                insert.Parameters.Add(new SqlParameter("@club_name", club));
                conn.Open();
                insert.ExecuteNonQuery();
                conn.Close();

                errorDelete.Text = "Club deleted succesfully";
                errorDelete.ForeColor = Color.Green;
            }
        }

        protected void addStadium(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = StadiumName.Text;
            string loc = StadiumLocation.Text;
            int capacity = Convert.ToInt32(StadiumCapacity.Text);

            SqlCommand getter = new SqlCommand("Stadiumexists", conn);
            getter.CommandType = CommandType.StoredProcedure;
            getter.Parameters.Add(new SqlParameter("@stadium", name));
            SqlParameter exist = getter.Parameters.Add("@Exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            conn.Open();
            getter.ExecuteNonQuery();
            conn.Close();

            if (exist.Value.ToString() == "1")
            {
                erroraddStadium.Text ="Stadium you are trying to add already exists";
                erroraddStadium.ForeColor = Color.Red;
            }
            else
            {
                SqlCommand insert = new SqlCommand("addStadium", conn);
                insert.CommandType = CommandType.StoredProcedure;
                insert.Parameters.Add(new SqlParameter("@stadium_name", name));
                insert.Parameters.Add(new SqlParameter("@location", loc));
                insert.Parameters.Add(new SqlParameter("@capacity", capacity));
                conn.Open();
                insert.ExecuteNonQuery();
                conn.Close();

                erroraddStadium.Text = "Stadium added succuesfully";
                erroraddStadium.ForeColor = Color.Green;
            }
        }

        protected void deleteStadium(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = StadiumName2.Text;

            SqlCommand getter = new SqlCommand("Stadiumexists", conn);
            getter.CommandType = CommandType.StoredProcedure;
            getter.Parameters.Add(new SqlParameter("@stadium", name));
            SqlParameter exist = getter.Parameters.Add("@Exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            conn.Open();
            getter.ExecuteNonQuery();
            conn.Close();

            if (exist.Value.ToString() == "0")
            {
                erroraddStadium.Text = "Stadium you are trying to delete doesnt exist";
                erroraddStadium.ForeColor = Color.Red;
            }
            else
            {
                SqlCommand insert = new SqlCommand("deleteStadium", conn);
                insert.CommandType = CommandType.StoredProcedure;
                insert.Parameters.Add(new SqlParameter("@stadium_name", name));
                conn.Open();
                insert.ExecuteNonQuery();
                conn.Close();

                errorStadium.Text = "Stadium deleted succuesfully";
                errorStadium.ForeColor = Color.Green;
            }
        }

        protected void blockFan(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string natID = NatID.Text;

            SqlCommand getter = new SqlCommand("FanExists", conn);
            getter.CommandType = CommandType.StoredProcedure;
            getter.Parameters.Add(new SqlParameter("@nat_id", natID));
            SqlParameter exist = getter.Parameters.Add("@exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            conn.Open();
            getter.ExecuteNonQuery();
            conn.Close();

            if (exist.Value.ToString() == "0")
            {
                errorFan.Text = "Fan you are trying to block doesnt exist";
                errorFan.ForeColor = Color.Red;
            }
            else
            {
                SqlCommand insert = new SqlCommand("blockFan", conn);
                insert.CommandType = CommandType.StoredProcedure;
                insert.Parameters.Add(new SqlParameter("@nat_id", natID));
                conn.Open();
                insert.ExecuteNonQuery();
                conn.Close();

                errorFan.Text = "Fan blocked succuesfully";
                errorFan.ForeColor = Color.Green;
            }
        }
    }
}