import wollok.game.*
import navesEnemigas.*
import nave.*

object nivel{
	const listaEnemigos =[]

	
	method dificultadNivel(){
		if (nave.enemigosDerrotados().between(0,15)){
			
			return 1
		}
		else if(nave.enemigosDerrotados().between(16,25)){
			return 2
		}
		else return 3
	}
	
//	method aparicionDeEnemigos(){
//		if (self.dificultadNivel()==1){
//			aparicionDeEnemigos = 2000
//		}
//		else if(self.dificultadNivel()==2){
//			aparicionDeEnemigos = 1000
//		}
//		else aparicionDeEnemigos = 500	
//		return aparicionDeEnemigos	
//	}
	
	method configuracionInicial(){
		//Teclado
		keyboard.space().onPressDo({nave.disparar()})
	
		keyboard.r().onPressDo({ game.clear() self.configuracionInicial() })
	
		//Nave
		game.addVisualCharacter(nave)
	
		//Naves Enemigas
		game.onTick(2000, "Nuevos enemigos", {self.spawnearEnemigo()})
	            
		//Power Up
		game.onTick(2000, "Nuevos power up" , {self.spawnearPowerUp()})
	}
	
	method gameOver(){
		game.removeTickEvent("Nuevos enemigos")
		game.removeTickEvent("Nuevos power up")
		nave.enemigosDerrotados(0)
		game.removeVisual(nave)
		listaEnemigos.forEach({e=>e.terminar()})
		game.say(nave,"game over")
	}
	
	method spawnearEnemigo(){
			const enemigos = new Enemigo()
			enemigos.configuracionInicial()
			listaEnemigos.add(enemigos)
	}
	
	method spawnearPowerUp(){
		if(nave.fase()<2){
			const powerUp = new PowerUp()
			powerUp.configuracionInicial()
		}
	}
	
	
}