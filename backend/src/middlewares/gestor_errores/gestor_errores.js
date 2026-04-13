export const gestorErrores = (err, req, res, next) => {
  console.error(`[${new Date().toISOString()}] ${req.method} ${req.url} → ${err.message}`)

  //Error por mal formato de JSON
  if (err.type === 'entity.parse.failed') return res.status(400).json({ error: 'El cuerpo de la petición no es un JSON válido' })

  // Errores de PostgreSQL
  if (err.code === '23505') return res.status(409).json({ error: 'Ya existe un registro con esos datos' })
  if (err.code === '23503') return res.status(400).json({ error: 'Referencia a un registro que no existe' })
  if (err.code === '23502') return res.status(400).json({ error: 'Faltan campos obligatorios' })
  if (err.code === '22P02') return res.status(400).json({ error: 'Formato de dato inválido' })

  // Errores de JWT
  if (err.name === 'JsonWebTokenError') return res.status(403).json({ error: 'Token inválido' })
  if (err.name === 'TokenExpiredError') return res.status(403).json({ error: 'Token expirado' })

  // Errores de conexión a BD
  if (err.code === 'ECONNREFUSED') return res.status(503).json({ error: 'No se puede conectar a la base de datos' })
  if (err.code === '57P03') return res.status(503).json({ error: 'Base de datos no disponible' })

  // Errores propios con status
  if (err.status) return res.status(err.status).json({ error: err.message })

  // Error genérico
  res.status(500).json({ error: 'Error interno del servidor' })
};