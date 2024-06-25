package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.Piezas;
import com.Proyecto2.project.model.PiezasUtilizadas;

import java.util.List;

public interface PiezasUtilizadasDAO {
    public String setPiezasUtilizadas(Piezas piezasStock, int cantidadPiezas, double costoIngresado,int iDservicio);

    public List<PiezasUtilizadas> getPiezasUtilizadas(int IDServicio);

}
