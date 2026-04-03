import pool from '../../config/db.config.js';

console.log("Cargando repositorio de deudas...");

export const obtenerDeudas = async () => {
  return await pool.query('SELECT * FROM deudas');
};

export const obtenerDeudaPorId = async (id) => {
  return await pool.query('SELECT * FROM deudas WHERE id = $1', [id]);
};

export const crearDeuda = async (datos) => {
  return await pool.query('INSERT INTO deudas (cliente_id,origen_tipo,origen_id,monto_total,monto_pagado,saldo,estado) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *', [datos.cliente_id, datos.origen_tipo, datos.origen_id, datos.monto_total, datos.monto_pagado, datos.saldo, datos.estado]);
};

export const actualizarDeuda = async (id, datos) => {
  return await pool.query('UPDATE deudas SET cliente_id=$1, origen_tipo=$2, origen_id=$3, monto_total=$4, monto_pagado=$5, saldo=$6, estado=$7 WHERE id=$8 RETURNING *', [datos.cliente_id, datos.origen_tipo, datos.origen_id, datos.monto_total, datos.monto_pagado, datos.saldo, datos.estado, id]);
};

export const eliminarDeuda = async (id) => {
  return await pool.query('DELETE FROM deudas WHERE id=$1', [id]);
};