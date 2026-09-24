import wollok.game.*
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