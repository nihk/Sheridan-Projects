//Contributors: Lei Wang, Noe Ascenio, Nick Rose

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MovieWiki.Custom_Classes;

namespace MovieWiki.Web_Forms
{
    // default webform for the application
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PromptLogin();
            }
        }

        // If the user isn't logged in, then prompt a login
        private void PromptLogin()
        {
            var sessUserAccount = Session[Global.ActiveUserAccount];
            if (sessUserAccount == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                var userAccount = sessUserAccount as UserAccount;
                lblWelcome.Text = string.Format("Welcome to MovieWiki, <b>{0}</b>.", userAccount.Username);
            }
        }

        // Shows all contributions a user made to articles
        public void DisplayAccountInformation()
        {
            // Creates UserAccount object
            var activeUser = Session[Global.ActiveUserAccount] as UserAccount;
            lblGreeting.Text = string.Format("Account details for: <b>{0}</b>", activeUser.Username);

            // Retrieves links to articles that have ever changed
            var userArticleEdits = from edit in MovieWikiDbHelper.AllWikiArticleEditHistories
                                   join article in MovieWikiDbHelper.AllWikiArticles
                                   on edit.ArticleId equals article.ArticleId
                                   where edit.AccountId == activeUser.AccountId
                                   orderby edit.EditTimestamp descending
                                   select new { Article = article, Edit = edit };

            lblArticleEdits.Visible = userArticleEdits.Count() > 0;

            // creates links to articles related to UserAccount
            foreach (var userArticleEdit in userArticleEdits)
            {
                var hyperLinkText = userArticleEdit.Article.Title;
                var timeStampLabel = new Label { Text = string.Format(" {0}, {1}",
                    userArticleEdit.Edit.EditTimestamp.ToShortDateString(), userArticleEdit.Edit.EditTimestamp.ToLongTimeString()) };
                var hyperLink = WebControlBuilder.BuildHyperLink(hyperLinkText,
                    string.Format(Global.ShowArticleUrlWithId, userArticleEdit.Article.ArticleId));
                pUserEdits.Controls.Add(hyperLink);
                pUserEdits.Controls.Add(timeStampLabel);
                pUserEdits.Controls.Add(new LiteralControl("<br />"));
            }
        }

        // nav bar event handlers
        // remove user from session and redirects until login screen
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session[Global.ActiveUserAccount] = null;
            Response.Redirect("Default.aspx");
        }

        // search event redirects to ShowArticle.aspx with Wiki Article to display
        protected void btnsearchbtn_Click(object sender, EventArgs e)
        {
            // redirection to specific WikiArticle if found in static class
            var searchResultUrl = MovieWikiDbHelper.GetWikiArticleUrlBySearch(searchInput.Text);
            if (searchResultUrl != null)
            {              
                Response.Redirect(searchResultUrl);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal('show');", true);
                upModal.Update();
                
            }
        }

        // Fire bootstrap events to display a modal
        protected void showAccountInfo_ServerClick(object sender, EventArgs e)
        {
            DisplayAccountInformation();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "AccountModal", "$('#AccountModal').modal();", true);
            updateAccount.Update();
        }

        protected void showRecentModal_ServerClick(object sender, EventArgs e)
        {
            DisplayRecentArticles();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "RecentModal", "$('#RecentModal').modal();", true);
            upRecentModal.Update();
        }

        // Shows at most 10 recent articles created on MovieWiki
        private void DisplayRecentArticles()
        {
            // retrieves last 10 articles created
            var recentArticles = (from edit in MovieWikiDbHelper.AllWikiArticleEditHistories
                                  join article in MovieWikiDbHelper.AllWikiArticles
                                  on edit.ArticleId equals article.ArticleId
                                  orderby edit.EditTimestamp descending
                                  select article).Distinct().Take(10);
            
            int result = recentArticles.Count();
            
            // Formats modal to display recent article informaiton
            lblRecentEdits.Text = recentArticles.Count() > 0
                ? result + " articles most recently contributed to:"
                : "No articles were created yet";

            foreach (var recentArticle in recentArticles)
            {
                var hyperLinkText = recentArticle.Title;
                var hyperLink = WebControlBuilder.BuildHyperLink(hyperLinkText,
                    string.Format(Global.ShowArticleUrlWithId, recentArticle.ArticleId));
                pUserEditsRecent.Controls.Add(hyperLink);
                pUserEditsRecent.Controls.Add(new LiteralControl("<br />"));
            }
        }
    }
}