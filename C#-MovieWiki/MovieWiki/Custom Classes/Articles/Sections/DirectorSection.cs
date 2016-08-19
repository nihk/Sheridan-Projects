//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace MovieWiki.Custom_Classes
{
    // If the subject of a CrewMemberArticle is also a Director, then 
    // it can include this section in its Article content
    public class DirectorSection : RoleSection
    {
        // See RoleSection.cs
        public override List<Panel> BuildControls(string moviesDirectedContent = null)
        {
            var directorPanel = new List<Panel>();
            var moviesDirected = WebControlBuilder.BuildLabelTextBoxPair("lblMoviesDirected", "Movies directed", "DirectorSection",
                                moviesDirectedContent, TextBoxMode.MultiLine, rowSpan: 5);
            directorPanel.Add(WebControlBuilder.BuildPanel(moviesDirected.Item1, moviesDirected.Item2));

            return directorPanel;
        }
    }
}