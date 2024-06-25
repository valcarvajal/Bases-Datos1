package com.Caso3BDI.project.model;

import java.sql.Date;
import java.sql.Time;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Visualizacion {

    private Date fecha;
    private String ubicacion;
    private Time duracion;
    private Integer calificacion;
    private Integer pelicula_id;

}

