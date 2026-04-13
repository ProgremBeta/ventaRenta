import pool from './../../config/db.config.js';

//importar funcion para hacer transacciones
import transaccion from './../../shared/utils/transacciones.js';

/*peticiones para obtener los datos de la base de datos*/

export const obtenerAlertas = async () => {
  return await pool.query('SELECT * FROM alertas');
};

export const obtenerAlertasPorId = async (id) => {
  return await pool.query('SELECT * FROM alertas WHERE id =$1', [id]);
};

export const crearAlertas = async (datos) => {
  return await transaccion(async (client) => {
    return await client.query(`
      INSERT INTO alertas (
        usuario_id,
        tipo,
        descripcion,
        visto
      ) VALUES ($1,$2,$3,$4) RETURNING *`,
      [
        datos.usuario_id,
        datos.tipo,
        datos.descripcion,
        datos.visto
      ]
    );
  });
};

export const actualizarAlerta = async (id, datos) => {
  return await transaccion(async (client) => {
    return await client.query(`
      UPDATE alertas SET 
        usuario_id=$1,
        tipo=$2,
        descripcion=$3,
        visto=$4 
      WHERE id=$5 RETURNING *`,
      [
        datos.usuario_id,
        datos.tipo,
        datos.descripcion,
        datos.visto,
        id
      ]
    );
  });
};

export const eliminarAlerta = async (id) => {
  return await transaccion(async (client) => {
    return await client.query('DELETE FROM alertas WHERE id=$1 RETURNING *', [id]);
  });
};