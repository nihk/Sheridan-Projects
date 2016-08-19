// Contributors: Nick Rose
using MovieWiki.Custom_Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace MovieWiki
{
    public class Global : System.Web.HttpApplication
    {
        // These are const strings which were being used in multiple different classes,
        // so we put them in this Global file for easy access
        public const string ActiveUserAccount = "ActiveUserAccount";
        public const string ActiveArticle = "ActiveArticle";
        public const string ShowArticleUrlWithId = "ShowArticle.aspx?id={0}";

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}