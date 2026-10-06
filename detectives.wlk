import wollok.game.*
import cuadroDeTexto.*

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

    method moverA(nuevaPosicion){
    if(!cuadros.hayCuadroAbierto()){
        if(nuevaPosicion.x() >= 0
            && nuevaPosicion.x() < game.width()
            && nuevaPosicion.y() >= 0
            && nuevaPosicion.y() < game.height()){
            position = nuevaPosicion
        }
    }
}
}