import wollok.game.*
import nave.*

class Enemigo {
	
	var property image = "naveEnemiga1.png"
	var property position 
	
	method moverse(){
		const newY = position.y() -1
		position = game.at(position.x(), newY)
	}
	method removerEnemigo(){
        game.removeVisual(self)
    }
	method teAgarro(){
		
	}
	method morir(){
		game.removeVisual(self)
	}
}
