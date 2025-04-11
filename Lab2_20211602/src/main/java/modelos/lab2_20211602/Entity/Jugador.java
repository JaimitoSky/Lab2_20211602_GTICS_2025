package modelos.lab2_20211602.Entity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


    @Entity
    @Getter
    @Setter
    @Table(name = "jugador")
    public class Jugador {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private int  idJugador;
        private String nombre;
        private int edad;
        private String posicion;
        private String club;

        @Column(name = "seleccion_idSeleccion")
        private int  seleccionId;


    }

