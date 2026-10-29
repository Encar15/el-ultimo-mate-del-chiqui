import wollok.game.*
import detectives.*
import objetos.*
import interacciones.*
import restoPersonajes.*
import directorJuego.*
import dialogos.*
import controles.*
import debug.*
import habitaciones.*
import colisiones.*
import cuadroDeTexto.*
import menu.*

// ====================== HABITACIONES ======================



const oficinaTesorero = new Habitacion(
    imagenDeFondo = "fondoOficinaTesorero.png",
    personajes = [],
    objetos = [puertaTesoreroAPasillo],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)

const vestuarios = new Habitacion(
    imagenDeFondo = "fondoVestuarios.png",
    personajes = [],
    objetos = [puertaVestuariosAPasillo],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)


// ====================== PUERTAS ======================

const puertaEstacionamientoARecepcion = new Puerta(position = game.at(11,0), destino = recepcion, llegada = game.at(15,9))
const puertaRecepcionAEstacionamiento = new Puerta(position = game.at(15,10), destino = estacionamiento, llegada = game.at(11,1))

const puertaRecepcionAPasillo = new Puerta(position = game.at(0,5), pared = paredIzquierda, destino = pasillo, llegada = game.at(21,5), requisitos = [tarjetaTrabajador], textoCerrado = "Solo empleados.")
const puertaPasilloARecepcion = new Puerta(position = game.at(22,5), pared = paredDerecha, destino = recepcion, llegada = game.at(1,5))

const puertaRecepcionASalaDePrensa = new Puerta(position = game.at(18,4), pared = paredDerecha, destino = salaDePrensa, llegada = game.at(1,5),requisitos = [acreditacion], textoCerrado = "Sin acreditación de prensa no se puede pasar.")
const puertaSalaDePrensaARecepcion = new Puerta(position = game.at(0,5), pared = paredIzquierda, destino = recepcion, llegada = game.at(17,4))

const puertaPasilloAOficina = new Puerta(position = game.at(0,5), pared = paredIzquierda, destino = oficinaTapia, llegada = game.at(21,5))
const puertaOficinaAPasillo = new Puerta(position = game.at(22,5), pared = paredDerecha, destino = pasillo, llegada = game.at(1,5))

const puertaPasilloADescanso = new Puerta(position = game.at(5,8), destino = areaDescanso, llegada = game.at(11,1))
const puertaDescansoAPasillo = new Puerta(position = game.at(11,0), destino = pasillo, llegada = game.at(5,7))

const puertaPasilloABanios = new Puerta(position = game.at(15,8), destino = banios, llegada = game.at(11,1))
const puertaBaniosAPasillo = new Puerta(position = game.at(11,0), destino = pasillo, llegada = game.at(15,7))

const puertaPasilloAVestuarios = new Puerta(position = game.at(5,3), destino = vestuarios, llegada = game.at(11,9))
const puertaVestuariosAPasillo = new Puerta(position = game.at(11,10), destino = pasillo, llegada = game.at(5,4))

const puertaPasilloATesorero = new Puerta(position = game.at(15,3), destino = oficinaTesorero, llegada = game.at(11,9))
const puertaTesoreroAPasillo = new Puerta(position = game.at(11,10), destino = pasillo, llegada = game.at(15,4))

const puertaDescansoACocina = new Puerta(position = game.at(11,10), destino = cocina, llegada = game.at(11,1), requisitos = [permisoCocina], textoCerrado = "Solo personal de cocina. Capaz el chef te deja pasar.")
const puertaCocinaADescanso = new Puerta(position = game.at(11,0), destino = areaDescanso, llegada = game.at(11,9))

// ====================== ESTACIONAMIENTO ======================

const estacionamiento = new Habitacion(
    imagenDeFondo = "fondoEstacionamiento.png"  ,
    personajes = [puertaEstacionamientoARecepcion, autoPatricio, autoTapia, autoRojo],
    objetos = [],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)

const autoPatricio = new Mueble(
    position = game.at(8,8),
    alto = 2,
    imagen = "autoNegro.png",
    descripcion = "Es mi auto."
)

