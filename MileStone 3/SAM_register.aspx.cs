using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3
{
    public partial class SAM_register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void add_SAM(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = Name.Text;
            String username = Username.Text;
            String password = Password.Text;

            SqlCommand addSAM = new SqlCommand("addAssociationManager", conn);
            addSAM.CommandType = CommandType.StoredProcedure;
            addSAM.Parameters.Add(new SqlParameter("@name", name));
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
    }
}