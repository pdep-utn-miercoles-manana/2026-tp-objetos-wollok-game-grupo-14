
import wollok.game.*
import juego.*

object gatito {
    var ubicacion = game.origin()
    var congelado = false
    const vidasMaximas = 3
    var vidas = vidasMaximas
    var orientacion = haciaLaDerecha
    // El puente en el que está parado (ningunPuente si está en tierra)
    var puente = ningunPuente

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
        puente = ningunPuente
    }

    method position(nuevaPosicion) {
        if (juego.permiteMoverse() && !self.estaCongelado()) {
            // Se da vuelta hacia donde apretó el jugador, aunque no pueda avanzar para ese lado
            self.mirarHacia(nuevaPosicion)
            // Camina por el camino o, si está arriba de un puente, a lo largo del puente
            const destino = self.destinoAlIrHacia(nuevaPosicion)
            if (self.puedeIrA(destino)) {
                ubicacion = destino
                self.bajarseSiSalioDelPuente()
                juego.verificarMeta()
                juego.verificarObstaculos()
            }
        }
    }

    // ---------- Puentes ----------

    method estaSobre(unPuente) = puente == unPuente

    method subirA(unPuente) {
        puente = unPuente
        unPuente.recibirAlGatito()
    }

    // Arriba del puente sólo camina a lo largo de él; fuera del puente, por el camino
    method puedeIrA(destino) =
        puente.permiteCaminar(ubicacion, destino) || (!puente.sostiene(destino) && juego.esTransitable(destino))

    // Al salir del puente por una punta, el puente le dice dónde baja
    method destinoAlIrHacia(nuevaPosicion) =
        if (puente.permiteCaminar(ubicacion, nuevaPosicion)) nuevaPosicion else puente.bajadaHacia(nuevaPosicion)

    method bajarseSiSalioDelPuente() {
        if (!puente.sostiene(ubicacion)) {
            puente = ningunPuente
        }
    }

    // El puente lo mueve con él, aunque esté congelado
    method serLlevadoA(nuevaPosicion) {
        ubicacion = nuevaPosicion
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

// Cuando el gatito está en tierra: no lo sostiene ni lo deja caminar sobre él
object ningunPuente {
    method sostiene(posicion) = false
    method permiteCaminar(desde, hasta) = false
    method bajadaHacia(destino) = destino
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


