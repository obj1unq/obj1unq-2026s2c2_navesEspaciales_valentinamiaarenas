class Nave {
	var property velocidad = 0
	const maximoAlcanzable = 300000

	method recibirAmenaza() {

	}
	//2
	method propulsar() {
		if(velocidad + 20000 >= maximoAlcanzable) {
			velocidad = maximoAlcanzable
		} else {
			velocidad =+ 20000
		}
	}
	//4
	method prepararseParaViaje() {
		if(velocidad + 15000 >= maximoAlcanzable){
			velocidad = maximoAlcanzable
		} else {
			velocidad =+ 15000
		}
	}
	//5
	method encontrarseConEnemigo() {
		self.recibirAmenaza()
		self.propulsar()
	}
}

class NaveDeCarga inherits Nave{
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
	
	method estaEnFalta() = self.sobrecargada() and self.excedidaDeVelocidad()
	
	method acercamientoDeControl() {
		if (self.estaEnFalta()) {
			self.recibirAmenaza()
		}
	}

}
//3
class NaveDeResiduosRadioactivos inherits NaveDeCarga {
	//4
	var property cerradoAlVacio = false
	override method recibirAmenaza() {
		velocidad = 0
	}
	//4
	override method prepararseParaViaje() {
		super()
		cerradoAlVacio = true
	}
}

class NaveDePasajeros inherits Nave{
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaPermitida() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaPermitida() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave{
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	//4
	override method prepararseParaViaje() {
		super()
		modo.prepararseParaViaje(self)
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararseParaViaje(nave) {
		nave.emitirMensaje("Saliendo en mision")
		nave.modo(ataque)
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method prepararseParaViaje(nave) {
		nave.emitirMensaje("Volviendo a la base")
	}

}
