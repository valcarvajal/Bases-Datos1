package com.Caso3BDI.project.dao;

import com.Caso3BDI.project.model.Visualizacion;
import java.util.List;


public interface VisualizacionDAO {

    int save(Visualizacion visualizacion);
    List<Visualizacion> getVisualizacionByPeliculaId(int peliculaId);

}

