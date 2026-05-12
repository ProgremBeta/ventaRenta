import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';

dotenv.config();

export const autenticarUsuario = async (datos) => {

  const payload = {
    identificacion: datos.identificacion,
    nombre: datos.nombre,
    rol_id: datos.rol_id
  }

  const token = jwt.sign(
    payload,
    process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN
  });

  const refreshToken = jwt.sign(
    payload,
    process.env.JWT_REFRESH_SECRET, {
    expiresIn: process.env.JWT_REFRESH_EXPIRES_IN
  });

  return {
    token,
    refreshToken
  }
};