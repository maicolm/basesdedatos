# 📚 Sistema de Gestión Escolar - Base de Datos SQL Server

Este repositorio contiene el diseño profesional de una base de datos para un colegio particular con múltiples sedes en Lima, Perú. El sistema está diseñado para manejar alumnos, profesores, tutores, grados, secciones, asistencias, pensiones (con pagos fraccionados), productos escolares y ventas, así como turnos y sedes educativas.

## 🧱 Estructura General

- **Sedes**: Define las distintas sedes del colegio (por distrito).
- **Turnos**: Turno en que estudia el alumno (mañana/tarde).
- **Grados y Secciones**: Organización académica de los alumnos.
- **Alumnos y Tutores**: Registro completo del alumnado y sus apoderados.
- **Profesores**: Datos del personal docente.
- **Asistencias**: Registro diario del estado de asistencia.
- **Pensiones**: Control de pagos mensuales con posibilidad de adelantos o pagos fraccionados.
- **Productos y Ventas**: Gestión de inventario y venta de productos escolares (uniformes, libros, etc.).

## ⚙️ Tecnologías Utilizadas

- **SQL Server 2019+**
- DBML (para documentación visual)
- Compatible con herramientas como:
  - SSMS (SQL Server Management Studio)
  - Azure Data Studio
  - dbdiagram.io (para el diagrama ER)

## 📂 Archivos Incluidos

| Archivo                  | Descripción                                                 |
|--------------------------|-------------------------------------------------------------|
| `script.sql`             | Script completo para crear la base de datos en SQL Server   |
| `modelo.dbml`            | Diagrama entidad-relación en formato DBML                   |
| `README.md`              | Este archivo, con explicación del proyecto                  |

## 🏫 Funcionalidades Clave

- **Manejo multisedes**: Cada alumno y profesor pertenece a una sede específica.
- **Pagos flexibles de pensiones**: Adelantos o fraccionamientos registrados individualmente.
- **Seguimiento académico**: Asistencias por alumno y clase.
- **Relación con tutores**: Un alumno puede tener uno o varios apoderados registrados.
- **Control de inventario**: Gestión de productos escolares y ventas.

## ▶️ Ejecución

1. Asegúrate de tener **SQL Server 2019 o superior**.
2. Copia el archivo `script.sql` en tu entorno de ejecución (ej. SSMS).
3. Verifica que la carpeta `C:\SQLData\` exista o cambia la ruta en la creación de la base.
4. Ejecuta el script paso a paso o de forma completa.
5. Usa el archivo `modelo.dbml` en [dbdiagram.io](https://dbdiagram.io/) o una herramienta compatible para visualizar el diagrama ER.

## 🧩 Recomendaciones

- Agrega respaldos automáticos de la base de datos.
- Define usuarios y roles para acceso diferenciado (ej. administrador, profesor, cajero).
- Considera cifrado en columnas sensibles si se sube a nube.

## 👨‍💻 Autor

Maicolm Rivera
Contacto: grupoxpertos@gmail.com

Desarrollado por Maicolm Rivera como parte de una evaluación técnica/proyecto académico.  


> **Licencia:** Este proyecto es de uso libre para fines educativos y profesionales. Cualquier uso comercial debe incluir atribución al autor.
