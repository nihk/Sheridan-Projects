

<%--Contributors: Lei Wang--%>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MovieWiki.Web_Forms.Default" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../css/main.css" rel="stylesheet" />
    <link href="../css/font-awesome.css" rel="stylesheet" />
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js" ></script>
    <script src="../js/script.js"></script>
    <title>Welcome To Movie Wiki</title>
</head>
<body>
    
    <form id="form1" runat="server">
      <asp:ScriptManager runat="server" />
      <div class="container">
        <!-- navbar section -->
        <nav class="navbar navbar-default">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="container-fluid">
                <div class="navbar-header">
                  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                  </button>
                  <a class="navbar-brand" href="#">
                      <img id="brandIcon" alt="Brand" src="../images/movie-icon.png"/>
                  </a>
                </div>                
            <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <div class="navbar-form navbar-left">
                      <div class="row titleSearch">
                          <div class="col-lg-3">
                            <div class="title">Movie Wiki</div>
                          </div>
                          <div class="col-lg-9">
                             <div class="input-group">
                                <asp:TextBox runat="server" ID="searchInput" CssClass="form-control" placeholder="Search for an article..."/>
                                <span class="input-group-btn">
                                  <button runat="server" id="btnsearchbtn" data-toggle="modal" class="btn btn-default" onserverclick="btnsearchbtn_Click">
                                      <i class="fa fa-search"></i>
                                  </button>
                                </span>
                             </div>
                          </div>
                        </div>
                    </div>
                  <button runat="server" id="btnSignIn" type="button" class="btn btn-default navbar-btn navbar-right" CausesValidation="False" onserverclick="btnLogout_Click">Log out</button>
                </div><!-- /.navbar-collapse -->
             </div>
          </nav>
      </div>
      <div class="modalSection"><!-- search modal section -->
        <div class="modal fade" tabindex="-1" role="dialog" id="myModal">
          <div class="modal-dialog" role="document">
            <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title text-center">No Result Found</h4>
                      </div>
                    </div><!-- /.modal-content -->
               </ContentTemplate>
            </asp:UpdatePanel>
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        <%-- Account Info Modal section --%>
        <div class="modal fade" tabindex="-1" role="dialog" id="AccountModal">
          <div class="modal-dialog" role="document">
            <asp:UpdatePanel ID="updateAccount" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">&times;</span></button>
                        <h2 class="modal-title text-center"><asp:Label ID="lblGreeting" runat="server" /></h2>
                      </div>
                      <div class="modal-body">
                          <asp:Label ID="lblArticleEdits" runat="server" Text="Your article contributions:"></asp:Label>
                          <asp:Panel id="pUserEdits" runat="server"></asp:Panel>
                      </div>
                    </div><!-- /.modal-content -->
               </ContentTemplate>
            </asp:UpdatePanel>
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
      </div>
      <%-- Recent Articles Modal section --%>
        <div class="modal fade" tabindex="-1" role="dialog" id="RecentModal">
          <div class="modal-dialog" role="document">
            <asp:UpdatePanel ID="upRecentModal" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">&times;</span></button>
                        <h2 class="modal-title text-center"><asp:Label ID="lblRecentEdits" runat="server"/></h2>
                      </div>
                      <div class="modal-body">
                          <asp:Panel id="pUserEditsRecent" runat="server"></asp:Panel>
                      </div>
                    </div><!-- /.modal-content -->
               </ContentTemplate>
            </asp:UpdatePanel>
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
      </div>

    <div id="mainSection">
        <div id="welcomeTitle" class="row text-center">
            <h1><asp:Label ID="lblWelcome" runat="server"></asp:Label></h1>
        </div>
        <!-- Images slider section -->
        <div id="sliderSection" class="container">
            <div id="slideShow" class="carousel slide" data-ride="carousel">
              <!-- Indicators -->
              <ol class="carousel-indicators">
                <li data-target="#slideShow" data-slide-to="0" class="active"></li>
                <li data-target="#slideShow" data-slide-to="1"></li>
                <li data-target="#slideShow" data-slide-to="2"></li>
              </ol>

              <!-- Wrapper for slides -->
              <div id="sliderInner" class="carousel-inner" role="listbox">
                  <a class="item active" href="ShowArticle.aspx?id=5"><img class="slideImg" src="../images/Avatar.jpeg" width="600" /></a>
                  <a class="item" href="ShowArticle.aspx?id=6"><img class="slideImg" src="../images/starWars.jpg" width="600" /></a>
                  <a class="item" href="ShowArticle.aspx?id=7"><img class="slideImg" src="../images/themartian.jpg" width="600" /></a>
              </div>

              <!-- Controls -->
              <a class="left carousel-control" href="#slideShow" role="button" data-slide="prev">
                  <span class="icon-prev" aria-hidden="true"></span>
                  <span class="sr-only"><i class="fa fa-angle-left"></i></span>
              </a>
              <a class="right carousel-control" href="#slideShow" role="button" data-slide="next">
                <span class="icon-next" aria-hidden="true"></span>
                <span class="sr-only"><i class="fa fa-angle-right"></i></span>
              </a>
            </div>
            <!-- option buttons section -->
            <div id="optionSection" class="row">
                <div class="col-md-4 text-center">
                    <button runat="server" id="showAccountInfo" data-toggle="modal" class="btn btn-default btn-lg" onserverclick="showAccountInfo_ServerClick">
                        Account information
                    </button>
                </div>
                <div class="col-md-4 text-center">
                    <button class="btn btn-default btn-lg">
                        <a href="ChooseArticleToCreate.aspx">Create an article</a>
                    </button>
                </div>
                <div class="col-md-4 text-center">
                    <button runat="server" data-toggle="modal" id="showRecentModal" class="btn btn-default btn-lg" onserverclick="showRecentModal_ServerClick">
                        Recent articles
                    </button>
                </div>
            </div>
         </div>
    </div>
    </form>
</body>
</html>
