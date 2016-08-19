

<!--Contributors: Lei Wang -->
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowArticle.aspx.cs" Inherits="MovieWiki.Web_Forms.ShowArticle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../css/main.css" rel="stylesheet" />
    <link href="../css/font-awesome.css" rel="stylesheet" />
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js" ></script>
    <script src="../js/script.js"></script>
    <title>Search Result</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="container">
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
                  <a class="navbar-brand" href="Default.aspx">
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
          <nav aria-label="back">
            <ul class="pager">
              <li class="previous"><a href="Default.aspx"><span aria-hidden="true">&larr;</span> Back</a></li>
              <li class="next disabled"><a href="#">Next <span aria-hidden="true">&rarr;</span></a></li>
            </ul>
          </nav>
        </div>
        <div class="modalSection">
            <div class="modal fade" tabindex="-1" role="dialog" id="myModal">
                <div class="modal-dialog" role="document">
                <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
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
        </div>
        <div class="container">
            <div class="createArticleSection">
                <div class="logInSection">
                    <div class="panel panel-info">
                        <div class="panel-body">
                            <asp:Panel ID="pnlArticleContent" runat="server" CssClass="form-horizontal"></asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <asp:Button CssClass="btn btn-default" ID="btnEditSave" runat="server" Text="Edit" OnClick="btnEditSave_Click" />  
                    </div>
                    <div class="col-md-8">
                        <asp:Button CssClass="btn btn-default" ID="btnDeleteArticle" runat="server" Visible="false" Text="Delete" OnClick="btnDeleteArticle_Click" />
                    </div>
                </div>
            </div>
         </div>
  </form>
</body>
</html>
