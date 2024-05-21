class Formacion{
	const locomotoras = []
	const vagones = []
	
	method locomotoras() = locomotoras
	method vagones() = vagones
	method pasajeros()=vagones.sum({v=>v.pasajerosMax()})
	method vagonesPopulares()=vagones.count({v=>v.pasajerosMax()>50})
	method esCarguera()=vagones.all({v=>v.cargaMax()>1000})
	method dispersionPesos()=vagones.max({v=>v.pesoMax()}).pesoMax() - vagones.min({v=>v.pesoMax()}).pesoMax()
	method cantidadBanios()=vagones.count({v=>v.tieneBanio()})
	method hacerMantenimiento()=vagones.forEach({v=>v.recibirMantenimiento()})
	method estaEquilibrada()= (vagones.max({v=>v.pasajerosMax()}).pasajerosMax() - vagones.min({v=>v.pasajerosMax()}).pasajerosMax()) < 20
	//method estaOrganizada() = ni idea
	//etapa 2
	method velocidadMax() = locomotoras.min({loc=>loc.velocidadMax()})
	method esEficiente() = locomotoras.all({loc=>loc.eficiente()})
	method pesoMaxLocomotoras() = locomotoras.sum({loc=>loc.peso()})
	method pesoMaxVagones() = vagones.sum({v=>v.pesoMax()})
	method pesoFormacion() = self.pesoMaxLocomotoras() + self.pesoMaxVagones()
	method pesoArrastreTotal() = locomotoras.sum({loc=>loc.puedeArrastrar()})
	method puedeMoverse() = self.pesoArrastreTotal() >= self.pesoFormacion()
	method cuantoFaltaParaEmpujar() = 
		if(self.puedeMoverse()) 0 
		else self.pesoFormacion() - self.pesoArrastreTotal() 
	//etapa 3
	method vagonMasPesado()= vagones.max({v=>v.pesoMax()})
	method esCompleja() = ((locomotoras.size()+vagones.size())>8) or (self.pesoFormacion()>80000)
	method agregarLocomotora(unaLocomotora){locomotoras.add(unaLocomotora)}
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

class Locomotora{
	var peso
	var puedeArrastrar
	var velocidadMax
	
	method peso() = peso
	method puedeArrastrar() = puedeArrastrar
	method velocidadMax() = velocidadMax
	method eficiente() = puedeArrastrar >= (peso*5)
}

class Deposito{
	var formaciones = []
	var locomotorasSueltas = []
	
	method formaciones() = formaciones
	method locomotorasSueltas() = locomotorasSueltas
	method vagonesMasPesados(){
		const vagonesMasPesados = formaciones.map({f=>f.vagonMasPesado()})
		return vagonesMasPesados.asSet()
	}
	method seNecesitaConductorExperto() = formaciones.any({f=>f.esCompleja()})
	method agregarUnaLocomotoraA(unaFormacion){
		if(formaciones.contains(unaFormacion)){
			if(not unaFormacion.puedeMoverse()){
				var locomotora = locomotorasSueltas.find({loc=>loc.puedeArrastrar()>unaFormacion.cuantoFaltaParaEmpujar()})
				unaFormacion.agregarLocomotora(locomotora)	
			}else{}
		}
	}
}


























