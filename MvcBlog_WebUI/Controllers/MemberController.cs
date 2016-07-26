using MvcBlog_WebUI.App_Code;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Tools;
using MvcBlog.BLL;
using MvcBlog.Model;
using System.Text;

namespace MvcBlog_WebUI.Controllers
{
    public class MemberController : Controller
    {
        PersonalBlogEntities ctx = new PersonalBlogEntities();

        public JsonResult RegisterUser(string jSonVeri)//Normal yoldan kayıt olma metodu. Facebook için ayrıca yapıldı
        {
            try
            {
                Dictionary<string, string> formVeri = JsonConvert.DeserializeObject<Dictionary<string, string>>(jSonVeri);
                IBusiness<Member> bs = new ProcedureBL<Member>();

                if (SessionManager.CaptchaCode != formVeri["CaptchaCode"])
                {
                    return Json(new { Basari = false, Mesaj = "Güvenlik Kodunu Yanlış Girdiniz" });
                }

                
                string email = formVeri["Email"];

                if (bs.SelectOne(k => k.Email == email) != null)
                {
                    return Json(new { Basari = false, Mesaj = "Böyle bir mail hesabı daha önceden kaydolmuş" });
                }

                Member member = new Member();
                member.Id = Guid.NewGuid().ToString();
                member.Name = formVeri["Name"];
                member.LastName = formVeri["LastName"];
                member.ActivationCode = RandomValueGenerator.GenerateActivationCode();
                member.Email = formVeri["Email"];
                
                member.IsActive = false;
                member.Password = Encryption.SHA1Encryption(formVeri["Password"]);
                member.RegisterDate = DateTime.Now;
                member.PhotoId = 8;
                member.MemberTypeId = 1;// Kulllanıcı tipi normal yoldan kayıt olan kullanıcı
                member.IsAdmin = false;

                ctx.Members.Add(member);
                ctx.SaveChanges();
                

                SendMail(member);

                return Json(new { Basari = true, Mesaj = "Kullanıcı Kayıt Başarılı. Mailden aktivasyon yapınız. 3 sn sonra ana sayfa yönleneceksiniz." });
            }
            catch (Exception ex)
            {
                return Json(new { Basari = false, Mesaj = "Bir hata oluştu " + ex.Message });
            }


        }

        public JsonResult RegisterFacebookUser(string jSonVeri)
        {
            try
            {
                Dictionary<string, string> formVeri = JsonConvert.DeserializeObject<Dictionary<string, string>>(jSonVeri);
                IBusiness<Member> bs = new ProcedureBL<Member>();
                string email = "";
                if (formVeri["Email"] != null)
                {
                    email = formVeri["Email"];
                }


                if (bs.SelectOne(k => k.Email == email) != null)
                {
                    return Json(new { Basari = false, Mesaj = "Böyle bir mail hesabı daha önceden kaydolmuş" });
                }

                Member member = new Member();
                member.Id = formVeri["Id"];
                member.Name = formVeri["Name"];
                member.LastName = formVeri["LastName"];
                member.Email = formVeri["Email"];
                member.PictureURL = "http://graph.facebook.com/" + formVeri["Id"] + "/picture?type=large";
                member.MemberTypeId = 2; // Kullanıcı tipi Facebook Kullanıcısı
                member.IsActive = true;

                member.RegisterDate = DateTime.Now;
                member.PhotoId = null;

                member.IsAdmin = false;

                ctx.Members.Add(member);
                ctx.SaveChanges();
                //bs.Save(member);

                SendMailForFacebookUser(member);

                return Json(new { Basari = true, Mesaj = "Facebook ile giriş başarılı. Hesabınıza kayıt olduğunuza dair mail gönderildi. 3 sn sonra ana sayfa yönleneceksiniz." });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    Basari = false,
                    Mesaj = "Bir hata oluştu " + ex.Message
                });
            }


        }

        private void SendMail(Member member)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Sayın ");
            sb.Append(member.Name + " ");
            sb.Append(member.LastName);
            sb.Append("<br/><br/><b><i>MVC Blog sitemize başarıyla kayıt oldunuz. Hoşgeldiniz</i></b>. <br/><br/>Lütfen şu kodu ");
            sb.Append("<b>"+member.ActivationCode+"</b>");
            sb.Append("<a href='http://localhost:4300/Member/Activation'>&nbsp;&nbsp;GİRİNİZ(TIKLA)</a>. ");

            MailSender.SendMail(member.Email, sb.ToString(), "Kayıt Mesajı");
        }

        private void SendMailForFacebookUser(Member member)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Sayın ");
            sb.Append(member.Name + " ");
            sb.Append(member.LastName);
            sb.Append("<br/><br/><b><i>MVC Blog sitemize Facebook hesabınızla başarıyla kayıt oldunuz. Hoşgeldiniz</i></b>.");


            MailSender.SendMail(member.Email, sb.ToString(), "Kayıt Mesajı");
        }

        public ActionResult Activation()
        {
            return View();
        }

        public JsonResult Activate(string code)
        {
            IBusiness<Member> bs = new ProcedureBL<Member>();
            Member member =
                bs.SelectOne(k => k.ActivationCode.ToString() == code);
            if (member != null)
            {
                member.IsActive = true;
                ctx.SaveChanges();
                return Json(new { Basari = true, Mesaj = "Hesabınız başarıyla aktifleştirildi" });
            }

            return Json(new { Basari = false, Mesaj = "Bu kodla ilişkili kayıt bulunamadı. Kodu doğru giriniz" });
        }

        public ActionResult LoginUser()
        {
            return View();
        }

        public JsonResult Login(string jSonVeri)
        {
            try
            {
                Dictionary<string, string> formData = JsonConvert.DeserializeObject<Dictionary<string, string>>(jSonVeri);

                string mail = formData["Mail"];
                string password = Encryption.SHA1Encryption(formData["Password"]);

                IBusiness<Member> bs = new ProcedureBL<Member>();
                Member member = bs.SelectOne(m => m.Email == mail && m.Password == password);

                if (member != null)
                {
                    SessionManager.ActiveMember = member;
                    return Json(new { Basarili = true });
                }
                else
                {
                    return Json(new { Basarili = false });
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    Basari = false,
                    Mesaj = "Bir hata oluştu " + ex.Message
                });
            }
        }

        public JsonResult FacebookLogin(string jSonVeri)
        {
            try
            {
                Dictionary<string, string> formData = JsonConvert.DeserializeObject<Dictionary<string, string>>(jSonVeri);

                string mail = formData["Email"];

                IBusiness<Member> bs = new ProcedureBL<Member>();
                Member member = bs.SelectOne(m => m.Email == mail);

                if (member != null)
                {
                    SessionManager.ActiveMember = member;
                    return Json(new { Basarili = true });
                }
                else
                {
                    return Json(new { Basarili = false });
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    Basari = false,
                    Mesaj = "Bir hata oluştu " + ex.Message
                });
            }
        }

        public void LogOut()
        {
            SessionManager.ActiveMember = null;
        }
    }
}