import wollok.game.*
import detectives.*
import cuadroDeTexto.*

object interacciones {

    method interactuar() {
        if (cuadros.hayCuadroAbierto()) {
            cuadros.cerrar()
        } else {
            self.interactuarConCercano()
        }
    }

    method interactuarConCercano() {
        const detectiveActual = detective.detectiveActual()
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
        return [                      // Misma celda (para pistas que pisás)
            pos.up(1),    // Arriba
            pos.down(1),  // Abajo
            pos.left(1),  // Izquierda
            pos.right(1)  // Derecha
        ]
    }
}