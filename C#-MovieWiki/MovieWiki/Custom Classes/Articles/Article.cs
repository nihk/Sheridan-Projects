//Contributors: Noe Ascenio, Nick Rose
using System.Linq;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System;

namespace MovieWiki.Custom_Classes
{
    // The parent class for all Article subtypes
    public abstract class Article
    {
        // These fields mimick what the database tables have
        public int ArticleId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }

        // Parses (string) XML from the database and assigns the values to Article's properties
        public virtual void ParseData(string articleData)
        {
            var xml = XElement.Parse(articleData);
            Description = xml.Elements("Description").FirstOrDefault().Value;
            Title = xml.Elements("Title").FirstOrDefault().Value;
        }

        // Builds web controls based on the fields Article has
        public virtual List<Panel> BuildControls()
        {
            var panels = new List<Panel>();

            var title = WebControlBuilder.BuildLabelTextBoxPair("lblTitle", "Title", "Title", Title);
            
            var titleVld = WebControlBuilder.BuildReqFieldValidator("Title", "vldTitle", "Enter a title for the article");
            title.Item2.Controls.Add(titleVld);
            panels.Add(WebControlBuilder.BuildPanel(title.Item1, title.Item2));

            var description = WebControlBuilder.BuildLabelTextBoxPair("lblDescription", "Description", "Description",
                Description, TextBoxMode.MultiLine, 40, 10);
            panels.Add(WebControlBuilder.BuildPanel(description.Item1, description.Item2));

            return panels;
        }

        // Serializes ASP table content into database-ready XML
        public virtual XElement ComposeXml(Control panel)
        {
            var xml = new XElement(this.GetType().Name);
            foreach (Control outerpanel in panel.Controls)
            {
                var op = outerpanel as Panel;
                foreach (var innercontrol in op.Controls)
                {
                    var ic = innercontrol as Panel;
                    if (ic != null)
                    {
                        foreach (var child in ic.Controls)
                        {
                            var textBox = child as TextBox;
                            if (textBox != null)
                            {
                                xml.Add(new XElement(textBox.ID, textBox.Text));
                            }
                        }
                    }
                    var checkBox = innercontrol as CheckBox;
                    if (checkBox != null)
                    {
                        xml.Add(new XElement(checkBox.ID, checkBox.Checked));
                    }
                }
            }
            return xml;
        }
    }
}
