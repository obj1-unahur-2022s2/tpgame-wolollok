import wollok.game.*
import navesEnemigas.*
import nave.*

object nivel{
	
	method spawnearEnemigo(){
		const enemigos = new Enemigo()
		enemigos.configuracionInicial()
	}
	
	method spawnearPowerUp(){
		const powerUp = new PowerUp()
		powerUp.configuracionInicial()
	}
}