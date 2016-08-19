//Contributors: Lei Wang, Nick Rose

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using MovieWiki.Custom_Classes;

namespace MovieWiki.Web_Forms
{
    // web form is the login page for the applicaition always redirect here if not logged in
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If the user is already logged in, redirect to the homepage
            if (Session[Global.ActiveUserAccount] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        // uses helper classes to check if user exist in database
        // redirects if user exist to home page or displays erro message
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            var username = txtUsername.Text;
            var hashedPassword = PasswordHelper.GetHashedPassword(txtPassword.Text);
            var userAccount = MovieWikiDbHelper.GetUserAccount(username, hashedPassword);

            if (userAccount != null)
            {
                Session[Global.ActiveUserAccount] = userAccount;
                Response.Redirect("Default.aspx");
            }
            else
            {
                lblErrorMsg.Text = string.Format(@"Incorrect password for user ""{0}.""", username);
            }
        }
        
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registration.aspx");
        }
    }
}