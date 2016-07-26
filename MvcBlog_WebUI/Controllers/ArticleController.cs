using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Model;
using MvcBlog.BLL;
using Newtonsoft.Json;
using MvcBlog_WebUI.App_Code;

namespace MvcBlog_WebUI.Controllers
{
    public class ArticleController : Controller
    {
        IBusiness<Article> bs = new ProcedureBL<Article>();//Birden çok kullandığım için scope'un dışına yazdım.

        PersonalBlogEntities ctx = new PersonalBlogEntities();
        //Üzerine tıklanan Makalenin detay sayfasını açmak için

        public ActionResult Detail(int id)
        {
            //Makalede bulunan etiketleri bulmak ve view'a yollamak için aşağıdaki satırları kullanıyoruz.
            ViewBag.tagData = ctx.Tags.Where(x => x.Articles.Any(me => me.Id == id));
            ViewBag.lastTagData = ctx.Tags.Where(x => x.Articles.Any(me => me.Id == id)).ToList().LastOrDefault();


            //Makalede bulunan yorumları bulmak ve view'a yollamak için aşağıdaki satırları kullanıyoruz.
            IBusiness<Comment> bsComment = new ProcedureBL<Comment>();
            ViewBag.commentData = bsComment.SelectUnordered(c => c.ArticleId == id).ToList();

            ViewBag.Member = SessionManager.ActiveMember;

            /*Sonraki makale bilgisini göndermek için ViewBag kullandım. 
            //Article tablosunda son id'ye gelince bir sonraki id hata vereceği için
            lastid ile sonid'yi bularak önlem aldım.
            */
            int lastId = bs.SelectOrdered<int>(a => a.Id > 0, a => a.Id, Order.DECREASE).FirstOrDefault().Id;
            int firstId= bs.SelectOrdered<int>(a => a.Id > 0, a => a.Id, Order.INCREASE).FirstOrDefault().Id;
            
            
            if (id != lastId)
            {
                int nextId = ctx.Articles.OrderBy(x => x.Id).Where(x => x.Id > id).FirstOrDefault().Id;
                ViewBag.nextArticle = bs.SelectOne(na => na.Id == nextId);
            }     
            else
                ViewBag.nextArticle = bs.SelectOne(na => na.Id == firstId);
            
            if(id != firstId)
            {
                int previousId = ctx.Articles.OrderByDescending(x => x.Id).Where(x => x.Id < id).FirstOrDefault().Id;
                ViewBag.prevArticle = bs.SelectOne(pa => pa.Id == previousId);
            }
                
            else
                ViewBag.prevArticle = bs.SelectOne(pa => pa.Id == lastId);

            //parametre olarak gönderilen id'ye eşit olan makaleyi bularak view'a tek bir makale olarak gönderiyoruz.
            Article article = bs.SelectOne(a => a.Id == id);
            return View(article);
        }

        //Makalenin detay sayfasında bir önceki makaleye geçmek için
        public ActionResult DetailPrev(int id)
        {
            //Eğer 1 numaralı id olmadığı sürece aşağıdakini yap
            if (id != 1)
            {
                int previousId = ctx.Articles.OrderByDescending(x => x.Id).Where(x => x.Id < id).FirstOrDefault().Id;
                return Redirect("/Article/Detail/" + previousId);
            }
            //Eğer 1 numaralı id'ye ulaşılmışsa hata vermemesi için son id'ye sahip kayıta ulaşıyoruz.
            else
            {
                int lastId = bs.SelectOrdered<int>(a => a.Id > 0, a => a.Id, Order.DECREASE).First().Id;
                return Redirect("/Article/Detail/" + lastId);
            }
        }

        //Makalenin detay sayfasında bir sonraki makaleye geçmek için
        public ActionResult DetailNext(int id)
        {
            //Son girilen makalenin id'sini bulmak için. Makaleleri id'si azalan şeklinde sıralayıp ilkini seçerek id'sini buluyoruz.
            int lastId = bs.SelectOrdered<int>(a => a.Id > 0, a => a.Id, Order.DECREASE).First().Id;

            if (id != lastId)
            {
                int nextId = ctx.Articles.OrderBy(x => x.Id).Where(x => x.Id > id).FirstOrDefault().Id;
                return Redirect("/Article/Detail/" + nextId);
            }
            else
            {
                //Son id'ye ulaşıldığında bir sonraki makaleye geçerken hata vermemesi için ilk makalenin id'sini buluyoruz.
                int firstId = bs.SelectOrdered<int>(a => a.Id > 0, a => a.Id, Order.INCREASE).First().Id;
                return Redirect("/Article/Detail/" + firstId);
            }
        }

        public ActionResult ListByDate(int year, int month)
        {
            List<Article> data = bs.SelectUnordered(d => d.PublishDate.Value.Year == year && d.PublishDate.Value.Month == month);
            return View(data);
        }

        public JsonResult SaveComment(string incomingData)
        {
            Dictionary<string, string> col = JsonConvert.DeserializeObject<Dictionary<string, string>>(incomingData);

            IBusiness<Comment> bs = new ProcedureBL<Comment>();
            Comment comment = new Comment();
            comment.MemberId = SessionManager.ActiveMember.Id;
            comment.IsActive = true;
            comment.AddedDate = DateTime.Now;
            comment.ArticleId = Convert.ToInt32(col["articleId"]);
            comment.CommentContent = col["comment"];

            bs.Save(comment);

            return Json(new { Basari = true, Mesaj = "Yorum Başarıyla Kaydedildi" });
        }

    }
}