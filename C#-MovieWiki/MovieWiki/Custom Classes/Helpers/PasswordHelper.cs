// Contributors: Nick Rose
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace MovieWiki.Custom_Classes
{
    // Source: https://support.microsoft.com/en-ca/kb/307020
    // This was added to the project so that passwords are never stored in plaintext
    public static class PasswordHelper
    {
        // Turns a plaintext password into ASCII bytes and hashes it using SHA512
        public static string GetHashedPassword(string password)
        {
            var sha512 = SHA512.Create();
            var plainTextBytes = Encoding.ASCII.GetBytes(password);
            return ByteArrayToString(sha512.ComputeHash(plainTextBytes));
        }

        // Converts the hashed bytes into a string to store to the database
        private static string ByteArrayToString(byte[] arrInput)
        {
            int i;
            StringBuilder sOutput = new StringBuilder(arrInput.Length);
            for (i = 0; i < arrInput.Length - 1; i++)
            {
                sOutput.Append(arrInput[i].ToString("X2"));
            }
            return sOutput.ToString();
        }
    }
}