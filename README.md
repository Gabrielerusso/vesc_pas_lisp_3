# VESC LISP Script – PAS + Throttle Integration (EU-Compliant)

## Overview

This repository contains a custom **LISP script for VESC firmware** that enables full integration of a **3-wire Pedal Assist Sensor (PAS)**, a **throttle**, and an optional **brake input**, with behavior tailored to meet **EU e-bike regulations (EN15194)**.

This work was developed for a project at **Odisee University (Aalst, Belgium)**, focused on building a **solar-powered electric cargo bike**.

---

## Features

- 🛴 **Walk Assist Mode**  
  Throttle-only operation is allowed **below 6 km/h** for pushing the bike without pedaling.

- 🚴‍♂️ **Pedal Assist**  
  PAS activates motor assistance only **while the user is pedaling**, in line with EU laws.

- 🎚 **Throttle During Pedaling**  
  Throttle can be used to **scale assist level** dynamically during pedal-assist mode.

- 🛑 **Brake Input (Optional)**  
  If connected, the brake input overrides all outputs and immediately disables motor power.

- 🔌 **Signal Routing**  
  - **PAS signal** connected to the **PPM pin** (digital input)
  - **Throttle** connected to **ADC1** (analog input)
  - **Brake (optional)** connected to **ADC2** (analog input)

---

## EU Compliance

This implementation is designed to meet the key technical requirements of the **EN15194** directive:

- Motor assistance is only active while pedaling
- Throttle-only control is limited to **6 km/h max**
- Motor cut-off is possible via brake input (optional)
- Maximum continuous rated power and 25 km/h speed limits must be configured via **VESC Tool**

> ⚠️ Local regulations may vary. It is your responsibility to ensure full legal compliance in your country.

---

## Installation Instructions

1. Open **VESC Tool** and ensure your VESC supports **LISP scripting**.
2. Connect:
   - PAS signal to **PPM input**
   - Throttle to **ADC1**
   - (Optional) Brake to **ADC2**
3. Upload the script and reboot the controller.

---

## Project Context

This script was created as part of a collaborative project with **Odisee University** in Aalst, Belgium, for the development of a **solar-powered electric tricycle** aimed at sustainable mobility.

---

## License

Free to use, modify, and distribute. No warranty or liability provided.

---

## Author

**Gabriele Russo**  
Commissioned for Odisee University (Belgium) solar e-bike project

---

## Contributions

Pull requests and improvements are welcome. Please open an issue for bugs or feature requests.
