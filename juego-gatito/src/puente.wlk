import gatito.*

class Puente {
    const posicionMinima
    const posicionMaxima
    var posicionMovil
    var avanzando = true
    const imagen
    // Dónde estaba el puente cuando se subió el gatito (ahí el gatito estaba sobre el camino)
    var posicionAlSubir = 0

    method mover() {
        const paso = if (avanzando) 1 else -1
        posicionMovil += paso

        if(posicionMovil >= posicionMaxima) {
            avanzando = false
        }
        if(posicionMovil <= posicionMinima) {
            avanzando = true
        }

        // Si el gatito está arriba, el puente lo lleva con él, esté donde esté parado
        if (gatito.estaSobre(self)) {
            gatito.serLlevadoA(self.siguientePosicion(gatito.position(), paso))
        }
    }

    method recibirAlGatito() {
        posicionAlSubir = posicionMovil
    }

    // Si el puente todavía está en una posición en que deja cruzar, el gatito que sale por una punta
    // baja directo al camino (aunque el puente lo haya corrido un poco); si no, se queda arriba
    method bajadaHacia(destino) =
        if (self.estaEnRangoDeCruce() && !self.sostiene(destino)) self.siguientePosicion(destino, posicionAlSubir - posicionMovil) else destino

    method estaEnRangoDeCruce() = posicionMovil.between(self.inicioDelCruce(), self.finDelCruce())

    method inicioDelCruce()
    method finDelCruce()

    method image() = imagen
    method position() {}
    method position(nuevaPosicion) {}
    method permiteCruzar(posicion) {}

    // Dónde queda algo que va arriba del puente cuando el puente avanza un paso
    method siguientePosicion(posicion, paso)

    // Si la casilla está sobre el puente, en el sentido en que se lo cruza
    method sostiene(posicion)

    // Arriba del puente se camina sólo a lo largo de él
    method permiteCaminar(desde, hasta)
}

class PuenteVertical inherits Puente {
    const ejeX
    const extremoIzquierdoPuente
    const extremoDerechoPuente
    const ySuperiorCruce
    const yInferiorCruce
    override method position() {
        return game.at(ejeX, posicionMovil)
    }

    override method position(nuevaPosicion) {
        posicionMovil = nuevaPosicion.y()
    }

    override method permiteCruzar(posicionGatito) {
        return posicionGatito.x() >= extremoIzquierdoPuente && posicionGatito.x() <= extremoDerechoPuente
            && posicionMovil >= yInferiorCruce && posicionMovil <= ySuperiorCruce
    }

    override method inicioDelCruce() = yInferiorCruce
    override method finDelCruce() = ySuperiorCruce

    // Sube y baja: lo que está arriba se mueve en vertical
    override method siguientePosicion(posicion, paso) = game.at(posicion.x(), posicion.y() + paso)

    override method sostiene(posicion) =
        posicion.x() >= extremoIzquierdoPuente && posicion.x() <= extremoDerechoPuente

    // Se cruza de izquierda a derecha, en la fila en la que está el gatito
    override method permiteCaminar(desde, hasta) = self.sostiene(hasta) && hasta.y() == desde.y()
}

class PuenteHorizontal inherits Puente {
    const ejeY
    const extremoSuperiorPuente
    const extremoInferiorPuente
    const xSuperiorCruce
    const xInferiorCruce
    override method position() {
        return game.at(posicionMovil, ejeY)
    }

    override method position(nuevaPosicion) {
        posicionMovil = nuevaPosicion.x()
    }

    override method permiteCruzar(posicionGatito) {
        return posicionGatito.y() >= extremoInferiorPuente && posicionGatito.y() <= extremoSuperiorPuente
            && posicionMovil >= xInferiorCruce && posicionMovil <= xSuperiorCruce
    }

    override method inicioDelCruce() = xInferiorCruce
    override method finDelCruce() = xSuperiorCruce

    // Va y viene de costado: lo que está arriba se mueve en horizontal
    override method siguientePosicion(posicion, paso) = game.at(posicion.x() + paso, posicion.y())

    override method sostiene(posicion) =
        posicion.y() >= extremoInferiorPuente && posicion.y() <= extremoSuperiorPuente

    // Se cruza de abajo hacia arriba, en la columna en la que está el gatito
    override method permiteCaminar(desde, hasta) = self.sostiene(hasta) && hasta.x() == desde.x()
}

