import wollok.game.*
import nivel.*

object nave {
	var property position = game.center()
	var property vidas = 5
	var property fase = 0
	var property enemigosDerrotados = 0
	
	method image() = "naveFase" + self.fase().toString() + ".png"
	
    method mejorar(){
    	if(fase != 2){
    		fase += 1
    	}
    }
    
    method disminuirFase(){
    	if(fase>0){
    		fase -=1
    	}
    }
    
    method agarroPowerUp(){	self.mejorar() }
	
	method teAgarroEnemigo(enemigo){
		game.removeVisual(enemigo)
		if(fase > 0){
			fase -= 1
		}
		else nivel.gameOver()
	}
	
	method perderVida(){ vidas -= 1	}
	
	method disparar(){
		if(game.hasVisual(self) and fase==1){
			const arsenal1 = new Rayo(position=game.at(self.position().x(),self.position().y()+1))
			const arsenal2 = new Rayo(position=game.at(self.position().x()+1,self.position().y()+1))
			const arsenal3 = new Rayo(position=game.at(self.position().x()-1,self.position().y()+1))
		
			arsenal1.configuracionInicial()
			arsenal2.configuracionInicial()
			arsenal3.configuracionInicial()
		}
		else if(game.hasVisual(self) and fase==2){
			const arsenal1 = new Rayo(position=game.at(self.position().x(),self.position().y()+1))
			const arsenal2 = new Rayo(position=game.at(self.position().x()+1,self.position().y()+1))
			const arsenal3 = new Rayo(position=game.at(self.position().x()-1,self.position().y()+1))
			const arsenal4 = new Rayo(position=game.at(self.position().x()+2,self.position().y()+1))
			const arsenal5 = new Rayo(position=game.at(self.position().x()-2,self.position().y()+1))	
		
		
			arsenal1.configuracionInicial()
			arsenal2.configuracionInicial()
			arsenal3.configuracionInicial()
			arsenal4.configuracionInicial()
			arsenal5.configuracionInicial()
		}
		else if(game.hasVisual(self)){
			const arsenal = new Rayo(position=game.at(self.position().x(),self.position().y()+1))
			arsenal.configuracionInicial()
		}
	}
	
	method bomba(){
		if(game.hasVisual(self) and fase>0){
			nivel.matarTodosLosEnemigos()
			game.say(self,"BOOM")
			self.disminuirFase()
		}
	}
	
	
	method enemigoDerrotado(){
		enemigosDerrotados += 1
	}
	
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
	var property image = "rayito2.png"
	var property position 
	
	method configuracionInicial(){
		game.addVisual(self)
		game.onTick(2*100, "moverse", {self.moverse()} )
		game.whenCollideDo(self, { enemigo => enemigo.morir() game.removeVisual(self) })
	}
	
	method moverse(){
		const newY = position.y() + 1
		position = game.at(position.x(), newY)
	}
	
	method disiparse(){
		game.removeVisual(self)
		game.removeTickEvent("moverse")
	}
	
	//method teAgarroEnemigo(enemigo){ game.removeVisual(enemigo) }
	method teAgarroEnemigo(enemigo){}

	method morir(){}
	//method terminar(){game.removeTickEvent("moverse")}
	method agarroPowerUp(){}
	method bajarFase(){}
}

// AGREGAR PANTALLA GAME OVER - PANTALLA TUTORIAL (TOCAS enter Y ARRANCA) como BOARDGROUND (EXTRA sonidos)

