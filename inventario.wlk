import wollok.game.*

object inventario {
    const pistas = []

    method guardar(unaPista){
        pistas.add(unaPista)
    }

    method pistas() = pistas

    method tiene(unaPista) = pistas.contains(unaPista)

    method cantidad() = pistas.size()

    method estaVacio() = pistas.isEmpty()

    method vaciar(){
        pistas.clear()
    }
}
