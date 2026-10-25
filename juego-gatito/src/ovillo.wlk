
import wollok.game.*
import gatito.*

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

    method afectarGatito() {
        self.verificarContacto()
    }

    method verificarContacto() {
        if (activo && game.onSameCell(gatito.position(), ubicacion)) {
            self.desconfigurar()
            estaCongelado.congelar()
        }
    }
}

object gatitoCongelado {
    method position() = gatito.position()
    method image() = "gatito_congelado.png"
}

object estaCongelado {
    var congelado = false

    method estaCongelado() = congelado

    method congelar() {
        if (!congelado) {
            congelado = true

            game.removeVisual(gatito)
            game.addVisual(gatitoCongelado)

            game.schedule(3000, {
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
}

const ovilloNivel1 = new Ovillo(
    ubicacion = game.at(71, 21)
)
