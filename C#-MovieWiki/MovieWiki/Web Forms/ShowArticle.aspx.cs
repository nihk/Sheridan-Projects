//Contributors: Lei Wang, Noe Ascenio, Nick Rose

using MovieWiki.Custom_Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieWiki.Web_Forms
{
    // web form displays Article to be displays with necessary controls
    public partial class ShowArticle : System.Web.UI.Page
    {
        private Article _article;
        private const string Edit = "Edit";
        private const string Save = "Save";

        protected void Page_Load(object sender, EventArgs e)
        {
            // gets id of article to display from redirection of other web forms
            var id = Request.QueryString["id"];
            if (id == null)
            {
                Response.Redirect("SearchArticle.aspx");
            }
            else
            {
                GetAndDisplayArticleControls(Convert.ToInt32(id));
            }
        }

        // Gets all the respective Article web controls and builds them. These web controls will be populated
        // with data, too
        private void GetAndDisplayArticleControls(int id)
        {
            _article = MovieWikiDbHelper.GetWikiArticleById(id);
            if (_article == null) return;
            var articleControls = _article.BuildControls();

            foreach (var row in articleControls)
            {
                pnlArticleContent.Controls.Add(row);
            }

            var titleControl = FindControl("Title") as TextBox;
            titleControl.Enabled = false;
            if (MovieWikiDbHelper.IsUserAdmin((Session[Global.ActiveUserAccount] as UserAccount).Username))
            {
                btnDeleteArticle.Visible = true;
            }
            ToggleControls(pnlArticleContent);
        }

        // changes state of Article web controls to allow changes in Article content
        protected void btnEditSave_Click(object sender, EventArgs e)
        {
            ToggleEditSaveButtonText();
        }

        // Makes the Edit button turn into a Save button, and vice versa
        private void ToggleEditSaveButtonText()
        {
            if (btnEditSave.Text == Edit)
            {
                btnEditSave.Text = Save;
            }
            else
            {
                UpdateEdits();
                btnEditSave.Text = Edit;
            }
        }

        // If a user edited the article, they can save the changes to the database here
        private void UpdateEdits()
        {
            var xml = _article.ComposeXml(pnlArticleContent);
            // NB editor does not always equal article author (the original author that created the article)
            var editor = Session[Global.ActiveUserAccount] as UserAccount;
            var timestamp = DateTime.Now;

            if (MovieWikiDbHelper.UpdateWikiArticle(_article.ArticleId, xml.ToString()))
            {
                MovieWikiDbHelper.InsertWikiArticleEditHistory(_article.ArticleId, editor.AccountId, timestamp);
                Session[Global.ActiveArticle] = _article;
            }
            else
            {
                Response.Write("An error occured while updating the article");
            }
        }

        // Toggles the editability of the web controls on the page
        private void ToggleControls(Control c)
        {
            if (c.HasControls())
            {
                foreach (Control control in c.Controls)
                {
                    ToggleControls(control);
                }
            }
            else
            {
                if (c.ID != "Title")  // Don't let the Title be changeable
                {
                    var textBox = c as TextBox;
                    if (textBox != null)  
                    {
                        textBox.Enabled = !textBox.Enabled;
                    }
                    var checkBox = c as CheckBox;
                    if (checkBox != null)
                    {
                        checkBox.Enabled = !checkBox.Enabled;
                    }
                }
            }
        }

        // For user "admin" only; they can delete articles
        protected void btnDeleteArticle_Click(object sender, EventArgs e)
        {
            if (!DeleteArticle())
            {
                Response.Write("Error deleting article");
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        // uses helper to remove article from database
        private bool DeleteArticle()
        {
            return MovieWikiDbHelper.DeleteWikiArticle(_article.ArticleId);
        }

        //navbar button event, see Default.aspx for more infromation
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