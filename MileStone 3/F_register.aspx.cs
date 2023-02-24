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
    public partial class F_register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = Name.Text;
            string username = Username.Text;
            string password = Password.Text;
            string natid = natID.Text;
            DateTime d = Calendar1.SelectedDate;
            string Address = address.Text;
            string phoneNumber = phone.Text;

            SqlCommand getter = new SqlCommand("FanExists", conn);
            getter.CommandType = CommandType.StoredProcedure;
            getter.Parameters.Add(new SqlParameter("@nat_id", natid));
            SqlParameter exist = getter.Parameters.Add("@exist", SqlDbType.Int);
            exist.Direction = ParameterDirection.Output;

            conn.Open();
            getter.ExecuteNonQuery();
            conn.Close();

            if (exist.Value.ToString() == "0")
            {
                SqlCommand insert = new SqlCommand("addFan", conn);
                insert.CommandType = CommandType.StoredProcedure;
                insert.Parameters.Add(new SqlParameter("@name", name));
                insert.Parameters.Add(new SqlParameter("@username", username));
                insert.Parameters.Add(new SqlParameter("@password", password));
                insert.Parameters.Add(new SqlParameter("@NationalID", natid));
                insert.Parameters.Add(new SqlParameter("@birthDate", d));
                insert.Parameters.Add(new SqlParameter("@address", Address));
                insert.Parameters.Add(new SqlParameter("@PhoneNumber", phoneNumber));
                conn.Open();
                insert.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("Login.aspx");
            }
            else
            {

                error.Text = "Natinol ID IS not Valid";
                error.ForeColor = Color.Red;
            }


        }
    }
}