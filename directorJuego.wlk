import wollok.game.*
import detectives.*
import objetos.*
import restoPersonajes.*
import cuadroDeTexto.*
import dialogos.*
import colisiones.*
import menu.*
import controles.*
import habitaciones.*
import instancias.*

object nivel {

    method iniciarPartida() {
        mapa.iniciar()
        game.addVisual(patricioJuan)
    }

    method reiniciarEstado(){
        patricioJuan.reiniciar()
        mapa.reiniciar()
        menu.reiniciar()
        cuadros.reiniciar()
        dialogos.reiniciar()
    }
}
