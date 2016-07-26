using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Model;
using MvcBlog.BLL;

namespace MvcBlog_WebUI.Controllers
{
    public class ArchiveController : Controller
    {
        IBusiness<Article> bs = new ProcedureBL<Article>();

        public ActionResult Index(int year, int month)
        {
            List<Article> data = bs.SelectUnordered(d => d.PublishDate.Value.Year == year && d.PublishDate.Value.Month == month);
            return View(data); ;
        }
    }
}