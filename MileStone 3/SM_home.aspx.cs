using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MileStone_3
{
    public partial class SM_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
                SqlConnection conn = new SqlConnection(connStr);



                SqlCommand getter = new SqlCommand("getStadium", conn);
                getter.CommandType = CommandType.StoredProcedure;
                getter.Parameters.Add(new SqlParameter("@stadium_manager", Session["user"]));
                SqlParameter id = getter.Parameters.Add("@stadium_ID", SqlDbType.Int);
                SqlParameter name = getter.Parameters.Add("@stadium_name", SqlDbType.VarChar, 20);
                SqlParameter capacity = getter.Parameters.Add("@capacity", SqlDbType.Int);
                SqlParameter location = getter.Parameters.Add("@location", SqlDbType.VarChar, 20);
                SqlParameter status = getter.Parameters.Add("@status", SqlDbType.Int);
                id.Direction = ParameterDirection.Output;
                name.Direction = ParameterDirection.Output;
                capacity.Direction = ParameterDirection.Output;
                location.Direction = ParameterDirection.Output;
                status.Direction = ParameterDirection.Output;
                conn.Open();
                getter.ExecuteNonQuery();
                conn.Close();

                Stadium_ID.Text = "Stadium ID : " + id.Value;
                Stadium_Name.Text = "Stadium Name : " + name.Value;
                Capacity.Text = "Capacity : " + capacity.Value;
                Location.Text = "Location : " + location.Value;
                if (status.Value.ToString() == "1")
                {
                    Status.Text = "Status: Available";
                }
                else
                {
                    Status.Text = "Status: Unavailable";
                }
                SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.allPendingRequests(@username)", conn);
                // cmd.CommandType=CommandType.StoredProcedure;  
                cmd.Parameters.AddWithValue("@username", Session["user"]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                Pending_Requests.DataSource = dt;
                Pending_Requests.DataBind();
           


        }

        protected void Pending_Requests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "accept")
            {
                int crow = Convert.ToInt32(e.CommandArgument.ToString());
                string crName = Pending_Requests.Rows[crow].Cells[0].Text;
                string host = Pending_Requests.Rows[crow].Cells[1].Text;
                string visitor = Pending_Requests.Rows[crow].Cells[2].Text;
                DateTime start = DateTime.Parse(Pending_Requests.Rows[crow].Cells[3].Text);
                DateTime end = DateTime.Parse(Pending_Requests.Rows[crow].Cells[4].Text);

                string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand accept = new SqlCommand("acceptRequest", conn);
                accept.CommandType = CommandType.StoredProcedure;
                accept.Parameters.Add(new SqlParameter("@ManagerUserName", Session["user"]));
                accept.Parameters.Add(new SqlParameter("@HostingName", host));
                accept.Parameters.Add(new SqlParameter("@CompetingName", visitor));
                accept.Parameters.Add(new SqlParameter("@StartTime", start));

                conn.Open();
                accept.ExecuteNonQuery();
                conn.Close();

                Response.Redirect(Request.RawUrl);

            }
            if (e.CommandName == "reject")
            {

                int crow = Convert.ToInt32(e.CommandArgument.ToString());
                string crName = Pending_Requests.Rows[crow].Cells[0].Text;
                string host = Pending_Requests.Rows[crow].Cells[1].Text;
                string visitor = Pending_Requests.Rows[crow].Cells[2].Text;
                DateTime start = DateTime.Parse(Pending_Requests.Rows[crow].Cells[3].Text);
                DateTime end = DateTime.Parse(Pending_Requests.Rows[crow].Cells[4].Text);

                string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand reject = new SqlCommand("rejectRequest", conn);
                reject.CommandType = CommandType.StoredProcedure;
                reject.Parameters.Add(new SqlParameter("@ManagerUserName", Session["user"]));
                reject.Parameters.Add(new SqlParameter("@HostingName", host));
                reject.Parameters.Add(new SqlParameter("@CompetingName", visitor));
                reject.Parameters.Add(new SqlParameter("@StartTime", start));

                conn.Open();
                reject.ExecuteNonQuery();
                conn.Close();

                Response.Redirect(Request.RawUrl);
            }
            else
            {
                Response.Write("hi");
            }

        }
    }

}

