// nivel.wlk
import wollok.game.*
import detectives.*
import objetos.*
import restoPersonajes.*

object nivel {

    method iniciarPartida() {
        game.addVisual(llave)
        game.addVisual(testigo)
        game.addVisual(patricioJuan)
        game.addVisual(contador)

        contador.iniciarCronometro()
    }
}

object contador {
    var property tiempoRestante = 60
    const cronometro = game.tick(1000, { self.descontar(1)}, false)

    method text() = "Tiempo restante: " + tiempoRestante.toString()
    method textColor() = "000000"
    method position() = game.at(game.width() - 3, game.height() - 1)

    method iniciarCronometro() {
        cronometro.start()
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
