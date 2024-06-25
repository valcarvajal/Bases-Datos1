package com.Proyecto2.project.service;

import com.Proyecto2.project.dao.*;
import com.Proyecto2.project.model.Piezas;
import com.Proyecto2.project.model.PiezasUtilizadas;
import com.Proyecto2.project.model.Servicios;
import com.Proyecto2.project.model.SumarioServicio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Component
public class Service {

    @Autowired
    private VehiculosDAO vDAO;
    @Autowired
    private ServiciosDAO sDAO;
    @Autowired
    private PiezasDAO pDAO;
    @Autowired
    private PiezasUtilizadasDAO pUDAO;
    @Autowired
    private ClientesDAO cDAO;

    // API 1 //
    private boolean matchOperation(int NumeroCliente, String placa){
        int propietario = vDAO.getPropietario(placa);
        return NumeroCliente == propietario;
    }

    public String newServicios(Servicios servicios, int NumeroCliente){
        try {
            if (matchOperation(NumeroCliente, servicios.getNumeroPlaca())) {
                return sDAO.setServicios(servicios);
            }
            return "Error -2: el cliente no concuerda con el propietario del vehiculo.";
        } catch (Exception e){
            return e.getMessage();
        }
    }

    // API 2 //
    private Piezas getOperation(String CodigoPieza){
        return pDAO.getPiezas(CodigoPieza);
    }

    public String newPiezasUtilizadas(PiezasUtilizadas piezasUtilizadas, int IDServicio ){
        try {
            Piezas inStock = getOperation(piezasUtilizadas.getCodigoPieza());
            return pUDAO.setPiezasUtilizadas(inStock,piezasUtilizadas.getCantidad(),piezasUtilizadas.getCostoTotal(),IDServicio);
        }catch (Exception e){
            return e.getMessage();
        }
    }

    // API 3 //
    private Servicios buildNewServicios(Servicios antiguo, Servicios nuevo){
        Servicios finalServicios = new Servicios();
        finalServicios.setIDServicio(nuevo.getIDServicio());
        finalServicios.setFechaIngreso(antiguo.getFechaIngreso());
        finalServicios.setFechaConclusion(nuevo.getFechaConclusion());
        finalServicios.setNumeroCuenta(antiguo.getNumeroCuenta());
        finalServicios.setNumeroPlaca(antiguo.getNumeroPlaca());
        finalServicios.setHorasInvertidas(nuevo.getHorasInvertidas());
        finalServicios.setCostoTotalManoObra(nuevo.getCostoTotalManoObra());
        finalServicios.setDescripcionServicio(antiguo.getDescripcionServicio());

        if (nuevo.getDescripcionServicio() != null){
            finalServicios.setDescripcionServicio(nuevo.getDescripcionServicio());
        }
        return finalServicios;
    }

    public String endServicios(Servicios servicios, int IDServicio){
        try {
            Servicios finalServicios = buildNewServicios(sDAO.getServiciosById(IDServicio), servicios);
            return sDAO.closeServicios(finalServicios,IDServicio);

        }catch (Exception e){
            return e.getMessage();
        }
    }

    // API 4 //
    private double calculateTotal(List<PiezasUtilizadas> piezasUtilizadas){
        double total = 0;
        for(PiezasUtilizadas pieza :piezasUtilizadas){
            total += pieza.getCostoTotal();
        }
        return total;
    }

    public SumarioServicio getSumario(int IDServicio){
        SumarioServicio[] retorno = new SumarioServicio[1];
        retorno[0] = new SumarioServicio();
        try {
            retorno[0].setServicio(sDAO.getServiciosById(IDServicio));

            String vID = retorno[0].getServicio().getNumeroPlaca();
            retorno[0].setVehiculo(vDAO.getVehiculoById(vID));

            int propietario = vDAO.getPropietario(vID);
            retorno[0].setCliente(cDAO.getCliente(propietario));

            retorno[0].setListaPiezas(pUDAO.getPiezasUtilizadas(IDServicio));

            retorno[0].setTotalTodasLasPiezas(calculateTotal(retorno[0].getListaPiezas()));

            retorno[0].setMensaje("Gracias por confiar en nosotros.");
        }catch (Exception e){
            retorno[0].setMensaje("Hubo un error encontrado la data para el servicio, info:"+e.getMessage());
        }
        return retorno[0];

    }

}
