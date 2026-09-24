import detectives.*
import objetos.*
import cuadroDeTexto.*

object interacciones {
    const interactuables = [llave]

    method interactuar(){
        if(cuadros.hayCuadroAbierto()){
            cuadros.cerrar()
        }else{
            const disponibles = interactuables.filter({
                unObjeto => unObjeto.puedeInteractuar(detective.detectiveActual())
            })

            if(!disponibles.isEmpty()){
                disponibles.first().interactuar(detective.detectiveActual())
            }
        }
    }
}