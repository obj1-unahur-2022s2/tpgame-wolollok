import wollok.game.*

object tablero {
	method alturaMax()= game.height()
	method alturaMin()= 0
	method anchoMax()= game.width()
	method anchoMin()= 0
	
	
	
}

object menu{
//	const property position = game.center()
	//method position()= game.center().left(4).down(2)
	method position()= game.origin()
	method image()= "Wollolok_Menu.png"
}

object reinicio{
	method position()= game.origin()
	//method position()= game.at(2,2)
	method image()= "Wolollok_Reinicio.png"
}
