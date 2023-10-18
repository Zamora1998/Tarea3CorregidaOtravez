using ClasesData;
using Controlador.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Controlador.Controllers
{
    public class CategoriasController : Controller
    {
        private RestauranteEntities Categ = new RestauranteEntities();

        public CategoriasController()
        {
            Categ.Configuration.LazyLoadingEnabled = false;
            Categ.Configuration.ProxyCreationEnabled = false;
        }
        public JsonResult ObtenerCategorias()
        {
            var categorias = Categ.Categorias
                .Select(c => new Categoriasclasso
                {
                    CategoriaID = c.CategoriaID,
                    Nombre = c.Nombre
                })
                .ToList();
            var categoriasConOrden = categorias.Select(c => new
            {
                CategoriaID = c.CategoriaID,
                Nombre = c.Nombre
            }).ToList();

            return Json(categoriasConOrden, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public HttpStatusCodeResult AgregarCategoria(Categoriasclasso nuevaCategoria)
        {
            try
            {
                var categoriaExistente = Categ.Categorias.FirstOrDefault(c => c.Nombre == nuevaCategoria.Nombre);

                if (categoriaExistente != null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Conflict);
                }

                var nuevaCategoriaEntity = new Categorias
                {
                    Nombre = nuevaCategoria.Nombre
                };

                Categ.Categorias.Add(nuevaCategoriaEntity);
                Categ.SaveChanges();
                return new HttpStatusCodeResult(HttpStatusCode.Created);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
        }
        [HttpDelete]
        public ActionResult EliminarCategoria(int id)
        {
            try
            {
                var categoriaExistente = Categ.Categorias.FirstOrDefault(c => c.CategoriaID == id);

                if (categoriaExistente == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.NotFound);
                }

                Categ.Categorias.Remove(categoriaExistente);
                Categ.SaveChanges();

                return new HttpStatusCodeResult(HttpStatusCode.OK);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
        }

        [HttpPut]
        public ActionResult EditarCategoria(string nombreActual, Categoriasclasso categoriaEditada)
        {
            try
            {
                var categoriaExistente = Categ.Categorias.FirstOrDefault(c => c.Nombre == nombreActual);

                if (categoriaExistente == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.NotFound);
                }

                var otroCategoriaMismoNombre = Categ.Categorias.FirstOrDefault(c => c.Nombre == categoriaEditada.Nombre && c.Nombre != nombreActual);

                if (otroCategoriaMismoNombre != null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Conflict);
                }

                categoriaExistente.Nombre = categoriaEditada.Nombre;

                Categ.SaveChanges();
                return new HttpStatusCodeResult(HttpStatusCode.OK);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
        }

        [HttpGet]
        public ActionResult ObtenerCategoriasnombre()
        {
            try
            {
                var todasLasCategorias = Categ.Categorias.ToList();
                return Json(todasLasCategorias, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
        }

    }
}