const autoTapia = new MuebleConPista(
    position = game.at(14,8),
    alto = 2,
    imagen = "autoAzul.png",
    requisitos = [llaveAutoTapia],
    textoCerrado = "Creo que es el auto de Tapia.",
    pista = amenazas,
    textoHallazgo = "Adentro hay un papel con varias amenazas escritas hacia el presidente de la FAFA.",
    descripcion = "Ahora es un auto sin dueño."
)

const autoRojo = new MuebleConPista(
    position = game.at(18,2),
    alto = 2,
    imagen = "autoRojo.png",
    requisitos = [llaveAutoRojo],
    textoCerrado = "Un auto rojo, parece bastante caro.",
    pista = bolsa,
    textoHallazgo = "Había una bolsa llena de guita, un arma y un papel que parece ser una denuncia. Está hasta las manos.",
    descripcion = "Ahora entiendo cómo se compró el auto."
)

const llaveAutoTapia = new LlaveDeAuto(nombre = "llave del auto de Tapia", texto = "La llave de un auto azul oscuro.")
const llaveAutoRojo = new LlaveDeAuto(nombre = "llave del auto rojo", texto = "La llave de un auto. El llavero parece de una marca carísima.")

const amenazas = new Dato(
    nombre = "amenazas",
    texto = "Un papel con varias amenazas escritas hacia el presidente de la AFA. Estaba en el auto de Tapia."
)

const bolsa = new Pista(
    nombre = "bolsa",
    texto = "Una bolsa con mucho efectivo, un arma y una denuncia que le hizo el gobierno. Estaba en el auto rojo."
)

// ====================== RECEPCIÓN ======================

const recepcion = new Habitacion(
    imagenDeFondo = "fondoRecepcion.png",
    personajes = [recepcionista],
    objetos = [puertaRecepcionAEstacionamiento, puertaRecepcionAPasillo, puertaRecepcionASalaDePrensa, mostrador],
    paredes = colisiones.fila(10, 13, 18) + colisiones.fila(7, 0, 13) + colisiones.fila(2, 0, 18) + colisiones.columna(0, 3, 6) + colisiones.columna(13, 8, 9) + colisiones.columna(18, 3, 9)
)

const recepcionista = new Informante(
    position = game.at(10,6),
    imagen = "recepcionista.png",
    texto = "Hola, acá tenes tu acreditación para ingresar a la conferencia de prensa",
    pista = acreditacion,
    textoDespues = "La conferencia es en la sala de prensa, por la puerta de la derecha."
)

const mostrador = new Mueble(
    position = game.at(11,6),
    ancho = 2,
    imagen = "mostrador.png",
    descripcion = "El mostrador de la recepción. La computadora está bloqueada."
)

const acreditacion = new Pista(
    nombre = "acreditación de prensa",
    imagen = "acreditacion.png",
    texto = "Una acreditación de prensa. Con esto te dejan entrar a la sala de prensa."
)

// ====================== SALA DE PRENSA ======================

const salaDePrensa = new Habitacion(
    imagenDeFondo = "fondoSalaPrensa.png",
    personajes = [camarografo,empleadoAfa, periodista, presidenteFifa],
    objetos = [puertaSalaDePrensaARecepcion, escenario, estrado, camaraTV1, camaraTV2],
    paredes = colisiones.fila(9, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 8) + colisiones.columna(22, 1, 8)
)

const escenario = new Escenario(
    position = game.at(8,5), ancho = 7, alto = 4,
    entrada = game.at(8,8),
    imagen = "escenario.png",
    descripcion = "El escenario de las conferencias. Se sube por la escalera."
)

const estrado = new MuebleConPista(
    position = game.at(11,7),
    imagen = "estrado.png",
    pista = tarjetaTrabajador,
    textoHallazgo = "Adentro del estrado había una tarjeta de trabajador de la FAFA.",
    descripcion = "El estrado está vacío."
)

const tarjetaTrabajador = new Pista(
    nombre = "tarjeta de trabajador",
    imagen = "tarjetaTrabajador.png",
    texto = "Una tarjeta de trabajador de la FAFA. Estaba escondida en el estrado de la sala de prensa."
)

const periodista = new Persona(
    position = game.at(10,3),
    imagen = "periodista.png",
    texto = "¿Usted es el detective? ¿Es verdad lo que se dice del Chiqui?"
)

