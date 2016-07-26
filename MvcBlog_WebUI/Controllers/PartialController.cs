using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Model;
using MvcBlog.BLL;
using System.Data.SqlClient;
using MvcBlog_WebUI.App_Code;

namespace MvcBlog_WebUI.Controllers
{
    public class PartialController : Controller
    {
        PersonalBlogEntities ctx = new PersonalBlogEntities();

        public ActionResult ListCategory()
        {
            IBusiness<Category> bs = new ProcedureBL<Category>();
            List<Category> categories = bs.SelectAll();
            return PartialView(categories);
        }

        public ActionResult ListRecentComments()
        {
            IBusiness<Comment> bs = new ProcedureBL<Comment>();
            List<Comment> comments = bs.SelectOrdered<DateTime>(a => a.AddedDate != null & a.IsActive == true, a => a.AddedDate.Value, Order.DECREASE).Take(4).ToList();
            return PartialView(comments);
        }

        public ActionResult ListPopularArticles()
        {
            IBusiness<Article> bs = new ProcedureBL<Article>();
            List<Article> articles = bs.SelectOrdered<int>(a => a.Displayed != null & a.Active==true, a => a.Displayed.Value, Order.DECREASE).Take(4).ToList();
            return PartialView(articles);
        }

        public PartialViewResult ListTags()
        {
            IBusiness<Tag> bs = new ProcedureBL<Tag>();
            List<Tag> tags = bs.SelectAll();
            return PartialView(tags);
        }

        public PartialViewResult ListArchives()
        {
            IEnumerable<DateTime> DistinctYearMonths = ctx.Articles
                .Select(a => new { a.PublishDate.Value.Year, a.PublishDate.Value.Month })
                .Distinct()
                .Take(3)
                .ToList()
                .Select(x => new DateTime(x.Year, x.Month, 1))
                .Reverse();
            return PartialView(DistinctYearMonths);
        }

        public PartialViewResult Login()
        {
            Member member = SessionManager.ActiveMember;
            if (member != null)
            {
                ViewBag.MemberActive = true;
                ViewBag.Member = member;
            }
            else
            {
                ViewBag.MemberActive = false;
            }

            return PartialView();
        }

    }
}