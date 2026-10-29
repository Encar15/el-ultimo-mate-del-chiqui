import wollok.game.*
import cuadroDeTexto.*
import dialogos.*
import directorJuego.*
import instancias.*

object menu {
    const pistasEncontradas = []
    const sospechososConocidos = []
    var pantallaActual = null

    method guardarPista(unaPista){
        pistasEncontradas.add(unaPista)
    }

    method pistas() = pistasEncontradas

    method tieneTodas(unasPistas) = unasPistas.all({ unaPista => pistasEncontradas.contains(unaPista) })

    method guardarSospechoso(unSospechoso){
        if(!sospechososConocidos.contains(unSospechoso)){
            sospechososConocidos.add(unSospechoso)
        }
    }

    method sospechosos() = sospechososConocidos

    method estaAbierto() = pantallaActual != null

    method alternar(){
        if(self.estaAbierto()){
            self.cerrar()
        }else{
            self.abrir()
        }
    }

    method abrir(){
        if(!cuadros.hayCuadroAbierto() && !dialogos.hayDialogoAbierto()){
            self.irA(menuPrincipal)
        }
    }

    method cerrar(){
        if(self.estaAbierto() && pantallaActual.sePuedeCerrar()){
            pantallaActual.ocultar()
            pantallaActual = null
        }
    }

    method irA(unaPantalla){
        if(self.estaAbierto()){
            pantallaActual.ocultar()
        }
        pantallaActual = unaPantalla
        pantallaActual.mostrar()
    }

    method confirmar(){ pantallaActual.confirmar() }
    method volver(){ pantallaActual.volver() }
    method arriba(){ pantallaActual.arriba() }
    method abajo(){ pantallaActual.abajo() }
    method izquierda(){ pantallaActual.izquierda() }
    method derecha(){ pantallaActual.derecha() }

    method reiniciar(){
        pistasEncontradas.clear()
        sospechososConocidos.clear()
        pantallaActual = null
        carpetaPistas.reiniciar()
        carpetaSospechosos.reiniciar()
    }
}

class Pantalla {
    var visualesEnPantalla = []

    method armarVisuales()

    method mostrar(){
        visualesEnPantalla = self.armarVisuales()
        visualesEnPantalla.forEach({ unVisual => game.addVisual(unVisual) })
    }

    method ocultar(){
        visualesEnPantalla.forEach({ unVisual => game.removeVisual(unVisual) })
        visualesEnPantalla = []
    }

    method actualizar(){
        self.ocultar()
        self.mostrar()
    }

    method confirmar(){}
    method volver(){}
    method arriba(){}
    method abajo(){}
    method izquierda(){}
    method derecha(){}

    method sePuedeCerrar() = true

    method textoSobrePapel(unTexto, unaPosicion) =
        new TextoDelCuadro(texto = unTexto, position = unaPosicion, color = "222222FF")
}

class PantallaConOpciones inherits Pantalla {
    var property cuadro = null

    override method armarVisuales() = cuadro.visuales()
    override method arriba(){ cuadro.anterior() }
    override method abajo(){ cuadro.siguiente() }
    override method confirmar(){ cuadro.opcionSeleccionada().elegir() }
}

class Opcion {
    const property texto
    const accion

    method elegir(){ accion.apply() }
}

object menuPrincipal inherits PantallaConOpciones(
    cuadro = new CuadroDeDialogo(
        texto = "MENÚ",
        etiqueta = "Z: elegir     X / C: cerrar",
        selector = new SelectorDialogo(opciones = [carpetaPistas, carpetaSospechosos])
    )
) {
    override method volver(){ menu.cerrar() }
}

object confirmacion inherits PantallaConOpciones {
    var sospechoso = null

    method preguntarPor(unSospechoso){
        sospechoso = unSospechoso
        self.cuadro(new CuadroDeDialogo(
            texto = "¿Querés incriminar a este sospechoso?",
            etiqueta = "Z: confirmar     X: cancelar",
            selector = new SelectorDialogo(
                opciones = [
                    new Opcion(texto = "Sí", accion = { veredicto.incriminar(sospechoso) }),
                    new Opcion(texto = "No", accion = { self.volver() })
                ],
                indiceSeleccionado = 1 
            )
        ))
        menu.irA(self)
    }

