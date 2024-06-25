package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.Vehiculos;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;


@Repository
public class VehiculosDAOImp implements VehiculosDAO{

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public Vehiculos getVehiculoById(String IDVehiculo){
        return jdbcTemplate.queryForObject("SELECT * FROM Vehiculos WHERE NumeroPlaca=?", new BeanPropertyRowMapper<Vehiculos>(Vehiculos.class), IDVehiculo);
    }

    @Override
    public String setVehiculo(Vehiculos vehiculos) {
        jdbcTemplate.update(
                "INSERT INTO Vehiculos (numeroPlaca, marca, modelo, anioFabricacion, numeroVIN, numeroCliente) " + "VALUES (?, ?, ?, ?, ?, ?)",
                vehiculos.getNumeroPlaca(),
                vehiculos.getMarca(),
                vehiculos.getModelo(),
                vehiculos.getAnioFabricacion(),
                vehiculos.getNumeroVIN(),
                vehiculos.getNumeroCliente()
        );
        return "Vehiculo guardado de forma exitosa";
    }

    public int getPropietario(String placa){
        try{
            String sql = "SELECT * FROM tallercr.Vehiculos WHERE NumeroPlaca=?";
            Vehiculos v = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<Vehiculos>(Vehiculos.class), placa);
            assert v != null;
            return v.getNumeroCliente();
        } catch (Exception e){
            throw new ExpressionException("Error: No fue posible encontrar la matricula suministrada.");
        }
    }

}
