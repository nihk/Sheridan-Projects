//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieWiki.Custom_Classes
{
    // See Article.cs for comments on how the purpose of each method
    public abstract class PersonArticle : Article
    {
        public string Name { get; set; }
        public string Age { get; set; }

        // Parses (string) XML from the database and assigns their values to specific PersonArticle properties
        public override void ParseData(string articleData)
        {
            base.ParseData(articleData);
            var xml = XElement.Parse(articleData);
            Name = xml.Elements("Name").FirstOrDefault().Value;
            Age = xml.Elements("Age").FirstOrDefault().Value;
        }

        // Builds additional web controls for MokiWIki properties
        public override List<Panel> BuildControls()
        {
            var basePanels = base.BuildControls();
            var personPanels = new List<Panel>();

            var name = WebControlBuilder.BuildLabelTextBoxPair("lblName", "Full name", "Name", Name);
            personPanels.Add(WebControlBuilder.BuildPanel(name.Item1, name.Item2));
            var age = WebControlBuilder.BuildLabelTextBoxPair("lblAge", "Age", "Age", Age);
            personPanels.Add(WebControlBuilder.BuildPanel(age.Item1, age.Item2));

            basePanels.InsertRange(1, personPanels);

            return basePanels;
        }
    }
}