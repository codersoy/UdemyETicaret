using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UdemyETicaret.Controllers
{
    public class CategoryController : BaseController
    {
        [HttpGet]
        public ActionResult Index()
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            else if (((int)(CurrentUser().MemberType)) < 4)
            {
                return RedirectToAction("Index", "i");
            }
            var cats = context.Categories.Where(x => x.isDeleted == false || x.isDeleted == null).ToList();

            //Eklenen ürünü en üstte göstermek için yaptık
            return View(cats.OrderByDescending(x => x.AddedDate).ToList());
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            var category = context.Categories.FirstOrDefault(x => x.Id == id);
            var categories = context.Categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString()
            }).ToList();
            categories.Add(new SelectListItem()
            {
                Text = "Ana Kategori",
                Selected = true,
                Value = "0"
            });
            ViewBag.Categories = categories;
            return View(category);
        }

        [HttpPost]
        public ActionResult Edit(DB.Categories category)
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            //Var olan kategoriyi güncellemek için
            if (category.Id > 0)
            {
                var cat = context.Categories.FirstOrDefault(x => x.Id == category.Id);
                cat.Description = category.Description;
                cat.Name = category.Name;
                cat.ModifedDate = DateTime.Now;
                cat.isDeleted = false;

                if (category.Parent_Id > 0)
                    cat.Parent_Id = category.Parent_Id;

                else
                    cat.Parent_Id = null;
            }

            //Yeni bir kategori eklemek için
            else
            {
                category.AddedDate = DateTime.Now;
                category.isDeleted = false;
                if (category.Parent_Id == 0)
                    category.Parent_Id = null;
                context.Entry(category).State = System.Data.Entity.EntityState.Added;
            }
            context.SaveChanges();
            return RedirectToAction("Index", "Category");
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            var cat = context.Categories.FirstOrDefault(x => x.Id == id);
            cat.isDeleted = true;
            context.SaveChanges();
            return RedirectToAction("Index", "Category");
        }
    }
}