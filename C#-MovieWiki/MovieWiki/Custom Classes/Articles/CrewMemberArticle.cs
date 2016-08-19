//Contributors: Noe Ascenio, Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieWiki.Custom_Classes
{
    // A subtype of PersonArticle (and thus Article, too)
    // Does the same things as Article but overrides some of the methods
    // to make it more specific to its own properties
    public class CrewMemberArticle : PersonArticle
    {
        private RoleSectionFactory _roleSectionFactory = new RoleSectionFactory();
        public List<RoleSection> Roles { get; set; }

        private CrewMemberArticle()
        {
            Roles = new List<RoleSection>();
        }

        public CrewMemberArticle(string[] roles) : this()
        {
            AddRoles(roles);
        }

        public CrewMemberArticle(int articleId, string title, string descriptionXml) : this()
        {
            ArticleId = articleId;
            Title = title;
            var parsedXml = XElement.Parse(descriptionXml);
        }

        // Parses (string) XML from the database and assigns their values to specific CrewMember properties
        public override void ParseData(string articleData)
        {
            base.ParseData(articleData);
            var xml = XElement.Parse(articleData);
            var roleSectionsXml = xml.Elements("RoleSections").FirstOrDefault();

            string[] roles, roleValues;
            if (roleSectionsXml != null && roleSectionsXml.Elements() != null)
            {
                roles = roleSectionsXml.Elements().Select(r => r.Name.LocalName).ToArray();
                roleValues = roleSectionsXml.Elements().Select(r => r.Value).ToArray();
                AddRoles(roles, roleValues);
            }
        }

        // Adds new RoleSection to Roles list 
        private void AddRoles(string[] roles, string[] roleValues = null)
        {
            if (roles != null)
            {
                for (int i = 0; i < roles.Length; i++) 
                {
                    var roleSection = _roleSectionFactory.GetInstance(roles[i],
                        roleValues != null ? roleValues[i] : null);
                    Roles.Add(roleSection);
                }
            }
        }

        // Builds additional web controls with CrewMemberArticle Class
        public override List<Panel> BuildControls()
        {
            var basePanels = base.BuildControls();
            var crewMemberPanels = new List<Panel>();
            Roles.ForEach(r => crewMemberPanels.AddRange(r.BuildControls(r.Description)));

            // Insert all before the last description textarea
            basePanels.InsertRange(basePanels.Count - 1, crewMemberPanels);

            return basePanels;
        }

        // Serializes ASP additional table content into database-ready XML for CrewMemberArticle subtype
        public override XElement ComposeXml(Control panel)
        {
            var xml = new XElement(this.GetType().Name);
            var xmlRoleSections = new XElement("RoleSections");

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
                                var xElement = new XElement(textBox.ID, textBox.Text);
                                if (textBox.ID.Contains("Section"))
                                {
                                    xmlRoleSections.Add(xElement);
                                }
                                else
                                {
                                    xml.Add(xElement);
                                }
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
            xml.Add(xmlRoleSections);
            return xml;
        }

        public override string ToString()
        {
            return "Crew Member Article";
        }
    }
}