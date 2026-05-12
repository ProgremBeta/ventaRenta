import bcrypt from 'bcrypt';
import * as repository from './../../modules/usuarios/usuarios.repository.js';

export const crearNuevoUsuario = async (datos, rolUsuario) => {

  let rol_id = rolUsuario;

  console.log("Datos recibidos en crearNuevoUsuario:", datos);
  console.log("rolUsuario recibido en crearNuevoUsuario:", rolUsuario);

  // Validaciones básicas
  if (!datos.nombre) {
    throw new Error('El campo nombre es obligatorio');
  }
  if (!datos.identificacion) {
    throw new Error('El campo identificación es obligatorio');
  }
  if (!datos.email) {
    throw new Error('El campo email es obligatorio');
  }
  if (!datos.telefono) {
    throw new Error('El campo teléfono es obligatorio');
  }
  if (!datos.contrasena_hash) {
    throw new Error('El campo contraseña es obligatorio');
  }

  console.log("rolUsuario del crear_usuario.service.js: ", rolUsuario);

  if (rol_id !== 1) {
    rol_id = 2;
  }

  console.log("rol del nuevo usuario: ", rol_id);

  // Validar formato de email
  const formatoEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!formatoEmail.test(datos.email)) {
    throw new Error('Formato de email inválido');
  }

  // Validar que el rol_id sea un número
  if (isNaN(datos.rol_id)) {
    throw new Error('rol_id debe ser un número');
  }

  //funcion que encripta la contaseña
  const nivelSeguridad = 5; // es el nivel de seguradad en la encriptada
  const contrasena = datos.contrasena_hash; // toma el dato ingresado

  const contrasenaEncriptada = await bcrypt.hash(contrasena, nivelSeguridad) //encripta la contraseña y la assigna a una constante

  console.log("contraseña encriptada: ", contrasenaEncriptada);

  const datosUsuario = {
    identificacion: datos.identificacion,
    nombre: datos.nombre,
    email: datos.email,
    telefono: datos.telefono,
    contrasena_hash: contrasenaEncriptada, //se ingresa a la lista de datos para mandarlos a la base de datos por medio de la peticion
    rol_id: rol_id,
    activo: true
  };

  const usuario = await repository.crearUsuario(datosUsuario);//funcion para mandar los datos a la base de datos

  return usuario.rows;
}