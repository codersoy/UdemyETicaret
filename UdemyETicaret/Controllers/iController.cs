﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UdemyETicaret.DB;
using UdemyETicaret.Models;
using UdemyETicaret.Models.i;

namespace UdemyETicaret.Controllers
{
    public class iController : BaseController
    {

        [HttpGet]
        public ActionResult Index(int? id)
        {

            IQueryable<DB.Products> products = context.Products.OrderByDescending(x=>x.AddedDate).Where(x => x.isDeleted == false || x.isDeleted == null);
            DB.Categories category = null;

            if (id.HasValue)
            {
                products = products.Where(x => x.Category_Id == id);
                category = context.Categories.FirstOrDefault(x => x.Id == id);
            }

            var viewModel = new Models.i.IndexModel()
            {
                Products = products.ToList(),
                Category = category
            };

            return View(viewModel);
        }

        [HttpGet]
        public ActionResult Product(int id = 0)
        {
            var pro = context.Products.FirstOrDefault(x => x.Id == id);
            if (pro == null)
            {
                return RedirectToAction("Index", "i");
            }
            ProductModels model = new ProductModels()
            {
                Product = pro,
                Comment = pro.Comments.ToList()
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Product(DB.Comments comment)
        {
            try
            {
                comment.Member_Id = base.CurrentUserId();
                comment.AddedDate = DateTime.Now;
                context.Comments.Add(comment);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                ViewBag.MyError = ex.Message;
            }
            return RedirectToAction("Product", "i");
        }

        [HttpGet]
        public ActionResult AddBasket(int id, bool remove = false)
        {
            List<i_BasketModels> basket = null;
            if (Session["Basket"] == null)
            {
                basket = new List<i_BasketModels>();
            }
            else
            {
                basket = (List<i_BasketModels>)Session["Basket"];
            }

            if (basket.Any(x => x.Product.Id == id))
            {
                var pro = basket.FirstOrDefault(x => x.Product.Id == id);
                if (remove && pro.Count > 0)
                {
                    pro.Count -= 1;
                }
                else
                {
                    if (pro.Product.UnitsInStock > pro.Count)
                    {
                        pro.Count += 1;
                    }
                    else
                    {
                        TempData["MyError"] = "Yeterli stok yok";
                    }
                }
            }
            else
            {
                var pro = context.Products.FirstOrDefault(x => x.Id == id);

                if (pro != null && pro.IsContinued && pro.UnitsInStock > 0)
                {
                    basket.Add(new i_BasketModels()
                    {
                        Count = 1,
                        Product = pro
                    });
                }
                else if (pro != null && pro.IsContinued == false)
                {
                    TempData["MyError"] = "Bu ürün artık satışta yok";
                }
                else if (pro != null && pro.UnitsInStock == 0)
                {
                    TempData["MyError"] = "Bu ürün stoklarda yok";
                }

            }
            basket.RemoveAll(x => x.Count < 1);
            Session["Basket"] = basket;

            return RedirectToAction("Index", "i");
        }

        [HttpGet]
        public ActionResult Basket()
        {
            List<i_BasketModels> model = (List<i_BasketModels>)Session["Basket"];

            if (model == null)
            {
                model = new List<i_BasketModels>();
            }
            if (base.IsLogon())
            {
                int currentID = CurrentUserId();
                ViewBag.CurrentAddress = context.Addresses
                    .Where(x => x.Member_Id == currentID)
                    .Select(x => new SelectListItem()
                    {
                        Text = x.Name,
                        Value = x.Id.ToString()
                    }).ToList();
            }

            ViewBag.TotalPrice = model.Select(x => x.Product.Price * x.Count).Sum();
            return View(model);
        }

        [HttpGet]
        public ActionResult RemoveBasket(int id)
        {
            List<i_BasketModels> basket = (List<i_BasketModels>)Session["Basket"];
            if (basket != null)
            {
                if (id > 0)
                {
                    basket.RemoveAll(x => x.Product.Id == id);
                }
                else if (id == 0)
                {
                    basket.Clear();
                }
                Session["Basket"] = basket;
            }
            return RedirectToAction("Basket", "i");
        }

        [HttpGet]
        public ActionResult Buy()
        {
            if (base.IsLogon())
            {
                var currentId = CurrentUserId();

                ////Ekleme yapıldı KONTROL ET
                //IQueryable<DB.Orders> orders;
                //if (((int)CurrentUser().MemberType) > 8)
                //{
                //    orders = context.Orders.Where(x => x.Status == "OB");
                //}
                //else
                //{
                //    orders = context.Orders.Where(x => x.Member_Id == currentId);
                //}
                //// EKLEME SONU 


                var order = context.Orders.Where(x => x.Member_Id == currentId);

                List<BuyModels> model = new List<BuyModels>();
                foreach (var item in order)
                {
                    var byModel = new BuyModels();
                    byModel.TotalPrice = item.OrderDetails.Sum(y => y.Price);
                    byModel.OrderName = string.Join(",", item.OrderDetails.Select(y => y.Products.Name + "(" + y.Quantity + ")"));
                    byModel.OrderStatus = item.Status;
                    byModel.OrderId = item.Id.ToString();
                    //byModel.Member = item.Members;
                    model.Add(byModel);
                }

                return View(model);
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }

        }

        [HttpPost]
        public ActionResult Buy(string Address)
        {
            if (base.IsLogon())
            {
                try
                {
                    var basket = (List<i_BasketModels>)Session["Basket"];
                    var guid = new Guid(Address);
                    var _address = context.Addresses.FirstOrDefault(x => x.Id == guid);
                    //Sipariş Verildi = SV
                    //Ödeme bildirimi = OB
                    //Ödeme onaylandı = OO
                    var order = new DB.Orders()
                    {
                        AddedDate = DateTime.Now,
                        Address = _address.AdresDescription,
                        Member_Id = CurrentUserId(),
                        Status = "SV",
                        Id = Guid.NewGuid()
                    };
                    foreach (i_BasketModels item in basket)
                    {
                        var oDetail = new DB.OrderDetails();
                        oDetail.AddedDate = DateTime.Now;
                        oDetail.Price += item.Product.Price * item.Count;
                        oDetail.Product_Id = item.Product.Id;
                        oDetail.Quantity = item.Count;
                        oDetail.Id = Guid.NewGuid();

                        order.OrderDetails.Add(oDetail);

                        var _product = context.Products.FirstOrDefault(x => x.Id == item.Product.Id);
                        if (_product != null && _product.UnitsInStock >= item.Count)
                        {
                            _product.UnitsInStock = _product.UnitsInStock - item.Count;
                        }
                        else
                        {
                            throw new Exception(string.Format("{0} ürünü için yeterli stok yoktur veya silinmiş bir ürünü almaya çalışıyorsunuz.", item.Product.Name));
                        }

                    }
                    context.Orders.Add(order);
                    context.SaveChanges();
                    Session["Basket"] = null;
                }
                catch (Exception ex)
                {
                    TempData["MyError"] = ex.Message;
                }
                return RedirectToAction("Buy", "i");
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }

        }

        [HttpPost]
        public JsonResult OrderNotif(OrderNotifModels model)
        {
            if (string.IsNullOrEmpty(model.OrderId) == false)
            {
                var guid = new Guid(model.OrderId);
                var order = context.Orders.FirstOrDefault(x => x.Id == guid);
                if (order != null)
                {
                    order.Description = model.OrderDescription;
                    order.Status = "OB";
                    context.SaveChanges();
                }
            }
            return Json("");
        }

        [HttpGet]
        public JsonResult GetProduct(int id)
        {
            var pro = context.Products.FirstOrDefault(x => x.Id == id);
            return Json(pro.Description, JsonRequestBehavior.AllowGet);
        }
    }
}