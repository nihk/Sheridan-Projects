//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace MovieWiki.Custom_Classes
{
    // An abstract class that all *Section types inherit from
    // Articles can hold (i.e. composition) Sections so that they can have more content.
    // Currently just CrewMemberArticle.cs has RoleSections
    public abstract class RoleSection
    {
        // The user inputted data for a given section
        public string Description { get; set; }

        // A list of Panels corresponding to what any RoleSection subtype specifies
        public abstract List<Panel> BuildControls(string content);
    }
}
