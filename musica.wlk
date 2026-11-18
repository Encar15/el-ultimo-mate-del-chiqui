import wollok.game.*

object musicaDeFondo {
    const cancion = game.sound("musicaDeFondo.mp3")

    method reproducir(){
        if(!cancion.played()){
            cancion.shouldLoop(true)
            cancion.play()
        }
    }
}

object silencio {
    method reproducir(){}
}