import wollok.game.*
import nivel.*
import medidas.*

object nave {
	var property position = game.center()
//	var property vidas = 5
	var property fase = 0
	var property enemigosDerrotados = 0
	
	method image() = "naveFase" + self.fase().toString() + ".png"
	
	method centrar(){
		position = game.center()
	}
	
    method mejorar(){
    	if(fase != 2){
    		fase += 1
    	}
    }
    
    method disminuirFase(){
    	if(fase>0){
    		fase -=1
    	}
    	else nivel.gameOver()
    }
    
    method agarroPowerUp(){	self.mejorar() }
	
	method teAgarroEnemigo(enemigo){
		game.removeVisual(enemigo)
		self.disminuirFase()
//		if(fase > 0){
//			fase -= 1
//		}
//		else nivel.gameOver()
	}
	
//	method perderVida(){ vidas -= 1	}
	
	method dispararSiPuede(){
		if(game.hasVisual(self)){
			self.disparar()
		}
	}
	
	method disparar(){
		(-fase..fase).forEach({n=> (new Rayo(position=game.at(self.position().x()+n,self.position().y()+1))).configuracionInicial()})
	}
	
	method bomba(){
		const sonido = game.sound("sonidoExplosion.mp3")
		
		if(game.hasVisual(self) and fase>0 and not game.hasVisual(explosion)){
			self.disminuirFase()
			game.say(self,"BOOM")
			sonido.play()
			game.addVisual(explosion)
			nivel.matarTodosLosEnemigos()
			game.schedule(1000, {=> game.removeVisual(explosion)})
		}
	}
	
	
	method enemigoDerrotado(){ enemigosDerrotados += 1 }
	
	method morir(){}
	method disiparse(){}
}
// position = game.at(nave.position().x(),nave.position().y()+1)
class PowerUp{
	var property image = "wollok.png"
	var property position = game.at(0.randomUpTo(9), 0.randomUpTo(9))
	
	method configuracionInicial(){
		game.addVisual(self)	
		game.whenCollideDo(self,{n => n.agarroPowerUp() game.removeVisual(self)})
	}
	
	method agarroPowerUp(){}
	
	method teAgarroEnemigo(enemigo){
		self.morir()
	}
	
	method morir(){	game.removeVisual(self)	}
	
	method bajarFase(){}
}

class Rayo {
//	var property image = "rayito2.png"
	var property position 
	
	method image() = "rayoFase" + nave.fase().toString() + ".png"
	
	method configuracionInicial(){
		game.addVisual(self)
		game.onTick(197, "moverse", {self.moverse()} )
		game.whenCollideDo(self, { enemigo => enemigo.morir() self.disiparse() })
	}
	
	method moverse(){
		position = position.up(1)
		if(position.y()>tablero.alturaMax()){
			self.disiparse()
			game.removeTickEvent("moverse")
		}
	}
	
	method disiparse(){
		if(game.hasVisual(self)){
			//game.removeTickEvent("moverse")
			game.removeVisual(self)
		}
		
	}
	
	//POLIMORFISMO
	//method teAgarroEnemigo(enemigo){ game.removeVisual(enemigo) }
	method teAgarroEnemigo(enemigo){}
	method morir(){}
	//method terminar(){game.removeTickEvent("moverse")}
	method agarroPowerUp(){}
	method bajarFase(){}
}

// AGREGAR PANTALLA GAME OVER - PANTALLA TUTORIAL (TOCAS enter Y ARRANCA) como BOARDGROUND (EXTRA sonidos)

