using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Tools;
using MvcBlog_WebUI.App_Code;

namespace MvcBlog_WebUI.Controllers
{
    public class ToolsController : Controller
    {
        // GET: Tools
        public FileContentResult CaptchaImage()
        {
            FileContentResult fr = this.File(CaptchGenerator.GenerateCaptcha(), "image/png");
            SessionManager.CaptchaCode = CaptchGenerator.CaptchaCode;

            return fr;
        }
    }
}