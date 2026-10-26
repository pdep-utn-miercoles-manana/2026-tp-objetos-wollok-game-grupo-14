
import wollok.game.*
import juego.*

object gatito {
    var ubicacion = game.origin()
    var congelado = false

    method position() = ubicacion

    method image() = "gatito.png"

    method estaCongelado() = congelado

    method irA(posicionInicial) {
        ubicacion = posicionInicial
    }

    method position(nuevaPosicion) {
        if (!self.estaCongelado() && juego.esTransitable(nuevaPosicion)) {
            ubicacion = nuevaPosicion
            juego.verificarMeta()
            juego.verificarObstaculos()
        }
    }

    method congelar() {
        if (!congelado) {
            congelado = true

            game.removeVisual(self)
            game.addVisual(gatitoCongelado)

            game.schedule(3000, {
                self.descongelar()
            })
        }
    }

    method descongelar() {
        if (congelado) {
            game.removeVisual(gatitoCongelado)
            game.addVisual(self)

            congelado = false
        }
    }
}

object gatitoCongelado {
    method position() = gatito.position()
    method image() = "gatito_congelado.png"
}

