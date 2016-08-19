// Contributors: Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Web;

namespace MovieWiki.Custom_Classes
{
    // A class used to track the current user surfing our website
    public class UserAccount
    {
        private readonly int _accountId;
        private readonly string _username;
        private readonly string _password;  // password is always hashed by SHA512
        private readonly bool _isAdmin;

        public int AccountId { get { return _accountId; } }
        public string Username { get { return _username; } }
        public string Password { get { return _password; } }
        public bool IsAdmin { get { return _isAdmin; } }

        // Constructor for UserAccount class
        public UserAccount(int accountId, string username, string password)
        {
            _accountId = accountId;
            _username = username;
            _password = password;
            _isAdmin = MovieWikiDbHelper.IsUserAdmin(username);
        }
    }
}