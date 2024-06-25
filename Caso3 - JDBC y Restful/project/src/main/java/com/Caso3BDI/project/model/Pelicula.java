package com.Caso3BDI.project.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

import java.util.*;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Pelicula {

    private int id;
    private String titulo;
    private List<Artista> artistas;
    private List<Visualizacion> visualizaciones;

    public void setArtistas(List<Artista> artistas) {this.artistas = artistas;}
    public void setVisualizaciones(List<Visualizacion> visualizaciones) { this.visualizaciones = visualizaciones;}

}

