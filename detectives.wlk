import wollok.game.*
import cuadroDeTexto.*
import colisiones.*
import dialogos.*

object patricioJuan {
    const nombre = "Patricio Juan"
    var property position = game.origin()

    method nombre() = nombre
    method image() = "goat.png"

    method moverArriba(){
        self.moverA(position.up(1))
    }

    method moverAbajo(){
        self.moverA(position.down(1))
    }

    method moverIzquierda(){
        self.moverA(position.left(1))
    }

    method moverDerecha(){
        self.moverA(position.right(1))
    }

    method casillaDisponible(nuevaPosicion){
    return nuevaPosicion.x() >= 0
        && nuevaPosicion.x() < game.width()
        && nuevaPosicion.y() >= 0
        && nuevaPosicion.y() < game.height()
        && !colisiones.hayColisionEn(nuevaPosicion)
    }

    method moverA(nuevaPosicion){
    if(!cuadros.hayCuadroAbierto() && !dialogos.hayDialogoAbierto()){
        if(self.casillaDisponible(nuevaPosicion)){
            position = nuevaPosicion
        }
    }
    }

    method reiniciar(){
    position = game.origin()
    }

    method ubicarEn(unaPosicion){
    position = unaPosicion
    }
}


