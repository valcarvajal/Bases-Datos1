package com.Caso3BDI.project.controller;

import com.Caso3BDI.project.model.Pelicula;
import com.Caso3BDI.project.model.Artista;
import com.Caso3BDI.project.model.Visualizacion;

import com.Caso3BDI.project.dao.ArtistaDAO;
import com.Caso3BDI.project.dao.PeliculaDAO;
import com.Caso3BDI.project.dao.VisualizacionDAO;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;


@RestController
public class PeliculaController {

    @Autowired
    private PeliculaDAO peliculaDAO;

    @Autowired
    private ArtistaDAO artistaDAO;

    @Autowired
    private VisualizacionDAO visualizacionDAO;


    @GetMapping("/pelicula/{id}")
    public Pelicula getPeliculaInfo(@PathVariable int id) {
        Pelicula pelicula = peliculaDAO.getById(id);
        if (pelicula != null) {
            List<Artista> artistas = artistaDAO.getArtistasByPeliculaId(id);
            pelicula.setArtistas(artistas);

            List<Visualizacion> visualizaciones = visualizacionDAO.getVisualizacionByPeliculaId(id);
            pelicula.setVisualizaciones(visualizaciones);

            return pelicula;
        } else {
            return null;
        }
    }
}

