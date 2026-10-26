
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
            gatito.congelar()
        }
    }
}

const ovilloNivel1 = new Ovillo(
    ubicacion = game.at(71, 21)
)
