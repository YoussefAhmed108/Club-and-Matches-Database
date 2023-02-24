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
    public partial class CR_register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {




        }

        protected void add_CR(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = Name.Text;
            String username = Username.Text;
            String password = Password.Text;
            String Club = ClubName.Text;

            SqlCommand clubExist = new SqlCommand("Clubexists", conn);
            clubExist.CommandType = CommandType.StoredProcedure;
            clubExist.Parameters.Add(new SqlParameter("@club", Club));
            SqlParameter found = clubExist.Parameters.Add("@Exist", SqlDbType.Int);
            found.Direction = ParameterDirection.Output;
            conn.Open();
            clubExist.ExecuteNonQuery();
            conn.Close();
            if (found.Value.ToString() == "1")
            {
                SqlCommand addCR = new SqlCommand("addRepresentative", conn);
                addCR.CommandType = CommandType.StoredProcedure;
                addCR.Parameters.Add(new SqlParameter("@name", name));
                addCR.Parameters.Add(new SqlParameter("@club_name", Club));
                addCR.Parameters.Add(new SqlParameter("@username", username));
                addCR.Parameters.Add(new SqlParameter("@password", password));

                SqlParameter done = addCR.Parameters.Add("@done", SqlDbType.Int);
                done.Direction = ParameterDirection.Output;
                conn.Open();
                addCR.ExecuteNonQuery();
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
                Response.Write("Club doesnt exist or already has a representative");
            }
        }
        }


            
   }
