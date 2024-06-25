package com.Proyecto2.project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Vehiculos {

    private String numeroPlaca;
    private String marca;
    private String modelo;
    private int anioFabricacion;
    private String numeroVIN;
    private int numeroCliente;

}