    override method armarVisuales() = carpetaSospechosos.armarVisuales() + super()

    override method volver(){ menu.irA(carpetaSospechosos) }
}

class Carpeta inherits Pantalla {
    const property texto
    const imagenCarpeta
    const nombreFicha
    const textoSinFichas
    var indice = 0

    method fichas()

    method elegir(){ menu.irA(self) }

    method hayFichas() = !self.fichas().isEmpty()

    method fichaActual() = self.fichas().get(indice)

    override method armarVisuales(){
        const carpeta = new ImagenDeMenu(image = imagenCarpeta, position = game.at(3,1))
        if(!self.hayFichas()){
            return [carpeta, self.textoSobrePapel(textoSinFichas, game.at(14,6))]
        }
        const ficha = self.fichaActual()
        const numeroDeFicha = nombreFicha + " " + (indice + 1).toString() + " de " + self.fichas().size().toString()
        return [
            carpeta,
            new ImagenDeMenu(image = ficha.imagenParaMenu(), position = game.at(6,5)),
            self.textoSobrePapel(numeroDeFicha, game.at(6,3)),
            self.textoSobrePapel(ficha.tituloParaMenu(), game.at(14,8)),
            self.textoSobrePapel(ficha.descripcionParaMenu(), game.at(14,6))
        ]
    }

    override method izquierda(){ self.pasarFicha(-1) }
    override method derecha(){ self.pasarFicha(1) }

    method pasarFicha(cuanto){
        if(self.hayFichas()){
            const cantidad = self.fichas().size()
            indice = (indice + cuanto + cantidad) % cantidad
            self.actualizar()
        }
    }

    override method volver(){ menu.irA(menuPrincipal) }

    method reiniciar(){ indice = 0 }
}

object carpetaPistas inherits Carpeta(
    texto = "Pistas",
    imagenCarpeta = "carpetaPistas.png",
    nombreFicha = "Pista",
    textoSinFichas = "Todavía no encontraste pistas."
) {
    override method fichas() = menu.pistas()
}

object carpetaSospechosos inherits Carpeta(
    texto = "Sospechosos",
    imagenCarpeta = "carpetaSospechosos.png",
    nombreFicha = "Sospechoso",
    textoSinFichas = "Todavía no hablaste con ningún sospechoso."
) {
    override method fichas() = menu.sospechosos()

    override method confirmar(){
        if(self.hayFichas()){
            confirmacion.preguntarPor(self.fichaActual())
        }
    }
}

object veredicto inherits Pantalla {
    var imagen = "casoFallido.png"
    var texto = ""

    method incriminar(unSospechoso){
        contador.detenerCronometro()
        if(unSospechoso.puedeIrPreso()){
            imagen = "casoResuelto.png"
            texto = unSospechoso.nombre() + " era el culpable."
        }else if(unSospechoso.esCulpable()){
            imagen = "casoFallido.png"
            texto = unSospechoso.nombre() + " era el culpable, pero no tenías pistas suficientes."
        }else{
            imagen = "casoFallido.png"
            texto = unSospechoso.nombre() + " no era el culpable."
        }
        self.terminarPartida()
    }

    method sinTiempo(){
        imagen = "casoSinTiempo.png"
        texto = "El culpable sigue suelto."
        self.terminarPartida()
    }

    method terminarPartida(){
        menu.irA(self)
        game.schedule(6000, { game.stop() })
    }

    override method armarVisuales() = [
        new ImagenDeMenu(image = imagen, position = game.at(5,3)),
        self.textoSobrePapel(texto, game.at(11,5))
    ]

    override method sePuedeCerrar() = false
}

class ImagenDeMenu {
    const property image
    const property position
}

object textos {
    method envolver(unTexto, ancho){
        const renglones = []
        var renglon = ""
        unTexto.words().forEach({ palabra =>
            if(renglon.isEmpty()){
                renglon = palabra
            }else if((renglon + " " + palabra).size() <= ancho){
                renglon = renglon + " " + palabra
            }else{
                renglones.add(renglon)
                renglon = palabra
            }
        })
        renglones.add(renglon)
        return renglones.join("\n")
    }
}