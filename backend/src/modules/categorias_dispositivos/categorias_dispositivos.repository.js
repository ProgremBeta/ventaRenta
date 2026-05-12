import Pool from "../../config/db.config.js";

import transaccion from "../../shared/utils/transacciones.js";
/*son peticiones para obtener los datos de la base de datos*/

export const obtenerCategoriasDispositivos = async () => {
  return await Pool.query("SELECT * FROM categorias_dispositivos");
};

export const obtenerCategoriaDispositivoPorId = async (id) => {
  return await Pool.query("SELECT * FROM categorias_dispositivos WHERE id = $1", [id]);
};

export const crearCategoriaDispositivo = async (datos) => {
  return await transaccion(async (client) => {
    return await client.query(`
      INSERT INTO categorias_dispositivos (
        nombre,
        descripcion,
        activo
      ) VALUES ($1,$2,$3) RETURNING *`,
      [
        datos.nombre,
        datos.descripcion,
        datos.activo
      ]
    );
  });
};

export const actualizarCategoriaDispositivo = async (id, datos) => {
  return await transaccion(async (client) => {
    return await client.query(`
      UPDATE categorias_dispositivos SET 
        nombre=$1,
        descripcion=$2,
        activo=$3
      WHERE id=$4 RETURNING *`,
      [
        datos.nombre,
        datos.descripcion,
        datos.activo,
        id
      ]
    );
  });
};

export const eliminarCategoriaDispositivo = async (id) => {
  return await transaccion(async (client) => {
    return await client.query("DELETE FROM categorias_dispositivos WHERE id = $1 RETURNING *", [id]);
  });
};