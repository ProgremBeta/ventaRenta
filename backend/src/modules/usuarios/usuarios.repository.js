import pool from "../../config/db.config.js";

export const obtenerUsuarios = async () => {
  return await pool.query('SELECT * FROM usuarios');
};

export const obtenerUsuarioPorId = async (id) => {
  return await pool.query('SELECT * FROM usuarios WHERE identificacion = $1', [id]);
};

export const crearUsuario = async (datos) => {
  return await pool.query(`
    INSERT INTO usuarios (
      identificacion,
      nombre,
      email,
      telefono,
      contrasena_hash,
      rol_id,
      activo
    ) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
    [
      datos.identificacion,
      datos.nombre,
      datos.email,
      datos.telefono,
      datos.contrasena_hash,
      datos.rol_id,
      datos.activo
    ]);
};

export const actualizarUsuario = async (id, datos) => {
  return await pool.query(`
    UPDATE usuarios SET 
      identificacion=$1,
      nombre=$2,
      email=$3,
      telefono=$4,
      contrasena_hash=$5,
      rol_id=$6,
      activo=$7
    WHERE identificacion=$8 RETURNING *`,
    [
      datos.identificacion,
      datos.nombre,
      datos.email,
      datos.telefono,
      datos.contrasena_hash,
      datos.rol_id,
      datos.activo,
      datos.identificacion
    ]);
};

export const eliminarUsuario = async (id) => {
  return await pool.query('DELETE FROM usuarios WHERE identificacion=$1 RETURNING *', [id]);
};