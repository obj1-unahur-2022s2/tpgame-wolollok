import wollok.game.*
import navesEnemigas.*
import nave.*
import medidas.*

object nivel{
	const property listaEnemigos =[]
	const tema = game.sound("MusicaTest2.mp3")
	
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
	
	method configSonido(){
		
		tema.volume(0.05)
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
		game.onTick(2000, "Nuevos enemigos", {self.spawnearEnemigo1()})   
		game.onTick(1000, "Nuevos enemigos2", {self.spawnearEnemigo2()})  
		game.onTick(750, "Nuevos enemigos3", {self.spawnearEnemigo3()})   
	            
		//Power Up
		game.onTick(1000, "Nuevos power up" , {self.spawnearPowerUp()})
		
		tema.resume()
	}
	
	method gameOver(){
		game.clear()
		tema.pause()
		keyboard.r().onPressDo({ game.clear() self.configuracionInicial() })
		game.addVisualIn(reinicio,game.origin())//2,2
		game.say(reinicio, "Has derrotado " + nave.enemigosDerrotados() + " enemigos")
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