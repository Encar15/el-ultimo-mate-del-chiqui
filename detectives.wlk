import wollok.game.*
import directorJuego.*

object detective {
    const detectives = [patricioJuan, sargentoDocs, oliviaBenson]
    var indice = 0
    var detectiveActual = null

    method siguiente(){
        if(indice == detectives.size() - 1){
            indice = 0
        }else{
            indice = indice + 1
        }
    }

    method anterior(){
        if(indice == 0){
            indice = detectives.size() - 1
        }else{
            indice = indice - 1
        }
    }

    method confirmar(){
        if(detectiveActual == null){
            detectiveActual = detectives.get(indice)
            
            nivel.iniciarPartida()
    }
}

    method detectiveActual(){
        return detectiveActual
    }

    method nombreSeleccionado(){
        return detectives.get(indice).nombre()
    }
}

object patricioJuan {
    const nombre = "Patricio Juan"
    var property position = game.origin()
    method nombre() = nombre
    method image() = "patrickJanePrueba.png"
}

object sargentoDocs{
    const nombre = "Sargento Docs"
    var property position = game.origin()
    method nombre() = nombre
    method image() = "steve.png"
}

object oliviaBenson{
    const nombre = "Olivia Benson"
    var property position = game.origin()
    method nombre() = nombre
    method image() = "imagenTest.png"
}

object textoSeleccion {
    method position() = game.at(7, 6)
    method text() = detective.nombreSeleccionado()
    method textColor() = "000000FF"
}