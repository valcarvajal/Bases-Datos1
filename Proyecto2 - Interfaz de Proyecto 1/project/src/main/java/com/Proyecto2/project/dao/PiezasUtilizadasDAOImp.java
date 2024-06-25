package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.Piezas;
import com.Proyecto2.project.model.PiezasUtilizadas;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class PiezasUtilizadasDAOImp implements PiezasUtilizadasDAO{

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public String setPiezasUtilizadas(Piezas piezasStock, int cantidadPiezas, double costoIngresado,int iDservicio) {
        double costoTotal = costoIngresado;
        String salida = "Piezas utilizadas guardadas de forma exitosa";
        if(costoTotal == 0){
            salida = salida + " con el precio automatico del sistema";
            costoTotal = piezasStock.getCostoVenta() * cantidadPiezas;
        }
        jdbcTemplate.update(
                "INSERT INTO piezasutilizadas (idServicio, codigoPieza, cantidad, costoTotal) "
                        + "VALUES (?, ?, ?, ?)",
                iDservicio,
                piezasStock.getCodigoPieza(),
                cantidadPiezas,
                costoTotal
        );
        return salida;
    }

    @Override
    public List<PiezasUtilizadas> getPiezasUtilizadas(int IDServicio) {
        return jdbcTemplate.query("SELECT * FROM piezasUtilizadas WHERE IDServicio=?", new BeanPropertyRowMapper<PiezasUtilizadas>(PiezasUtilizadas.class),IDServicio);
    }

}

