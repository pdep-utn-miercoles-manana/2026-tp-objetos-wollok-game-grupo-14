import nivel.*
import gatito.*
import sonido.*
object juego {
    var nivelActual = nivel1
    var estado = true
    var tiempoRestante = 0
    var cambiandoDeNivel = false

    method estaEnJuego() = estado

    // Mientras cambia de nivel el gatito no se mueve, aunque se siga apretando la flecha
    method permiteMoverse() = estado && !cambiandoDeNivel

    method tiempoRestante() = tiempoRestante

    method numeroDeNivel() = nivelActual.numero()

    method fondoDelNivel() = nivelActual.fondo()

    method agregarGatitoAdelante() {
        if(game.hasVisual(gatito)) {
            game.removeVisual(gatito)
        }
        game.addVisualCharacter(gatito)
    }


    // Se llama una sola vez, al arrancar el programa
    method iniciar() {
        estado = true
        gatito.reiniciarVidas()
        game.boardGround("fondo_barra.png")
        game.addVisual(mapa)
        barraSuperior.mostrar()
        keyboard.r().onPressDo({ self.volverAJugar() })
        keyboard.m().onPressDo({ sonido.alternar() })
        game.onTick(1000, "reloj", { self.pasarUnSegundo() })
        self.iniciarNivel()
    }

    // Se llama al empezar cada nivel: las vidas no se tocan, así pasan al siguiente nivel
    method iniciarNivel() {
        tiempoRestante = nivelActual.tiempoLimite()
        nivelActual.iniciar()
        self.agregarGatitoAdelante()
    }

    method pasarUnSegundo() {
        if (estado) {
            tiempoRestante -= 1
            if (tiempoRestante <= 0) {
                self.reiniciarDesdeElNivel1()
            }
        }
    }

    method ganar() {
        estado = false
        cartelFinal.mostrar("cartel_ganaste.png")
    }

    method perder() {
        estado = false
        cartelFinal.mostrar("cartel_perdiste.png")
    }

    // Con la R, una vez que ganó o perdió, vuelve a jugar desde el nivel 1
    method volverAJugar() {
        if (!estado) {
            cartelFinal.ocultar()
            estado = true
            self.reiniciarDesdeElNivel1()
        }
    }

    // Si se acaba el tiempo vuelve a empezar todo desde el nivel 1, con las 3 vidas
    method reiniciarDesdeElNivel1() {
        nivelActual.desconfigurarObstaculos()
        nivelActual = nivel1
        gatito.reiniciarVidas()
        self.vidasCambiaron()
        self.empezarNivelConPausa()
    }

    method vidasCambiaron() {
        marcadorDeVidas.mostrar()
    }

    method gatitoSinVidas() {
        self.perder()
    }

    method volverAlInicioDelNivel() {
        nivelActual.ponerGatitoEnElInicio()
    }

    method verificarMeta() {
        nivelActual.verificarMeta()
    }

    method avanzarNivel() {
        nivelActual.desconfigurarObstaculos()
        if(nivelActual == nivel1) {
            nivelActual = nivel2
            self.empezarNivelConPausa()
        }
        else if (nivelActual == nivel2) {
            nivelActual = nivel3
            self.empezarNivelConPausa()
        }
        else {
            self.ganar()
        }

    }

    // El gatito aparece quieto en el inicio del nivel y recién puede moverse después de una pausa
    method empezarNivelConPausa() {
        cambiandoDeNivel = true
        self.iniciarNivel()
        game.schedule(1500, { cambiandoDeNivel = false })
    }

    method estaCambiandoDeNivel() = cambiandoDeNivel

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

// El fondo del nivel va como imagen apoyada abajo a la izquierda, a su tamaño real
// (boardGround la estiraría a todo el tablero, incluida la franja de la barra)
object mapa {
    method position() = game.origin()
    method image() = juego.fondoDelNivel()
}

// ---------- Barra de arriba: nivel, vidas y tiempo ----------
// Los textos de Wollok se ven muy chicos, así que todo se dibuja con imágenes pixeladas

object barraSuperior {
    method position() = game.at(23, 71)
    method image() = "barra.png"

    method mostrar() {
        game.addVisual(self)
        game.addVisual(cifraDelNivel)
        game.addVisual(decenasDelTiempo)
        game.addVisual(unidadesDelTiempo)
        game.addVisual(sonido)
        marcadorDeVidas.mostrar()
    }
}

object cifraDelNivel {
    method position() = game.at(32, 72)
    method image() = "digito_" + juego.numeroDeNivel() + ".png"
}

object decenasDelTiempo {
    method position() = game.at(66, 72)
    method image() = "decena_" + juego.tiempoRestante().div(10) + ".png"
}

object unidadesDelTiempo {
    method position() = game.at(68, 72)
    method image() = "unidad_" + juego.tiempoRestante() % 10 + ".png"
}

// Un corazón por cada vida, dentro de la barra
class Corazon {
    const numero

    method position() = game.at(44 + (numero - 1) * 3, 72)
    method image() = "corazon.png"
}

object marcadorDeVidas {
    const corazones = []

    method cantidadDeCorazones() = corazones.size()

    // Vuelve a dibujar tantos corazones como vidas tenga el gatito
    method mostrar() {
        corazones.forEach { corazon => game.removeVisual(corazon) }
        corazones.clear()
        gatito.vidas().times { numero =>
            const corazon = new Corazon(numero = numero)
            corazones.add(corazon)
            game.addVisual(corazon)
        }
    }
}

object cartelFinal {
    var imagen = "cartel_perdiste.png"

    method position() = game.at(27, 29)
    method image() = imagen

    method mostrar(nuevaImagen) {
        imagen = nuevaImagen
        if (!game.hasVisual(self)) {
            game.addVisual(self)
        }
    }

    method ocultar() {
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }
}