const camarografo = new Persona(
    position = game.at(12,3),
    imagen = "camarografo.png",
    texto = "Estamos en vivo, no se me cruce adelante de la cámara."
)

const empleadoAfa = new Persona(
    position = game.at(18,5),
    imagen = "empleado.png",
    texto = "La conferencia se suspendió. Desde la mañana nadie sabe nada del Chiqui."
)

const camaraTV1 = new Mueble(position = game.at(6,3), imagen = "camaraTV.png", descripcion = "Una cámara de televisión. Está grabando.")
const camaraTV2 = new Mueble(position = game.at(16,3), imagen = "camaraTV.png", descripcion = "Una cámara de televisión. Está grabando.")

const presidenteFifa = new Sospechoso(
    position = game.at(16,6),
    nombre = "Presidente de la JIJA",
    esCulpable = true,
    pistasNecesarias = [],
    descripcion = "Es el presidente de la JIJA y tiene un gran poder de influencia.",
    nombreBaseImagen = "pelado",
    imagen = "pelado.png",
    texto = "No tengo nada más para decirte. Estoy ocupado.",
    preguntas = [preguntaPresidente1]
)

const preguntaPresidente1 = new Pregunta(
    texto = "¿Qué queres pancho? No ves que estoy ocupado.",
    opciones = [opcionPresidente1, opcionPresidente2, opcionPresidente3]
)

const opcionPresidente1 = new OpcionDialogo(
    texto = "Ehh, relaja pelado, ¿no viste algo fuera de lo normal hoy?",
    tono = gentil,
    respuestaNormal = "Que voy a ver yo. Tengo mucho laburo como para ver boludeces.",
    respuestaEnojada = "¡No me rompas las pelotas, no vi un carajo. Tomatela!"
)

const opcionPresidente2 = new OpcionDialogo(
    texto = "Pero mira la cara de zapallo que tenes, sos re culpable!.",
    tono = provocador,
    respuestaNormal = "¿Qué decís? ¡No hable con la victima en todo el dia!",
    respuestaEnojada = "¡ZAPALLO QUIEN, YO NO FUI ESTUPIDO!"
)

const opcionPresidente3 = new OpcionDialogo(
    texto = "¿Sabes que le paso al chiqui?",
    tono = neutral,
    respuestaNormal = "No hable con el, le paso algo?",
    respuestaEnojada = "no y si supiera no te diria."
)

// ====================== PASILLO ======================

const pasillo = new Habitacion(
    imagenDeFondo = "fondoPasillo.png",
    personajes = [guardia],
    objetos = [puertaPasilloAOficina, puertaPasilloABanios, puertaPasilloARecepcion, puertaPasilloADescanso, puertaPasilloAVestuarios, puertaPasilloATesorero],
    paredes = colisiones.fila(8, 0, 22) + colisiones.fila(3, 0, 22) + colisiones.columna(0, 4, 7) + colisiones.columna(22, 4, 7)
)

const guardia = new Sospechoso(
    position = game.at(1,5),
    nombre = "el guardia",
    nombreBaseImagen = "guardia",
    imagen = "guardiaNormal.png",
    texto = "Estoy laburando, tomátela.",
    preguntas = [preguntaGuardiaNervioso, preguntaGuardiaPorro],
    descripcion = "Guardia de la Oficina Del Chiqui"
)

const preguntaGuardiaNervioso = new Pregunta(
    texto = "Estoy re sacado. A la oficina del Chiqui no pasa nadie.",
    opciones = [opcionGuardiaNervioso1, opcionGuardiaNervioso2, opcionGuardiaNervioso3]
)

const opcionGuardiaNervioso1 = new OpcionDialogo(
    texto = "Te voy a pedir amablemente que me dejes entrar a la oficina",
    tono = gentil,
    respuestaNormal = "Estoy laburando, tomátela que ando estresado",
    respuestaEnojada = "No escuchaste que dije que estoy re sacado, tomátela"
)

const opcionGuardiaNervioso2 = new OpcionDialogo(
    texto = "Te vas a correr maestro o te corro yo",
    tono = provocador,
    respuestaNormal = "A quién vas a correr rubiesito de Nordelta, tomátela",
    respuestaEnojada = "Que te haces el vivo, tomátela o te hago de goma"
)

