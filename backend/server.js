//Importo librerias para el servidor 
import app from './src/app.js';
import dotenv from 'dotenv';

//Para el manejo de las variables de entorno
dotenv.config();

//Llamo la variable de entorno PORT para el puerto
const PORT = process.env.PORT || 3000;

console.log("SERVIDOR EN LISTEN")

app.listen(PORT, () => {
  console.log(`El servidor está corriendo en http://localhost:${PORT}`);
  console.log("SERVIDOR ACTIVO")
});