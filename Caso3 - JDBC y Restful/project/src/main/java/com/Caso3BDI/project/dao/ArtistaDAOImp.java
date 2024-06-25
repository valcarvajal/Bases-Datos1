package com.Caso3BDI.project.dao;

import com.Caso3BDI.project.model.Artista;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.*;


@Repository
public class ArtistaDAOImp implements ArtistaDAO {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public List<Artista> getArtistasByPeliculaId(int peliculaId) {
        String sql = "SELECT a.id, a.nombre, a.apellido, rp.rol FROM Artista a " +
                "JOIN RolPeli rp ON a.id = rp.artista " +
                "WHERE rp.pelicula = ?";

        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, peliculaId);
        Map<Integer, Artista> artistasMap = new HashMap<>();

        for (Map<String, Object> row : rows) {
            int artistaId = (int) row.get("id");
            String rol = (String) row.get("rol");

            Artista artista = artistasMap.getOrDefault(artistaId, new Artista());
            artista.setId(artistaId);
            artista.setNombre((String) row.get("nombre"));
            artista.setApellido((String) row.get("apellido"));

            List<String> roles = artista.getRoles();
            if (roles == null) {
                roles = new ArrayList<>();
            }
            roles.add(rol);

            artista.setRoles(roles);
            artistasMap.put(artistaId, artista);
        }

        return new ArrayList<>(artistasMap.values());
    }

}

