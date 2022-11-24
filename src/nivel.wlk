import wollok.game.*
import navesEnemigas.*
import nave.*
import medidas.*


object facil {
	method spawnearEnemigo() = new Enemigo()
}
object intermedio {
	method spawnearEnemigo() = new Enemigo2()
}
object dificil {
	method spawnearEnemigo() = new Enemigo3()
}

object nivel{
	const property listaEnemigos =[]
	const tema = game.sound("MusicaTest2.mp3")
	
	method matarTodosLosEnemigos(){
		listaEnemigos.forEach({e=>e.morir()})
	}
	
	method dificultadNivel(){
		if (nave.enemigosDerrotados().between(0,10)){
			return facil
		}
		else if(nave.enemigosDerrotados().between(11,50)){
			return intermedio
		}
		else return dificil
	}
	
	method configSonido(){
		
		tema.volume(0.5)
		tema.shouldLoop(true)
		tema.play()
		tema.pause()
	}
	
	method configuracionInicial(){
		
		nave.fase(0)
		nave.enemigosDerrotados(0)
		//Teclado
		keyboard.space().onPressDo({game.schedule(99,{=> nave.dispararSiPuede()})})
		
		keyboard.b().onPressDo({nave.bomba()})
		
		keyboard.r().onPressDo({ game.clear() tema.pause() self.configuracionInicial() })
		
		//Nave
		game.addVisualCharacter(nave)
		nave.centrar()
		//Naves Enemigas
		game.onTick(2000, "Nuevos enemigos", {self.spawnearEnemigo_(facil)})   
		game.onTick(1000, "Nuevos enemigos2", {self.spawnearEnemigo_(intermedio)})  
		game.onTick(899, "Nuevos enemigos3", {self.spawnearEnemigo_(dificil)})  
	            
		//Power Up
		game.onTick(20000, "Nuevos power up" , {self.spawnearPowerUp()})
		
		tema.resume()
	}
	
	method gameOver(){
		game.clear()
		tema.pause()
		keyboard.r().onPressDo({ game.clear() self.configuracionInicial() })
		game.addVisualIn(reinicio,game.origin())//2,2
		game.say(reinicio, "Has derrotado " + nave.enemigosDerrotados() + " enemigos")
	}
	

	
	method spawnearEnemigo_(dificultad){
		var enemigo
		if(self.dificultadNivel()==dificultad){
			enemigo = self.dificultadNivel().spawnearEnemigo()
			enemigo.configuracionInicial()
			listaEnemigos.add(enemigo)	
		}
	}
	
	method spawnearPowerUp(){
		if(nave.fase()<2){
			const powerUp = new PowerUp()
			powerUp.configuracionInicial()
		}
	}
	
	
}