using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3
{
    public partial class F_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.availableMatchToAttend(@date)", conn);
            // cmd.CommandType=CommandType.StoredProcedure;  
            cmd.Parameters.AddWithValue("@date", DateTime.Now);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            Matches.DataSource = dt;
            Matches.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "purchase")
            {
                string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand getter = new SqlCommand("getID", conn);
                getter.CommandType = CommandType.StoredProcedure;
                getter.Parameters.Add(new SqlParameter("@username", Session["User"]));
                SqlParameter id = getter.Parameters.Add("@ID", SqlDbType.VarChar, 20);
                id.Direction = ParameterDirection.Output;

                conn.Open();
                getter.ExecuteNonQuery();
                conn.Close();

                int crow = Convert.ToInt32(e.CommandArgument.ToString());
                string host = Matches.Rows[crow].Cells[0].Text;
                string visitor = Matches.Rows[crow].Cells[1].Text;
                DateTime start = DateTime.Parse(Matches.Rows[crow].Cells[2].Text);

                SqlCommand buy = new SqlCommand("purchaseTicket", conn);
                buy.CommandType = CommandType.StoredProcedure;
                buy.Parameters.Add(new SqlParameter("@nat_id", id.Value));
                buy.Parameters.Add(new SqlParameter("@host_name", host));
                buy.Parameters.Add(new SqlParameter("@comp_name", visitor));
                buy.Parameters.Add(new SqlParameter("@start_time", start));

                conn.Open();
                buy.ExecuteNonQuery();
                conn.Close();

                message.Text = "Ticket purchased sucessfully";
                message.ForeColor = Color.Green;

                Response.Redirect(Request.RawUrl);
            }
        }
    }
}