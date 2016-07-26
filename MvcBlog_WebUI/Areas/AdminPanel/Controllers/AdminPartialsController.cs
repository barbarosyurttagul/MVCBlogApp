using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog_WebUI.App_Code;

namespace MvcBlog_WebUI.Areas.AdminPanel.Controllers
{
    public class AdminPartialsController : Controller
    {
        
        public PartialViewResult AdminHeader()
        {
            ViewBag.Member = SessionManager.ActiveMember;
            return PartialView();
        }

        public PartialViewResult AdminLeftSide()
        {
            return PartialView();
        }
    }
}