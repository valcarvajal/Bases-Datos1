package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.Clientes;

import com.Proyecto2.project.model.Vehiculos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
public class ClientesDAOImp implements ClientesDAO{

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public Clientes getCliente(int NumeroCliente) {
        return jdbcTemplate.queryForObject("SELECT * FROM clientes WHERE NumeroCliente=?", new BeanPropertyRowMapper<Clientes>(Clientes.class), NumeroCliente);

    }
}
