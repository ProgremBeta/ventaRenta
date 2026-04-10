import pool from "../../config/db.config.js";

console.log("Cargando repositorio de usuarios...");

export const obtenerUsuarios = async () => {
  return await pool.query('SELECT * FROM usuarios');
};

export const obtenerUsuarioPorId = async (id) => {
  return await pool.query('SELECT * FROM usuarios WHERE id = $1', [id]);
};

export const crearUsuario = async (datos) => {
  return await pool.query('INSERT INTO usuarios (nombre,email,telefono,contrasena_hash,rol_id) VALUES ($1, $2, $3, $4, $5) RETURNING *', [datos.nombre, datos.email, datos.telefono, datos.contrasena_hash, datos.rol_id]);
};

export const actualizarUsuario = async (id, datos) => {
  return await pool.query('UPDATE usuarios SET nombre=$1, email=$2, telefono=$3, contrasena_hash=$4, rol_id=$5 WHERE id=$6 RETURNING *', [datos.nombre, datos.email, datos.telefono, datos.contrasena_hash, datos.rol_id, id]);
};

export const eliminarUsuario = async (id) => {
  return await pool.query('DELETE FROM usuarios WHERE id=$1', [id]);
};