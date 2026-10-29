import wollok.game.*
import cuadroDeTexto.*
import colisiones.*
import dialogos.*
import instancias.*


object patricioJuan {
    var property position = game.at(7,9)
    var image = "patricioFrente.gif"

    method image() = image

    method moverArriba(){ self.moverA(position.up(1), "patricioEspalda.gif") }
    method moverAbajo(){ self.moverA(position.down(1), "patricioFrente.gif") }
    method moverIzquierda(){ self.moverA(position.left(1), "patricioIzquierda.gif") }
    method moverDerecha(){ self.moverA(position.right(1), "patricioDerecha.gif") }

    method moverA(nuevaPosicion, imagenNueva){
        if(!cuadros.hayCuadroAbierto() && !dialogos.hayDialogoAbierto()){
            image = imagenNueva
            if(self.casillaDisponible(nuevaPosicion)){
                position = nuevaPosicion
            }
        }
    }
   
    method reiniciar(){
        position = game.at(7,9)
        image = "patricioFrente.gif"
    }

    method casillaDisponible(nuevaPosicion){
    return nuevaPosicion.x() >= 0
        && nuevaPosicion.x() < game.width()
        && nuevaPosicion.y() >= 0
        && nuevaPosicion.y() < game.height()
        && !colisiones.hayColisionEn(nuevaPosicion)
    }

    method ubicarEn(unaPosicion){
    position = unaPosicion
    }
}