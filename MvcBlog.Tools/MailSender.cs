using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace MvcBlog.Tools
{
    public static class MailSender
    {
        public static void SendMail(string receiver, string message, string subject)
        {
            MailAddress from = new MailAddress(ConfigurationManager.AppSettings["MyMailAddress"], "MVC Blog Activation");
            MailAddress to = new MailAddress(receiver);

            MailMessage msg = new MailMessage(from, to);
            msg.Subject = subject;
            msg.Body = message;
            msg.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["MailUserName"], ConfigurationManager.AppSettings["MailPassword"]);
            smtp.EnableSsl = true;
            smtp.Send(msg);

        }
    }
}
