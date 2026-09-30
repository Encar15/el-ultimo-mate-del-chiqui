import wollok.game.*
import cuadroDeTexto.*

class Persona {
    var property position
    const nombre
    const imagen
    const texto

    method image() = imagen

    method interactuar(unDetective){
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

class Sospechoso inherits Persona {
    var confianza
    var presion
    const informaciones

    method confianza(){
        return confianza
    }

    method presion(){
        return presion
    }

    method aumentarConfianza(cantidad){
        confianza = confianza + cantidad
    }

    method aumentarPresion(cantidad){
        presion = presion + cantidad
    }

    method informacionesDisponibles(){
        return informaciones.filter({
            unaInformacion => unaInformacion.puedeRevelarse(confianza,presion)
        })
    }
}

class Informacion {
    const texto
    const confianzaNecesaria
    const presionNecesaria

    method texto(){
        return texto
    }

    method puedeRevelarsePorConfianza(confianza){
        return confianza >= confianzaNecesaria
    }

    method puedeRevelarsePorPresion(presion){
        return presion >= presionNecesaria
    }

    method puedeRevelarse(confianza,presion){
        return self.puedeRevelarsePorConfianza(confianza)
            || self.puedeRevelarsePorPresion(presion)
    }
}