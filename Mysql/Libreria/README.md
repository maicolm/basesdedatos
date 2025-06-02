# Base de Datos para Librería en Lima, Perú

Este proyecto define el diseño profesional de una base de datos para una **librería con múltiples sedes** distribuidas en los distritos de Lima, Perú. La librería gestiona no solo inventarios y ventas de libros, sino también talleres y eventos culturales con autores invitados.

---

## Objetivos

- Modelar una base de datos escalable y normalizada.
- Gestionar múltiples sedes en distintos distritos.
- Controlar el stock de libros por sede.
- Registrar ventas y sus detalles.
- Administrar talleres, eventos y la participación de clientes.
- Documentar y visualizar claramente el diseño a través de un diagrama ER.

---

## Estructura del Proyecto

### Archivos incluidos

| Archivo                  | Descripción |
|--------------------------|-------------|
| `libreria_peru.sql`      | Script SQL para crear la base de datos completa en MySQL. |
| `libreria_peru.dbml`     | Modelo ER en formato DBML compatible con [dbdiagram.io](https://dbdiagram.io). |
| `README.md`              | Documentación del proyecto. |

---

## Modelo de Datos

La base de datos contiene las siguientes entidades principales:

- `distritos`: Lista de distritos de Lima donde hay sedes.
- `sedes`: Sucursales físicas de la librería.
- `libros`: Catálogo de libros, con relación a autores y categorías.
- `stock_sede_libro`: Relación de inventario entre libros y sedes.
- `clientes`: Usuarios registrados que compran libros o participan en talleres/eventos.
- `ventas` y `detalle_ventas`: Registro de ventas por sede y cliente.
- `talleres` e `inscripciones_taller`: Gestión de talleres culturales y artísticos.
- `eventos` y `asistencia_eventos`: Registro de eventos con autores y asistencia.

---

## 🧭 Diagrama Entidad-Relación

Haz clic en el enlace para ver el **diagrama visual ER** generado con `dbdiagram.io`:

👉 [Ver Diagrama ER Interactivo](https://dbdiagram.io/d/libreria-peru)

> También puedes abrir el archivo `libreria_peru.dbml` en [https://dbdiagram.io](https://dbdiagram.io) para modificarlo, exportarlo como imagen (PNG/PDF) o compartirlo.

---

## ⚙️ Requisitos

- MySQL 5.7 o superior
- Editor de base de datos (como MySQL Workbench o DBeaver)

---

## 🚀 Uso


Importa el archivo libreria_peru.sql en tu base de datos MySQL.

Opcional: visualiza el diagrama ER en dbdiagram.io importando el archivo libreria_peru.dbml.


## 👨‍💻 Autor

Maicolm Rivera
Contacto: grupoxpertos@gmail.com

Desarrollado por Maicolm Rivera como parte de una evaluación técnica/proyecto académico.  


> **Licencia:** Este proyecto es de uso libre para fines educativos y profesionales. Cualquier uso comercial debe incluir atribución al autor.