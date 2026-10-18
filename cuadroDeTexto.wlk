import wollok.game.*

class TextoDelCuadro {
    var property texto
    var property position
    const color = "FFFFFFFF"

    method text() = texto
    method textColor() = color
}

class CuadroDeTexto {
    var property texto
    var abierto = false
    var textoVisual = null

    method position() = game.at(0,0)
    method image() = "fondoNegroCuadroDeTexto.png"

    method abrir(){
        textoVisual = new TextoDelCuadro(
            texto = texto,
            position = game.at(2,2))
        game.addVisual(self)
        game.addVisual(textoVisual)
        abierto = true
    }

    method cerrar(){
        game.removeVisual(textoVisual)
        game.removeVisual(self)
        abierto = false
    }

    method estaAbierto(){
        return abierto
    }
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
            cuadroActual.cerrar()
            objetoActual.finalizarInteraccion()
            cuadroActual = null
            objetoActual = null
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
