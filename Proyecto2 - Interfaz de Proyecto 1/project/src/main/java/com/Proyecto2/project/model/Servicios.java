package com.Proyecto2.project.model;
import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Servicios {

    private int IDServicio;

    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="dd/MM/yyyy")
    private Date fechaIngreso;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="dd/MM/yyyy")
    private Date fechaConclusion;

    private String descripcionServicio;
    private String numeroPlaca;
    private int numeroCuenta;
    private double horasInvertidas;
    private double costoTotalManoObra;
    private double costoTotalFacturado;
    private double porcentajeUtilidad;

}

