import wollok.game.*
import cuadroDeTexto.*

class OpcionDialogo {
    const texto
    const tono
    const respuestaNormal
    const respuestaEnojada

    method texto() = texto
    method respuestaSegunEstado(unEstado) = unEstado.reaccionar(self)
    method respuestaInocente() = respuestaNormal
    method respuestaCulpable() = respuestaEnojada

    method afectarSospechoso(unSospechoso) {
        tono.afectar(unSospechoso)
    }
}

// ====================== TONOS DE DIÁLOGO ======================

object provocador {
    method afectar(unSospechoso) {
        unSospechoso.aumentarPresion(10)
        unSospechoso.estadoDeAnimo(acorralado)
    }
}

object gentil {
    method afectar(unSospechoso) {
        unSospechoso.aumentarConfianza(10)
        unSospechoso.estadoDeAnimo(relajado)
    }
}

object neutral {
    method afectar(unSospechoso) {
        // No altera la confianza, la presión ni el estado de ánimo
    }
}

object relajado {
    method imagen(base) = base + "Normal.png"

    method reaccionar(pregunta) = pregunta.respuestaInocente()
}

object acorralado {
    method imagen(base) = base + "Nervioso.png"

    method reaccionar(pregunta) = pregunta.respuestaCulpable()
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
    const etiqueta = "Elegir dialogo:"

    var visualesAbiertos = []

    method position() = game.at(0,0)
    method image() = "fondoNegroCuadroDeTexto.png"

    method visuales(){
        const cantidadDeOpciones = selector.opciones().size()
        const visualesOpciones = (0 .. cantidadDeOpciones - 1).map({ unIndice =>
            new TextoOpcionDialogo(
                selector = selector,
                indice = unIndice,
                position = game.at(2, 2 - unIndice)
            )
        })
        return [
            self,
            new TextoDelCuadro(texto = texto, position = game.at(2,4)),
            new TextoDelCuadro(texto = etiqueta, position = game.at(2,3))
        ] + visualesOpciones
    }

    method abrir(){
        visualesAbiertos = self.visuales()
        visualesAbiertos.forEach({
            unVisual => game.addVisual(unVisual)
        })
    }

    method cerrar(){
        visualesAbiertos.forEach({
            unVisual => game.removeVisual(unVisual)
        })
        visualesAbiertos = []
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