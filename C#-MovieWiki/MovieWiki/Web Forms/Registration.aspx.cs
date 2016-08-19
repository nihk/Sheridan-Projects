//Contributors: Lei Wang, Nick Rose

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using MovieWiki.Custom_Classes;

namespace MovieWiki.Web_Forms
{
    // web form allows user access to application if they dont already have have
    // log in credentials
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // makes sure user does not exist before adding them to UserAccount class and within database
        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            var username = txtCreateUsername.Text;
            var hashedPassword = PasswordHelper.GetHashedPassword(txtCreatePassword.Text);

            if (MovieWikiDbHelper.InsertUserAccount(username, hashedPassword))
            {
                Session[Global.ActiveUserAccount] = MovieWikiDbHelper.GetUserAccount(username, hashedPassword);
                Response.Redirect("Default.aspx");
            }
            else
            {
                lblCreateAccountErrorMsg.Text = string.Format(@"The account ""{0}"" already exists", username);
            }
        }

        protected void btnCancelCreateAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnSignIn_ServerClick(object sender, EventArgs e)
        {

            Response.Redirect("Login.aspx");
        }
    }
}