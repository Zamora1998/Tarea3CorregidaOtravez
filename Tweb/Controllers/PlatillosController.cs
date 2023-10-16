/*using ClasesData;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tweb.Models;

namespace Tweb.Controllers
{
    public class PlatillosController : ApiController
    {
        private RestauranteEntities Plati = new RestauranteEntities();

        public PlatillosController()
        {
            Plati.Configuration.LazyLoadingEnabled = false;
            Plati.Configuration.ProxyCreationEnabled = false;
        }

        [HttpPost]
        [Route("api/Platillos/RegistrarPlatillo")]
        public IHttpActionResult RegistrarPlatillo(Platilloclass platilloNuevo)
        {
            try
            {
                var platilloExistente = Plati.Platillos.FirstOrDefault(p => p.Nombre == platilloNuevo.Nombre);

                if (platilloExistente != null)
                {
                    return Conflict();
                }

                var nuevoPlatillo = new Platillos
                {
                    Nombre = platilloNuevo.Nombre,
                    Costo = platilloNuevo.Costo,
                    CategoriaID = platilloNuevo.CategoriaID,
                    IDESTADO = platilloNuevo.IDESTADO
                };

                Plati.Platillos.Add(nuevoPlatillo);
                Plati.SaveChanges();

                var requestUri = Request.RequestUri;
                var newResourceUrl = new Uri(requestUri, $"api/Platillos/RegistrarPlatillo/{nuevoPlatillo.PlatilloID}");
                return Created(newResourceUrl, "R");
            }
            catch (Exception)
            {
                return InternalServerError();
            }

        }

        [HttpPut]
        [Route("api/Platillos/EditarPlatillo")]
        public IHttpActionResult EditarPlatillo(string nombreActual, Platilloclass platilloEditado)
        {
            try
            {
                // Buscar el platillo por nombre
                var platilloExistente = Plati.Platillos.FirstOrDefault(p => p.Nombre == nombreActual);

                if (platilloExistente == null)
                {
                    return NotFound();
                }

                platilloExistente.Nombre = platilloEditado.Nombre;
                platilloExistente.Costo = platilloEditado.Costo;
                platilloExistente.CategoriaID = platilloEditado.CategoriaID;
                platilloExistente.IDESTADO = platilloEditado.IDESTADO;

                Plati.SaveChanges();

                return Ok("R");
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }

        [HttpDelete]
        [Route("api/Platillos/EliminarPlatillo/{nombre}")]
        public IHttpActionResult EliminarPlatillo(string nombre)
        {
            try
            {
                var platilloExistente = Plati.Platillos.FirstOrDefault(p => p.Nombre == nombre);

                if (platilloExistente == null)
                {
                    return NotFound();
                }

                Plati.Platillos.Remove(platilloExistente);
                Plati.SaveChanges();

                return Ok("R");
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }
            [HttpGet]
            [Route("api/Platillos/ListarPlatillos")]
            // En el controlador de Platillos
            public IHttpActionResult ListarPlatillos()
            {
                try
                {
                    var platillos = from p in Plati.Platillos
                                    join c in Plati.Categorias on p.CategoriaID equals c.CategoriaID
                                    join e in Plati.Estado on p.IDESTADO equals e.EstadoID
                                    select new
                                    {
                                        PlatilloID = p.PlatilloID,
                                        Nombre = p.Nombre,
                                        Costo = p.Costo,
                                        CategoriaNombre = c.Nombre,
                                        EstadoDescripcion = e.Descripcion
                                    };

                    return Ok(platillos);
                }
                catch (Exception ex)
                {
                    return InternalServerError(ex);
                }
            }

        [HttpGet]
        [Route("api/Listado/ListarPlatillosPorCategoria")]
        public IHttpActionResult ListarPlatillosPorCategoria(string categoriaSeleccionada)
        {
            try
            {
                var platillos = from p in Plati.Platillos
                                join c in Plati.Categorias on p.CategoriaID equals c.CategoriaID
                                join e in Plati.Estado on p.IDESTADO equals e.EstadoID
                                where c.Nombre == categoriaSeleccionada
                                select new
                                {
                                    PlatilloID = p.PlatilloID,
                                    Nombre = p.Nombre,
                                    Costo = p.Costo,
                                    CategoriaNombre = c.Nombre,
                                    EstadoDescripcion = e.Descripcion
                                };

                return Ok(platillos);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        } 
    }
}
*/