package com.Caso3BDI.project.dao;

import com.Caso3BDI.project.model.Visualizacion;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.*;


@Repository
public class VisualizacionDAOImp implements VisualizacionDAO {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public int save(Visualizacion visualizacion) {
        return jdbcTemplate.update("INSERT INTO Visualizacion (fecha, ubicacion, duracion, calificacion, pelicula_id) VALUES (?, ?, ?, ?, ?)",
                visualizacion.getFecha(), visualizacion.getUbicacion(), visualizacion.getDuracion(), visualizacion.getCalificacion(), visualizacion.getPelicula_id());
    }

    @Override
    public List<Visualizacion> getVisualizacionByPeliculaId(int peliculaId) {
        String sql = "SELECT * FROM Visualizacion WHERE pelicula_id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Visualizacion.class), peliculaId);
    }

}

