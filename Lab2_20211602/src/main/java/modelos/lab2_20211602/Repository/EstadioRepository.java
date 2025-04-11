package modelos.lab2_20211602.Repository;

import modelos.lab2_20211602.Entity.Estadio;
import modelos.lab2_20211602.Entity.Jugador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
    public interface EstadioRepository extends JpaRepository<Estadio, Integer> {

}
