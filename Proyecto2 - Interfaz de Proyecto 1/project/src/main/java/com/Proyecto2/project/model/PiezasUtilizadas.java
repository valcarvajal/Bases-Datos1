package com.Proyecto2.project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PiezasUtilizadas {

    private int idPiezaUtilizada;
    private int idServicio;
    private String codigoPieza;
    private int cantidad;
    private double costoTotal;

}

