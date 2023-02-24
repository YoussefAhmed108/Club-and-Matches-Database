using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using static System.Web.UI.WebControls.DataControlField;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Security.Policy;
using System.Drawing;

namespace MileStone_3
{
    public partial class SM_register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void add_SM(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = Name.Text;
            String username = Username.Text;
            String password = Password.Text;
            String Sname = Stadium_Name.Text;

            SqlCommand clubExist = new SqlCommand("stadiumExists", conn);
            clubExist.CommandType = CommandType.StoredProcedure;
            clubExist.Parameters.Add(new SqlParameter("@stadium", Sname ));
            SqlParameter found = clubExist.Parameters.Add("@Exist", SqlDbType.Int);
            found.Direction = ParameterDirection.Output;
            conn.Open();
            clubExist.ExecuteNonQuery();
            conn.Close();
            if (found.Value.ToString() == "1")
            {
                SqlCommand addSAM = new SqlCommand("addStadiumManager", conn);
                addSAM.CommandType = CommandType.StoredProcedure;
                addSAM.Parameters.Add(new SqlParameter("@name", name));
                addSAM.Parameters.Add(new SqlParameter("@StadiumName", Sname));
                addSAM.Parameters.Add(new SqlParameter("@username", username));
                addSAM.Parameters.Add(new SqlParameter("@password", password));
                SqlParameter done = addSAM.Parameters.Add("@done", SqlDbType.Int);
                done.Direction = ParameterDirection.Output;
                conn.Open();
                addSAM.ExecuteNonQuery();
                conn.Close();
                if (done.Value.ToString() == "1")
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    Response.Write("Username already taken");
                }
            }
            else
            {
                stadium_error.Text = "Stadium doesnt exist or already has a manager";
                stadium_error.ForeColor = Color.Red;
            }
        }
    }
}