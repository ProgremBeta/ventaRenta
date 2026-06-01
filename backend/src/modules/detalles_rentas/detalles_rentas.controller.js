import * as service from './detalles_rentas.service.js';

export const obtenerRenta = async (req, res, next) => {
	try{
		const result = await service.obtenerRenta();

		if (!result || result.length === 0) {
			console.log("no existen datos de detalles de rentas")
			return res.status(400).json({mensaje: "no existen datos de detalles de rentas"})
		}

		res.status(200).json(result);
	}catch (err){
		console.log("Error en detalles rentas controller al intentar obtener las rentas", err)
		next(err)
	}
}

export const obtenerRentaPorId = async (req, res, next) => {
	const { id } = req.params;
	try{
		const result = await service.obtenerRentaPorId(id)

		if (!result || result.length === 0) { 
			console.log(`no existe renta con el id ${id}`)
			res.status(404).json({mensaje: `no existe renta con el id ${id}`})
		}

		res.status(200).json(result)
	}catch (err){
		console.log(`Error en al obtener la renta con el id ${id} `, err)
		next(err);
	}
}

export const crearRenta = async(req, res, next) => {
	const datos = req.body;

	try{
		if (!datos) {
			console.log("se requiere los datos para crear un renta")
			return res.status(400).json({mensaje:"se requiere los datos para crear un renta"})
		}

		if (!datos.precio_hora) {
			console.log("se requiere el precio por hora")
			return res.status(400).json({mensaje:"se requiere el precio por hora"})
		}

		if (!datos.tiempo_total) {
			console.log("se requiere el tiempo total")
			return res.status(400).json({mensaje: "se requiere el tiempo total"})
		}

		if (!datos.sub_total) {
			console.log("se requiere el sub total")
			return res.status(400).json({mensaje:"se requiere el sub total"})
		}

		const result = await service.crearRenta(datos)

		res.status(201).json(result)
	}catch(err){
		console.log("Error al crear renta controller: ", err)
		next(err)
	}
}

export const actualizarRenta = async(req,res,next) => {
	const { id } = req.params;
	const datos = req.body;

	try{
		const result = await service.actualizarRenta(id,datos);

		res.status(200).json(result)
	}catch(err){
		console.log("Error al actualizar renta controller: ", err);
		next(err)
	}
}

export const eliminarRenta = async(req,res,next) => {
	const { id } = req.params;

	try{
		const result = await service.eliminarRenta(id);

		if (!result || result.length === 0) {
			console.log("no existen datos o ya fue eliminado")
			return res.status(400).json({mensaje: "no existen datos o ya fue eliminado"})
		}

		res.status(200).json(result)
	}catch(err){
		console.log("Error al eliminar renta controller: ", err);
		next(err);
	}
}