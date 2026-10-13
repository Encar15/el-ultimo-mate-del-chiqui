import wollok.game.*
import cuadroDeTexto.*
import inventario.*

class Pista {
    var property position = game.origin()
    const nombre
    const texto
    var disponible = true

    method nombre() = nombre
    method image() = nombre + ".png"

    method texto(){
        return texto
    }

    method estaDisponible(){
        return disponible
    }

    method esSolido() = false

    method interactuar(unDetective){
        self.marcarEncontrada()
        const cuadro = new CuadroDeTexto(texto = texto)
        cuadros.abrir(cuadro,self)
    }

    method marcarEncontrada(){
        disponible = false
        inventario.guardar(self)
    }

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

    method image() = imagen
    method descripcion() = descripcion

    method esSolido() = true

    method interactuar(unDetective){
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

    override method interactuar(unDetective){
        estado.revisar(self)
    }

    method entregarPista(){
        pista.marcarEncontrada()
        estado = vacio
        self.decir(textoHallazgo)
    }

    method estaVacio() = estado.estaVacio()

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
    position = game.at(8,6),
    nombre = "bombilla",
    texto = "Encontraste una bombilla tirada en el piso."
)

// ====================== MUEBLES ===========================

const cuadroBarco = new Mueble(
    position = game.at(4,10),
    imagen = "cuadroBarco.png",
    descripcion = "Es un cuadro de un barco."
)

const escritorio = new MuebleConPista(
    position = game.at(12,7),
    imagen = "escritorio.png",
    descripcion = "El cajón está vacío.",
    pista = llave,
    textoHallazgo = "Encontraste una llave adentro del cajón."
)

const matafuego = new Mueble(
    position = game.at(5,10),
    imagen = "matafuego.png",
    descripcion = "Un matafuego. Venció en 2019."
)
