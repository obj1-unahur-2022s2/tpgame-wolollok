import wollok.game.*
import nave.*

class Enemigo {
	
	var property image = "naveEnemiga1.png"
	var property position = game.at(0.randomUpTo(9), 9)
	
	method moverse(){
//		const newY = position.y() -1
		position = position.down(1)
	}
	
	method configuracionInicial(){
		game.addVisual(self)
		game.onTick(1000, "movimiento", {self.moverse()})
		game.whenCollideDo(self, {n => n.teAgarroEnemigo(self)})
	}
	
	method removerEnemigo(){ game.removeVisual(self) }
	
	method morir(){
		game.removeVisual(self)
		game.removeTickEvent("movimiento")
	}
	
	method terminar(){
		game.removeTickEvent("movimiento")
	}
	
	method teAgarroEnemigo(enemigo){}
	method agarroPowerUp(){}
}


