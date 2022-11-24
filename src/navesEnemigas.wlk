import wollok.game.*
import nave.*
import nivel.*
import medidas.*

class Enemigo {
	var property position = game.at(0.randomUpTo(tablero.anchoMax()), tablero.alturaMax())
	const property posicionInicial = position
	const muerte = game.sound("sonidoMuerte.mp3")
	const nivelEnemigo = 1
	
	method image()= "naveEnemiga" + nivelEnemigo + ".png"
			
	method moverse(){
		position = position.down(1)
		if(position.y() < tablero.alturaMin()){
			self.desaparecer()
		}
	}
	
	method configuracionInicial(){
		game.addVisual(self)
		game.onTick(999, "movimiento", {self.moverse()})
		game.whenCollideDo(self, {n => n.teAgarroEnemigo(self)})	
	}
	
	method removerEnemigo(){ game.removeVisual(self) }
	
	//dos maneras de desaparecer al enemigo, una si colisiona con algo y otra si se sale del tablero
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
			self.terminar2()
			self.removerEnemigo()
			nave.enemigoDerrotado()
			muerte.play()
		}
	}
	
	method terminar2(){}
	
	
	method terminar(){ game.removeTickEvent("movimiento") }
	
	//POLIMORFISMO
	method teAgarroEnemigo(enemigo){}
	method agarroPowerUp(){}
}

class Enemigo2 inherits Enemigo(nivelEnemigo = 2){
	
	override method moverse(){
		self.abajoIzq()
		game.schedule(500,{self.abajoDer()})
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

class Enemigo3 inherits Enemigo(nivelEnemigo = 3){
	
	override method terminar2() {
		self.terminar()
	}
	
	override method moverse(){
		position = game.at(
            position.x() + (nave.position().x()-position.x())/3,//4
            position.y() + (nave.position().y()- position.y())/3//4
		)
	}
}

