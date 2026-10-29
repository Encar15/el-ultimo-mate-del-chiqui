import wollok.game.*
import instancias.*

class TextoDelCuadro {
    var property texto
    var property position
    const color = "FFFFFFFF"

    method text() = texto
    method textColor() = color
}

class CuadroDeTexto {
    var property texto
    var textoVisual = null
    const anchoDeLetra = 0.06

    method position() = game.at(0,0)
    method image() = "fondoNegroCuadroDeTexto.png"

    method abrir(){
        textoVisual = new TextoDelCuadro(
            texto = texto,
            position = self.posicionDelTexto())
        game.addVisual(self)
        game.addVisual(textoVisual)
    }

    method cerrar(){
        game.removeVisual(textoVisual)
        game.removeVisual(self)
    }

    method posicionDelTexto() = game.at((0.5 + texto.size() * anchoDeLetra / 2).round(), 2)
}

object cuadros {
    var cuadroActual = null
    var objetoActual = null

    method abrir(unCuadro, unObjeto){
        cuadroActual = unCuadro
        objetoActual = unObjeto
        cuadroActual.abrir()
    }

    method cerrar(){
        if(cuadroActual != null){
            const objeto = objetoActual
            cuadroActual.cerrar()
            cuadroActual = null
            objetoActual = null
            objeto.finalizarInteraccion()
        }
    }

    method hayCuadroAbierto(){
        return cuadroActual != null
    }

    method reiniciar(){
    cuadroActual = null
    objetoActual = null
    }
}
