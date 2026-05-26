import pool from './../../config/db.config.js';

import transaccion from './../../shared/utils/transacciones.js';

export const obtenerRoles = async () => {
  return await pool.query('SELECT * FROM roles');
};

export const obtenerRolPorId = async (id) => {
  return await pool.query('SELECT * FROM roles WHERE id = $1', [id]);
};

export const crearRol = async (datos) => {
  return await transaccion(async (client) => {
    const result = await client.query(`
        INSERT INTO roles (
          nombre,
          activo
        ) VALUES ($1, $2) RETURNING *`,
      [
        datos.nombre,
        datos.activo
      ]
    );
    return result;
  });
};

export const actualizarRol = async (id, datos) => {
  return await transaccion(async (client) => {
    return await client.query(`
      UPDATE roles SET 
        nombre=$1,
        activo=$2
      WHERE id=$3 RETURNING *`,
      [
        datos.nombre,
        datos.activo,
        id
      ]
    );
  });
};

export const eliminarRol = async (id) => {
  return await transaccion(async (client) => {
    return await client.query('DELETE FROM roles WHERE id=$1 RETURNING *', [id]);
  });
};