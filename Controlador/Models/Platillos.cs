using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Controlador.Models
{
    public class Platilloclass
    {
        public string Nombre { get; set; }
        public decimal Costo { get; set; }
        public int CategoriaID { get; set; }
        public int IDESTADO { get; set; }
    }
}