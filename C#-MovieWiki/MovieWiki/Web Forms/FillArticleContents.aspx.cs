//Contributors: Lei Wang, Noe Ascenio, Nick Rose

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MovieWiki.Custom_Classes;
using System.Xml.Linq;

namespace MovieWiki.Web_Forms
{
    // webform is created dynamically from options choosen in ChooseArticleToCreate webform
    public partial class FillArticleContents : System.Web.UI.Page
    {
        private ArticleFactory _articleFactory = new ArticleFactory();
        private Article _article;

        protected void Page_Load(object sender, EventArgs e)
        {
            // The previous page sends a query string with the article type chosen by the user
            var articleType = Request.QueryString["articleType"];

            // If somehow it was null, go back
            if (articleType == null)
            {
                Response.Redirect("ChooseArticleToCreate.aspx");
            }

            // Get the parameters in the query string. Right now it's just any of the role sections
            var queryStringParameters = Request.QueryString["parameters"];
            var parametersSplit = queryStringParameters == null
                ? null
                : queryStringParameters.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            // Use an ArticleFactory object to get an Article instance (e.g. MovieArticle, PropArticle, etc.)
            // based on the given articleType and parameters from the querystring
            _article = _articleFactory.GetInstance(articleType, parametersSplit);
            lblArticleTemplateHeader.Text = string.Format("{0} Template", _article.ToString());
            
            BuildArticleTemplate();
        }

        // Each Article has BuildControls() which will return a List<TableRow> that is populated with
        // its respective web control content. E.g. a MovieArticle will have a Characters TextBox
        // but a PropArticle won't. This method adds those table rows to main the static table control
        private void BuildArticleTemplate()
        {
            var panels = _article.BuildControls();

            foreach (var pl in panels)
            {
                pnlArticleContent.Controls.Add(pl);
            }
        }

        // TODO redirect to newly created article page after create button clicked
        protected void btnCreateArticle_Click(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;  // to clear any error text

            // Get all the content of the dynamically created web controls that
            //  the user filled, as XML
            var xml = _article.ComposeXml(pnlArticleContent);
            var author = Session[Global.ActiveUserAccount] as UserAccount;
            var title = xml.Elements("Title").FirstOrDefault().Value;
            var timestamp = DateTime.Now;

            // Insert the article, and, if successfuly, assign it to the active session and update
            // the WikiArticleEditHistory table, too.
            if (MovieWikiDbHelper.InsertWikiArticle(_article.GetType().Name, title, xml.ToString()))
            {
                // Reassign _article now that all the properties are properly set. This isn't totally
                // necessary, but good so that the old article isn't usable afterward
                _article = MovieWikiDbHelper.GetWikiArticleByTitle(title);
                MovieWikiDbHelper.InsertWikiArticleEditHistory(_article.ArticleId, author.AccountId, timestamp);

                Session[Global.ActiveArticle] = _article;
                Response.Redirect("Default.aspx");
            }
            else
            {
                lblError.Text = "An article with that title already exists";
            }
        }
        
        //nav bar control event handlers, see Default.aspx.cs for more information
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session[Global.ActiveUserAccount] = null;
            Response.Redirect("Default.aspx");
        }

        protected void btnsearchbtn_Click(object sender, EventArgs e)
        {
            var searchResultUrl = MovieWikiDbHelper.GetWikiArticleUrlBySearch(searchInput.Text);
            if (searchResultUrl != null)
            {
                Response.Redirect(searchResultUrl);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
                upModal.Update();
            }


        }
    }
}