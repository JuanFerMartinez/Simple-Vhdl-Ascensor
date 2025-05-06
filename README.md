# Simple VHDL Elevator

Este proyecto implementa un sistema de ascensor básico en VHDL, diseñado para funcionar de manera simple en una protoboard utilizando una FPGA Cyclone III (DE0) u otra compatible.
El sistema no controla motores reales; únicamente simula la lógica de un ascensor mediante botones, LEDs y displays de 7 segmentos.

## Características

- Simulación de un ascensor de 5 pisos.
- Uso de botones externos para seleccionar pisos.
- Indicación del piso actual en displays de 7 segmentos.
- Simulación de apertura y cierre de puertas.
- Control de estados de manera secuencial sin motores ni actuadores físicos.
- Implementado en protoboard.

## Estructura

El proyecto incluye los siguientes archivos principales en VHDL:

- `ascensor_main.vhd`: módulo principal que coordina el sistema.
- `puerta.vhd`: control de apertura y cierre de puertas.
- `mostrar_piso.vhd`: visualización del piso actual en displays de 7 segmentos.
- `anomalias.vhd`: manejo de situaciones anómalias.
- Otros módulos auxiliares.

## Requisitos

- FPGA Cyclone III (DE0) o similar.
- Entorno de desarrollo Quartus II 13.1 o compatible.
- Protoboard para conexiones simples (botones y LEDs).

## Notas

Este proyecto fue implementado como una simulación funcional básica. No se utilizaron motores, sensores de movimiento ni sistemas mecánicos. Todo el control es lógico y está orientado a la práctica de diseño digital con VHDL.

