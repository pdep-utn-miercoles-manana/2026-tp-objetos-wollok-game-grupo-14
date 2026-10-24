class TramoHorizontal {
    const y
    const xInicial
    const xFinal

    method contiene(posicion) {
        return posicion.y() == y && posicion.x() >= xInicial && posicion.x() <= xFinal
    }
}

class TramoVertical {
    const x
    const yInicial
    const yFinal

    method contiene(posicion) {
        return posicion.x() == x && posicion.y() >= yInicial && posicion.y() <= yFinal
    }
}

const tramo1Nivel1 = new TramoHorizontal (
    y = 36,
    xInicial = 1,
    xFinal = 40
)

const tramo2Nivel1 = new TramoVertical (
    x = 40,
    yInicial = 21,
    yFinal = 51
)

const tramo3Nivel1 = new TramoHorizontal (
    y = 21,
    xInicial = 40,
    xFinal = 71
)

const tramo4Nivel1 = new TramoHorizontal (
    y = 51,
    xInicial = 40,
    xFinal = 71
)

const tramo5Nivel1 = new TramoVertical (
    x = 71,
    yInicial = 21,
    yFinal = 51
)

const tramo6Nivel1 = new TramoHorizontal (
    y = 35,
    xInicial = 40,
    xFinal = 99
)

const tramo1Nivel2 = new TramoHorizontal (
    y = 21,
    xInicial = 1,
    xFinal = 89
)

const tramo2Nivel2 = new TramoVertical (
    x = 19,
    yInicial = 21,
    yFinal = 55
)

const tramo3Nivel2 = new TramoVertical (
    x = 89,
    yInicial = 21,
    yFinal = 55
)

const tramo4Nivel2 = new TramoHorizontal (
    y = 55,
    xInicial = 19,
    xFinal = 99
)

const tramo1Nivel3  = new TramoVertical (
    x = 2,
    yInicial = 3,
    yFinal = 55
)

const tramo2Nivel3 = new TramoHorizontal (
    y = 3,
    xInicial = 2,
    xFinal = 27
)

const tramo3Nivel3 = new TramoHorizontal (
    y = 51,
    xInicial = 2,
    xFinal = 24
)

const tramo4Nivel3 = new TramoVertical (
    x = 24,
    yInicial = 51,
    yFinal = 63
)

const tramo5Nivel3 = new TramoVertical (
    x = 27,
    yInicial = 3,
    yFinal = 41
)

const tramo6Nivel3 = new TramoHorizontal (
    y = 63,
    xInicial = 24,
    xFinal = 91
)

const tramo7Nivel3 = new TramoHorizontal (
    y = 41,
    xInicial = 27,
    xFinal = 38
)

const tramo8Nivel3 = new TramoVertical (
    x = 91,
    yInicial = 52,
    yFinal = 63
)

const tramo9Nivel3 = new TramoVertical (
    x = 38,
    yInicial = 3,
    yFinal = 52
)

const tramo10Nivel3 = new TramoHorizontal (
    y = 52,
    xInicial = 38,
    xFinal = 91
)

const tramo11Nivel3 = new TramoHorizontal (
    y = 3,
    xInicial = 38,
    xFinal = 99
)