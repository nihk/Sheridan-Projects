//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

namespace MovieWiki.Custom_Classes
{
    // A subtype of Article, see Article.cs for details on the methods
    public class MovieArticle : Article
    {
        public string Theme { get; set; }
        public string Characters { get; set; }
        public string Language { get; set; }
        public string Duration { get; set; }

        public MovieArticle() { }

        public MovieArticle(int articleId, string title, string description)
        {
            ArticleId = articleId;
            Title = title;
            ParseData(description);
        }

        // Retrieves MovieArticle class specific data from XML
        public override void ParseData(string articleData)
        {
            base.ParseData(articleData);
            var xml = XElement.Parse(articleData);
            Theme = xml.Elements("Theme").FirstOrDefault().Value;
            Characters = xml.Elements("Characters").FirstOrDefault().Value;
            Duration = xml.Elements("Duration").FirstOrDefault().Value;
            Language = xml.Elements("Language").FirstOrDefault().Value;
        }

        // Builds additional web controls with CharacterArticle properties
        public override List<Panel> BuildControls()
        {
            var basePanels = base.BuildControls();

            var moviePanels = new List<Panel>();
            var theme = WebControlBuilder.BuildLabelTextBoxPair("lblTheme", "Theme", "Theme", Theme);
            var characters = WebControlBuilder.BuildLabelTextBoxPair("lblCharacters", "Characters", "Characters",
                Characters, TextBoxMode.MultiLine, rowSpan: 5);
            var language = WebControlBuilder.BuildLabelTextBoxPair("lblLanguage", "Language", "Language", Language);
            var duration = WebControlBuilder.BuildLabelTextBoxPair("lblDuration", "Duration", "Duration", Duration);
            moviePanels.Add(WebControlBuilder.BuildPanel(theme.Item1, theme.Item2));
            moviePanels.Add(WebControlBuilder.BuildPanel(characters.Item1, characters.Item2));
            moviePanels.Add(WebControlBuilder.BuildPanel(language.Item1, language.Item2));
            moviePanels.Add(WebControlBuilder.BuildPanel(duration.Item1, duration.Item2));

            // Insert all before the last description textarea
            basePanels.InsertRange(1, moviePanels);

            return basePanels;
        }

        public override string ToString()
        {
            return "Movie Article";
        }
    }
}