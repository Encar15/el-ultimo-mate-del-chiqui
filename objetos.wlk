import wollok.game.*
import cuadroDeTexto.*

class Pista {
    var property position
    const nombre
    const texto
    var disponible = true

    method image() = nombre + ".png"

    method puedeInteractuar(unDetective){
        return disponible && unDetective.position() == self.position()
    }

    method interactuar(unDetective){
        disponible = false
        const cuadro = new CuadroDeTexto(texto = texto)
        cuadros.abrir(cuadro,self)
    }

    method finalizarInteraccion(){
        game.removeVisual(self)
}
}

const llave = new Pista(
    position = game.at(4,5),
    nombre = "llave",
    texto = "encontraste una llave"
)