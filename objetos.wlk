import wollok.game.*
import cuadroDeTexto.*

class Pista {
    var property position
    const nombre
    const texto
    var disponible = true

    method image() = nombre + ".png"

    method estaDisponible(){
        return disponible
    }

    method interactuar(unDetective){
        disponible = false
        const cuadro = new CuadroDeTexto(texto = texto)
        cuadros.abrir(cuadro,self)
    }

    method finalizarInteraccion(){
        game.removeVisual(self)
    }

    method reiniciar(){
    disponible = true
    }
}

const llave = new Pista(
    position = game.at(4,5),
    nombre = "llave",
    texto = "encontraste una llave"
)