using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UdemyETicaret.Controllers
{
    public class ProductController : BaseController
    {
        [HttpGet]
        public ActionResult Index()
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            else if (((int)(CurrentUser().MemberType)) < 4)
            {
                return RedirectToAction("Index", "i");
            }
            var products = context.Products.Where(x => x.isDeleted == false || x.isDeleted == null).ToList();

            //Eklenen ürünü en üstte göstermek için yaptık
            return View(products.OrderByDescending(x=>x.AddedDate).ToList());
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            var product = context.Products.FirstOrDefault(x => x.Id == id);
            var categories = context.Categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString()
            }).ToList();
            ViewBag.Categories = categories;
            return View(product);
        }

        [HttpPost]
        public ActionResult Edit(DB.Products product)
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            var productImagePath = string.Empty;

            if (Request.Files != null && Request.Files.Count > 0)
            {
                var file = Request.Files[0];
                if (file.ContentLength > 0)
                {
                    var folder = Server.MapPath("~/images/upload/Product");
                    var fileName = Guid.NewGuid() + ".jpg";
                    file.SaveAs(Path.Combine(folder, fileName));

                    var filePath = "images/upload/Product/" + fileName;
                    productImagePath = filePath;
                }
            }

            if (product.Id > 0)
            {
                var dbProduct = context.Products.FirstOrDefault(x => x.Id == product.Id);
                dbProduct.Category_Id = product.Category_Id;
                dbProduct.ModifiedDate = DateTime.Now;
                dbProduct.Description = product.Description;
                dbProduct.IsContinued = product.IsContinued;
                dbProduct.Name = product.Name;
                dbProduct.Price = product.Price;
                dbProduct.UnitsInStock = product.UnitsInStock;
                dbProduct.isDeleted = false;
                if (string.IsNullOrEmpty(productImagePath) == false)
                {
                    dbProduct.ProductImageName = productImagePath;
                }

            }
            else
            {
                product.AddedDate = DateTime.Now;
                product.ProductImageName = productImagePath;
                product.isDeleted = false;
                context.Entry(product).State = System.Data.Entity.EntityState.Added;
            }



            context.SaveChanges();

            return RedirectToAction("Index", "Product");
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            if (IsLogon() == false) return RedirectToAction("Index", "i");
            var pro = context.Products.FirstOrDefault(x => x.Id == id);
            pro.isDeleted = true;
            context.SaveChanges();
            return RedirectToAction("Index", "Product");
        }
    }
}