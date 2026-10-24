class Puente {
    const posicionMinima
    const posicionMaxima
    var posicionMovil
    var avanzando = true
    const imagen
    method mover() {
        if(avanzando) {
            posicionMovil+=1
        }
        else {
            posicionMovil-=1
        }

        if(posicionMovil >= posicionMaxima) {
            avanzando = false
        }
        if(posicionMovil <= posicionMinima) {
            avanzando = true
        }
    }

    method image() = imagen
    method position() {}
    method position(nuevaPosicion) {}
    method permiteCruzar(posicion) {}
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
    extremoSuperiorPuente = 38,
    extremoInferiorPuente = 48,
    xInferiorCruce = 15,
    xSuperiorCruce = 22 
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
    ySuperiorCruce = 24
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
    ySuperiorCruce = 24
)

const puente4Nivel2 = new PuenteVertical (
    imagen = "puenteGrandeVertical.png",
    posicionMinima = 46,
    posicionMaxima = 62,
    posicionMovil = 55,
    ejeX = 73,
    extremoIzquierdoPuente = 69,
    extremoDerechoPuente = 77,
    yInferiorCruce = 50,
    ySuperiorCruce = 59
)

// const puente1Nivel3 = new PuenteVertical (
//     imagen = "puenteGrandeVertical.png",
//     posicionMinima = 3,
//     posicionMaxima = 56,
//     posicionMovil = 55,
//     ejeX = 10,
//     extremoIzquierdoPuente = 9,
//     extremoDerechoPuente = 14,
//     yInferiorCruce = 52,
//     ySuperiorCruce = 57
// )