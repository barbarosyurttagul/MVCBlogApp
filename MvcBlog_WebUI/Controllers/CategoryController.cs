using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Model;
using MvcBlog.BLL;

namespace MvcBlog_WebUI.Controllers
{
    public class CategoryController : Controller
    {
        public ActionResult Index(int id)
        {
            IBusiness<Category> bsc = new ProcedureBL<Category>();
            ViewBag.Title = bsc.SelectOne(c => c.Id==id).CategoryName + " Kategorisindeki Makaleler";

            IBusiness<Article> bs = new ProcedureBL<Article>();
            List<Article> articles = bs.SelectUnordered(a => a.CategoryId == id);
            return View(articles);
        }
    }
}