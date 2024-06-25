package com.Proyecto2.project.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Talleres {

    private int numeroCuenta;
    private String nombreTaller;
    private String provincia;
    private String canton;
    private String distrito;
    private String ubicacionExacta;
    private String numeroTelefono;
    private String email;
    private String login;
    private String password;
    private double costoOperacionMensual;
    private int horasTrabajoMes;

}

