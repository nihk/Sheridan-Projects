

<!--Contributors: Lei Wang -->
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="MovieWiki.Web_Forms.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../css/main.css" rel="stylesheet" />
    <link href="../css/font-awesome.css" rel="stylesheet" />
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js" ></script>
    <title>Registration</title>
</head>
<body>
    <form runat="server">
    <div class="container">
        <div class="content">
            <div class="logInSection">
              <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="text-center loginTitle">Enter account details</div>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal">
                  <div class="form-group">
                      <div class="row">
                        <asp:Label ID="lblCreateUsername" runat="server" Text="Username" class="col-sm-3 control-label"></asp:Label>
                        <div class="col-sm-8">
                          <asp:TextBox class="form-control" ID="txtCreateUsername" runat="server"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="vldCreateUsername" ForeColor="Red" runat="server" ErrorMessage="Enter a username" ControlToValidate="txtCreateUsername" />
                        </div>
                     </div>
                  </div>
                  <div class="form-group">
                      <div class="row">
                        <asp:Label ID="lblCreatePassword" runat="server" Text="Password" class="col-sm-3 control-label"></asp:Label>
                        <div class="col-sm-8">
                          <asp:TextBox ID="txtCreatePassword" TextMode="Password" runat="server" class="form-control"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="vldCreatePassword" ForeColor="Red" runat="server" ErrorMessage="Enter a password" ControlToValidate="txtCreatePassword" />
                        </div>
                      </div>
                  </div>
                  <div class="form-group">
                      <div class="row">
                        <asp:Label ID="lblReenterCreatePassword" runat="server" Text="Re-enter" class="col-sm-3 control-label"></asp:Label>
                        <div class="col-sm-8">
                          <asp:TextBox ID="txtReenterCreatePassword" TextMode="Password" runat="server" class="form-control"></asp:TextBox>
                          <asp:CompareValidator id="vldReenterCreatePassword" ForeColor="Red" runat="server" ControlToCompare="txtReenterCreatePassword" ControlToValidate="txtCreatePassword" ErrorMessage="Passwords don't match" />
                        </div>
                      </div>
                  </div>
                  <div class="form-group">
                     <div class="row">
                        <div class="col-sm-offset-3 col-sm-3">
                            <asp:Button class="btn btn-primary" ID="btnCreateAccount" runat="server" Text="Register" OnClick="btnCreateAccount_Click" />
                        </div>
                        <div class="col-sm-4">
                            <asp:Button class="btn btn-primary" ID="btnCancelCreateAccount" CausesValidation="false" runat="server" Text="Cancel" OnClick="btnCancelCreateAccount_Click" />
                        </div>
                     </div>
                  </div>
                  <asp:Label ID="lblCreateAccountErrorMsg" runat="server"></asp:Label>
                  </div>
                
                </div>
             </div>
         </div>
      </div>
  </div>
</form>
</body>
</html>
