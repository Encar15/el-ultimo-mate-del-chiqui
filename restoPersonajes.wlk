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
    const preguntas
    var preguntasPendientes = []
    const humorInicial = 0
    var humor = 0
    const nombreBaseImagen
    const nombre
    const property esCulpable = false
    const pistasNecesarias = []
    const descripcion = "Todavía no hay pruebas en su contra."

    method initialize(){
        self.reiniciar()
    }

    override method image() = self.estadoDeAnimo().imagen(nombreBaseImagen)

    method nombre() = nombre
    method puedeIrPreso() = esCulpable && menu.tieneTodas(pistasNecesarias)
    method imagenParaMenu() = self.image()
    method tituloParaMenu() = nombre.toUpperCase()
    method descripcionParaMenu() = textos.envolver(descripcion, 40)
    method cambiarHumor(cantidad){
        humor = humor + cantidad
    }
    method estadoDeAnimo() = estadosDeAnimo.segun(humor)
    method tienePreguntaDisponible() = preguntasPendientes.any({ unaPregunta => unaPregunta.esPreguntable() })
    method proximaPregunta() = preguntasPendientes.find({ unaPregunta => unaPregunta.esPreguntable() })
    override method interactuar(unDetective){
        menu.guardarSospechoso(self)
        if(self.tienePreguntaDisponible()){
            self.preguntar(self.proximaPregunta())
        }else{
            super(unDetective)
        }
    }

    method preguntar(unaPregunta){
        preguntasPendientes.remove(unaPregunta)
        const cuadro = new CuadroDeDialogo(
            texto = unaPregunta.texto(),
            selector = new SelectorDialogo(opciones = unaPregunta.opciones())
        )
        dialogos.abrir(cuadro, self)
    }

    method recibirRespuesta(unaOpcion){
        unaOpcion.afectarSospechoso(self)
        const respuesta = unaOpcion.respuestaSegunEstado(self.estadoDeAnimo())
        cuadros.abrir(new CuadroDeTexto(texto = respuesta), self)
    }

    method reiniciar(){
        humor = humorInicial
        preguntasPendientes = preguntas.copy()
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
    texto = "Ya te dije todo lo que sé. No puedo dejarte pasar.",
    preguntas = [preguntaGuardia1, preguntaGuardia2]
)

const preguntaGuardia1 = new Pregunta(
    texto = "No puedo dejarte pasar.",
    opciones = [opcionGuardia1, opcionGuardia2, opcionGuardia3]
)

const opcionGuardia1 = new OpcionDialogo(
    texto = "Necesito ver a Chiqui urgente por favor.",
    tono = gentil,
    respuestaNormal = "No puedo dejarte pasar si Chiqui no me avisó que venías.",
    respuestaEnojada = "Mirá, flaco, ya te dije que no pasás. Cortala."
)

const opcionGuardia2 = new OpcionDialogo(
    texto = "Abrime la puerta en este instante.",
    tono = provocador,
    respuestaNormal = "Salí de acá, ¿quién te pensás que sos?",
    respuestaEnojada = "¡Te voy a sacar a patadas si no te vas!"
)

const opcionGuardia3 = new OpcionDialogo(
    texto = "Necesito pasar.",
    tono = neutral,
    respuestaNormal = "No te puedo dejar pasar.",
    respuestaEnojada = "Sigo sin poder dejarte pasar. Y me estás molestando."
)

const preguntaGuardia2 = new Pregunta(
    texto = "¿Otra vez vos? ¿Qué pasa ahora?",
    requisitos = [informeForense],
    opciones = [opcionGuardia4, opcionGuardia5]
)

const opcionGuardia4 = new OpcionDialogo(
    texto = "La yerba del mate tenía veneno. ¿Viste a alguien?",
    tono = neutral,
    respuestaNormal = "Vi entrar a alguien con un termo, pero no le vi la cara.",
    respuestaEnojada = "¡Yo cuido la puerta, no miro quién lleva termo!"
)

const opcionGuardia5 = new OpcionDialogo(
    texto = "Seguro que vos le pusiste veneno a la yerba.",
    tono = provocador,
    respuestaNormal = "¿Yo? Yo no toco nada, solo cuido la puerta.",
    respuestaEnojada = "¡A mí no me metas en esto!"
)

const utilero = new Sospechoso(
    position = game.at(17,8),
    nombre = "presidente de la fifa",
    esCulpable = true,
    pistasNecesarias = [bombilla, informeForense],
    descripcion = "es el presidente de la fifa y tiene un gran poder de influencia.",
    nombreBaseImagen = "pelado",
    imagen = "pelado.png",
    texto = "No tengo nada más para decirte. Estoy ocupado.",
    preguntas = [preguntaPresidente1, preguntaPresidente2]
)

const preguntaPresidente1 = new Pregunta(
    texto = "¿Qué necesitás? Estoy ocupado.",
    opciones = [opcionPresidente1, opcionPresidente2, opcionPresidente3]
)

const opcionPresidente1 = new OpcionDialogo(
    texto = "Disculpá, ¿viste algo raro hoy?",
    tono = gentil,
    respuestaNormal = "Nada raro. Estuve en una reunion toda la tarde.",
    respuestaEnojada = "¡Ya te dije que estuve en una reunion todo el dia, tomatela!"
)

const opcionPresidente2 = new OpcionDialogo(
    texto = "Vos tenés cara de culpable.",
    tono = provocador,
    respuestaNormal = "¿Qué decís? ¡No hable con la victima en todo el dia!",
    respuestaEnojada = "¡No me acuses sin pruebas, eh!"
)

const opcionPresidente3 = new OpcionDialogo(
    texto = "¿Conocés bien al Chiqui?",
    tono = neutral,
    respuestaNormal = "Todos lo conocen. Le gusta el mate bien caliente.",
    respuestaEnojada = "Sí, lo conozco, y?."
)

const preguntaPresidente2 = new Pregunta(
    texto = "¿Otra vez vos? Te dije que estoy ocupado.",
    requisitos = [bombilla],
    opciones = [opcionPresidente4, opcionPresidente5]
)

const opcionPresidente4 = new OpcionDialogo(
    texto = "Encontré esta bombilla en el locker 17. ¿Es tuya?",
    tono = neutral,
    respuestaNormal = "No, yo no uso ese locker.",
    respuestaEnojada = "¡No sé de quién es esa bombilla!"
)

const opcionPresidente5 = new OpcionDialogo(
    texto = "Esta bombilla tiene tus huellas.",
    tono = provocador,
    respuestaNormal = "Imposible. Yo tomo con mi propia bombilla.",
    respuestaEnojada = "¡Eso es mentira y lo sabés!"
)

// ====================== INFORMANTES ======================

const forense = new Informante(
    position = game.at(3,7),
    imagen = "forense.png",
    texto = "Terminé con el cuerpo, detective. Lo envenenaron: había veneno en la yerba del mate.",
    pista = informeForense
)
