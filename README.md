📘 README – Bases de Datos Profesionales para Sistemas Empresariales
Este repositorio contiene scripts SQL organizados por motor de base de datos para distintos sistemas empresariales desarrollados con enfoque profesional. Cada motor tiene su propio esquema y estructura pensada para necesidades específicas como autenticación de usuarios, seguridad, mantenimiento y relaciones de datos bien definidas.

🧩 Estructura por Motor
1. 🟡 Oracle – Empresa de Desarrollo de Software
Sistema orientado a:
Empresas que desarrollan sistemas a medida, dan soporte y mantenimiento a clientes de distintos rubros.

Incluye:

Creación de tablespaces, usuario y roles.

Tablas relacionadas (clientes, proyectos, usuarios, roles, lenguajes, etc.).

Seguridad con contraseñas encriptadas y roles.

Procedimientos almacenados (CRUD).

Triggers automáticos para validaciones.

Comentarios profesionales en cada tabla.

📂 Carpeta: /oracle/

2. 🔵 SQL Server – Sistema de Gestión Escolar
Sistema orientado a:
Instituciones educativas con múltiples sedes que requieren gestionar alumnos, docentes, pensiones y asistencia.

Incluye:

Modelo completo con relaciones bien definidas.

Scripts para creación de tablas con claves foráneas.

Normalización para control de grados, secciones, turnos.

DBML (Database Markup Language) sugerido para documentación en GitHub.

Ideal para despliegues en entornos Microsoft.

📂 Carpeta: /sqlserver/

3. 🔴 MySQL – Sistema Web de Reconocimiento Facial
Sistema orientado a:
Aplicaciones web de autenticación biométrica mediante reconocimiento facial.

Incluye:

Estructura básica con tablas para usuarios, sesiones, logs y fotos.

Pensado para integrarse con backend en Flask/FastAPI y frontend en WebRTC.

Campos optimizados para imágenes (BLOB/base64).

Seguridad básica con claves hash.

Listo para usar con servidores web (Apache/Nginx) y bases ligeras.

📂 Carpeta: /mysql/

📦 Requisitos Generales
MySQL 8+, SQL Server 2017+ u Oracle 12c+

Cliente compatible (Workbench, SSMS, SQL Developer)

Permisos para ejecutar scripts de creación y manipulación de objetos

📧 Contacto
Desarrollado por: Maicolm Rivera Zamudio
Equipo de Modelado de Datos
📨 grupoxpertos@gmail.com
