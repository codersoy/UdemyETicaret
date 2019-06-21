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

        [HttpGet]
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
                user.Member.MemberType = DB.MemberTypes.Customer;
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

        [HttpGet]
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

        [HttpGet]
        public ActionResult Logout()
        {
            Session["LogOnUser"] = null;
            return RedirectToAction("Login", "Account");
        }

        [HttpGet]
        public ActionResult Profile(int id = 0, string ad = "")
        {
            List<DB.Addresses> adresses = null;
            DB.Addresses currentAdres = new DB.Addresses();
            if (id == 0)
            {
                id = base.CurrentUserId();
                adresses = context.Addresses.Where(x => x.Member_Id == id).ToList();
                if (string.IsNullOrEmpty(ad) == false)
                {
                    var guid = new Guid(ad);
                    currentAdres = context.Addresses.FirstOrDefault(x => x.Id == guid);
                }
            }
            var user = context.Members.FirstOrDefault(x => x.Id == id);
            if (user == null)
            {
                return RedirectToAction("Index", "i");
            }
            ProfileModels model = new ProfileModels()
            {
                Members = user,
                Addresses = adresses,
                CurrentAddress = currentAdres
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

        [HttpPost]
        public ActionResult Address(DB.Addresses address, string Cancel)
        {
            if (!string.IsNullOrEmpty(Cancel))
            {
                return RedirectToAction("Profile", "Account");
            }
            DB.Addresses _address = null;
            if (address.Id == Guid.Empty)
            {
                address.Id = Guid.NewGuid();
                address.AddedDate = DateTime.Now;
                address.Member_Id = base.CurrentUserId();
                context.Addresses.Add(address);
            }
            else
            {
                _address = context.Addresses.FirstOrDefault(x => x.Id == address.Id);
                _address.ModifiedDate = DateTime.Now; context.SaveChanges();
                _address.Name = address.Name;
                _address.AdresDescription = address.AdresDescription;
            }
            context.SaveChanges();
            return RedirectToAction("Profile", "Account");
        }

        [HttpGet]
        public ActionResult RemoveAddress(string id)
        {
            var guid = new Guid(id);
            var address = context.Addresses.FirstOrDefault(x => x.Id == guid);
            context.Addresses.Remove(address);
            context.SaveChanges();
            return RedirectToAction("Profile", "Account");
        }
    }
}