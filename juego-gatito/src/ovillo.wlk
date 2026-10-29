
import wollok.game.*
import gatito.*

class Ovillo {
    const ubicacion
    var activo = false

    method position() = ubicacion

    method image() = "ovilloNuevo.png"

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
    ubicacion = game.at(72, 22)
)

const ovilloNivel2 = new Ovillo(
    ubicacion = game.at(45, 55)
)

const ovilloNivel3 = new Ovillo(
    ubicacion = game.at(33, 42)
)