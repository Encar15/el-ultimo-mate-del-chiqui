import wollok.game.*
import detectives.*
import interacciones.*
import dialogos.*

object controles {

    method configurar(){
        keyboard.right().onPressDo({
            patricioJuan.moverDerecha()
        })

        keyboard.left().onPressDo({
            patricioJuan.moverIzquierda()
        })

        keyboard.up().onPressDo({
            if(dialogos.hayDialogoAbierto()){
                dialogos.anterior()
            }else{
                patricioJuan.moverArriba()
            }
        })

        keyboard.down().onPressDo({
            if(dialogos.hayDialogoAbierto()){
                dialogos.siguiente()
            }else{
                patricioJuan.moverAbajo()
            }
        })

        keyboard.z().onPressDo({
            interacciones.interactuar()
        })
    }
}