const opcionGuardiaNervioso3 = new OpcionDialogo(
    texto = "Dejame entrar",
    tono = neutral,
    respuestaNormal = "No me hinches que estoy alterado",
    respuestaEnojada = "Al cielo te voy a hacer entrar si no te las tomas"
)

const preguntaGuardiaPorro = new Pregunta(
    texto = "Pensé que había quedado claro",
    requisitos = [porro],
    opciones = [opcionGuardiaPorro1, opcionGuardiaPorro2],
    alResponder = { elGuardia => elGuardia.moverseA(game.at(1,7)) }
)

const opcionGuardiaPorro1 = new OpcionDialogo(
    texto = "Noté que estabas alterado, te traje esto para desestrezar",
    tono = gentil,
    respuestaNormal = "Uhh que genio maestro alta genética, muchas gracias pasá tranquilo",
    respuestaEnojada = "Me lo voy a fumar, pero igual te quiero romper la cabeza"
)

const opcionGuardiaPorro2 = new OpcionDialogo(
    texto = "Te conseguí esto, dejame pasar y te lo doy",
    tono = neutral,
    respuestaNormal = "Uhh lo re necesitaba, dale pasá pero no digas nada",
    respuestaEnojada = "Me lo fumo y después te peleo"
)

// ====================== BAÑOS ======================

const banios = new Habitacion(
    imagenDeFondo = "fondoBanios.png",
    personajes = [senoraLimpieza, tuca],
    objetos = [puertaBaniosAPasillo, inodoro1, inodoro2, inodoro3, lavamanos1, lavamanos2, lavamanos3, ducha1, ducha2, ventanaBanio],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)

const inodoro1 = new Mueble(position = game.at(2,9), imagen = "inodoro.png", descripcion = "Un inodoro. Por suerte está limpio.")
const inodoro2 = new Mueble(position = game.at(4,9), imagen = "inodoro.png", descripcion = "Un inodoro. Por suerte está limpio.")
const inodoro3 = new Mueble(position = game.at(6,9), imagen = "inodoro.png", descripcion = "Un inodoro. Por suerte está limpio.")

const lavamanos1 = new Mueble(position = game.at(9,9), imagen = "lavamanos.png", descripcion = "Un lavamanos.")
const lavamanos2 = new Mueble(position = game.at(11,9), imagen = "lavamanos.png", descripcion = "Todavía quedan unas manchitas rojas en la pileta.")
const lavamanos3 = new Mueble(position = game.at(13,9), imagen = "lavamanos.png", descripcion = "Un lavamanos.")

const ducha1 = new Mueble(position = game.at(15,9), imagen = "ducha.png", descripcion = "Una ducha. Está seca, hoy nadie la usó.")
const ducha2 = new Mueble(position = game.at(17,9), imagen = "ducha.png", descripcion = "Una ducha. Está seca, hoy nadie la usó.")

const ventanaBanio = new Mueble(
    position = game.at(20,10),
    imagen = "ventanaBanio.png",
    descripcion = "Una ventanita abierta. Sale un olor raro."
)

const senoraLimpieza = new Persona(
    position = game.at(7,5),
    imagen = "senoraLimpieza.png",
    texto = "Hoy vi a alguien lavándose las manos llenas de sangre acá. No le llegué a ver la cara."
)

const tuca = new Informante(
    position = game.at(21,9),
    imagen = "tuca.png",
    texto = "Shh, no le digas a nadie que vine a fumar al baño. Te doy esto para comprar tu silencio.",
    pista = porro,
    textoDespues = "No le digas a nadie, eh."
)

const porro = new Pista(
    nombre = "porro",
    texto = "Un porro que te dio Tuca para que no digas nada. Al guardia le puede interesar."
)

// ====================== OFICINA DE TAPIA ======================

const oficinaTapia = new Habitacion(
    imagenDeFondo = "fondoOficinaTapia.png",
    objetos = [escritorioTapia, cuerpo, termo, puertaOficinaAPasillo],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)

