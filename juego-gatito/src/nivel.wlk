import gatito.*
import juego.*
import tramo.*
import lago.*
import puente.*
import ovillo.*
import pescadito.*
class Nivel {
    const fondo
    var completado = false
    const posicionInicial
    const posicionFinal
    const tramos
    const obstaculos
    const puentes
    const tiempoLimite
    const numero

    method obstaculos() = obstaculos

    method numero() = numero

    method fondo() = fondo

    method tiempoLimite() = tiempoLimite

    method iniciar() {
        completado = false
        self.ponerGatitoEnElInicio()
        self.configurarObstaculos()

    }

    method ponerGatitoEnElInicio() {
        gatito.irA(posicionInicial)
    }

    method configurarObstaculos() {
        obstaculos.forEach {obstaculo => obstaculo.configurar()}
    }

    method desconfigurarObstaculos() {
        obstaculos.forEach {obstaculo => obstaculo.desconfigurar()}
    }

    method verificarMeta() {
        if(game.onSameCell(gatito.position(), posicionFinal)) {
            self.completar()
        }
    }
    
    method completar() {
        completado = true
        juego.avanzarNivel()
    }

    method esTransitable(posicion) {
        return tramos.any {tramo => tramo.contiene(posicion)}
    }

    method moverPuentes() {
        puentes.forEach {puente => puente.mover()}
    }
}

const nivel1 = new Nivel (
    fondo = "Fondo1.jpg",
    posicionInicial = game.at(1, 36),
    posicionFinal = game.at(90, 35),
    tramos = #{tramo1Nivel1, tramo2Nivel1, tramo3Nivel1, tramo4Nivel1, tramo5Nivel1, tramo6Nivel1},
    obstaculos = #{lago1Nivel1, lago2Nivel1, ovilloNivel1, pescaditoNivel1},
    puentes = #{puente1Nivel1, puente2Nivel1},
    tiempoLimite = 60,
    numero = 1
)

const nivel2 = new Nivel (
    fondo = "Fondo2.jpg",
    posicionInicial = game.at(1, 21),
    posicionFinal = game.at(91, 55),
    tramos = #{tramo1Nivel2, tramo2Nivel2, tramo3Nivel2, tramo4Nivel2},
    obstaculos = #{lago1Nivel2, lago2Nivel2, lago3Nivel2, lago4Nivel2, ovilloNivel2, pescaditoNivel2},
    puentes = #{puente1Nivel2, puente2Nivel2, puente3Nivel2, puente4Nivel2},
    tiempoLimite = 75,
    numero = 2
)

const nivel3 = new Nivel (
    fondo = "Fondo3.jpg",
    posicionInicial = game.at(2, 55),
    posicionFinal = game.at(90, 3),
    tramos = #{tramo1Nivel3, tramo2Nivel3, tramo3Nivel3, tramo4Nivel3, tramo5Nivel3, tramo6Nivel3, tramo7Nivel3, tramo8Nivel3, tramo9Nivel3, tramo10Nivel3, tramo11Nivel3},
    obstaculos = #{lago1Nivel3, lago2Nivel3, lago3Nivel3, lago4Nivel3, lago5Nivel3, lago6Nivel3, lago7Nivel3, ovilloNivel3, pescaditoNivel3},
    puentes = #{puente1Nivel3, puente2Nivel3, puente3Nivel3, puente4Nivel3, puente5Nivel3, puente6Nivel3, puente7Nivel3},
    tiempoLimite = 90,
    numero = 3
)
