import juego.*

object gatito {
    var ubicacion = game.origin()
    method position() = ubicacion
    method image() = "gatito.png"

    method irA(posicionInicial) {
        ubicacion = posicionInicial
    }

    method position(nuevaPosicion) {
        if(juego.esTransitable(nuevaPosicion)) {
            ubicacion = nuevaPosicion
            juego.verificarMeta()
            juego.verificarObstaculos()
        }
    }

}