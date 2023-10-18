async function cargarDatosDesdeControlador() {
    try {
        const response = await fetch('http://localhost:50912/Categorias/ObtenerCategorias');
        if (response.ok) {
            const data = await response.json();
            const tabla = document.getElementById('tablaCategorias');
            const tbody = tabla.createTBody();

            data.sort((a, b) => a.Nombre.localeCompare(b.Nombre));

            data.forEach(categoria => {
                const row = tbody.insertRow();

                const cellCheck = row.insertCell();
                cellCheck.classList.add('text-center');
                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                cellCheck.appendChild(checkbox);

                const cellId = row.insertCell();
                cellId.classList.add('text-center');
                cellId.textContent = categoria.CategoriaID;
                const cellNombre = row.insertCell();
                cellNombre.classList.add('text-center');
                cellNombre.textContent = categoria.Nombre;

                const cellAcciones = row.insertCell();
                cellAcciones.classList.add('text-center');

                const btnEliminar = document.createElement('button');
                btnEliminar.textContent = 'Eliminar';
                btnEliminar.classList.add('btn', 'btn-danger');
                btnEliminar.type = 'button';
                btnEliminar.onclick = (event) => {
                    event.stopPropagation();

                    const row = event.target.closest('tr');
                    const checkbox = row.querySelector('input[type="checkbox"]');

                    if (checkbox && checkbox.checked) {
                        const id = categoria.CategoriaID;
                        $('#modalConfirmacion').modal('show');
                        document.getElementById('btnConfirmarEliminar').onclick = async () => {
                            const response = await fetch(`http://localhost:50912/Categorias/EliminarCategoria/${id}`, {
                                method: 'DELETE'
                            });

                            if (response.status === 200) {
                                $('#modalConfirmacion').modal('hide');
                                $('#modalConfirmacion').on('hidden.bs.modal', function () {
                                    window.location.reload(); 
                                });
                            } else {
                                console.error('Error al eliminar la categoría');
                            }
                        };
                    } else {
                        $('#modalAdvertencia').modal('show');
                    }

                    return false;
                };
                cellAcciones.appendChild(btnEliminar);

                const btnModificar = document.createElement('button');
                btnModificar.textContent = 'Modificar';
                btnModificar.classList.add('btn', 'btn-warning', 'ml-2');
                btnModificar.type = 'button';
                btnModificar.onclick = (event) => {
                    event.stopPropagation();
                    const row = event.target.closest('tr');
                    const checkbox = row.querySelector('input[type="checkbox"]');

                    if (checkbox && checkbox.checked) {
                        const nombre = categoria.Nombre;
                        $('#modalModificar').modal('show');
                        document.getElementById('modalCategoriaID').textContent = nombre; 

                        document.getElementById('btnAceptarModificar').onclick = async () => {
                            const nombreActual = document.getElementById('modalCategoriaID').textContent; 
                            const nuevoNombre = document.getElementById('txtinputNombre').value; 

                            const letrasRegex = /^[A-Za-z]+$/;

                            if (!nuevoNombre || !letrasRegex.test(nuevoNombre)) {
                                document.getElementById('errorEditar').textContent = 'El nombre no es válido.';
                                return;
                            }

                            const requestBody = {
                                Nombre: nuevoNombre
                            };

                            const response = await fetch(`http://localhost:50912/Categorias/EditarCategoria?nombreActual=${nombreActual}`, {
                                method: 'PUT',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify(requestBody)
                            });

                            if (response.status === 200) {
                                $('#modalModificar').modal('hide');
                                $('#modalModificar').on('hidden.bs.modal', function () {
                                    window.location.reload();
                                });
                            } else if (response.status === 409) {
                                document.getElementById('errorEditar').textContent = 'El nombre ya se encuentra en uso.';
                            } else {
                                console.error('Error al editar la categoría');
                            }
                        };
                    } else {
                        $('#modalAdvertencia').modal('show');
                    }

                    return false;
                };
                cellAcciones.appendChild(btnModificar);
            });
        } else {
            console.error('Error al cargar datos desde Controlador');
        }
    } catch (error) {
        console.error('Error inesperado: ' + error.message);
    }
}

cargarDatosDesdeControlador();




