// Contributors: Nick Rose
using MovieWiki.MovieWikiServiceReference;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace MovieWiki.Custom_Classes
{
    // A helper class that stores static properties that contain all the database information
    public static class MovieWikiDbHelper
    {
        // Factory instance to help create Article instances
        private static readonly ArticleFactory ArticleFactory = new ArticleFactory();
        // Client for the WCF service
        private static MovieWikiServiceClient movieWikiServiceClient = new MovieWikiServiceClient();

        // Static collections of all database data
        private static List<UserAccount> _allUserAccounts;
        public static List<UserAccount> AllUserAccounts
        {
            get
            {
                if (_allUserAccounts == null)
                {
                    UpdateUserAccountProp();
                }
                return _allUserAccounts;
            }
            private set
            {
                _allUserAccounts = value;
            }
        }

        private static List<Article> _allWikiArticles;
        public static List<Article> AllWikiArticles
        {
            get
            {
                if (_allWikiArticles == null)
                {
                    UpdateWikiArticleProp();
                }
                return _allWikiArticles;
            }
            private set
            {
                _allWikiArticles = value;
            }
        }

        private static List<WikiArticleEditHistory> _allWikiArticleEditHistories;
        public static List<WikiArticleEditHistory> AllWikiArticleEditHistories
        {
            get
            {
                if (_allWikiArticleEditHistories == null)
                {
                    UpdateWikiArticleEditHistoriesProp();
                }
                return _allWikiArticleEditHistories;
            }
            private set
            {
                _allWikiArticleEditHistories = value;
            }
        }

        // These enums are used when parsing a DataSet so as to avoid magic strings
        private enum UserAccountTable
        {
            AccountId = 0,
            Username = 1,
            Password = 2
        }

        private enum WikiArticleTable
        {
            ArticleId = 0,
            ArticleType = 1,
            Title = 2,
            Description = 3
        }

        private enum WikiArticleEditHistoryTable
        {
            EditId = 0,
            ArticleId = 1,
            AccountId = 2,
            EditTimestamp = 3
        }

        // Methods insert and update recored on  and update static Objects

        public static bool InsertWikiArticleEditHistory(int aticleId, int accountId, DateTime timestamp)
        {
            if (movieWikiServiceClient.InsertWikiArticleEditHistory(aticleId, accountId, timestamp) == 1)
            {
                UpdateWikiArticleEditHistoriesProp();
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool InsertWikiArticle(string articleType, string title, string descriptionXml)
        {
            if (IsExistingWikiArticle(title)) return false;

            if (movieWikiServiceClient.InsertWikiArticle(articleType, title, descriptionXml) == 1)
            {
                UpdateWikiArticleProp();
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool UpdateWikiArticle(int articleId, string descriptionXml)
        {
            if (movieWikiServiceClient.UpdateWikiArticle(articleId, descriptionXml) == 1)
            {
                UpdateWikiArticleProp();
                return true;
            }
            else
            {
                return false;
            }
        }

        // Each time there is an insert/update/delete, this property gets updated
        private static void UpdateWikiArticleProp()
        {
            AllWikiArticles = GetAllWikiArticles();
        }
        
        public static bool DeleteWikiArticle(int articleId)
        {
            if (movieWikiServiceClient.DeleteWikiArticle(articleId) >= 1)
            {
                UpdateWikiArticleProp();
                UpdateWikiArticleEditHistoriesProp();
                return true;
            }
            else
            {
                return false;
            }
        }

        // Converts dataset to list of Article objects
        private static List<Article> GetAllWikiArticles()
        {
            var dataSet = movieWikiServiceClient.GetAllWikiArticles();
            var wikiArticles = new List<Article>();

            foreach (DataRow row in dataSet.Tables["WikiArticle"].Rows)
            {
                var articleId = Convert.ToInt32(row[(int)WikiArticleTable.ArticleId]);
                var articleType = Convert.ToString(row[(int)WikiArticleTable.ArticleType]);
                var title = Convert.ToString(row[(int)WikiArticleTable.Title]);
                var description = Convert.ToString(row[(int)WikiArticleTable.Description]);

                var article = ArticleFactory.GetInstance(articleType, articleId, title, description);
                wikiArticles.Add(article);
            }

            return wikiArticles;
        }

        // Search by title in static WikiArticle list object 
        public static Article GetWikiArticleByTitle(string title)
        {
            return AllWikiArticles.FirstOrDefault(w => string.Equals(w.Title, title, StringComparison.OrdinalIgnoreCase));
        }

        // Used by the search feature in the navbar; it takes a string search
        // and returns the link to that article, or null if nothing was found
        public static string GetWikiArticleUrlBySearch(string search)
        {
            var matchingArticle = GetWikiArticleByTitle(search);

            return matchingArticle != null
                ? string.Format(Global.ShowArticleUrlWithId, matchingArticle.ArticleId)
                : null;
        }

        // Search by id property in static WikiArticle list object 
        public static Article GetWikiArticleById(int id)
        {
            return AllWikiArticles.FirstOrDefault(w => w.ArticleId == id);
        }

        // Used to make sure there are no unique constraint violations when inserting a new Article
        public static bool IsExistingWikiArticle(string title)
        {
            return AllWikiArticles.Any(w => string.Equals(w.Title, title, StringComparison.OrdinalIgnoreCase));
        }

        // Insert new record to UserAccount table in database
        public static bool InsertUserAccount(string username, string password)
        {
            if (IsExistingUsername(username)) return false;

            if (movieWikiServiceClient.InsertUserAccount(username, password) == 1)
            {
                UpdateUserAccountProp();
                return true;
            }
            else
            {
                return false;
            }
        }

        // Each time there is an insert/update/delete, this property gets updated
        private static void UpdateUserAccountProp()
        {
            AllUserAccounts = GetAllUserAccounts();
        }

        // Converts DataSet to list of UserAccount object
        private static List<UserAccount> GetAllUserAccounts()
        {
            var dataSet = movieWikiServiceClient.GetAllUserAccounts();
            var userAccounts = new List<UserAccount>();

            foreach (DataRow row in dataSet.Tables["UserAccount"].Rows)
            {
                var accountId = Convert.ToInt32(row[(int)UserAccountTable.AccountId]);
                var username = Convert.ToString(row[(int)UserAccountTable.Username]);
                var password = Convert.ToString(row[(int)UserAccountTable.Password]);

                userAccounts.Add(new UserAccount(accountId, username, password));
            }

            return userAccounts;
        }

        // Search for user in static UserAccount list object 
        public static UserAccount GetUserAccount(string username, string password)
        {
            return AllUserAccounts.FirstOrDefault(u => 
                string.Equals(u.Username, username, StringComparison.OrdinalIgnoreCase)
                && u.Password == password);
        }

        // Used to make sure the unique constraint of the UserAccount database table is not violated
        private static bool IsExistingUsername(string username)
        {
            return AllUserAccounts.Any(u => string.Equals(u.Username, username, StringComparison.OrdinalIgnoreCase));
        }

        // The user "admin" can delete articles
        public static bool IsUserAdmin(string username)
        {
            return username.ToLower() == "admin";
        }

        // Converts DataSet to list of WikiArticleEditHistory object
        private static List<WikiArticleEditHistory> GetAllWikiArticleEditHistories()
        {
            var dataSet = movieWikiServiceClient.GetAllWikiArticleEditHistories();
            var editHistories = new List<WikiArticleEditHistory>();

            foreach (DataRow row in dataSet.Tables["WikiArticleEditHistory"].Rows)
            {
                var editId = Convert.ToInt32(row[(int)WikiArticleEditHistoryTable.EditId]);
                var articleId = Convert.ToInt32(row[(int)WikiArticleEditHistoryTable.ArticleId]);
                var accountId = Convert.ToInt32(row[(int)WikiArticleEditHistoryTable.AccountId]);
                var editTimeStamp = Convert.ToDateTime(row[(int)WikiArticleEditHistoryTable.EditTimestamp]);

                editHistories.Add(new WikiArticleEditHistory(editId, articleId, accountId, editTimeStamp));
            }

            return editHistories;
        }

        // Each time there is an insert/update/delete, this property gets updated
        private static void UpdateWikiArticleEditHistoriesProp()
        {
            AllWikiArticleEditHistories = GetAllWikiArticleEditHistories();
        }
    }
}