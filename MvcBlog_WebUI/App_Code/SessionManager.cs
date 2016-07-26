using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcBlog.Model;

namespace MvcBlog_WebUI.App_Code
{
    public static class SessionManager
    {
        public static string CaptchaCode
        {
            get
            {
                return HttpContext.Current.Session["CaptchaCode"].ToString();
            }
            set
            {
                HttpContext.Current.Session.Add("CaptchaCode", value);
            }
        }

        public static Member ActiveMember
        {
            get
            {
                return HttpContext.Current.Session["ActiveMember"] as Member;
            }
            set
            {
                HttpContext.Current.Session.Add("ActiveMember", value);
            }
        }
    }
}