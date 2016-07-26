using MvcBlog.BLL;
using MvcBlog.Model;
using MvcBlog.Tools;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcBlog_WebUI.Areas.AdminPanel.Controllers
{
    public class AdminArticleController : Controller
    {
        PersonalBlogEntities context = new PersonalBlogEntities();
        public ActionResult Article()
        {
            #region dropdownlist Kategori
            List<Category> categories = new ProcedureBL<Category>().SelectOrdered<string>(c => c.Id > 0, c => c.CategoryName, Order.INCREASE);
            List<SelectListItem> listItem = new List<SelectListItem>();

            for (int i = 0; i < categories.Count; i++)
            {
                SelectListItem item = new SelectListItem();
                item.Text = categories[i].CategoryName;
                item.Value = categories[i].Id.ToString();
                listItem.Add(item);
            }
            ViewBag.ddlCategory = new SelectList(listItem, "Value", "Text"); 
            #endregion

            return View();
        }

        #region Önce Resmi Yükledim
        public JsonResult ArticleImageUpload()
        {
            HttpPostedFileBase hpf = Request.Files[0];
            string randomFileName = string.Empty;

            if (hpf != null && hpf.ContentLength > 0)
            {
                if (!hpf.ContentType.Contains("image/"))
                {
                    return Json(new { Basari = false, Message = "Yalnızca resim dosyası yükleyebilirsiniz" });
                }

                if (hpf.ContentLength > 1024 * 1024)
                {
                    return Json(new { Basari = false, Message = "Dosya 1 MB'dan büyük olamaz" });
                }

                randomFileName = RandomValueGenerator.GenerateRandomFileName(new FileInfo(hpf.FileName).Extension);

                hpf.SaveAs(Server.MapPath("~/Content/images/") + randomFileName);

                IBusiness<Photo> bs = new ProcedureBL<Photo>();
                Photo photo = new Photo();
                photo.Name = randomFileName;
                photo.CoverPicPath = "/Content/images/" + randomFileName;
                photo.AddDate = DateTime.Now;
                bs.Save(photo);
                return Json(new { Basari = true });
            }

            return Json(new { Basari = false, Message = "Resim yüklemediniz" });

        }
        #endregion

        #region Sonra Makaleyi Ekledim
        [ValidateInput(false)]
        public JsonResult AddArticle(string jSonData)
        {
            Dictionary<string, string> formData = JsonConvert.DeserializeObject<Dictionary<string, string>>(jSonData);

            IBusiness<Article> bs = new ProcedureBL<Article>();
            Article article = new Article();
            IBusiness<Photo> bsPhoto = new ProcedureBL<Photo>();

            article.ArticleName = formData["ArticleName"];
            article.ArticleContent = formData["Content"];
            article.CategoryId = Convert.ToInt32(formData["CategoryId"]);
            article.PublishDate = DateTime.Now;
            article.CoverPhotoId = bsPhoto.SelectOrdered<int>(p => p.Id > 0, p => p.Id, Order.DECREASE).FirstOrDefault().Id;
            article.Displayed = 0;
            article.Active = true;


            #region Etiket Ekleme
            string[] tags = formData["Tags"].Split(',');
            foreach (string tagItem in tags)
            {
                Tag tag = context.Tags.FirstOrDefault(x => x.TagName.ToLower() == tagItem.ToLower().Trim());
                if (tag != null)
                {

                    article.Tags.Add(tag);
                    context.SaveChanges();
                }
                else
                {
                    tag = new Tag();
                    tag.TagName = tagItem;
                    article.Tags.Add(tag);
                    context.SaveChanges();
                }

            }
            #endregion

            context.Articles.Add(article);
            context.SaveChanges();

            return Json(new { Basari = true, Message = "Makale başarıyla kaydedildi" });
        } 
        #endregion
    }
}