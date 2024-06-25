package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.Servicios;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ServiciosDAOImp implements ServiciosDAO{

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public String setServicios(Servicios servicios) {
        jdbcTemplate.update(
            "INSERT INTO Servicios (FechaIngreso, DescripcionServicio, NumeroPlaca, NumeroCuenta, HorasInvertidas, CostoTotalManoObra) "
                + "VALUES (?, ?, ?, ?, ?, ?)",
                servicios.getFechaIngreso(),
                servicios.getDescripcionServicio(),
                servicios.getNumeroPlaca(),
                servicios.getNumeroCuenta(),
                servicios.getHorasInvertidas(),
                servicios.getCostoTotalManoObra()
        );
        return "Servicio guardado de forma exitosa";
    }

    @Override
    public Servicios getServiciosById(int IDServicio){
        return jdbcTemplate.queryForObject("SELECT * FROM Servicios WHERE IDServicio=?", new BeanPropertyRowMapper<Servicios>(Servicios.class), IDServicio);
    }

    @Override
    public String closeServicios(Servicios servicios, int IDServicio){
        String sql =
                "UPDATE servicios "+
                "SET fechaIngreso=?, fechaConclusion=?, descripcionServicio=?, numeroPlaca=?, numeroCuenta=?, horasInvertidas=?, "+
                "costoTotalManoObra=? "+
                "WHERE IDServicio=? ";
        jdbcTemplate.update(sql, new Object[]{
                    servicios.getFechaIngreso(), servicios.getFechaConclusion(), servicios.getDescripcionServicio(),
                    servicios.getNumeroPlaca(), servicios.getNumeroCuenta(), servicios.getHorasInvertidas(),
                    servicios.getCostoTotalManoObra(), IDServicio}
        );
        jdbcTemplate.update("CALL calcular_datos_financieros(?);", IDServicio);

        return "Se han actualizado y calculado los datos financieros del servicio con id: " + IDServicio;
    }


}

