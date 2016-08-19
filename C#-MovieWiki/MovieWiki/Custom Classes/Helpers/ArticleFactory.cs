// Contributors: Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MovieWiki.Custom_Classes
{
    // A helper class that returns Article subtype instances. Uses the Factory design pattern
    public class ArticleFactory
    {
        // Used when building an article's template
        public Article GetInstance(string articleType, string[] parameters)
        {
            switch (articleType)
            {
                case "CrewMemberArticle": return new CrewMemberArticle(parameters);
                case "CharacterArticle": return new CharacterArticle();
                case "MovieArticle": return new MovieArticle();
                case "PropArticle": return new PropArticle();
                default: throw new Exception("Error creating article");
            }
        }

        // Used when getting articles from the database
        public Article GetInstance(string articleType, int articleId, string title, string description)
        {
            var article = GetInstance(articleType, null);
            article.ArticleId = articleId;
            article.Title = title;
            article.ParseData(description);

            return article;
        }
    }
}