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
}