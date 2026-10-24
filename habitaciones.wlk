import wollok.game.*
import colisiones.*
import detectives.*
import restoPersonajes.*
import objetos.*
import cuadroDeTexto.*
import menu.*

object fondo {
    var property image = "fondoOficina.png"

    method position() = game.origin()
}

class Habitacion {
    const imagenDeFondo
    const personajes = []
    const objetos = []
    const paredes = []

    method entrar(){
        fondo.image(imagenDeFondo)

        personajes.forEach({
            unPersonaje => game.addVisual(unPersonaje)
        })

        objetos.forEach({
            unObjeto => unObjeto.mostrar()
        })

        colisiones.cargar(self.solidos())
    }

    method salir(){
        personajes.forEach({
            unPersonaje => game.removeVisual(unPersonaje)
        })

        objetos.forEach({
            unObjeto => unObjeto.ocultar()
        })

        colisiones.limpiar()
    }

    method solidos(){
        return paredes + personajes + objetos.filter({
            unObjeto => unObjeto.esSolido()
        })
    }

    method contiene(unElemento){
        return personajes.contains(unElemento) || objetos.contains(unElemento)
    }

    method elementosEn(unaPosicion) = (personajes + objetos).filter({ unElemento => unElemento.ocupa(unaPosicion) })

    method reiniciar(){
        objetos.forEach({
            unObjeto => unObjeto.reiniciar()
        })
    }
}

class Puerta {
    var property position
    const destino
    const llegada
    const imagen = "puerta.png"
    const requisitos = []
    const textoCerrado = "La puerta está cerrada."

    method image() = imagen

    method esSolido() = true

    method interactuar(unDetective){
        if(menu.tieneTodas(requisitos)){
            mapa.irA(destino, llegada)
        }else{
            cuadros.abrir(new CuadroDeTexto(texto = textoCerrado), self)
        }
    }

    method finalizarInteraccion(){
    }

    method ocupa(unaPosicion) = position == unaPosicion

    method mostrar(){
        game.addVisual(self)
    }

    method ocultar(){
        game.removeVisual(self)
    }

    method reiniciar(){
    }
}


object mapa {
    const habitaciones = [oficina, pasillo]
    const habitacionInicial = oficina
    var habitacionActual = habitacionInicial

    method habitacionActual() = habitacionActual

    method iniciar(){
        game.addVisual(fondo)
        habitacionActual.entrar()
    }

    method irA(unaHabitacion, unaPosicion){
        habitacionActual.salir()
        habitacionActual = unaHabitacion
        habitacionActual.entrar()

        patricioJuan.ubicarEn(unaPosicion)
        self.traerAlFrente(patricioJuan)
    }

    method traerAlFrente(unVisual){
        game.removeVisual(unVisual)
        game.addVisual(unVisual)
    }

    method reiniciar(){
        habitaciones.forEach({
            unaHabitacion => unaHabitacion.reiniciar()
        })
        habitacionActual = habitacionInicial
        colisiones.limpiar()
    }
}

// ====================== HABITACIONES ======================

const oficina = new Habitacion(
    imagenDeFondo = "fondoOficina.png",
    personajes = [testigo, utilero],
    objetos = [cuadroBarco, escritorio, puertaOficinaAPasillo],
    paredes = colisiones.fila(11, 0, 22)
)

const pasillo = new Habitacion(
    imagenDeFondo = "fondoPasillo.png",
    personajes = [sospechosoPrueba, forense],
    objetos = [matafuego, puertaPasilloAOficina, locker],
    paredes = colisiones.fila(11, 0, 22) + colisiones.columna(16, 8, 10)
)
// ====================== PUERTAS ======================

const puertaOficinaAPasillo = new Puerta(
    position = game.at(22,5),
    destino = pasillo,
    llegada = game.at(1,5)
)

const puertaPasilloAOficina = new Puerta(
    position = game.at(0,5),
    destino = oficina,
    llegada = game.at(21,5)
)
