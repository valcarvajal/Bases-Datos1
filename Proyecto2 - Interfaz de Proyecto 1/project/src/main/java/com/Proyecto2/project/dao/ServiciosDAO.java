package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.PiezasUtilizadas;
import com.Proyecto2.project.model.Servicios;

public interface ServiciosDAO {

    public Servicios getServiciosById(int IDServicio);

    public String setServicios(Servicios servicios);

    public String closeServicios(Servicios servicios, int IDServicio);
}
