
class Ovillo {
    const ubicacion //indica dónde está el ovillo.
    method position() = ubicacion //permite que Wollok Game conozca su posición.
    method image() = "ovillo.png" //devuelve la imagen del ovillo.
    method afectar(gatito) {
        gatito.congelarDurante(3000) //cuando el gatito lo toca, le pide que se congele durante 3 segundos (Pero se pone 3000 porque son milisegundos)
    }
}
