import wollok.game.*
import cuadroDeTexto.*

class Sospechoso {
    var property position
    const nombre
    var confeso = false

    method image() = nombre.toLowerCase() + ".png"

    method interactuar(detective) {
        if (detective.tienePista("llave")) {
            game.say(self, "¡Está bien, confieso! La llave era mía.")
            confeso = true
        } else {
            game.say(self, "Yo no vi nada, oficial. Déjeme en paz.")
        }
    }
}


class Persona {
    var property position
    const nombre
    const imagen
    const texto

    method image() = imagen

    method interactuar(){
        const cuadro = new CuadroDeTexto(texto = texto)
        cuadros.abrir(cuadro,self)
    }

    method finalizarInteraccion(){
    }
}

const testigo = new Persona(
    position = game.at(6,5),
    nombre = "Testigo",
    imagen = "testigoPrueba.png",
    texto = "Vi a alguien salir de la habitación."
)