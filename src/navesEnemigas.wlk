import wollok.game.*
import nave.*
import nivel.*
import medidas.*

class Enemigo {
	var property position = game.at(0.randomUpTo(tablero.anchoMax()), tablero.alturaMax())
	const property posicionInicial = position
	
	method image()= "naveEnemiga1.png"
			
	method moverse(){
//		const newY = position.y() -1
		position = position.down(1)
		if(position.y() < tablero.alturaMin()){
			self.desaparecer()
		}
	}
	
	method configuracionInicial(){
		game.addVisual(self)
		game.onTick(1000, "movimiento", {self.moverse()})
		game.whenCollideDo(self, {n => n.teAgarroEnemigo(self)})	
	}
	
	method removerEnemigo(){ game.removeVisual(self) }
	
	method desaparecer(){
		if(game.hasVisual(self)){
			nivel.listaEnemigos().remove(self)
			self.terminar()
			self.removerEnemigo()
		}
	}
	
	method morir(){
		if(game.hasVisual(self)){
			nivel.listaEnemigos().remove(self)
			self.terminar()
			self.removerEnemigo()
			nave.enemigoDerrotado()
		}
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
            position.x() + (nave.position().x()-position.x())/4,
            position.y() + (nave.position().y()- position.y())/4
		)
	}
}

