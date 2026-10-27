import wollok.game.*

// Todos los sonidos del juego pasan por acá, así se pueden silenciar con la tecla M.
// Para un efecto:        sonido.reproducir("salto.mp3")
// Para música de fondo:  sonido.reproducirEnLoop("musica.mp3")
object sonido {
    var activado = true
    const musicas = []

    // Ícono dentro de la barra de arriba
    method position() = game.at(72, 72)
    method image() = if (activado) "sonido_on.png" else "sonido_off.png"

    method estaActivado() = activado

    method volumen() = if (activado) 1 else 0

    method alternar() {
        activado = !activado
        musicas.forEach { musica => musica.volume(self.volumen()) }
    }

    // Los efectos cortos directamente no suenan si está silenciado
    method reproducir(archivo) {
        if (activado) {
            game.sound(archivo).play()
        }
    }

    // La música queda guardada para poder bajarle y subirle el volumen al silenciar
    method reproducirEnLoop(archivo) {
        const musica = game.sound(archivo)
        musica.shouldLoop(true)
        musica.volume(self.volumen())
        musicas.add(musica)
        musica.play()
    }
}
