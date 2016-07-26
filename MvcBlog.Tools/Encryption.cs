using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace MvcBlog.Tools
{
    public static class Encryption
    {
        public static string SHA1Encryption(string expression)
        {
            // GERİ DÖNÜŞÜ YOK
            SHA1 s = new SHA1CryptoServiceProvider();
            byte[] encryptingExpression = ASCIIEncoding.Default.GetBytes(expression);
            byte[] encrypted = s.ComputeHash(encryptingExpression);
            return BitConverter.ToString(encrypted);
        }
    }
}
