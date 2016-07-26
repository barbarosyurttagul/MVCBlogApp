using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MvcBlog.Tools
{
    public static class CaptchGenerator
    {
        public static string CaptchaCode { get; private set; }

        public static byte[] GenerateCaptcha()
        {
            Bitmap bmp = new Bitmap(150, 30);
            Graphics gr = Graphics.FromImage(bmp); // bmp nesnesi üzerine bağlı bir Graphics nesnesi yarattık. Çünkü çizimlerimizi gr nesnesi ile yapabiliyoruz.

            HatchBrush brush = RandomValueGenerator.GenerateBrush();

            
            Rectangle rect = new Rectangle(0, 0, bmp.Width, bmp.Height);

            gr.FillRectangle(brush, rect);

            Font font = new Font("Verdana", 12f, FontStyle.Italic);

            CaptchaCode = RandomValueGenerator.GenerateCaptchaCode(5, true);

            gr.DrawString(CaptchaCode, font, Brushes.White, new PointF(5, 5));

            MemoryStream ms = new MemoryStream();
            bmp.Save(ms, ImageFormat.Png);
            return ms.ToArray();
        }
    }
}
