import wollok.game.*
import nave.*

class Enemigo {
	
	var property image = "naveEnemiga1.png"
	var property position = game.at(0.randomUpTo(9), 9)
	
	method moverse(){
		const newY = position.y() -1
		position = game.at(position.x(), newY)
	}
	
	method configuracionInicial(){
		game.addVisual(self)
		game.onTick(1000, "movimiento", {self.moverse()})
	}
	
	method removerEnemigo(){
        game.removeVisual(self)
    }
	method teAgarro(){
		
	}
	method morir(){
		game.removeVisual(self)
		game.removeTickEvent("movimiento")
	}
}


