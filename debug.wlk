import wollok.game.*
import directorJuego.*
import controles.*
import instancias.*

object debug {
    const activo = true

    method configurar(){
        if(activo){
            keyboard.p().onPressDo({
                contador.alternarPausa()
            })

            keyboard.o().onPressDo({
                contador.reiniciarCronometro()
            })

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