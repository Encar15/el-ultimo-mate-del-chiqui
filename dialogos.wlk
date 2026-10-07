import wollok.game.*
import cuadroDeTexto.*

class OpcionDialogo {
    const texto
    const tono
    const respuesta

    method texto(){
        return texto
    }

    method tono(){
        return tono
    }

    method respuesta(){
        return respuesta
    }
}
class TextoOpcionDialogo {
    const selector
    const indice
    var property position

    method text(){
        return selector.opciones().get(indice).texto()
    }

    method textColor(){
        if(selector.indiceSeleccionado() == indice){
            return "FFFF00FF"
        }else{
            return "FFFFFFFF"
        }
    }
}

class TextoEtiquetaDialogo {
    const texto
    var property position

    method text(){
        return texto
    }

    method textColor(){
        return "FFFFFFFF"
    }
}

class SelectorDialogo {
    const opciones
    var indiceSeleccionado = 0

    method opciones(){
        return opciones
    }

    method indiceSeleccionado(){
        return indiceSeleccionado
    }

    method siguiente(){
        if(indiceSeleccionado == opciones.size() - 1){
            indiceSeleccionado = 0
        }else{
            indiceSeleccionado = indiceSeleccionado + 1
        }
    }

    method anterior(){
        if(indiceSeleccionado == 0){
            indiceSeleccionado = opciones.size() - 1
        }else{
            indiceSeleccionado = indiceSeleccionado - 1
        }
    }

    method opcionSeleccionada(){
        return opciones.get(indiceSeleccionado)
    }
}

class CuadroDeDialogo {
    const texto
    const selector

    var textoPrincipal = null
    var tituloOpciones = null
    var visualesOpciones = []

    method position() = game.at(0,0)
    method image() = "fondoNegroCuadroDeTexto.png"

    method abrir(){
        textoPrincipal = new TextoDelCuadro(
        texto = texto,
        position = game.at(2,4)
        )

        tituloOpciones = new TextoEtiquetaDialogo(
            texto = "Elegir dialogo:",
            position = game.at(2,3)
        )

        visualesOpciones = [
            new TextoOpcionDialogo(
                selector = selector,
                indice = 0,
                position = game.at(2,2)
            ),
            new TextoOpcionDialogo(
                selector = selector,
                indice = 1,
                position = game.at(2,1)
            ),
            new TextoOpcionDialogo(
                selector = selector,
                indice = 2,
                position = game.at(2,0)
            )
        ]

        game.addVisual(self)
        game.addVisual(textoPrincipal)
        game.addVisual(tituloOpciones)

        visualesOpciones.forEach({
            unVisual => game.addVisual(unVisual)
        })
    }

    method cerrar(){
        game.removeVisual(textoPrincipal)
        game.removeVisual(tituloOpciones)

        visualesOpciones.forEach({
            unVisual => game.removeVisual(unVisual)
        })

        game.removeVisual(self)
    }

    method siguiente(){
        selector.siguiente()
    }

    method anterior(){
        selector.anterior()
    }

    method opcionSeleccionada(){
        return selector.opcionSeleccionada()
    }
}

object dialogos {
    var cuadroActual = null
    var personajeActual = null

    method abrir(unCuadro,unPersonaje){
        cuadroActual = unCuadro
        personajeActual = unPersonaje

        cuadroActual.abrir()
    }

    method siguiente(){
        cuadroActual.siguiente()
    }

    method anterior(){
        cuadroActual.anterior()
    }

    method confirmar(){
    const opcionElegida = cuadroActual.opcionSeleccionada()
    const personaje = personajeActual

    self.cerrar()

    personaje.recibirRespuesta(opcionElegida)
    }

    method cerrar(){
        cuadroActual.cerrar()

        cuadroActual = null
        personajeActual = null
    }

    method hayDialogoAbierto(){
        return cuadroActual != null
    }

    method reiniciar(){
    cuadroActual = null
    personajeActual = null
    }
}