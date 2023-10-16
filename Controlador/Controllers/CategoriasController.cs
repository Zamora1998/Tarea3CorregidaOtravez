using ClasesData;
using Controlador.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Controlador.Controllers
{
    public class CategoriasController : Controller
    {
        // GET: Categorias
        private RestauranteEntities Categ = new RestauranteEntities();

        public CategoriasController()
        {
            Categ.Configuration.LazyLoadingEnabled = false;
            Categ.Configuration.ProxyCreationEnabled = false;
        }

        // GET: Categorias/ObtenerCategorias
        public JsonResult ObtenerCategorias()
        {
            var categorias = Categ.Categorias
                .Select(c => new Categoriasclasso
                {
                    CategoriaID = c.CategoriaID,
                    Nombre = c.Nombre
                })
                .ToList();

            // Reorganizar las propiedades en el JSON
            var categoriasConOrden = categorias.Select(c => new
            {
                CategoriaID = c.CategoriaID,
                Nombre = c.Nombre
            }).ToList();

            return Json(categoriasConOrden, JsonRequestBehavior.AllowGet);
        }
    }
}