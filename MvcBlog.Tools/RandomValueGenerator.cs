using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MvcBlog.Tools
{
    public static class RandomValueGenerator
    {
        public static string GenerateCaptchaCode(int characterLength, bool onlyNumeric)
        {
            string generatedCode = "";
            Random r = new Random();
            string numbers = "0123456789";
            string lowercaseLetters = "abcdefghijklmnoprstuvyz";
            string uppercaseLetters = lowercaseLetters.ToUpper();

            if (onlyNumeric)
            {
                for (int i = 0; i < characterLength; i++)
                {
                    generatedCode += numbers[r.Next(numbers.Length)];
                }
            }
            else
            {
                string items = numbers + lowercaseLetters + uppercaseLetters;
                for (int i = 0; i < characterLength; i++)
                {
                    generatedCode += items[r.Next(items.Length)];
                }
            }

            return generatedCode;
        }

        public static HatchBrush GenerateBrush()
        {
            Random r = new Random();
            return new HatchBrush((HatchStyle)r.Next(0, 53), GenerateColor());
        }

        public static Color GenerateColor()
        {
            Random r = new Random();
            return Color.FromArgb(r.Next(0, 255), r.Next(0, 255), r.Next(0, 255));
        }

        public static Guid GenerateActivationCode()
        {
            return Guid.NewGuid();
        }

        public static string GenerateRandomFileName(string extension)
        {
            string random = "";
            Random r = new Random();
            string s = "0123456789abcdefghijklmnoprstuvyz";
            for (int i = 0; i < s.Length; i++)
            {
                random += s[r.Next(s.Length)];
            }

            return random + DateTime.Now.ToShortDateString().Replace(".", "") + extension;
        }
    }
}
