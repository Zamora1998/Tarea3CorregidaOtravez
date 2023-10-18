$(document).ready(function () {
    $('#miModal').on('hidden.bs.modal', function () {
        location.reload();
    });
});

function validarInput() {
    var input = document.getElementById("txtInputregistrar").value;
    var errorMensaje = document.getElementById("errorMensaje");

    if (input.trim() === "") {
        mostrarMensaje(errorMensaje, "El campo no puede estar vacío.", false);
        return;
    }
    if (/^[a-zA-Z]+$/.test(input)) {
        fetch('http://localhost:50912/Categorias/AgregarCategoria', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ Nombre: input })
        })
            .then(response => {
                if (response.status === 201) {
                    mostrarMensaje(errorMensaje, "Categoría creada con éxito.", false);
                } else if (response.status === 409) {
                    mostrarMensaje(errorMensaje, "La categoría ya existe.", false);
                } else {
                    mostrarMensaje(errorMensaje, "Hubo un error al enviar la categoría.", false);
                }
            })
            .catch(error => {
                console.error('Error al enviar datos al Controlador:', error);
                mostrarMensaje(errorMensaje, "Error al enviar datos al Controlador.", false);
            });

    } else {
        mostrarMensaje(errorMensaje, "El campo debe contener solo letras.", false);
    }
}

function mostrarMensaje(elemento, mensaje, recargarPagina) {
    elemento.textContent = mensaje;
    setTimeout(function () {
        elemento.textContent = "";
        if (recargarPagina) {
            location.reload();
        }
    }, 4000); 
}




