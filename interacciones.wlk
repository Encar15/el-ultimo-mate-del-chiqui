import detectives.*
import objetos.*
import cuadroDeTexto.*
import restoPersonajes.*

object interacciones {
    const tiposDeInteraccion = [interaccionPista,interaccionPersona]

    method interactuar(){
        if(cuadros.hayCuadroAbierto()){
            cuadros.cerrar()
        }else{
            const disponibles = tiposDeInteraccion.filter({
                unaInteraccion => unaInteraccion.puedeInteractuar(detective.detectiveActual())
            })

            if(!disponibles.isEmpty()){
                disponibles.first().interactuar(detective.detectiveActual())
            }
        }
    }
}

object interaccionPersona {
    const personas = [testigo]

    method puedeInteractuar(unDetective){
        return personas.any({
            unaPersona => self.estaAlLado(unaPersona,unDetective)
        })
    }

    method interactuar(unDetective){
        const disponibles = personas.filter({
            unaPersona => self.estaAlLado(unaPersona,unDetective)
        })

        disponibles.first().interactuar()
    }

    method estaAlLado(unaPersona,unDetective){
        return unDetective.position().up(1) == unaPersona.position()
            || unDetective.position().down(1) == unaPersona.position()
            || unDetective.position().left(1) == unaPersona.position()
            || unDetective.position().right(1) == unaPersona.position()
    }
}

object interaccionPista {
    const pistas = [llave]

    method puedeInteractuar(unDetective){
        return pistas.any({
            unaPista => unaPista.estaDisponible()
                && unaPista.position() == unDetective.position()
        })
    }

    method interactuar(unDetective){
        const disponibles = pistas.filter({
            unaPista => unaPista.estaDisponible()
                && unaPista.position() == unDetective.position()
        })

        disponibles.first().interactuar(unDetective)
    }
}