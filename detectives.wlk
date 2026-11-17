import wollok.game.*
import colisiones.*
import instancias.*


object patricioJuan {
    var property position = game.at(7,9)
    var image = "patricioFrente.gif"

    method image() = image

    method mover(unaDireccion){
        image = unaDireccion.imagenDelDetective()
        const nuevaPosicion = unaDireccion.siguiente(position)
        if(self.casillaDisponible(nuevaPosicion)){
            position = nuevaPosicion
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

object arriba {
    method siguiente(unaPosicion) = unaPosicion.up(1)
    method imagenDelDetective() = "patricioEspalda.gif"
    method enPantalla(unaPantalla){ unaPantalla.arriba() }
    method enDialogo(unDialogo){ unDialogo.anterior() }
}

object abajo {
    method siguiente(unaPosicion) = unaPosicion.down(1)
    method imagenDelDetective() = "patricioFrente.gif"
    method enPantalla(unaPantalla){ unaPantalla.abajo() }
    method enDialogo(unDialogo){ unDialogo.siguiente() }
}

object izquierda {
    method siguiente(unaPosicion) = unaPosicion.left(1)
    method imagenDelDetective() = "patricioIzquierda.gif"
    method enPantalla(unaPantalla){ unaPantalla.izquierda() }
    method enDialogo(unDialogo){}
}

object derecha {
    method siguiente(unaPosicion) = unaPosicion.right(1)
    method imagenDelDetective() = "patricioDerecha.gif"
    method enPantalla(unaPantalla){ unaPantalla.derecha() }
    method enDialogo(unDialogo){}
}