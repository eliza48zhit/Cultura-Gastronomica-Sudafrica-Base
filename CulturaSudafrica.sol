// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaSudafrica
 * @dev Registro de tecnicas de fuego abierto y preservacion de proteinas.
 * Serie: Sabores de Africa (5/54)
 */
contract CulturaSudafrica {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        string tipoCombustible;   // Madera, Carbon, Gas o Secado al Aire
        uint256 diasCurado;       // Critico para el Biltong (0 si es coccion fresca)
        bool esProteinaCaza;      // Uso de avestruz, kudu, impala o res
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Biltong (Icono de preservacion)
        registrarPlato(
            "Biltong Tradicional", 
            "Carne de res o venado, vinagre, sal, pimienta negra, cilantro seco.",
            "Marinar carne en vinagre y especias, colgar en ambiente controlado hasta secar.",
            "Secado al Aire", 
            5, 
            false
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        string memory _combustible, 
        uint256 _curado,
        bool _caza
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_curado <= 30, "Limite de curado: 30 dias");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            tipoCombustible: _combustible,
            diasCurado: _curado,
            esProteinaCaza: _caza,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        string memory ingredientes,
        string memory combustible,
        uint256 curado,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.ingredientes, p.tipoCombustible, p.diasCurado, p.likes);
    }
}
