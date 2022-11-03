import wollok.game.*
import nave.*
import nivel.*

class Enemigo {
	var property position = game.at(0.randomUpTo(9), 9)
	const property posicionInicial = position
	
	method image()= "naveEnemiga1.png"
			
	method moverse(){
//		const newY = position.y() -1
		position = position.down(1)
		if(position.y()<0){
			game.removeVisual(self)
			game.removeTickEvent("movimiento")
		}
	}
	
	method configuracionInicial(){
		game.addVisual(self)
		game.onTick(1000, "movimiento", {self.moverse()})
		game.whenCollideDo(self, {n => n.teAgarroEnemigo(self)})	
	}
	
	method removerEnemigo(){ game.removeVisual(self) }
	
	method morir(){
		nivel.listaEnemigos().remove(self)
		self.removerEnemigo()
		self.terminar()
		nave.enemigoDerrotado()
		//game.say(nave,nave.enemigosDerrotados().toString())
	}
	
	method terminar(){ game.removeTickEvent("movimiento") }
	
	method teAgarroEnemigo(enemigo){}
	method agarroPowerUp(){}
}

class Enemigo2 inherits Enemigo{
	override method image()= "naveEnemiga2.png"
	
	override method configuracionInicial(){
		game.addVisual(self)
		game.onTick(1000, "movimiento", {self.zigzag()})
		game.whenCollideDo(self, {n => n.teAgarroEnemigo(self)})
	}
	
	method zigzag(){
		self.abajoIzq()
		game.schedule(500,{=> self.abajoDer()})
	}
	
	method abajoIzq(){
		position = position.down(1)
		position = position.left(1)
	}
	
	method abajoDer(){
		position = position.down(1)
		position = position.right(1)
	}
	
}

class Enemigo3 inherits Enemigo{
	override method image()= "naveEnemiga3.png"
	
	override method configuracionInicial(){
		game.addVisual(self)
		game.onTick(1000, "movimiento", {self.perseguirNave()})
		game.whenCollideDo(self, {n => n.teAgarroEnemigo(self)})
	}
	
	method perseguirNave(){
		position = game.at(
            position.x() + (nave.position().x()-position.x())/3,
            position.y() + (nave.position().y()- position.y())/3
		)
	}
	
	
}

