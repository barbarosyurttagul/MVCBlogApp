using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Model;

namespace MvcBlog_WebUI.Controllers
{
    public class TagController : Controller
    {
        PersonalBlogEntities ctx = new PersonalBlogEntities();
        public ActionResult Index(int id)
        {
            //bir makalenin birden çok etiketi olabileceğinden parametrede gönderilen id'ye eşit olan etiket id'sine sahip makaleleri bularak list'e atıyoruz ve view'a gönderiyoruz.
            List<Article> data = ctx.Articles.Where(x => x.Tags.Any(me => me.TagId == id)).OrderByDescending(p=>p.PublishDate).ToList();
            
            ViewBag.Title = ctx.Tags.Where(t => t.TagId == id).FirstOrDefault().TagName + " etiketli makaleler";
            return View(data);
        }

    }
}