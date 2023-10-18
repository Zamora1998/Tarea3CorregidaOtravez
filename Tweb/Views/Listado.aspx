<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Listado.aspx.cs" Inherits="Tweb.Views.Listado" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administracion de Platillos</title>
    <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="../JS/ListadoGeneral.js"></script>  

    
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand mr-auto" href="#">Administrador de Categorias</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="Platillos.aspx">Platillos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Categorias.aspx">Categorias</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Listado.aspx">Listado Platillos</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="dropdown">
        <button class="btn btn-secondary dropdown-toggle" type="button" id="categoriaDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Selecciona una categoría
        </button>
        <div class="dropdown-menu" aria-labelledby="categoriaDropdown" id="dropdownCategorias">
        </div>
    </div>
    <form id="form1" runat="server">
        <div>
            <h2>Platillos </h2>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#nuevoPlatilloModal" onclick="mostrarModal()">
                Agregar Platillo
            </button>
            <div class="modal fade" id="nuevoPlatilloModal" runat="server">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Nuevo Platillo</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="nombre">Nombre:</label>
                                <input type="text" class="form-control" id="nombre" runat="server" />
                            </div>
                            <div class="form-group">
                                <label for="costo">Costo:</label>
                                <input type="text" class="form-control" id="costo" runat="server" />
                            </div>
                            <div class="form-group">
                                <label for="ddlcategoria">Categoría:</label>
                                <select class="form-control" id="ddlcategoria" runat="server">
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="ddlestado">Estado:</label>
                                <select class="form-control" id="ddlestado" runat="server">
                                </select>
                            </div>
                            <span id="errorMensaje" runat="server" style="color: red;"></span>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnGuardarPlatillo" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClientClick="validarYGuardarPlatillo(); return false;" />
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="modalAdvertencia" class="modal fade" runat="server">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Advertencia</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>Por favor seleccione el platillo.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal de Confirmación -->
            <div class="modal fade" id="confirmacionModal" tabindex="-1" role="dialog" aria-labelledby="confirmacionModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmacionModalLabel">Confirmar Eliminación</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>¿Estás seguro de que deseas eliminar el platillo <span id="nombrePlatillo"></span>?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-danger" id="botonEliminar">Eliminar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal para Modificar Registro -->
            <div class="modal fade" id="modalModificar" tabindex="-1" role="dialog" aria-labelledby="modalModificarLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalModificarLabel">Modificar Platillo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class ="modal-body">
                            <p>ID de Platillo: <span id="modalPlatilloID"></span></p>
                            <p>Nombre Existente: <span id="txtmodalNombre2" class="form-control"></span></p>
                            <div class="form-group">
                                <label for="txtmodalNombre">Nombre:</label>
                                <input type="hidden" id="nombreActual" />
                                <input type="text" id="txtmodalNombre" class="form-control" placeholder="Ingrese el nuevo nombre del Platillo" pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]+" title="Solo letras, espacios y tildes/ñ" />
                            </div>
                            <div class="form-group">
                                <label for="txtmodalCosto">Costo:</label>
                                <input type="hidden" id="CostoActual" />
                                <input type="text" id="txtmodalCosto" class="form-control" placeholder="Ingrese el nuevo coste del platillo" pattern="[0-9]+(\.[0-9]{1,2})?" title="Solo números, opción decimal con hasta dos dígitos" />
                            </div>
                            <div class="form-group">
                                <label for="ddleditarcategoria">Categoría:</label>
                                <select class="form-control" id="ddleditarcategoria" runat="server">
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="ddleditarestado">Estado:</label>
                                <select class="form-control" id="ddleditarestado" runat="server">
                                </select>
                            </div>
                            <span id="errorEditar" style="color: red;"></span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" id="btnAceptarModificar">GuardarCambios</button>
                        </div>
                    </div>
                </div>
            </div>
            <h3>Listado de Platillos</h3>
            <table id="tablaPlatillos" class="table table-bordered  table-striped">
                <thead>
                    <tr>
                        <th></th>
                        <th class="text-center">ID</th>
                        <th class="text-center">Nombre</th>
                        <th class="text-center">Costo</th>
                        <th class="text-center">Categoría</th>
                        <th class="text-center">Estado</th>
                        <th class="text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="text-center"></tbody>
            </table>
        </div>
    </form>
    <style>
        #tablaPlatillos td {
            text-align: center;
        }
    </style>
</body>
</html>
