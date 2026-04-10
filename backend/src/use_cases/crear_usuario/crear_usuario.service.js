import bcrypt from 'bcrypt';
import * as repository from './../../modules/usuario/usuarios.repository.js';

export const crearNuevoUsuario = async (datos) => {
  // Validaciones básicas
  if (!datos.nombre || !datos.email || !datos.contrasena_hash || !datos.rol_id) {
    throw new Error('Faltan campos requeridos: nombre, email, contrasena_hash, rol_id');
  }

  // Validar formato de email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(datos.email)) {
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
    nombre: datos.nombre,
    email: datos.email,
    telefono: datos.telefono,
    contrasena_hash: contrasenaEncriptada, //se ingresa a la lista de datos para mandarlos a la base de datos por medio de la peticion
    rol_id: datos.rol_id
  };

  const usuario = await repository.crearUsuario(datosUsuario);//funcion para mandar los datos a la base de datos

  return usuario;
}