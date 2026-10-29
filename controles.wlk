import wollok.game.*
import detectives.*
import interacciones.*
import dialogos.*
import menu.*
import instancias.*

object controles {

    method configurar(){
        keyboard.right().onPressDo({ self.derecha() })
        keyboard.left().onPressDo({ self.izquierda() })
        keyboard.up().onPressDo({ self.arriba() })
        keyboard.down().onPressDo({ self.abajo() })
        keyboard.z().onPressDo({ self.confirmar() })
        keyboard.x().onPressDo({ self.cancelar() })
        keyboard.c().onPressDo({ menu.alternar() })
    }

    method derecha(){
        if(menu.estaAbierto()){
            menu.derecha()
        }else{
            patricioJuan.moverDerecha()
        }
    }

    method izquierda(){
        if(menu.estaAbierto()){
            menu.izquierda()
        }else{
            patricioJuan.moverIzquierda()
        }
    }

    method arriba(){
        if(menu.estaAbierto()){
            menu.arriba()
        }else if(dialogos.hayDialogoAbierto()){
            dialogos.anterior()
        }else{
            patricioJuan.moverArriba()
        }
    }

    method abajo(){
        if(menu.estaAbierto()){
            menu.abajo()
        }else if(dialogos.hayDialogoAbierto()){
            dialogos.siguiente()
        }else{
            patricioJuan.moverAbajo()
        }
    }

    method confirmar(){
        if(menu.estaAbierto()){
            menu.confirmar()
        }else{
            interacciones.interactuar()
        }
    }

    method cancelar(){
        if(menu.estaAbierto()){
            menu.volver()
        }
    }
}
