using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.BLL;
using MvcBlog.Model;

namespace MvcBlog_WebUI.Controllers
{
    public class HomeController : Controller
    {
        PersonalBlogEntities ctx = new PersonalBlogEntities();

        public const int PageSize = 5;
        public ActionResult Index()
        {
            ViewBag.Title = "MVC BLOG SİTEM";
            IBusiness<Article> bs = new ProcedureBL<Article>();
            List<Article> articles = bs.SelectOrdered<DateTime>(a => a.PublishDate != null & a.Active == true, a => a.PublishDate.Value, Order.DECREASE).Take(PageSize).ToList();
            ViewBag.NumberOfPages = Convert.ToInt32(Math.Ceiling((double)bs.SelectAll().Count() / PageSize));
            ViewBag.CurrentPage = 1;
            return View(articles);
        }

        public ActionResult ArticleList(int page)
        {
            IBusiness<Article> bs = new ProcedureBL<Article>();
            List<Article> articles = bs.SelectOrdered<DateTime>(a => a.PublishDate != null & a.Active == true, a => a.PublishDate.Value, Order.DECREASE).Skip(PageSize * (page - 1)).Take(PageSize).ToList();
            ViewBag.NumberOfPages = Convert.ToInt32(Math.Ceiling((double)bs.SelectAll().Count() / PageSize));
            ViewBag.CurrentPage = page;
            return PartialView(articles);
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }

        public ActionResult SearchBar(string searchString)
        {
            IBusiness<Article> bs = new ProcedureBL<Article>();
            var articles = bs.SelectOrdered<DateTime>(a => a.PublishDate.Value != null && a.Active == true, a => a.PublishDate.Value, Order.DECREASE);

            if (!String.IsNullOrEmpty(searchString))
                articles = ctx.Articles.Where(a => a.ArticleName.Contains(searchString) || a.ArticleContent.Contains(searchString)).ToList();
            ViewBag.ArticleCount = articles.Count.ToString();
            
            return PartialView(articles);
        }

        

    }
}