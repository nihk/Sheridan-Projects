//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieWiki.Custom_Classes
{
    // See Article.cs for comments on the purpose of each method
    public class PropArticle : Article
    {
        public string MoviesFeaturedIn { get; set; }
        public string Function { get; set; }

        public PropArticle() { }

        // Constructor for PropArticle class
        public PropArticle(int articleId, string title, string description)
        {
            ArticleId = articleId;
            Title = title;
            ParseData(description);
        }

        // Parses (string) XML from the database and assigns their values to specific PropArticle properties
        public override void ParseData(string articleData)
        {
            base.ParseData(articleData);
            var xml = XElement.Parse(articleData);
            MoviesFeaturedIn = xml.Elements("MoviesFeaturedIn").FirstOrDefault().Value;
            Function = xml.Elements("Function").FirstOrDefault().Value;
        }

        // Builds additional web controls for MovieWiki properties
        public override List<Panel> BuildControls()
        {
            var basePanels = base.BuildControls();
            var propPanels = new List<Panel>();
            var moviesFeatured = WebControlBuilder.BuildLabelTextBoxPair("lblMoviesFeaturedIn", "Movies featured in", "MoviesFeaturedIn",
                MoviesFeaturedIn, TextBoxMode.MultiLine, rowSpan: 5);
            var function = WebControlBuilder.BuildLabelTextBoxPair("lblFunction", "Function", "Function", Function);
            propPanels.Add(WebControlBuilder.BuildPanel(moviesFeatured.Item1, moviesFeatured.Item2));
            propPanels.Add(WebControlBuilder.BuildPanel(function.Item1, function.Item2));

            basePanels.InsertRange(1, propPanels);

            return basePanels;
        }

        public override string ToString()
        {
            return "Prop Article";
        }
    }
}