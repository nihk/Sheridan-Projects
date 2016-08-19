// Contributors: Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MovieWiki.Custom_Classes
{
    // A factory class used to help create instances of role sections (which currently
    // only CrewMemberArticle.cs uses
    public class RoleSectionFactory
    {
        // Get an instance of RoleSection without any property data
        public RoleSection GetInstance(string role)
        {
            switch (role)
            {
                case "ActorSection": return new ActorSection();
                case "ProducerSection": return new ProducerSection();
                case "DirectorSection": return new DirectorSection();
                default: throw new Exception("Error creating RoleSection");
            }
        }

        // Get an instance of RoleSection and set properties with data
        public RoleSection GetInstance(string role, string description)
        {
            var roleSection = GetInstance(role);
            roleSection.Description = description;
            return roleSection;
        }
    }
}