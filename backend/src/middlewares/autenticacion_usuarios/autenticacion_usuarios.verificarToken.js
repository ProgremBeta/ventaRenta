import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';

dotenv.config();

export const verificarToken = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1]
  if (!token) return res.status(401).json({ message: 'Token requerido' })

  try {
    req.usuarioLogeado = jwt.verify(token, process.env.JWT_SECRET)
    next()
  } catch (err) {
    next(err)
  }
}