using InfilonPractical.Interface;
using InfilonPractical.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace InfilonPractical.Controllers
{
    public class HomeController : Controller
    {
        private readonly IUserService _userService;

        public HomeController(IUserService userService)
        {
            _userService = userService;
        }

        public IActionResult Index()
        {
            List<UserEntity> users = _userService.GetAll();
            return View(users);
        }

        public IActionResult Edit(int? id)
        {
            UserEntity user = _userService.GetById(id);
            return View(user);
        }

        [HttpPost]
        public IActionResult Edit(UserEntity model)
        {
            if (ModelState.IsValid)
            {
                _userService.SaveUser(model);
                return RedirectToAction("Index", "Home");
            }
            return View();
        }

        [HttpPost]
        [Route("InsertUser")]
        public IActionResult InsertUser()
        {
            _userService.Insert();
            return null;
        }
        [HttpGet]
        [Route("getAllAsJson")]
        public IActionResult GetAllAsJson()
        {
            List<UserListJson> users = _userService.GetAllAsJson();
            return Ok(users);
        }
    }
}
