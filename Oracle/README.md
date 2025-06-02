
# 📘 README – Base de Datos Oracle: Sistema de Empresa de Desarrollo de Software

## 🗂 Descripción General

Este proyecto implementa la base de datos para una empresa de desarrollo de software que gestiona:

- Proyectos de desarrollo a medida en distintos lenguajes de programación.
- Clientes de diversos rubros.
- Servicios de soporte y mantenimiento.
- Control de usuarios con roles, login y contraseñas encriptadas.
- Seguridad basada en roles y disparadores automáticos para control de datos.

## 📦 Estructura del Proyecto

El repositorio incluye los siguientes archivos SQL:

| Archivo                          | Descripción |
|----------------------------------|-------------|
| `01_creacion_base_datos.sql`     | Crea los `tablespaces`, el `usuario`, los `roles` y asigna permisos. |
| `02_creacion_tablas.sql`         | Define todas las tablas con sus relaciones, claves primarias/foráneas y comentarios. |
| `03_procedimientos.sql`          | Procedimientos almacenados para operaciones CRUD en las tablas principales. |
| `04_triggers.sql`                | Triggers (disparadores) para validación, auditoría o lógica automática. |

## 👤 Usuario del Esquema

```
Usuario:       devsoft_user  
Contraseña:    StrongPassword123  
Tablespace:    ts_devsoft_data (datos), ts_devsoft_idx (índices)
Rol:           devsoft_admin
```

> ⚠️ **Nota:** Cambia la contraseña por una segura en producción.  
> ⚠️ Asegúrate de ajustar las rutas de `DATAFILE` según la configuración de tu entorno Oracle.

## 🔐 Seguridad

- Las contraseñas de los usuarios se almacenan encriptadas (algoritmo SHA256 o similar).
- Los roles determinan los privilegios para acceder o modificar cada entidad.
- Se incluyen triggers para evitar operaciones indebidas (como borrado de usuarios críticos o modificación de claves no autorizadas).

## ⚙️ Requisitos

- Oracle Database 12c o superior.
- Privilegios de DBA para ejecutar `CREATE TABLESPACE`, `CREATE USER`, etc.
- SQL*Plus, SQL Developer o herramienta equivalente para ejecutar scripts.

## 🚀 Instrucciones de Despliegue

1. **Conectar con usuario DBA.**  
   Ejecuta `01_creacion_base_datos.sql` para preparar el entorno (tablespaces, usuario, rol).

2. **Conectarte como `devsoft_user`.**  
   Ejecuta `02_creacion_tablas.sql` para crear todas las tablas con sus relaciones y documentación.

3. **Ejecutar lógica de negocio.**  
   Lanza `03_procedimientos.sql` para registrar todos los procedimientos CRUD.

4. **Activar lógica automática.**  
   Ejecuta `04_triggers.sql` para configurar validaciones automáticas.

## 📝 Comentarios y Documentación

Cada tabla y objeto del sistema contiene comentarios (`COMMENT ON ...`) explicando su propósito. Esto facilita la comprensión futura del modelo.

## 🛠 Autor

**Sistema desarrollado por:**  
Maicolm Rivera
Contacto: grupoxpertos@gmail.com
