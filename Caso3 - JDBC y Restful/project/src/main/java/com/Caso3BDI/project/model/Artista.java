package com.Caso3BDI.project.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

import java.util.*;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Artista {

    private int id;
    private String nombre;
    private String apellido;
    private List<String> roles;

    public void setRoles(List<String> roles) {this.roles = roles;}

}

