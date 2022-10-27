import wollok.game.*

object nave {
	var property position = game.center()
	var property vidas = 5
	var property fase = 0
	
	
	method image() = "naveFase" + self.fase().toString() + ".png"
	
    method mejorar(){
    	if(fase != 2){
    		fase += 1
    	}
    }
    method teAgarro(){
		self.mejorar()
	}
	method morir(){}
	method disiparse(){}
	method perderVida(){
		vidas -= 1
	}
	
	method disparar(){
		const arsenal = new Rayo()
		arsenal.configuracionInicial()
	}
}

class PowerUp{
	var property image = "wollok.png"
	var property position = game.at(0.randomUpTo(9), 0.randomUpTo(9))
	
	method configuracionInicial(){
		game.addVisual(self)	
		game.whenCollideDo(self,{n => n.teAgarro() game.removeVisual(self)})
	}
	
	method teAgarro(){}
	method morir(){
		game.removeVisual(self)
	}
}

class Rayo {
	var property image = "rayito.png"
	var property position = game.at(nave.position().x(),nave.position().y()+1)
	
	
	
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
	
	method teAgarro(){}
	
	method morir(){
		 game.whenCollideDo(self, {rayo => rayo.disiparse()})
	}
}


