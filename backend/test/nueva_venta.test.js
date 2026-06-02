import test from 'node:test';
//import assert from 'node:assert';
import request from 'supertest';
import app from './../src/app.js';

test('crear venta correctamente', async () => {

 test('crear venta correctamente', async () => {

    const nuevo_usuario = await request(app)
    .post('/api/nuevo_usuario')
    .send({
        identificacion: 12345678912,
        nombre: "prueba test",
        email: "prueba.test4@test.com",
        telefono: 987654321,
        contrasena_hash: "123456"
        })

    console.log("", nuevo_usuario)

  const login = await request(app)
  .post('/api/login')
  .send({
    identificacion: '123456789',
    contrasena_hash: '123456'
  });

  const token = login._body.token;
  
  console.log("el token es: ",token)
  
  const nueva_categoria = await request(app)
  .post('/api/nueva_categoria')
  .set('Authorization', `Bearer ${token}`)
  .send({
    nombre: "categoria prueba test",
    descripcion: "esto es una prueba de desarrollo",
  });

  console.log("", nueva_categoria)

  const nuevo_producto = await request(app)
  .post('/api/nuevo_producto')
  .set('Authorization', `Bearer ${token}`)
  .send({
    nombre: "producto prueba test",
    descripcion: "esto es una prueba de desarrollo",
    precio: 5000,
    categoria_id: 1,
    stock:5
  });

  console.log("", nuevo_producto)

  const nueva_venta = await request(app)
  .post('/api/nueva_venta')
  .set('Authorization', `Bearer ${token}`)
  .send({
    usuario_id: 1,
    cliente_id: 1,
    metodo_pago: 1,
    detalles: [
      {
        producto_id: 7,
        cantidad: 2
      }
    ]
  });

  console.log("", nueva_venta)


});
});