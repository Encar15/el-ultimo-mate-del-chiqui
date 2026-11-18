import wollok.game.*

object musicaDeFondo {
    const duracionMs = 220000
    var reproduciendo = false
    var cancion = null

    method reproducir(){
        if(!reproduciendo){
            reproduciendo = true
            self.tocar()
            game.onTick(duracionMs, "loopMusicaFondo", { self.tocar() })
        }
    }

    method tocar(){
        cancion = game.sound("musicaDeJuego.mp3")
        cancion.play()
    }

    method detener(){
        if(reproduciendo){
            reproduciendo = false
            game.removeTickEvent("loopMusicaFondo")
            cancion.stop()
        }
    }
}

object silencio {
    method reproducir(){}
    method detener(){}
}