import wollok.game.*
import cuadroDeTexto.*
import menu.*

class Pista {
    var property position = game.origin()
    const nombre
    const texto
    var disponible = true

    method image() = nombre + ".png"

    method esSolido() = false

    method ocupa(unaPosicion) = disponible && position == unaPosicion

    method interactuar(unDetective){
        self.marcarEncontrada()
        const cuadro = new CuadroDeTexto(texto = texto)
        cuadros.abrir(cuadro,self)
    }

    method marcarEncontrada(){
        disponible = false
        menu.guardarPista(self)
    }

    method imagenParaMenu() = self.image()
    method tituloParaMenu() = nombre.toUpperCase()
    method descripcionParaMenu() = textos.envolver(texto, 40)

    method finalizarInteraccion(){
        game.removeVisual(self)
    }

    method mostrar(){
        if(disponible){
            game.addVisual(self)
        }
    }

    method ocultar(){
        if(disponible){
            game.removeVisual(self)
        }
    }

    method reiniciar(){
        disponible = true
    }
}

class Mueble {
    var property position
    const imagen
    const descripcion
    const ancho = 1
    const alto = 1
    const requisitos = []                 
    const textoCerrado = "Está cerrado."

    method image() = imagen
    method descripcion() = descripcion

    method esSolido() = true

    method ocupa(unaPosicion) = unaPosicion.x().between(position.x(), position.x() + ancho - 1) && unaPosicion.y().between(position.y(), position.y() + alto - 1)

    method interactuar(unDetective){
        if(menu.tieneTodas(requisitos)){
            self.usar(unDetective)
        }else{
            self.decir(textoCerrado)
        }
    }

   method usar(unDetective){
        self.decir(descripcion)
    }

    method decir(unTexto){
        const cuadro = new CuadroDeTexto(texto = unTexto)
        cuadros.abrir(cuadro,self)
    }

    method finalizarInteraccion(){
    }

    method mostrar(){
        game.addVisual(self)
    }

    method ocultar(){
        game.removeVisual(self)
    }

    method reiniciar(){
    }
}

class MuebleConPista inherits Mueble {
    const pista
    const textoHallazgo
    var estado = conPista

    override method usar(unDetective){
        estado.revisar(self)
    }

    method entregarPista(){
        pista.marcarEncontrada()
        estado = vacio
        self.decir(textoHallazgo)
    }

    override method reiniciar(){
        estado = conPista
        pista.reiniciar()
    }
}

object conPista {
    method revisar(unMueble){
        unMueble.entregarPista()
    }

    method estaVacio() = false
}

object vacio {
    method revisar(unMueble){
        unMueble.decir(unMueble.descripcion())
    }

    method estaVacio() = true
}

// ====================== PISTAS ======================
// si no tiene posicion esta dentro de un mueble, si tiene posicion esta en el piso

const llave = new Pista(
    nombre = "llave",
    texto = "Una llave chiquita. Parece de un locker."
)

const bombilla = new Pista(
    nombre = "bombilla",
    texto = "Es una bombilla de un mate, parece que alguien la uso hace poco"
)

// ====================== MUEBLES ===========================

const cuadroBarco = new Mueble(
    position = game.at(4,11),
    imagen = "cuadroBarco.png",
    descripcion = "Es un cuadro de un barco."
)

const escritorio = new MuebleConPista(
    position = game.at(12,7),
    imagen = "escritorio.png",
    ancho = 2,
    alto = 2,
    descripcion = "El cajón está vacío.",
    pista = llave,
    textoHallazgo = "Encontraste una llave adentro del cajón."
)

const matafuego = new Mueble(
    position = game.at(5,10),
    imagen = "matafuegos.png",
    descripcion = "Un matafuego. Venció en 2019."
)

const locker = new MuebleConPista(
    position = game.at(12,9),
    alto = 2,
    imagen = "locker.png",
    descripcion = "Abriste el locker con la llave. Adentro solo hay ropa doblada.",
    pista = bombilla,
    textoHallazgo = "Encontraste una bombilla adentro del locker.",
    requisitos = [llave],
    textoCerrado = "El locker está cerrado con llave."
)