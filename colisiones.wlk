import wollok.game.*

class Colision {
    var property position
}

const pared1 = new Colision(
    position = game.at(3,3)
)

const pared2 = new Colision(
    position = game.at(3,4)
)

const pared3 = new Colision(
    position = game.at(3,5)
)

object colisiones {
    const solidos = [pared1,pared2,pared3]

    method hayColisionEn(unaPosicion){
        return solidos.any({
            unSolido => unSolido.position() == unaPosicion
        })
    }
}