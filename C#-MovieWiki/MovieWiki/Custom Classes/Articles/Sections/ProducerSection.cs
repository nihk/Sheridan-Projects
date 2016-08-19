//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace MovieWiki.Custom_Classes
{
    // If the subject of a CrewMemberArticle is also a Producer, then 
    // it can include this section in its Article content
    public class ProducerSection : RoleSection
    {
        // See RoleSection.cs
        public override List<Panel> BuildControls(string moviesProducedContent = null)
        {
            var producerPanel = new List<Panel>();
            var moviesProduced = WebControlBuilder.BuildLabelTextBoxPair("lblMoviesProduced", "Movies produced", "ProducerSection",
                                moviesProducedContent, TextBoxMode.MultiLine, rowSpan: 5);
            producerPanel.Add(WebControlBuilder.BuildPanel(moviesProduced.Item1, moviesProduced.Item2));

            return producerPanel;
        }
    }
}