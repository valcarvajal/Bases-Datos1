package com.Proyecto2.project.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Clientes {

    private int numeroCliente;
    private String numeroCedula;
    private String tipoCedula;
    private String nombreCliente;
    private String telefonoCliente;
    private String emailCliente;

}

