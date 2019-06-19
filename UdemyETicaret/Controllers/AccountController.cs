using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UdemyETicaret.DB;
using UdemyETicaret.Models.Account;

namespace UdemyETicaret.Controllers
{
    public class AccountController : BaseController
    {

        // GET: Account
        public ActionResult Register()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Register(Models.Account.RegisterModels user)
        {
            try
            {
                if (user.rePassword != user.Member.Password)
                {
                    throw new Exception("Şifreler uyuşmuyor.");
                }
                if (context.Members.Any(x => x.Email == user.Member.Email))
                {
                    throw new Exception("Bu e-posta adresine kayıtlı kullanıcı var.");
                }
                user.Member.MemberType = DB.MemberType.Customer;
                user.Member.AddedDate = DateTime.Now;
                context.Members.Add(user.Member);
                context.SaveChanges();
                return RedirectToAction("Login", "Account");
            }
            catch (Exception ex)
            {
                ViewBag.RegError = ex.Message;
                return View();
            }
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Models.Account.LoginModels model)
        {
            try
            {
                var user = context.Members.FirstOrDefault(x => x.Password == model.Member.Password && x.Email == model.Member.Email);
                if (user != null)
                {
                    Session["LogOnUser"] = user;
                    return RedirectToAction("Index", "i");
                }
                else
                {
                    ViewBag.RegError = "Kullanıcı bilgileriniz hatalı.";
                    return View();
                }
            }
            catch (Exception ex)
            {
                ViewBag.RegError = ex.Message;
                return View();
            }
        }

        public ActionResult Logout()
        {
            Session["LogOnUser"] = null;
            return RedirectToAction("Login", "Account");
        }

        public ActionResult Profile(int id = 0)
        {
            if (id == 0)
            {
                id = base.CurrentUserId();
            }
            var user = context.Members.FirstOrDefault(x => x.Id == id);
            if (user == null)
            {
                return RedirectToAction("Index", "i");
            }
            ProfileModels model = new ProfileModels()
            {
                Members = user
            };
            return View(model);
        }

        [HttpGet]
        public ActionResult ProfileEdit()
        {
            int id = base.CurrentUserId();
            var user = context.Members.FirstOrDefault(x => x.Id == id);
            if (user == null)
            {
                return RedirectToAction("Index", "i");
            }
            ProfileModels model = new ProfileModels()
            {
                Members = user
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult ProfileEdit(ProfileModels model)
        {
            try
            {
                int id = CurrentUserId();
                var updateMember = context.Members.FirstOrDefault(x => x.Id == id);
                updateMember.ModifiedDate = DateTime.Now;
                updateMember.Bio = model.Members.Bio;
                updateMember.Name = model.Members.Name;
                updateMember.Surname = model.Members.Surname;

                if (string.IsNullOrEmpty(model.Members.Password) == false)
                {
                    updateMember.Password = model.Members.Password;
                }
                if (Request.Files != null && Request.Files.Count > 0)
                {
                    var file = Request.Files[0];
                    if (file.ContentLength > 0)
                    {
                        var folder = Server.MapPath("~/images/upload");
                        var fileName = Guid.NewGuid() + ".jpg";
                        file.SaveAs(Path.Combine(folder, fileName));

                        var filePath = "images/upload/" + fileName;
                        updateMember.ProfileImageName = filePath;
                    }
                }
                context.SaveChanges();

                return RedirectToAction("Profile", "Account");
            }
            catch (Exception ex)
            {
                ViewBag.MyError = ex.Message;
                int id = CurrentUserId();
                var ViewModel = new Models.Account.ProfileModels()
                {
                    Members = context.Members.FirstOrDefault(x => x.Id == id)
                };
                return View(ViewModel);
            }
        }

    }
}