# 🛡️ Auditor de Redes - Suite de Seguridad 2025

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey.svg)
![Batch](https://img.shields.io/badge/language-Batch-green.svg)

## 📋 Descripción

**Auditor de Redes** es una poderosa herramienta de auditoría de ciberseguridad desarrollada en Windows Batch Script. Esta suite integral permite realizar análisis de seguridad tanto a nivel local como de red, detectando vulnerabilidades, escaneando puertos críticos y verificando el estado de seguridad de los sistemas Windows.

Esta herramienta está diseñada para profesionales de IT, administradores de sistemas y entusiastas de la ciberseguridad que necesitan realizar auditorías rápidas y efectivas de su infraestructura.

## ✨ Características Principales

### 🔍 1. Auditoría Local Avanzada
- **Verificación de Firewall**: Comprueba el estado del firewall de Windows
- **Cifrado de Disco (BitLocker)**: Valida si el disco está protegido con BitLocker
- **Windows Update**: Detecta actualizaciones pendientes y parches de seguridad
- **Análisis de Puertos Locales**: Identifica puertos críticos abiertos (SMB, RDP, etc.)

### 🌐 2. Reconocimiento de Red
- **Escaneo de Dispositivos**: Detecta todos los dispositivos activos en tu red local
- **Identificación de MAC Address**: Muestra las direcciones físicas (MAC) de cada dispositivo
- **Mapeo de Red**: Visualiza la topología de tu red y los equipos conectados

### 🎯 3. Escáner de Vulnerabilidades "Full Spectrum"
Análisis profundo de los **9 puertos más críticos**:
- **Puerto 445 (SMB)**: Riesgo de ransomware y archivos compartidos
- **Puerto 3389 (RDP)**: Escritorio remoto - puerta de entrada para hackers
- **Puerto 1433 (SQL Server)**: Base de datos expuesta - riesgo de robo de datos
- **Puerto 22 (SSH)**: Acceso a consola de servidores Linux
- **Puerto 21 (FTP)**: Transferencia de archivos sin cifrar
- **Puerto 23 (Telnet)**: Protocolo obsoleto e inseguro
- **Puerto 5900 (VNC)**: Control remoto de pantalla
- **Puerto 80 (HTTP)**: Servidor web sin cifrado
- **Puerto 8080 (Proxy)**: Servicios web alternativos

## 🔧 Requisitos del Sistema

- **Sistema Operativo**: Windows 10/11 (Pro/Enterprise requerido para verificación de BitLocker)
- **Privilegios**: Derechos de administrador (obligatorio)
- **PowerShell**: Versión 5.0 o superior
- **Red**: Conexión de red activa para escaneo de dispositivos

## 📥 Instalación

1. **Clonar o descargar el repositorio**:
```bash
git clone https://github.com/Diego-Santos-AT/Auditor-de-redes.git
```

2. **Navegar al directorio**:
```bash
cd Auditor-de-redes
```

3. **Ejecutar como Administrador**:
   - Clic derecho en `AuditoriaDiegoSantos.bat`
   - Seleccionar "Ejecutar como administrador"

## 🚀 Uso

### Primera Ejecución

1. **Configuración Inicial** (Opción 0):
   - Ejecuta esta opción solo la primera vez
   - Configura las políticas de ejecución de PowerShell
   - Habilita los colores ANSI en la consola
   ```
   >> COMANDO: 0
   ```

### Funciones Principales

#### Opción 1: Auditoría Local
```
>> COMANDO: 1
```
Realiza un análisis completo del sistema local:
- Verifica el estado del firewall
- Comprueba el cifrado BitLocker
- Analiza actualizaciones pendientes
- Identifica puertos locales abiertos

**Ejemplo de salida**:
```
[+] Verificando Perímetro (Firewall)...
    [OK] Firewall Activo
[+] Verificando Cifrado de Disco (BitLocker)...
    [OK] El disco está cifrado y protegido.
```

#### Opción 2: Reconocimiento de Red
```
>> COMANDO: 2
```
Escanea tu red local para encontrar dispositivos:
1. Introduce el segmento de red (ej: `192.168.1`)
2. El script escaneará todas las IPs del rango (1-254)
3. Mostrará las direcciones IP y MAC de cada dispositivo encontrado

**Ejemplo de uso**:
```
>> Escribe el segmento (Ej: 192.168.1): 192.168.1
Escaneando 192.168.1.x ... Buscando IPs y MACs...

--- DISPOSITIVOS ENCONTRADOS ---
Interfaz: 192.168.1.100 --- 0x2
  Dirección de Internet          Dirección física          Tipo
  192.168.1.1            00-11-22-33-44-55     dinámico
  192.168.1.50           aa-bb-cc-dd-ee-ff     dinámico
```

#### Opción 3: Escáner de Vulnerabilidades
```
>> COMANDO: 3
```
Analiza una IP específica en busca de puertos abiertos:
1. Introduce la IP objetivo (ej: `192.168.1.55`)
2. El script verificará los 9 puertos más críticos
3. Recibirás un informe detallado del estado de cada puerto

**Ejemplo de salida**:
```
[...] Testeando Archivos Compartidos (SMB/445)...
      [CRÍTICO] ABIERTO. Riesgo Ransomware alto.
[...] Testeando Escritorio Remoto (RDP/3389)...
      [OK] Cerrado.
```

## ⚠️ Consideraciones de Seguridad

### ⚖️ Uso Responsable
- **Solo escanea redes y sistemas de tu propiedad o con autorización explícita**
- El escaneo no autorizado de redes puede ser ilegal en tu jurisdicción
- Esta herramienta es para fines educativos y profesionales legítimos

### 🔒 Privacidad
- Todos los análisis se realizan localmente
- No se envía información a servidores externos
- Los resultados solo se muestran en tu pantalla

### 🛡️ Recomendaciones
Si el escáner detecta vulnerabilidades:
1. **Puerto SMB (445) abierto**: Considera deshabilitarlo si no es necesario
2. **RDP (3389) expuesto**: Usa VPN o cambia el puerto por defecto
3. **SQL Server (1433) abierto**: Configura firewall y autenticación fuerte
4. **Servicios obsoletos (Telnet, FTP)**: Migra a alternativas seguras (SSH, SFTP)

## 🎨 Interfaz

La herramienta utiliza una interfaz de consola mejorada con:
- **Colores ANSI**: Códigos de color para mejor visualización
- **Indicadores visuales**: Verde (OK), Rojo (Peligro), Amarillo (Alerta)
- **Menú interactivo**: Navegación simple por números

## 🐛 Solución de Problemas

### Error: "Necesitas ejecutar esto como Administrador"
**Solución**: Clic derecho en el archivo .bat → "Ejecutar como administrador"

### Los colores no se muestran correctamente
**Solución**: Ejecuta la opción 0 (Configuración Inicial) para habilitar colores ANSI

### BitLocker no se puede verificar
**Causa**: Windows Home no incluye BitLocker
**Solución**: Actualiza a Windows Pro o usa alternativas como VeraCrypt

### El escaneo de red no encuentra dispositivos
**Posibles causas**:
- Firewall bloqueando pings
- Segmento de red incorrecto
- Dispositivos con protección anti-escaneo

## 📝 Registro de Cambios

### Versión 2025
- ✅ Interfaz mejorada con colores ANSI
- ✅ Escaneo de 10 puertos críticos
- ✅ Detección de direcciones MAC
- ✅ Verificación de BitLocker
- ✅ Análisis de actualizaciones de Windows

## 👨‍💻 Autor

**Diego Santos** - 2025
- Desarrollador de ciberseguridad
- Especialista en auditorías de red

## 📄 Licencia

Este proyecto está bajo una licencia de uso libre. Puedes usarlo, modificarlo y distribuirlo libremente para fines legítimos.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar esta herramienta:
1. Fork el proyecto
2. Crea una rama para tu función (`git checkout -b feature/nueva-funcion`)
3. Commit tus cambios (`git commit -am 'Añadir nueva función'`)
4. Push a la rama (`git push origin feature/nueva-funcion`)
5. Crea un Pull Request

## ⭐ Agradecimientos

Gracias a la comunidad de ciberseguridad por su apoyo y feedback continuo.

---

**⚠️ DISCLAIMER**: Esta herramienta está diseñada para uso ético y legal. El autor no se responsabiliza del uso indebido de esta herramienta. Siempre obtén permiso antes de auditar sistemas que no sean de tu propiedad.
