import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final logger = Logger();
  static BuildContext? appContext;
  static Database? _database;
  static const String _databaseName = 'myerp_database.db';
  static const int _databaseVersion = 1;

  
  // Tabla Sucursales
  static const String tableSucursales = 'sucursales';
  static const String columnNombre = 'nombre';
  static const String columnDireccion = 'direccion_fisica';
  static const String columnCorreo = 'correo';
  static const String columnSitioWeb = 'sitio_web';
  static const String columnTelefono = 'telefono';
  static const String columnCelular = 'celular';
  static const String columnWhatsapp = 'whatsapp';
  static const String columnFacebook = 'facebook';
  static const String columnInstagram = 'instagram';
  static const String columnTwitter = 'twitter';
  static const String columnPinterest = 'pinterest';
  static const String columnTiktok = 'tiktok';
  static const String columnEncargado = 'encargado';
  static const String columnLogo = 'logo';

  // Tabla Empresa
  static const String tableEmpresa = 'empresa';
  static const String columnTipo = 'tipo';
  static const String columnNombreEmpresa = 'nombre_empresa';
  static const String columnRazonSocial = 'razon_social';
  static const String columnRFC = 'rfc';
  static const String columnResponsable = 'responsable';
  static const String columnFechaRegistro = 'fecha_registro';
  static const String columnFechaFundacion = 'fecha_fundacion';
  static const String columnGiroEmpresa = 'giro_empresa';

  // Tabla Usuario
  static const String tableUsuario = 'usuario';
  static const String columnNombreCompleto = 'nombre_completo';
  static const String columnRol = 'rol';
  static const String columnCorreoElectronico = 'correo_electronico';
  static const String columnTelefonoUsuario = 'telefono_usuario';
  static const String columnCelularUsuario = 'celular_usuario';
  static const String columnDireccionUsuario = 'direccion_usuario';
  static const String columnFechaRegistroUsuario = 'fecha_registro_usuario';
  static const String columnFechaIngreso = 'fecha_ingreso';
  static const String columnRFCUsuario = 'rfc_usuario';
  static const String columnRegimenFiscal = 'regimen_fiscal';
  static const String columnNumSeguridadSocial = 'num_seguridad_social';
  static const String columnPasscode = 'passcode';

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    final exists = await databaseExists(path);

    if (!exists) {
      logger.i('Creando nueva base de datos...');
      await Directory(dirname(path)).create(recursive: true);
      final database = await openDatabase(path, version: _databaseVersion, onCreate: _createDatabase);
      _database = database;
    
    } else {
      logger.i('Base de datos existente, abriendo...');
      final database = await openDatabase(path, version: _databaseVersion);
      _database = database;
     
    }

    return _database!;
  }

   Future<void> _createDatabase(Database db, int version) async {
  // Definir las consultas para crear las tablas
    const createSucursalesTableQuery = '''
      CREATE TABLE $tableSucursales (
        $columnNombre TEXT,
        $columnDireccion TEXT,
        $columnCorreo TEXT,
        $columnSitioWeb TEXT,
        $columnTelefono TEXT,
        $columnCelular TEXT,
        $columnWhatsapp TEXT,
        $columnFacebook TEXT,
        $columnInstagram TEXT,
        $columnTwitter TEXT,
        $columnPinterest TEXT,
        $columnTiktok TEXT,
        $columnEncargado TEXT,
        $columnLogo TEXT
      )
    ''';

    const createEmpresaTableQuery = '''
      CREATE TABLE $tableEmpresa (
        $columnTipo TEXT,
        $columnNombreEmpresa TEXT NOT NULL,
        $columnRazonSocial TEXT,
        $columnRFC TEXT,
        $columnResponsable TEXT NOT NULL,
        $columnFechaRegistro TEXT,
        $columnFechaFundacion TEXT,
        $columnGiroEmpresa TEXT
      )
    ''';

    const createUsuarioTableQuery = '''
      CREATE TABLE $tableUsuario (
        $columnNombreCompleto TEXT NOT NULL,
        $columnRol TEXT NOT NULL,
        $columnCorreoElectronico TEXT NOT NULL UNIQUE,
        $columnTelefonoUsuario TEXT,
        $columnCelularUsuario TEXT,
        $columnDireccionUsuario TEXT,
        $columnFechaRegistroUsuario TEXT,
        $columnFechaIngreso TEXT,
        $columnRFCUsuario TEXT,
        $columnRegimenFiscal TEXT,
        $columnNumSeguridadSocial TEXT,
        $columnPasscode TEXT
      )
    ''';

    // Ejecutar las consultas para crear las tablas
    await db.execute(createSucursalesTableQuery);
    await db.execute(createEmpresaTableQuery);
    await db.execute(createUsuarioTableQuery);
  }

  
}