const escritorioTapia = new MuebleConPista(
    position = game.at(11,6),
    ancho = 2,
    alto = 2,
    imagen = "escritorioTapia.png",
    pista = conversacionesWhatsapp,
    textoHallazgo = "En la computadora del escritorio había varias conversaciones fuertes con Toviggino e Infantino.",
    descripcion = "El escritorio del Chiqui. El mate está frío y la computadora sigue prendida."
)

const cuerpo = new MuebleConPista(
    position = game.at(11,4),
    ancho = 2,
    imagen = "cuerpo.png",
    pista = llaveAutoTapia,
    textoHallazgo = "Está muerto. En el bolsillo del saco tenía la llave de un auto.",
    descripcion = "Ya revisé el cuerpo. No tiene nada más."
)

const termo = new Pista(
    position = game.at(9,4),
    nombre = "termo",
    imagen = "termoTirado.png",
    texto = "El termo del Chiqui, tirado en el piso. Tiene un olor raro."
)

const conversacionesWhatsapp = new Dato(
    nombre = "conversacionesWhatsapp",
    texto = "En la computadora del escritorio había varias conversaciones fuertes con Toviggino e Infantino."
)

// ====================== ÁREA DE DESCANSO (COMEDOR) ======================

const areaDescanso = new Habitacion(
    imagenDeFondo = "fondoAreaDescanso.png",
    personajes = [chef, jugador, mozo],
    objetos = [mesaLarga, buffet, heladera, planta1, planta2, tele, puertaDescansoAPasillo, puertaDescansoACocina],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)

const mesaLarga = new Mueble(
    position = game.at(5,4),
    ancho = 13,
    alto = 3,
    imagen = "mesaLarga.png",
    descripcion = "La mesa del plantel. Tiene 26 sillas, una para cada jugador."
)

const buffet = new Mueble(
    position = game.at(14,9),
    ancho = 3,
    imagen = "buffet.png",
    descripcion = "El buffet del almuerzo. Hay milanesas, fideos y ensalada."
)

const heladera = new Mueble(
    position = game.at(19,9),
    imagen = "heladera.png",
    descripcion = "Una heladera llena de agua y bebidas isotónicas."
)

const planta1 = new Mueble(position = game.at(1,9), imagen = "planta.png", descripcion = "Una planta. Alguien se olvidó de regarla.")
const planta2 = new Mueble(position = game.at(21,9), imagen = "planta.png", descripcion = "Una planta. Alguien se olvidó de regarla.")

const tele = new Mueble(
    position = game.at(6,10),
    imagen = "tele.png",
    descripcion = "Están pasando Chacarita Chicago."
)

const chef = new Informante(
    position = game.at(13,9),
    imagen = "cocinero.png",
    texto = "¿Sos el detective? A mi cocina no entra cualquiera, pero tomá este permiso y pasá.",
    pista = permisoCocina,
    textoDespues = "La cocina es por la puerta de arriba. No me toques nada, que está todo limpio."
)

const permisoCocina = new Pista(
    nombre = "permiso de cocina",
    imagen = "permisoCocina.png",
    texto = "Un permiso firmado por el chef. Con esto te dejan entrar a la cocina."
)

const jugador = new Persona(
    position = game.at(19,5),
    imagen = "jugador.png",
    texto = "El Chiqui siempre comía con nosotros antes de los partidos. Hoy no apareció."
)

const mozo = new Persona(
    position = game.at(8,2),
    imagen = "mozo.png",
    texto = "¿Le sirvo algo, detective? Hoy hay milanesas con puré."
)

// ====================== COCINA ======================

const cocina = new Habitacion(
    imagenDeFondo = "fondoCocina.png",
    personajes = [arquero],
    objetos = [estanteria1, horno1, horno2, horno3, horno4, pava, mesadaPileta, heladeraCocina, estanteria2,
               mesaDeTrabajo, mesaEmplatado, hornoBarro, tacho, bolsasPapas, cajonVerduras, puertaCocinaADescanso],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)

