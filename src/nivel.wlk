import wollok.game.*
import navesEnemigas.*
import nave.*

object nivel{
	const listaEnemigos =[]
	
	method configuracionInicial(){
		//Teclado
		keyboard.space().onPressDo({nave.disparar()})
	
		keyboard.r().onPressDo({})
	
		//Nave
		game.addVisualCharacter(nave)
	
		//Naves Enemigas
		game.onTick(1000, "Nuevos enemigos", {self.spawnearEnemigo()})
	            
		//Power Up
		game.onTick(2000, "Nuevos power up" , {self.spawnearPowerUp()})
	}
	
	method gameOver(){
		game.removeTickEvent("Nuevos enemigos")
		game.removeTickEvent("Nuevos power up")
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
		const powerUp = new PowerUp()
		powerUp.configuracionInicial()
	}
	
	
}