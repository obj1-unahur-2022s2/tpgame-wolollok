import wollok.game.*

object nave {
	var property position = game.center()
	const imagen = "nave.png"
	var property vidas = 5
	method image() = imagen
	method morir(){}
	method perderVida(){
		vidas -= 1
	}
}

class Rayo {
	var property image = "rayito.png"
	var property position = nave.position()
	
	method dispararse(){
		const newY = position.y() + 1
		position = game.at(position.x(), newY)
	}
	
	method disiparse(){
		self.morir()
	}
	
	method morir(){
		game.removeVisual(self)
	}
}
