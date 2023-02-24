using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SAM_register(object sender, EventArgs e)
        {
            Response.Redirect("SAM_register.aspx");
        }

        protected void CR_register(object sender, EventArgs e)
        {
            Response.Redirect("CR_register.aspx");
        }

        protected void SM_register(object sender, EventArgs e)
        {
            Response.Redirect("SM_register.aspx");
        }

        protected void F_register(object sender, EventArgs e)
        {
            Response.Redirect("F_register.aspx");
        }
    }
}