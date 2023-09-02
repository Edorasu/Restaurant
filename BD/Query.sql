CREATE DATABASE Restaurant
GO

USE Restaurant
GO
/*1. Un restaurante necesita un sistema administrativos para control de usuarios, dentro de los usuarios deben haber roles, para el administrador y para los empleados, notificaciones de pedidos, empleados, productos(platillos),
categoria de platillos, necesita saber que clientes le comprar y que productos compraran (tabla ventas), tambien,
2. el restaurante necesita un sistema de compras de materia prima(ingredientes)y detalles de las compras que hizo, detalle de las ventas que realizo,
necesita un metodo de pago, carrito de compras(almacenar los productos comprados), 
3. para la app movil necesita acceder a la misma BD con la credenciales de cliente,  ver los prouctos, hacer el pedido, y recibir el pedido en la pag web.
ocupare el metodo de pago(efectivo, tarjeta)*/

CREATE TABLE Categoria(
IdCategoria int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
GO

CREATE TABLE Producto(
IdProducto int primary key identity,
Nombre varchar(500),
Descripcion varchar(500),
IdCategoria int references Categoria (IdCategoria),
Precio decimal(10,2) default 0,
stock int,
RutaImagen varchar(500),
NombreImagen varchar(500),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
GO

CREATE TABLE Cliente(
IdCliente int primary key identity,
Nombres varchar(100),
Apellidos varchar(100),
Correo varchar(100),
Clave varchar(150),
Reestablecer bit default 0,
FechaRegistro datetime default getdate()
)
GO

CREATE TABLE Carrito(
IdCarrito int primary key identity,
IdCliente int references Cliente(IdCliente),
IdProducto int references Producto(IdProducto),
Cantidad int
)
GO

CREATE TABLE Venta(
IdVenta int primary key identity,
IdCliente int references Cliente(IdCliente),
TotalProducto int,
MontoTotal decimal(10,2),
Contacto varchar(100),
IdDistrito varchar(10),
Telefono varchar(50),
Direccion varchar(500),
IdTransaccion varchar(50),
FechaVenta datetime default getdate()
)
GO

CREATE TABLE Detalle_Venta(
IdDetalleVenta int primary key identity,
IdVenta int references Venta(IdVenta),
IdProducto int references Producto(IdProducto),
Cantidad int,
Total decimal(10,2)
)
GO

CREATE TABLE Departamento(
IdDepartamento varchar(3) not null,
Descripcion varchar(50) not null
)
GO


CREATE TABLE Municipio(
IdMunicipio varchar(3) not null,
Descripcion varchar(50) not null,
IdDepartamento varchar(3) not null
)
GO

CREATE TABLE Distrito(
IdDistritio varchar(3) not null,
Descripcion varchar(50) not null,
IdMunicipio varchar(3) not null,
IdDepartamento varchar(3) not null
)
GO


--TABLAS ADICIONALES AL RESTAURANT

CREATE TABLE Menu(
IdMenu int primary key identity,
Descripcion varchar(500),
IdMenuPadre int references Menu (IdMenu),
Icono varchar(30),
Controlador varchar(30),
PaginaAccion Varchar(30),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
GO

CREATE TABLE Rol(
IdRol int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
GO

CREATE TABLE RolMenu(
IdRolMenu int primary key identity,
IdRol int references Rol(IdRol),
IdMenu int references Menu(IdMenu),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
GO

CREATE TABLE Usuario(
IdUsuario int primary key identity,
Nombres varchar(100),
Apellidos varchar(100),
Correo varchar(100),
Telefono varchar(100),
IdRol int references Rol(IdRol),
Clave varchar(150),
Reestablecer bit default 1,
Activo bit default 1,
FechaRegistro datetime default getdate()
)
GO

--Supongo que deberia de incluir a los empleados una planilla de pagos, una tabla para las compras, gastos, ganancias,
--