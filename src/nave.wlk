import wollok.game.*

object nave {
	var property position = game.center()
	var imagen = "nave.png"
	var property vidas = 5
	var fase = 0
	method image(){
        if(fase==1){
        	imagen = "naveFase1.png"
        	return imagen
        }
        else if(fase==2){
            imagen = "naveFase2.png"
        	return imagen
        }
        else return imagen
    }
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
}

class PowerUp{
	var property image = "wollok.png"
	var property position = game.at(0.randomUpTo(9), 0.randomUpTo(9))
	
	
	method teAgarroEnemigo(){}
}

class Rayo {
	var property image = "rayito.png"
	var property position = game.at(nave.position().x(),nave.position().y()+1)
	
	method dispararse(){
		const newY = position.y() + 1
		position = game.at(position.x(), newY)
	}
	
	method disiparse(){
		game.removeVisual(self)
	}
	method teAgarro(){
	}
	
	method morir(){
		 game.whenCollideDo(self, {rayo => rayo.disiparse()})
	}
}
