// Contributors: Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MovieWiki.Custom_Classes
{
    // A class used to track the user creations/edits of Articles
    public class WikiArticleEditHistory
    {
        public int EditId { get; set; }
        public int ArticleId { get; set; }
        public int AccountId { get; set; }
        public DateTime EditTimestamp { get; set; }

        // Constructor for WikiArticleEditHistory class
        public WikiArticleEditHistory(int editId, int articleId, int accountId, DateTime editTimeStamp)
        {
            EditId = editId;
            ArticleId = articleId;
            AccountId = accountId;
            EditTimestamp = editTimeStamp;
        }
    }
}