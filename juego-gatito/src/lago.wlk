import gatito.*
import puente.*
class Lago {
    const xInicio
    const xFin
    const yInicio
    const yFin
    const puente

    method configurar() {
        game.addVisual(puente)
    }

    method desconfigurar() {
        if (game.hasVisual(puente)) {
            game.removeVisual(puente)
        }
    }

    method esZonaPeligrosa(posicion) {
        return posicion.x() >= xInicio && posicion.x() <= xFin
            && posicion.y() >= yInicio && posicion.y() <= yFin
    }
    // Si pisa el agua: con el puente en su lugar se sube a él, si no se cae.
    // Arriba del puente ya no corre peligro: el puente lo lleva.
    method afectarGatito() {
        if(self.esZonaPeligrosa(gatito.position()) && !gatito.estaSobre(puente)) {
            if (puente.permiteCruzar(gatito.position())) {
                gatito.subirA(puente)
            } else {
                gatito.caerAlAgua()
            }
        }
    }
}

const lago1Nivel1 = new Lago (
    xInicio = 51,
    xFin = 61,
    yInicio = 51,
    yFin = 51,
    puente = puente1Nivel1
)

const lago2Nivel1 = new Lago (
    xInicio = 51,
    xFin = 61,
    yInicio = 21,
    yFin = 21,
    puente = puente2Nivel1
)

const lago1Nivel2 = new Lago (
    xInicio = 19,
    xFin = 19,
    yInicio = 44,
    yFin = 46,
    puente = puente1Nivel2
)

const lago2Nivel2 = new Lago (
    xInicio = 54,
    xFin = 62,
    yInicio = 21,
    yFin = 21,
    puente = puente2Nivel2
)

const lago3Nivel2 = new Lago (
    xInicio = 73,
    xFin = 77,
    yInicio = 21,
    yFin = 21,
    puente = puente3Nivel2
)

const lago4Nivel2 = new Lago (
    xInicio = 72,
    xFin = 77,
    yInicio = 55,
    yFin = 55,
    puente = puente4Nivel2
)

const lago1Nivel3 = new Lago (
    xInicio = 9,
    xFin = 16,
    yInicio = 51,
    yFin = 51,
    puente = puente1Nivel3
)

const lago2Nivel3 = new Lago (
    xInicio = 9,
    xFin = 16,
    yInicio = 3,
    yFin = 3,
    puente = puente2Nivel3
)

const lago3Nivel3 = new Lago (
    xInicio = 77,
    xFin = 84,
    yInicio = 63,
    yFin = 63,
    puente = puente3Nivel3
)

const lago4Nivel3 = new Lago (
    xInicio = 77,
    xFin = 84,
    yInicio = 52,
    yFin = 52,
    puente = puente4Nivel3
)

const lago5Nivel3 = new Lago (
    xInicio = 77,
    xFin = 84,
    yInicio = 3,
    yFin = 3,
    puente = puente5Nivel3
)

const lago6Nivel3 = new Lago (
    xInicio = 27,
    xFin = 27,
    yInicio = 17,
    yFin = 21,
    puente = puente6Nivel3
)

const lago7Nivel3 = new Lago (
    xInicio = 38,
    xFin = 38,
    yInicio = 17,
    yFin = 21,
    puente = puente7Nivel3
)