// nivel.wlk
import wollok.game.*
import detectives.*
import objetos.*
import restoPersonajes.*
import cuadroDeTexto.*
import dialogos.*
import colisiones.*

class Habitacion {
    const fondo
    const personajes
    const objetos
    const colisionesHabitacion

    method entrar(){
        game.boardGround(fondo)

        personajes.forEach({
            unPersonaje => game.addVisual(unPersonaje)
        })

        objetos.forEach({
            unObjeto => unObjeto.mostrar()
        })

        colisiones.cargar(colisionesHabitacion)
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
}

// class Puerta {
//     var property position
//     const imagen
//     var destino = null
//     var posicionDestino = null

//     method image() = imagen

//     method conectar(unaHabitacion,unaPosicion){
//         destino = unaHabitacion
//         posicionDestino = unaPosicion
//     }

//     method interactuar(unDetective){
//         nivel.irA(destino,posicionDestino)
//     }

//     method mostrar(){
//         game.addVisual(self)
//     }

//     method ocultar(){
//         game.removeVisual(self)
//     }
// }

object nivel {

    method iniciarPartida() {
        game.addVisual(llave)
        game.addVisual(testigo)
        game.addVisual(patricioJuan)
        game.addVisual(contador)
        game.addVisual(sospechosoPrueba)

        contador.iniciarCronometro()
    }

    method reiniciarEstado(){
    patricioJuan.reiniciar()
    llave.reiniciar()
    sospechosoPrueba.reiniciar()
    cuadros.reiniciar()
    dialogos.reiniciar()
    contador.reiniciar()
    }

}


object contador {
    var property tiempoRestante = 60
    var pausado = false
    const cronometro = game.tick(1000, { self.descontar(1)}, false)

    method text() = "Tiempo restante: " + tiempoRestante.toString()
    method textColor() = "000000"
    method position() = game.at(game.width() - 3, game.height() - 1)

    method iniciarCronometro() {
        cronometro.start()
        pausado = false
    }

    method pausar(){
        cronometro.stop()
        pausado = true
    }

    method reanudar(){
        cronometro.start()
        pausado = false
    }

    method alternarPausa(){
        if(pausado){
            self.reanudar()
        }else{
            self.pausar()
        }
    }

    method reiniciarCronometro(){
        cronometro.stop()
        tiempoRestante = 60
        cronometro.start()
        pausado = false
    }

    method detenerCronometro(){
        cronometro.stop()
        pausado = false
    }

    method reiniciar(){
    cronometro.stop()
    tiempoRestante = 60
    pausado = false
    }

    method contadorEnCero() {
      self.tiempoRestante() == 0
    }

    method descontar(cantidad) {
      tiempoRestante = 0.max(tiempoRestante - cantidad)

      if(tiempoRestante == 0){
        self.perderJuego()
      }
    }

    method perderJuego() {
        cronometro.stop()

        game.say(patricioJuan, "¡Se me acabó el tiempo!")
        game.schedule(2000, { game.stop() })
    }
}


