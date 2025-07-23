# 🧪 Prueba Técnica – Diseño de Arquitectura de Red para Fábrica Automatizada

Esta prueba técnica está pensada para evaluar tu capacidad de análisis, diseño y estructuración de una solución técnica frente a un entorno industrial complejo. No existen respuestas cerradas: buscamos entender cómo abordas un reto de red y arquitectura desde un enfoque técnico, razonado y con orientación a la operación real.

---

## 🏭 Contexto General

Una fábrica va a ser totalmente reestructurada para robotizarla y dotarla de un nuevo sistema. Necesita una arquitectura **resiliente, segura y organizada** para cubrir todas sus necesidades operativas **on-premise**.

!(fábrica)[./testraven.png]

La fábrica cuenta con:

- **Tres líneas de producción automatizadas**, controladas desde un **orquestador central de servicios** ubicados en el centro de datos.
- Cada línea de producción trabaja de forma independiente para **clientes diferentes**.
- Todos los **dispositivos industriales** están conectados a una red **Ethernet TCP/IP** y se comunican con el orquestador vía **HTTPS (puerto 443)**.
- En un **rack de datos**, se aloja un sistema de virtualización que ejecuta servicios internos en puertos como: `80`, `3306`, `9200`, `2049`, `22`. Estos servicios no deben salir de ese rack y quedar confinados al hypervisor.
- En un segundo **rack de comunicaciones**, se centraliza el cableado, la conectividad y todo el hardware de comunicaciones preciso.
- Existen **autómatas** conectados por **WiFi industrial** que usan:
  - `11311/TCP`
  - Rango de puertos entre `7400–7600` (TCP/UDP)
- La fábrica también dispone de **dispositivos IoT y sensores industriales**, que deben ser monitorizados en modo **pull** a través de:
  - `502/TCP` (Modbus)
  - `161/TCP` (SNMP)
- Se requiere acceso de **clientes externos** que interactúan con el orquestador (push/pull de datos).
- Todo el tráfico de entrada al orquestador debe ser cifrado con **punto a punto**.
- Todo el diseño debe funcionar en un entorno **100% on-premise**y la fábrica cuenta con la capacidad eléctrica, cableado y conectividad garantizados.

---

## 🎯 Objetivos de la prueba

Queremos que presentes una propuesta técnica en la que detalles cómo diseñarías **una arquitectura de red completa y segura** para este entorno. Esperamos que tengas en cuenta:

### 🧱 1. Estructura de red

- Segmentación lógica
- Red WiFi para autómatas con los requisitos mencionados
- Integración de los racks de datos y comunicaciones
- Topología general de red

### 🔐 2. Seguridad

- Propuesta de reglas de **firewall**, **en pseudocódigo** o en sintaxis estándar como `iptables`, indicando puertos, protocolos y origen/destino.
- Aislamiento entre zonas de red
- Medidas de autenticación y cifrado (TLS, certificados, ACLs...)

### 📦 3. Servicios necesarios

- ¿Qué elementos o servicios necesitas para implementar la solución?
- ¿Qué software o sistemas utilizarías para asegurar disponibilidad, visibilidad y escalabilidad?

### ⚙️ 4. Resiliencia

- ¿Qué mecanismos propones para asegurar continuidad del servicio?
- ¿Cómo se recupera la operación en caso de cortes de red, caídas de equipos o fallos del orquestador?

### 🧠 5. Análisis y justificación

- Explica tus decisiones técnicas: por qué eliges una estrategia u otra
- Menciona posibles riesgos, carencias y cómo los mitigarías

---

## ✅ Criterios de evaluación

- Claridad y organización del diseño
- Justificación de las decisiones
- Cobertura de requisitos funcionales
- Aplicación de buenas prácticas de arquitectura y seguridad

¡Gracias por tu tiempo y dedicación!

> – Equipo técnico de Ravenloop