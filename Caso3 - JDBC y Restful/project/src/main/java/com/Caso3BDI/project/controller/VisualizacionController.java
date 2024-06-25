package com.Caso3BDI.project.controller;

import com.Caso3BDI.project.model.Visualizacion;
import com.Caso3BDI.project.dao.VisualizacionDAO;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;


@RestController
public class VisualizacionController {

    private final VisualizacionDAO visualizacionDAO;

    @Autowired
    public VisualizacionController(VisualizacionDAO visualizacionDAO) {
        this.visualizacionDAO = visualizacionDAO;
    }

    @PostMapping("/pelicula/{id}/visualizacion")
    public ResponseEntity<String> registrarVisualizacion(@PathVariable int id, @RequestBody Visualizacion visualizacion) {
        visualizacion.setPelicula_id(id);
        try {
            visualizacionDAO.save(visualizacion);
            return ResponseEntity.ok("Visualización agregada correctamente para la película con ID: " + id);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al agregar visualización para la película con ID: " + id);
        }
    }

}