const puente1Nivel1 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 43,
    posicionMaxima = 56,
    posicionMovil = 51,
    ejeX = 53,
    extremoIzquierdoPuente = 51,
    extremoDerechoPuente = 61,
    yInferiorCruce = 49,
    ySuperiorCruce = 51
)

const puente2Nivel1 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 15,
    posicionMaxima = 28,
    posicionMovil = 21,
    ejeX = 53,
    extremoIzquierdoPuente = 51,
    extremoDerechoPuente = 61,
    yInferiorCruce = 19,
    ySuperiorCruce = 21
)

// revisar rango de cruce de puente1Nivel2
const puente1Nivel2 = new PuenteHorizontal (
    imagen = "puenteGrandeHorizontal.png",
    posicionMinima = 13,
    posicionMaxima = 25,
    posicionMovil = 19,
    ejeY = 42,
    extremoSuperiorPuente = 48,
    extremoInferiorPuente = 38,
    xInferiorCruce = 17,
    xSuperiorCruce = 19
)

const puente2Nivel2 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 15,
    posicionMaxima = 28,
    posicionMovil = 21,
    ejeX = 57,
    extremoIzquierdoPuente = 51,
    extremoDerechoPuente = 62,
    yInferiorCruce = 19,
    ySuperiorCruce = 21
)

const puente3Nivel2 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 15,
    posicionMaxima = 28,
    posicionMovil = 21,
    ejeX = 73,
    extremoIzquierdoPuente = 69,
    extremoDerechoPuente = 77,
    yInferiorCruce = 19,
    ySuperiorCruce = 21
)

const puente4Nivel2 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 46,
    posicionMaxima = 62,
    posicionMovil = 55,
    ejeX = 73,
    extremoIzquierdoPuente = 69,
    extremoDerechoPuente = 77,
    // el camino está en la fila 55: el puente lo cubre cuando su base está entre 53 y 55 (igual que en el nivel 1)
    yInferiorCruce = 53,
    ySuperiorCruce = 55
)

const puente1Nivel3 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 42,
    posicionMaxima = 56,
    posicionMovil = 51,
    ejeX = 10,
    extremoIzquierdoPuente = 8,
    extremoDerechoPuente = 16,
    yInferiorCruce = 49,
    ySuperiorCruce = 51
)

const puente2Nivel3 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 1,
    posicionMaxima = 13,
    posicionMovil = 3,
    ejeX = 10,
    extremoIzquierdoPuente = 8,
    extremoDerechoPuente = 16,
    yInferiorCruce = 1,
    ySuperiorCruce = 3
)

const puente3Nivel3 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 58,
    posicionMaxima = 68,
    posicionMovil = 63,
    ejeX = 77,
    extremoIzquierdoPuente = 74,
    extremoDerechoPuente = 84,
    yInferiorCruce = 61,
    ySuperiorCruce = 63
)

const puente4Nivel3 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 40,
    posicionMaxima = 54,
    posicionMovil = 52,
    ejeX = 77,
    extremoIzquierdoPuente = 74,
    extremoDerechoPuente = 84,
    yInferiorCruce = 50,
    ySuperiorCruce = 52
)

const puente5Nivel3 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 1,
    posicionMaxima = 13,
    posicionMovil = 3,
    ejeX = 77,
    extremoIzquierdoPuente = 74,
    extremoDerechoPuente = 84,
    yInferiorCruce = 1,
    ySuperiorCruce = 3
)

const puente6Nivel3 = new PuenteHorizontal (
    imagen = "puenteGrandeHorizontal.png",
    posicionMinima = 22,
    posicionMaxima = 30,
    posicionMovil = 27,
    ejeY = 17,
    extremoSuperiorPuente = 21,
    extremoInferiorPuente = 14,
    xInferiorCruce = 25,
    xSuperiorCruce = 27
)

const puente7Nivel3 = new PuenteHorizontal (
    imagen = "puenteGrandeHorizontal.png",
    posicionMinima = 33,
    posicionMaxima = 45,
    posicionMovil = 38,
    ejeY = 17,
    extremoSuperiorPuente = 21,
    extremoInferiorPuente = 14,
    xInferiorCruce = 36,
    xSuperiorCruce = 38
)