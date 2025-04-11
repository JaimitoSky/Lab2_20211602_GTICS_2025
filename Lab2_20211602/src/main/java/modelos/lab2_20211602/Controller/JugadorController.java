package modelos.lab2_20211602.Controller;

import modelos.lab2_20211602.Entity.Jugador;
import modelos.lab2_20211602.Repository.JugadorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;
@Controller
@RequestMapping("/jugador")
public class JugadorController {

    private final JugadorRepository jugadorRepository;
    public JugadorController(JugadorRepository jugadorRepository){
        this.jugadorRepository=jugadorRepository;
    }
    @GetMapping(value = {"", "/jugador"})
    public String listarJugadores(Model model) {
        List<Jugador> lista=jugadorRepository.findAll();
        model.addAttribute("listaJugadores",lista);
        return "jugador/lista";
    }
    @GetMapping(value = {"/jugador/nuevo"})
    public String mostrarFormulario(Model model) {
        model.addAttribute("jugador",new Jugador());
        return "jugador/formulario";
    }
    @PostMapping(value = {"/jugador/guardar"})
    public String guardarJugador(@ModelAttribute("jugador") Jugador jugador) {
        jugadorRepository.save(jugador);
        return "jugador/jugador";
    }
    @GetMapping(value = {"/jugador/eliminar"})
    public String eliminarJugador(@PathVariable("id") int id) {
        jugadorRepository.deleteById(id);
        return "jugador/jugador";
    }

}
