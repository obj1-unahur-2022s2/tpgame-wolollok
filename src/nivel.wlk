import wollok.game.*
import navesEnemigas.*
import nave.*

object nivel{
	const property listaEnemigos =[]

	method matarTodosLosEnemigos(){
		listaEnemigos.forEach({e=>e.morir()})
	}
	
	method dificultadNivel(){
		if (nave.enemigosDerrotados().between(0,10)){
			return 1
		}
		else if(nave.enemigosDerrotados().between(11,50)){
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
		nave.fase(0)
		nave.enemigosDerrotados(0)
		//Teclado
		keyboard.space().onPressDo({nave.disparar()})
		
		keyboard.b().onPressDo({nave.bomba()})
		
		keyboard.r().onPressDo({ game.clear() self.configuracionInicial() })
	
		//Nave
		game.addVisualCharacter(nave)
	
		//Naves Enemigas
		game.onTick(2000, "Nuevos enemigos", {self.spawnearEnemigo1()})   
		game.onTick(1000, "Nuevos enemigos2", {self.spawnearEnemigo2()})  
		game.onTick(500, "Nuevos enemigos3", {self.spawnearEnemigo3()})   
	            
		//Power Up
		game.onTick(2000, "Nuevos power up" , {self.spawnearPowerUp()})
	}
	
	method gameOver(){
		game.removeTickEvent("Nuevos enemigos")
		game.removeTickEvent("Nuevos enemigos2")
		game.removeTickEvent("Nuevos enemigos3")
		game.removeTickEvent("Nuevos power up")
		game.removeVisual(nave)
		listaEnemigos.forEach({e=>e.terminar()})
		game.say(nave,"game over")
	}
	
	method spawnearEnemigo1(){
		if(self.dificultadNivel()==1){
			const enemigos = new Enemigo()
			enemigos.configuracionInicial()
			listaEnemigos.add(enemigos)	
		}
	}
	
	method spawnearEnemigo2(){
		if(self.dificultadNivel()==2){
			const enemigos = new Enemigo2()
			enemigos.configuracionInicial()
			listaEnemigos.add(enemigos)	
		}
	}
	
	method spawnearEnemigo3(){
		if(self.dificultadNivel()==3){
			const enemigos = new Enemigo3()
			enemigos.configuracionInicial()
			listaEnemigos.add(enemigos)	
		}
	}
	
	method spawnearPowerUp(){
		if(nave.fase()<2){
			const powerUp = new PowerUp()
			powerUp.configuracionInicial()
		}
	}
	
	
}