import * as repository from './detalles_rentas.repository.js';

export const obtenerRenta = async () => {
	const result = await repository.obtenerRenta();
	return result.rows;
}

export const obtenerRentaPorId = async (id) => {
	const result = await repository.obtenerRentaPorId(id);
	return result.rows;
}

export const  crearRenta = async (datos) => {

	console.log("datos para crear renta: ", datos)

	const result = await repository.crearRenta(datos);
	return result.rows;
}

export const actualizarRenta = async (id, datos) => {
	const result = await repository.actualizarRenta(id, datos);
	return result.rows;
}

export const eliminarRenta = async () => {
	const result = await repository.eliminarRenta();
	return result.rows;
}