import wollok.game.*
import cuadroDeTexto.*
import colisiones.*

object patricioJuan {
    const nombre = "Patricio Juan"
    var property position = game.origin()

    method nombre() = nombre
    method image() = "pixil-frame-1.png"

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
    if(!cuadros.hayCuadroAbierto()){
        if(self.casillaDisponible(nuevaPosicion)){
            position = nuevaPosicion
            }
        }
    }
}


