package com.Proyecto2.project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SumarioServicio {
    private Servicios servicio;
    private Clientes cliente;
    private Vehiculos vehiculo;
    private List<PiezasUtilizadas> listaPiezas;
    private double totalTodasLasPiezas;
    private String mensaje;

}
