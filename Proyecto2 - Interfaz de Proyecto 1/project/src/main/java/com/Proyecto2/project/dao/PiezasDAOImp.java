package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.Piezas;

import com.Proyecto2.project.model.Servicios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class PiezasDAOImp implements PiezasDAO{

    @Autowired
    JdbcTemplate jdbcTemplate;
    public Piezas getPiezas(String CodigoPieza){
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM Piezas WHERE CodigoPieza=?", new BeanPropertyRowMapper<Piezas>(Piezas.class), CodigoPieza);

        }catch (Exception e){
            throw new ExpressionException("Error -3: la pieza buscada no existe en catalogo.");
        }

    }
}
