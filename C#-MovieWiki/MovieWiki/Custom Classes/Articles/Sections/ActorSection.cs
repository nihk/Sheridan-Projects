//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace MovieWiki.Custom_Classes
{
    // If the subject of a CrewMemberArticle is also an Actor, then 
    // it can include this section in its Article content
    public class ActorSection : RoleSection
    {
        // See RoleSection.cs
        public override List<Panel> BuildControls(string moviesStarredIn = null)
        {
            var actorPanel= new List<Panel>();
            var charactersPortrayed = WebControlBuilder.BuildLabelTextBoxPair("lblCharactersPortrayed", "Characters portrayed", "ActorSection",
                                moviesStarredIn, TextBoxMode.MultiLine, rowSpan: 5);
            actorPanel.Add(WebControlBuilder.BuildPanel(charactersPortrayed.Item1, charactersPortrayed.Item2));

            return actorPanel;
        }
    }
}