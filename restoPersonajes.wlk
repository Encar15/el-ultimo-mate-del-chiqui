import wollok.game.*
import cuadroDeTexto.*
import dialogos.*
import menu.*
import objetos.*

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

    method ocupa(unaPosicion) = position == unaPosicion
}

const testigo = new Persona(
    position = game.at(6,5),
    imagen = "testigoPrueba.png",
    texto = "Vi a alguien salir de la habitación."
)

class Sospechoso inherits Persona {
    var confianza
    var presion
    const opcionesDialogo
    var opcionElegida = null
    var property estadoDeAnimo = relajado
    const nombreBaseImagen
    const nombre
    const property esCulpable = false
    const pistasNecesarias = []
    const descripcion = "Todavía no hay pruebas en su contra."

    override method image() = estadoDeAnimo.imagen(nombreBaseImagen)

    method nombre() = nombre
    method puedeIrPreso() = esCulpable && menu.tieneTodas(pistasNecesarias)
    method imagenParaMenu() = self.image()
    method tituloParaMenu() = nombre.toUpperCase()
    method descripcionParaMenu() = textos.envolver(descripcion, 40)

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

    override method interactuar(unDetective){
        menu.guardarSospechoso(self)
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
        unaOpcion.afectarSospechoso(self)

        self.mostrarRespuesta()
    }

    method mostrarRespuesta(){
        const textoRespuesta = opcionElegida.respuestaSegunEstado(estadoDeAnimo)

        const cuadro = new CuadroDeTexto(
            texto = textoRespuesta
        )

        cuadros.abrir(cuadro,self)
    }

     method reiniciar(){
        opcionElegida = null
        estadoDeAnimo = relajado
    }
}

class Informante inherits Persona {
    const pista
    const textoDespues = "Espero que te sirva la información que te di."
    var estado = sinHablar

    override method interactuar(unDetective){
        estado.hablar(self)
    }

    override method finalizarInteraccion(){
        estado.terminoDeHablar(self)
    }

    method contarPista(){
        estado = contandoPista
        self.decir(self.texto())
    }

    method entregarPista(){
        pista.marcarEncontrada()
        estado = yaInformo
        self.decir("Se guardó " + pista.tituloParaMenu() + " como pista en el menú.")
    }

    method recordar(){
        self.decir(textoDespues)
    }

    method decir(unTexto){
        cuadros.abrir(new CuadroDeTexto(texto = unTexto), self)
    }

    method reiniciar(){
        estado = sinHablar
    }
}

object sinHablar {
    method hablar(unInformante){ unInformante.contarPista() }
    method terminoDeHablar(unInformante){}
}

object contandoPista {
    method hablar(unInformante){}
    method terminoDeHablar(unInformante){ unInformante.entregarPista() }
}

object yaInformo {
    method hablar(unInformante){ unInformante.recordar() }
    method terminoDeHablar(unInformante){}
}

// ====================== SOSPECHOSOS ======================

const sospechosoPrueba = new Sospechoso(
    position = game.at(10,5),
    nombre = "El guardia",
    nombreBaseImagen = "guardia",
    imagen = "dummy.png",
    texto = "No puedo dejarte pasar.",
    confianza = 0,
    presion = 0,
    opcionesDialogo = [respuesta1, respuesta2, respuesta3]
)

const respuesta1 = new OpcionDialogo(
    texto = "Necesito ver a Chiqui urgente por favor.",
    tono = gentil,
    respuestaNormal = "No puedo dejarte pasar si Chiqui no me avisó que venías.",
    respuestaEnojada = "Mirá, flaco, ya te dije que no pasás. Cortala."
)

const respuesta2 = new OpcionDialogo(
    texto = "Abrime la puerta en este instante.",
    tono = provocador,
    respuestaNormal = "Salí de acá, ¿quién te pensás que sos?",
    respuestaEnojada = "¡Te voy a sacar a patadas si no te vas!"
)

const respuesta3 = new OpcionDialogo(
    texto = "Necesito pasar.",
    tono = neutral,
    respuestaNormal = "No te puedo dejar pasar.",
    respuestaEnojada = "Sigo sin poder dejarte pasar. Y me estás molestando."
)

const utilero = new Sospechoso(
    position = game.at(17,8),
    nombre = "presidente de la fifa",
    esCulpable = true,
    pistasNecesarias = [bombilla, informeForense],
    descripcion = "es el presidente de la fifa y tiene un gran poder de influencia.",
    nombreBaseImagen = "pelado",
    imagen = "pelado.png",
    texto = "¿Qué necesitás? Estoy ocupado.",
    confianza = 0,
    presion = 0,
    opcionesDialogo = [preguntaPresidente1, preguntaPresidente2, preguntaPresidente3]
)

const preguntaPresidente1 = new OpcionDialogo(
    texto = "Disculpá, ¿viste algo raro hoy?",
    tono = gentil,
    respuestaNormal = "Nada raro. Estuve en una reunion toda la tarde.",
    respuestaEnojada = "¡Ya te dije que estuve en una reunion todo el dia, tomatela!"
)

const preguntaPresidente2 = new OpcionDialogo(
    texto = "Vos tenés cara de culpable.",
    tono = provocador,
    respuestaNormal = "¿Qué decís? ¡No hable con la victima en todo el dia!",
    respuestaEnojada = "¡No me acuses sin pruebas, eh!"
)

const preguntaPresidente3 = new OpcionDialogo(
    texto = "¿Conocés bien al Chiqui?",
    tono = neutral,
    respuestaNormal = "Todos lo conocen. Le gusta el mate bien caliente.",
    respuestaEnojada = "Sí, lo conozco, y?."
)

// ====================== INFORMANTES ======================

const forense = new Informante(
    position = game.at(3,7),
    imagen = "forense.png",
    texto = "Terminé con el cuerpo, detective. Lo envenenaron: había veneno en la yerba del mate.",
    pista = informeForense
)
