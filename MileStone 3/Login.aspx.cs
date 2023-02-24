using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["projectStadium"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = Username.Text;
            String password = Password.Text;

            Session["User"] = username;

            SqlCommand login = new SqlCommand("CredinitialVerficaftion", conn);
            login.CommandType= CommandType.StoredProcedure;
            login.Parameters.Add(new SqlParameter("@username", username));
            login.Parameters.Add(new SqlParameter("@password", password));
            SqlParameter verfication = login.Parameters.Add("@Result", SqlDbType.Int);
            SqlParameter type = login.Parameters.Add("@type", SqlDbType.VarChar, 20);
            verfication.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;
            conn.Open();
            login.ExecuteNonQuery();
            conn.Close();
            if (verfication.Value.ToString() == "1")
            {
                if(type.Value.ToString() == "SA")
                {
                    Response.Redirect("SA_home.aspx");
                }
                else
                {
                    if(type.Value.ToString() == "SAM")
                    {
                        Response.Redirect("SAM_home.aspx");
                    }
                    else
                    {
                        if(type.Value.ToString() == "CR")
                        {
                            Response.Redirect("CR_home.aspx");
                        }
                        else
                        {
                            if(type.Value.ToString() == "SM")
                            {
                                Response.Redirect("SM_home.aspx");
                            }
                            else
                            {
                                SqlCommand block = new SqlCommand("isBlocked", conn);
                                block.CommandType = CommandType.StoredProcedure;
                                block.Parameters.Add(new SqlParameter("@username", username));
                                SqlParameter isBlocked = block.Parameters.Add("@blocked", SqlDbType.Int);
                                isBlocked.Direction = ParameterDirection.Output;
                                conn.Open();
                                block.ExecuteNonQuery();
                                conn.Close();
                                if (isBlocked.Value.ToString() == "1")
                                {
                                    Response.Redirect("F_home.aspx");
                                }
                                else
                                {
                                    error.Text = "You are Blocked";
                                }
                                
                            }
                        }
                    }
                }
            }
            else
            {
                Response.Write("Invalid Username or Password");
            }
           


        }

        protected void Register(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}