        const contenedor = document.getElementById('contenedor');
        const btnCambiar = document.getElementById('btn-cambiar');
        const formLogin = document.getElementById('form-login');
        const formRegister = document.getElementById('form-register');
        const titulo = document.getElementById('titulo-panel');
        const texto = document.getElementById('texto-panel');

        let mostrandoLogin = true;

        btnCambiar.addEventListener('click', () => {
            mostrandoLogin = !mostrandoLogin;

            if (mostrandoLogin) {
                contenedor.classList.remove('mover');
                formLogin.style.display = 'flex';
                formRegister.style.display = 'none';
                btnCambiar.innerText = 'Registrarse';
                titulo.innerText = '¿Aún no tienes una cuenta?';
                texto.innerText = 'Regístrate para que puedas iniciar sesión';
            } else {
                contenedor.classList.add('mover');
                formLogin.style.display = 'none';
                formRegister.style.display = 'flex';
                btnCambiar.innerText = 'Iniciar Sesión';
                titulo.innerText = '¿Ya tienes una cuenta?';
                texto.innerText = 'Inicia sesión para acceder';
            }
        });