import wollok.game.*
import cuadroDeTexto.*
import dialogos.*

class Persona {
    var property position
    const imagen
    const texto

    method image() = imagen

    method texto(){
    return texto
    }

    method interactuar(unDetective){
        const cuadro = new CuadroDeTexto(texto = texto)
        cuadros.abrir(cuadro,self)
    }

    method finalizarInteraccion(){
    }
}

const testigo = new Persona(
    position = game.at(6,5),
    imagen = "testigoPrueba.png",
    texto = "Vi a alguien salir de la habitación."
)

class Sospechoso inherits Persona {
    var confianza
    var presion
    const informaciones
    const opcionesDialogo
    var opcionElegida = null

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

    override method interactuar(unDetective){
        if(opcionElegida == null){
            self.abrirOpciones()
        }else{
            self.mostrarRespuesta()
        }
    }

    method abrirOpciones(){
        const selector = new SelectorDialogo(
            opciones = opcionesDialogo
        )

        const cuadro = new CuadroDeDialogo(
            texto = self.texto(),
            selector = selector
        )

        dialogos.abrir(cuadro,self)
    }

    method recibirRespuesta(unaOpcion){
        opcionElegida = unaOpcion
        self.mostrarRespuesta()
    }

    method mostrarRespuesta(){
        const cuadro = new CuadroDeTexto(
            texto = opcionElegida.respuesta()
        )

        cuadros.abrir(cuadro,self)
    }

    method reiniciar(){
    opcionElegida = null
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

const sospechosoPrueba = new Sospechoso(
    position = game.at(10,5),
    imagen = "sospechozoPrueba.png",
    texto = "No puedo dejarte pasar.",
    confianza = 0,
    presion = 0,
    informaciones = [],
    opcionesDialogo = [respuesta1,respuesta2,respuesta3]
)

const respuesta1 = new OpcionDialogo(
    texto = "Necesito ver a Chiqui urgente por favor.",
    tono = "gentil",
    respuesta = "No puedo dejarte pasar si Chiqui no me aviso que venias."
)

const respuesta2 = new OpcionDialogo(
    texto = "Abrime la puerta en este instante.",
    tono = "provocador",
    respuesta = "Sali de aca, quien te pensas que sos?"
)

const respuesta3 = new OpcionDialogo(
    texto = "Necesito pasar.",
    tono = "neutral",
    respuesta = "No te puedo dejar pasar."
)