const estanteria1 = new Mueble(position = game.at(1,9), ancho = 2, imagen = "estanteria.png", descripcion = "Ollas, latas de tomate y bolsas de harina.")
const horno1 = new Mueble(position = game.at(4,9), imagen = "horno.png", descripcion = "Está apagado. Adentro no hay nada.")
const horno2 = new Mueble(position = game.at(5,9), imagen = "horno.png", descripcion = "Adentro hay una bandeja de pan quemado. Mejor no tocar.")
const horno3 = new MuebleConPista(
    position = game.at(6,9),
    imagen = "horno.png",
    pista = empanadas,
    textoHallazgo = "Adentro del horno había una bandeja de empanadas recién hechas.",
    descripcion = "El horno quedó vacío."
)

const horno4 = new Mueble(position = game.at(7,9), imagen = "horno.png", descripcion = "Está apagado. Adentro no hay nada.")
const pava = new Mueble(position = game.at(9,9), imagen = "pava.png", descripcion = "La pava con la que se calentó el agua del mate. No tiene rastros de veneno.")
const mesadaPileta = new Mueble(position = game.at(11,9), ancho = 3, imagen = "mesadaPileta.png", descripcion = "La pileta está llena de platos sin lavar.")
const heladeraCocina = new Mueble(position = game.at(15,9), ancho = 2, imagen = "heladeraCocina.png", descripcion = "Una heladera enorme. Hay carne para todo el plantel.")
const estanteria2 = new Mueble(position = game.at(18,9), ancho = 2, imagen = "estanteria.png", descripcion = "Más ollas y más latas. Acá cocinan para un ejército.")

const mesaDeTrabajo = new Mueble(
    position = game.at(4,5),
    ancho = 4,
    alto = 2,
    imagen = "mesaDeTrabajo.png",
    descripcion = "Están preparando más empanadas. La masa todavía está fresca."
)

const mesaEmplatado = new Mueble(
    position = game.at(14,5),
    ancho = 4,
    alto = 2,
    imagen = "mesaEmplatado.png",
    descripcion = "Milanesas, puré y fruta. El almuerzo del plantel."
)

const hornoBarro = new Mueble(
    position = game.at(1,1),
    ancho = 2,
    alto = 2,
    imagen = "hornoBarro.png",
    descripcion = "Un horno de barro. Está prendido, pero adentro no hay nada."
)

const tacho = new Mueble(position = game.at(4,1), imagen = "tacho.png", descripcion = "El tacho de basura. Mejor no revolver.")
const bolsasPapas = new Mueble(position = game.at(20,1), imagen = "bolsasPapas.png", descripcion = "Bolsas de papas. Para el puré de mañana.")
const cajonVerduras = new Mueble(position = game.at(21,1), imagen = "cajonVerduras.png", descripcion = "Un cajón de tomates y lechuga.")

const llaveVestuario = new Pista(
    nombre = "llave del vestuario",
    imagen = "llaveVestuario.png",
    texto = "La llave del vestuario. Te la dio el arquero a cambio de las empanadas."
)

const arquero = new InformanteConPedido(
    position = game.at(3,5),
    imagen = "arquero.png",
    pedido = [empanadas],
    textoPedido = "Tengo un hambre que me muero. El chef dejó algo en el horno, pero a mí no me deja entrar.",
    texto = "¡Empanadas! Sos un crack. Tomá, la llave del vestuario, a mí no me hace falta.",
    pista = llaveVestuario,
    textoDespues = "El vestuario es la puerta de abajo a la izquierda del pasillo."
)

const empanadas = new Pista(
    nombre = "empanadas",
    texto = "Una bandeja de empanadas recién hechas. Estaban en uno de los hornos de la cocina."
)

// ====================== VESTUARIO ======================

const vestuario = new Habitacion(
    imagenDeFondo = "fondoVestuarios.png",
    objetos = [puertaVestuarioAPasillo],
    paredes = colisiones.fila(10, 0, 22) + colisiones.fila(0, 0, 22) + colisiones.columna(0, 1, 9) + colisiones.columna(22, 1, 9)
)

const puertaPasilloAVestuario = new Puerta(
    position = game.at(5,3),
    destino = vestuario,
    llegada = game.at(11,9),
    requisitos = [llaveVestuario],
    textoCerrado = "El vestuario está cerrado con llave."
)

const puertaVestuarioAPasillo = new Puerta(
    position = game.at(11,10),
    destino = pasillo,
    llegada = game.at(5,4)
)