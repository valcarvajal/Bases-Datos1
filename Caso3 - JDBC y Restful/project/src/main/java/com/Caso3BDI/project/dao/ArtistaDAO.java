package com.Caso3BDI.project.dao;

import com.Caso3BDI.project.model.Artista;
import java.util.List;


public interface ArtistaDAO {

    List<Artista> getArtistasByPeliculaId(int peliculaId);

}

