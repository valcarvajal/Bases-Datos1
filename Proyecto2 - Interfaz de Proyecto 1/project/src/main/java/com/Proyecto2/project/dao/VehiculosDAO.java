package com.Proyecto2.project.dao;

import com.Proyecto2.project.model.Servicios;
import com.Proyecto2.project.model.Vehiculos;

public interface VehiculosDAO {

    public Vehiculos getVehiculoById(String IDVehiculo);
    public String setVehiculo(Vehiculos vehiculos);
    public int getPropietario(String placa);
}
