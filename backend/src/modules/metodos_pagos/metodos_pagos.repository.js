import Pool from '../../config/db.config.js';

export const obtenerMetodosPagos = async () => {
  return await Pool.query('SELECT * FROM metodos_pagos');
}

export const obtenerMetodoPagoPorId = async (id) => {
  return await Pool.query('SELECT * FROM metodos_pagos WHERE id=$1', [id]);
}

export const crearMetodoPago = async (datos) => {
  return await Pool.query(`
    INSERT INTO metodos_pagos (
      nombre,
      descripcion
    ) VALUES ($1, $2) RETURNING *`,
    [
      datos.nombre,
      datos.descripcion
    ]);
}

export const actualizarMetodoPago = async (id, datos) => {
  return await Pool.query(`
    UPDATE metodos_pagos SET
      nombre = $1,
      descripcion = $2
    WHERE id = $3 RETURNING *`,
    [
      datos.nombre,
      datos.descripcion,
      id
    ]);
}

export const eliminarMetodoPago = async (id) => {
  return await Pool.query('DELETE FROM metodos_pagos WHERE id = $1', [id]);
}