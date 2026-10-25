
class Ovillo {
    const ubicacion
    var activo = false

    method position() = ubicacion

    method image() = "ovillo.png"

    method configurar() {
        activo = true
        game.addVisual(self)
    }

    method desconfigurar() {
        if (activo) {
            game.removeVisual(self)
            activo = false
        }
    }

    method verificarContacto() {
        if (activo && game.onSameCell(gatito.position(), ubicacion)) {
            self.desconfigurar()
            controlMovimiento.congelar()
        }
    }
}


object gatitoCongelado {
    method position() = gatito.position() //Para que cambie la imagen dependiendo de la posicion donde se encuentra el gatito(asi podemos colocar el ovillo en distintas posiciones)
    method image() = "gatito_congelado.png"

}


object estaCongelado {
    var congelado = false

    method moverA(nuevaPosicion) {
        if (!congelado && juego.estaJugando()) {
            gatito.position(nuevaPosicion)
            juego.verificarObstaculos()
        }
    }

    method congelar() {
        if (!congelado) {
            congelado = true

            game.removeVisual(gatito)
            game.addVisual(gatitoCongelado)

            game.schedule(3000, {  //ejecuta la descongelación una sola vez, pasados 3000 milisegundos. Los métodos addVisual y removeVisual muestran y retiran los sprites del tablero.
                self.descongelar()
            })
        }
    }

    method descongelar() {
        if (congelado) {
            game.removeVisual(gatitoCongelado)
            game.addVisual(gatito)

            congelado = false
        }
    }

    method estaCongelado() = congelado
}

const ovilloNivel1 = new Ovillo( //creamos el obstaculo ovillo en el nivel 1, y le asignamos posicion
    ubicacion = game.at(20, 36)
)
