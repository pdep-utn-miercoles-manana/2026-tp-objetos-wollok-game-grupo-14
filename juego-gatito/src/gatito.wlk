
import wollok.game.*
import juego.*

object gatito {
    var ubicacion = game.origin()
    var congelado = false
    const vidasMaximas = 3
    var vidas = vidasMaximas
    var orientacion = haciaLaDerecha

    method position() = ubicacion

    
    method image() {
    if (vidas == 3) {
        return orientacion.imagenArmaduraCompleta()
    } else if (vidas == 2) {
        return orientacion.imagenPechera()
    } else {
        return orientacion.imagen()
    }
    }


    method imagenCongelado() = orientacion.imagenCongelado()

    method estaCongelado() = congelado

    method vidas() = vidas

    method reiniciarVidas() {
        vidas = vidasMaximas
    }

    // Nunca puede tener más de 3 vidas
    method ganarVida() {
        if (vidas < vidasMaximas) {
            vidas += 1
            juego.vidasCambiaron()
        }
    }

    // Pierde una vida y vuelve al inicio del nivel; si no le quedan, pierde el juego
    method caerAlAgua() {
        vidas -= 1
        juego.vidasCambiaron()
        if (vidas <= 0) {
            juego.gatitoSinVidas()
        } else {
            juego.volverAlInicioDelNivel()
        }
    }

    // Al empezar un nivel siempre mira hacia la derecha
    method irA(posicionInicial) {
        ubicacion = posicionInicial
        orientacion = haciaLaDerecha
    }

    method position(nuevaPosicion) {
        if (juego.permiteMoverse() && !self.estaCongelado()) {
            // Se da vuelta hacia donde apretó el jugador, aunque no pueda avanzar para ese lado
            self.mirarHacia(nuevaPosicion)
            if (juego.esTransitable(nuevaPosicion)) {
                ubicacion = nuevaPosicion
                juego.verificarMeta()
                juego.verificarObstaculos()
            }
        }
    }

    // Si camina hacia los costados se da vuelta; si sube o baja sigue mirando para donde miraba
    method mirarHacia(nuevaPosicion) {
        if (nuevaPosicion.x() < ubicacion.x()) {
            orientacion = haciaLaIzquierda
        }
        if (nuevaPosicion.x() > ubicacion.x()) {
            orientacion = haciaLaDerecha
        }
    }

    method congelar() {
        if (!congelado) {
            congelado = true

            game.removeVisual(self)
            game.addVisual(gatitoCongelado)

            game.schedule(3000, {
                self.descongelar()
            })
        }
    }

    method descongelar() {
        if (congelado) {
            game.removeVisual(gatitoCongelado)
            game.addVisual(self)

            congelado = false
        }
    }
}

object gatitoCongelado {
    method position() = gatito.position()
    method image() = gatito.imagenCongelado()
}

// Hacia dónde mira el gatito: cada una sabe qué imagen usar


object haciaLaDerecha {
    method imagen() = "gatito.png"
    method imagenCongelado() = "gatito_congelado.png"
    method imagenPechera() = "gatito_pechera.png"
    method imagenArmaduraCompleta() = "gatito_gladiador.png"
}

object haciaLaIzquierda {
    method imagen() = "gatito_izquierda.png"
    method imagenCongelado() = "gatito_congelado_izquierda.png"
    method imagenPechera() = "gatito_pechera_izquierda.png"
    method imagenArmaduraCompleta() = "gatito_gladiador_izquierda.png"
}


