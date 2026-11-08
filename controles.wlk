import wollok.game.*
import detectives.*
import interacciones.*
import dialogos.*
import menu.*
import instancias.*

object controles {
    const esperaInicial = 250
    const intervalo = 200
    const flechasApretadas = []
    var pulsaciones = 0


    method configurar(){
        flechasApretadas.clear()
        self.configurarFlecha(keyboard.right(), haciaLaDerecha)
        self.configurarFlecha(keyboard.left(), haciaLaIzquierda)
        self.configurarFlecha(keyboard.up(), haciaArriba)
        self.configurarFlecha(keyboard.down(), haciaAbajo)
        keyboard.z().onPressDo({ self.confirmar() })
        keyboard.x().onPressDo({ self.cancelar() })
        keyboard.c().onPressDo({ menu.alternar() })
    }

        method configurarFlecha(unaTecla, unaDireccion){
        unaTecla.onPressDo({ self.apretarFlecha(unaDireccion) })
        unaTecla.onReleaseDo({ self.soltarFlecha(unaDireccion) })
    }

    method apretarFlecha(unaDireccion){
        unaDireccion.apretar()
        flechasApretadas.remove(unaDireccion)
        flechasApretadas.add(unaDireccion)
        self.repetirDespuesDe(esperaInicial)
    }

    method soltarFlecha(unaDireccion){
        const eraLaQueMandaba = self.hayFlechaApretada() && flechasApretadas.last() == unaDireccion
        flechasApretadas.remove(unaDireccion)
        if(eraLaQueMandaba){
            self.dejarDeRepetir()
            if(self.hayFlechaApretada()){
                self.repetirDespuesDe(intervalo)
            }
        }
    }

    method hayFlechaApretada() = !flechasApretadas.isEmpty()

    method repetirDespuesDe(milisegundos){
        self.dejarDeRepetir()
        const estaVez = pulsaciones
        game.schedule(milisegundos, {
            if(estaVez == pulsaciones && self.hayFlechaApretada()){
                self.empezarARepetir()
            }
        })
    }

    method empezarARepetir(){
        self.darUnPaso()
        game.onTick(intervalo, "caminarConLaFlechaApretada", { self.darUnPaso() })
    }

    method dejarDeRepetir(){
        pulsaciones = pulsaciones + 1
        game.removeTickEvent("caminarConLaFlechaApretada")
    }

    method darUnPaso(){
        if(!menu.estaAbierto() && self.hayFlechaApretada()){
            flechasApretadas.last().caminar()
        }
    }

    method derecha(){
        if(menu.estaAbierto()){
            menu.derecha()
        }else{
            patricioJuan.moverDerecha()
        }
    }

    method izquierda(){
        if(menu.estaAbierto()){
            menu.izquierda()
        }else{
            patricioJuan.moverIzquierda()
        }
    }

    method arriba(){
        if(menu.estaAbierto()){
            menu.arriba()
        }else if(dialogos.hayDialogoAbierto()){
            dialogos.anterior()
        }else{
            patricioJuan.moverArriba()
        }
    }

    method abajo(){
        if(menu.estaAbierto()){
            menu.abajo()
        }else if(dialogos.hayDialogoAbierto()){
            dialogos.siguiente()
        }else{
            patricioJuan.moverAbajo()
        }
    }

    method confirmar(){
        if(menu.estaAbierto()){
            menu.confirmar()
        }else{
            interacciones.interactuar()
        }
    }

    method cancelar(){
        if(menu.estaAbierto()){
            menu.volver()
        }
    }
}

object haciaLaDerecha {
    method apretar(){ controles.derecha() }
    method caminar(){ patricioJuan.moverDerecha() }
}

object haciaLaIzquierda {
    method apretar(){ controles.izquierda() }
    method caminar(){ patricioJuan.moverIzquierda() }
}

object haciaArriba {
    method apretar(){ controles.arriba() }
    method caminar(){ patricioJuan.moverArriba() }
}

object haciaAbajo {
    method apretar(){ controles.abajo() }
    method caminar(){ patricioJuan.moverAbajo() }
}
