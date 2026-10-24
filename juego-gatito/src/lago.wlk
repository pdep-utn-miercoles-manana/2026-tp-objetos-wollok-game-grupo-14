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
        game.removeVisual(puente)
    }

    method esZonaPeligrosa(posicion) {
        return posicion.x() >= xInicio && posicion.x() <= xFin
            && posicion.y() >= yInicio && posicion.y() <= yFin
    }
    method afectarGatito() {
        if(self.esZonaPeligrosa(gatito.position()) && !puente.permiteCruzar(gatito.position())) {
            game.say(gatito, "Perdí!!!!")
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

// const lago1Nivel3 = new Lago (
//     xInicio = 9,
//     xFin = 16,
//     yInicio = 55,
//     yFin = 55,
//     puente = puente1Nivel3
// )