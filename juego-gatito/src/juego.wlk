import nivel.*
object juego {
    var nivelActual = nivel1
    var estado = true

    method iniciar() {
        estado = true
        nivelActual.iniciar()
    }

    method ganar() {
        estado = false
    }
    method perder() {
        estado = false
    }

    method verificarMeta() {
        nivelActual.verificarMeta()
    }

    method avanzarNivel() {
        nivelActual.desconfigurarObstaculos()
        if(nivelActual == nivel1) {
            nivelActual = nivel2
            self.iniciar()
        }
        else if (nivelActual == nivel2) {
            nivelActual = nivel3
            self.iniciar()
        }
        else {
            self.ganar()
        }
        
    }

    method esTransitable(posicion) {
        return nivelActual.esTransitable(posicion)
    }

    method verificarObstaculos() {
        nivelActual.obstaculos().forEach {obstaculo => obstaculo.afectarGatito()}
    }

    method moverPuentes() {
        nivelActual.moverPuentes()
    }

}