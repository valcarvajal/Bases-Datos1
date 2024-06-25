package com.Caso3BDI.project.dao;

import com.Caso3BDI.project.model.Pelicula;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class PeliculaDAOImp implements PeliculaDAO {

    @Autowired
     JdbcTemplate jdbcTemplate;

    @Override
    public Pelicula getById(int id) {
        return jdbcTemplate.queryForObject("SELECT * FROM Pelicula WHERE id=?", new BeanPropertyRowMapper<Pelicula>(Pelicula.class), id);
    }

}

