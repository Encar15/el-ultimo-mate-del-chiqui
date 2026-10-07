import wollok.game.*
import detectives.*
import cuadroDeTexto.*
import dialogos.*

object interacciones {

    method interactuar() {
    if(dialogos.hayDialogoAbierto()){
        dialogos.confirmar()
    }else{
        if(cuadros.hayCuadroAbierto()){
            cuadros.cerrar()
        }else{
            self.interactuarConCercano()
        }
    }
}

    method interactuarConCercano() {
        const detectiveActual = patricioJuan
        self.candidatos(detectiveActual)
            .take(1)
            .forEach({ elemento => elemento.interactuar(detectiveActual) })
    }

    method candidatos(unDetective) {
        return self.posicionesAInterrogar(unDetective)
                   .flatMap({ pos => game.getObjectsIn(pos) })
                   .filter({ obj => obj != unDetective })
    }

    method posicionesAInterrogar(unDetective) {
        const pos = unDetective.position()
        return [
            pos.up(1),
            pos.down(1),
            pos.left(1),
            pos.right(1)
        ]
    }
}