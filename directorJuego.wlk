// nivel.wlk
import wollok.game.*
import detectives.*
import objetos.*
import restoPersonajes.*

object nivel {

    method configurarInicio() {
        game.addVisual(textoSeleccion)
    }

    method iniciarPartida() {
        // 1. Quitar los visuales de la selección
        game.removeVisual(textoSeleccion)

        // 3. Poblar la escena con los elementos del misterio
        game.addVisual(llave)
        game.addVisual(testigo)

         // 2. Colocar al detective elegido en el juego
        game.addVisualCharacter(detective.detectiveActual())
    }
}