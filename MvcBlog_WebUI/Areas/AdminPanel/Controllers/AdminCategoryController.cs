using MvcBlog.BLL;
using MvcBlog.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcBlog_WebUI.Areas.AdminPanel.Controllers
{
    public class AdminCategoryController : Controller
    {
       
        public ActionResult Index()
        {
            IBusiness<Category> bs = new ProcedureBL<Category>();
            List<Category> categories = bs.SelectAll();
            return View(categories);
        }

        public JsonResult Update(string jSonData)
        {
            Dictionary<string, string> formData = JsonConvert.DeserializeObject<Dictionary<string, string>>(jSonData);
            int id = Convert.ToInt32(formData["categoryId"]);
            string updatedCategory = formData["categoryName"];
            if (updatedCategory!="")
            {
                IBusiness<Category> bs = new ProcedureBL<Category>();
                Category category = bs.SelectOne(c => c.Id == id);
                category.CategoryName = updatedCategory;
                bs.Save(category);
                return Json(new {Basarili=true, Message="Kategori Güncellendi"});
            }
            else
            {
                return Json(new { Basarili = false, Message = "Kategori Boş Bırakılamaz" });
            }    
        }

        public ActionResult Insert(string newCategory)
        {

            IBusiness<Category> bs = new ProcedureBL<Category>();
            List<Category> categories = bs.SelectAll();
            Category isExistingCategory = bs.SelectOne(c => c.CategoryName == newCategory);

            if (newCategory != "" && isExistingCategory == null)//Kategori kutusu boş bırakılmadıysa ve Daha önceden aynısı girilmediyse
            {    
                Category category = new Category();
                category.CategoryName = newCategory;
                bs.Save(category);
                List<Category> newCategories = bs.SelectAll();
                return PartialView(newCategories);
            }
            else
            {
                return PartialView("InsertError", categories);
            }
        }

    }
}