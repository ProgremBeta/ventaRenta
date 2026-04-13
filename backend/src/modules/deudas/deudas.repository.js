import pool from '../../config/db.config.js';

export const obtenerDeudas = async () => {
  return await pool.query('SELECT * FROM deudas');
};

export const obtenerDeudaPorId = async (id) => {
  return await pool.query('SELECT * FROM deudas WHERE id = $1', [id]);
};

export const crearDeuda = async (datos) => {
  return await pool.query(`
    INSERT INTO deudas (
      cliente_id,
      monto_total,
      monto_pagado,
      saldo,
      estado
    ) VALUES ($1, $2, $3, $4, $5) RETURNING *`,
    [
      datos.cliente_id,
      datos.monto_total,
      datos.monto_pagado,
      datos.saldo,
      datos.estado
    ]);
};

export const actualizarDeuda = async (id, datos) => {
  return await pool.query(`
    UPDATE deudas SET 
      cliente_id=$1,
      monto_total=$2,
      monto_pagado=$3,
      saldo=$4,
      estado=$5 
    WHERE id=$6 RETURNING *`,
    [
      datos.cliente_id,
      datos.monto_total,
      datos.monto_pagado,
      datos.saldo,
      datos.estado,
      id
    ]);
};

export const eliminarDeuda = async (id) => {
  return await pool.query('DELETE FROM deudas WHERE id=$1', [id]);
};