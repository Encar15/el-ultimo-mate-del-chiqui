import wollok.game.*

class Colision {
    var property position
}

object colisiones {
    var solidos = []

    method cargar(nuevosSolidos){
        solidos = nuevosSolidos
    }

    method limpiar(){
        solidos = []
    }

    method hayColisionEn(unaPosicion){
        return solidos.any({
            unSolido => unSolido.position() == unaPosicion
        })
    }

    // Ayudas para armar paredes sin escribir casilla por casilla
    method fila(y, desdeX, hastaX){
        return (desdeX..hastaX).map({
            x => new Colision(position = game.at(x,y))
        })
    }

    method columna(x, desdeY, hastaY){
        return (desdeY..hastaY).map({
            y => new Colision(position = game.at(x,y))
        })
    }
}