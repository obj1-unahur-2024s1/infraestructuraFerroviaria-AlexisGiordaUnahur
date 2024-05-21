class Formacion{
	const locomotoras = []
	const vagones = []
	
	method pasajeros()=vagones.sum({v=>v.pasajerosMax()})
	method vagonesPopulares()=vagones.count({v=>v.pasajerosMax()>50})
	method esCarguera()=vagones.all({v=>v.cargaMax()>1000})
	method dispersionPesos()=vagones.max({v=>v.pesoMax()}).pesoMax() - vagones.min({v=>v.pesoMax()}).pesoMax()
	method cantidadBanios()=vagones.count({v=>v.tieneBanio()})
	method hacerMantenimiento()=vagones.forEach({v=>v.recibirMantenimiento()})
	method estaEquilibrada()= (vagones.max({v=>v.pasajerosMax()}).pasajerosMax() - vagones.min({v=>v.pasajerosMax()}).pasajerosMax()) < 20
	//method estaOrganizada() = ni idea
}

class VagonPasajeros{
	var largo
	var ancho
	var tieneBanio
	var estaOrdenado
	
	method largo()=largo
	method ancho()=ancho
	method tieneBanio()=tieneBanio
	method estaOrdeando()=estaOrdenado
	method pasajerosMax()=(largo * (if(ancho>3) 10 else 8)) - (if(estaOrdenado) 0 else 15)
	method cargaMax()=if(tieneBanio)300 else 800
	method pesoMax()= 2000 + (80*self.pasajerosMax()) + self.cargaMax()
	method recibirMantenimiento(){estaOrdenado = true}
}

class VagonCarga{
	var cargaMaxima
	var maderasSueltas
	
	method tieneBanio() = false
	method pasajerosMax()= 0
	method cargaMax()= cargaMaxima - maderasSueltas*400
	method pesoMax()= 1500 + self.cargaMax()
	method recibirMantenimiento(){maderasSueltas= (maderasSueltas-2).max(0)}
}

class VagonDormitorio{
	var compartimientos
	var camas
	
	method compartimientos()=compartimientos
	method camas()=camas
	method tieneBanio()=true
	method pasajerosMax()= compartimientos * camas
	method cargaMax()=1200
	method pesoMax()= 4000 + (80*self.pasajerosMax()) + self.cargaMax()
	method recibirMantenimiento(){}
}