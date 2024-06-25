package com.Proyecto2.project.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Piezas {

    private String codigoPieza;
    private String descripcionPieza;
    private double costoVenta;

}

