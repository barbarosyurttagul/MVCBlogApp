using MvcBlog.BLL;
using MvcBlog.Model;
using MvcBlog.Tools;
using MvcBlog_WebUI.App_Code;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcBlog_WebUI.Areas.AdminPanel.Controllers
{
    public class AdminController : Controller
    {
        
        public ActionResult LoginPage()
        {
            return View();
        }

        public JsonResult Login(string jSonData)
        {
            Dictionary<string, string> formData = JsonConvert.DeserializeObject<Dictionary<string, string>>(jSonData);
            string Email = formData["Email"];
            string Password = Encryption.SHA1Encryption(formData["Password"]);

            IBusiness<Member> bs = new ProcedureBL<Member>();
            Member member = bs.SelectOne(m => m.Email == Email && m.Password == Password && m.IsAdmin == true);
            if (member != null)
            {
                SessionManager.ActiveMember = member;
                return Json(new { Basarili = true, Message= "Giriş Başarılı! 3 sn.sonra yönlendirileceksiniz" });
            }
            else
            {
                return Json(new { Basarili=false, Message= "Giriş Başarısız! Email veya şifreniz yanlış" });
            }         
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult LogOut()
        {
            SessionManager.ActiveMember = null;
            return RedirectToAction("LoginPage");
        }

    }
}