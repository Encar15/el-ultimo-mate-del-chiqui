import wollok.game.*
import directorJuego.*
import controles.*
import instancias.*

object debug {
    const activo = true

    method configurar(){
        if(activo){
            keyboard.r().onPressDo({
                self.reiniciarJuego()
            })
        }
    }

    method reiniciarJuego(){

        game.clear()

        nivel.reiniciarEstado()
        nivel.iniciarPartida()

        controles.configurar()
        self.configurar()
    }
}