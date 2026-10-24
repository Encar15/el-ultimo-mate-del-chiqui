import wollok.game.*
import detectives.*
import objetos.*
import restoPersonajes.*
import cuadroDeTexto.*
import dialogos.*
import colisiones.*
import menu.*
import controles.*
import habitaciones.*

object nivel {

    method iniciarPartida() {
        mapa.iniciar()
        game.addVisual(patricioJuan)
        game.addVisual(contador)

        contador.iniciarCronometro()
    }

    method reiniciarEstado(){
        patricioJuan.reiniciar()
        sospechosoPrueba.reiniciar()
        forense.reiniciar()
        mapa.reiniciar()
        menu.reiniciar()
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

    method descontar(cantidad) {
      tiempoRestante = 0.max(tiempoRestante - cantidad)

      if(tiempoRestante == 0){
        self.perderJuego()
      }
    }

    method perderJuego() {
        cronometro.stop()
        veredicto.sinTiempo()
    }
}