
import wollok.game.*
import gatito.*

class Pescadito {
    const ubicacion
    var activo = false

    method position() = ubicacion

    method image() = "pescadito.png"

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
            gatito.ganarVida()
        }
    }
}

// Cada pescadito está pasando un cruce de agua

// Nivel 1: después del lago de arriba (lago1Nivel1, x 51..61)
const pescaditoNivel1 = new Pescadito(
    ubicacion = game.at(66, 51)
)

// Nivel 2: en la esquina donde se juntan los dos caminos, después de cruzar dos lagos por cualquiera de ellos
const pescaditoNivel2 = new Pescadito(
    ubicacion = game.at(89, 55)
)

// Nivel 3: después del lago de arriba a la izquierda (lago1Nivel3, x 9..16)
const pescaditoNivel3 = new Pescadito(
    ubicacion = game.at(20, 51)
)
