package com.Proyecto2.project.controller;

import com.Proyecto2.project.model.PiezasUtilizadas;
import com.Proyecto2.project.model.Servicios;
import com.Proyecto2.project.model.SumarioServicio;
import com.Proyecto2.project.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class APIController {

    @Autowired
    private Service s;

    @PostMapping("/taller/{NumeroCuenta}/cliente/{NumeroCliente}/servicio")
    public String beginServicio(@RequestBody Servicios servicios, @PathVariable int NumeroCliente){
        return s.newServicios(servicios, NumeroCliente);
    }

    @PostMapping("/taller/{NumeroCuenta}/cliente/{NumeroCliente}/servicio/{IDServicio}/pieza")
    public String savePiezaEnServicio(@RequestBody PiezasUtilizadas piezasUtilizadas, @PathVariable int IDServicio){
        return s.newPiezasUtilizadas(piezasUtilizadas, IDServicio);
    }

    @PatchMapping("/taller/{NumeroCuenta}/cliente/{NumeroCliente}/servicio/{IDServicio}")
    public String closeServicio(@RequestBody Servicios servicios, @PathVariable int IDServicio){
        return s.endServicios(servicios, IDServicio);
    }

    @GetMapping("/taller/{NumeroCuenta}/cliente/{NumeroCliente}/servicio/{IDServicio}")
    public SumarioServicio getServicio(@PathVariable int IDServicio){
        return s.getSumario(IDServicio);
    }

}

/*
  ***Post beginServicio***
 {
 "fechaIngreso": "dd/MM/yyyy",
 "fechaConclusion": null,
 "descripcionServicio": "Texto",
 "numeroPlaca": "Texto",
 "numeroCuenta": 0,
 "horasInvertidas": 0.0,
 "costoTotalManoObra": 0.0,
 "costoTotalFacturado": 0.0,
 "porcentajeUtilidad": 0.0,
 "idservicio": 0
 }

  ***Post savePiezaEnServicio***
 {
 "idPiezaUtilizada": 0,
 "idServicio": 0,
 "codigoPieza": "Texto",
 "cantidad": 0,
 "costoTotal": 0.0
 }

 */