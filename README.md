# AntGain Headless Installer for Linux (x86_64)

This repository provides a minimal headless installer script for running [AntGain](https://link.antgain.app/MA0RCSZ3) on Linux systems. The script allows you to:

- Install AntGain in a detached, headless mode
- Run it automatically on system boot
- View logs easily
- Uninstall cleanly

Supported architectures: x86_64 only. ARM systems (Raspberry Pi, etc.) are not supported.

---

## Features

- Headless operation: No GUI or interactive control needed. All monitoring and management is done via the AntGain dashboard.
- Detached execution: Runs in the background, terminal is free for other tasks.
- Autostart support: Can enable or disable automatic launch on login using systemd user services.
- Minimal dependencies: Works on a clean Ubuntu/Debian installation, but some optional libraries may be needed depending on your system.

---

## Optional Libraries

Some systems may require these libraries for proper operation:

- `libgtk-3-0`
- `libgdk-pixbuf2.0-0`
- `libayatana-appindicator3-1` or `libappindicator3-1`

On Ubuntu/Debian you can install them with:

```bash
sudo apt install libgtk-3-0 libgdk-pixbuf2.0-0 libayatana-appindicator3-1
```

---

## Quick Installation

### 1. Download the script

```bash
wget https://github.com/<YOUR_USERNAME>/antgain-headless/raw/main/antgain.sh
chmod +x antgain.sh
```


### 2. Install AntGain with your API key

```bash
./antgain.sh install YOUR_API_KEY
```


The script will download the latest AntGain binary, start it in detached mode, and store logs at `~/antgain.log`.

### 3. Check logs

```bash
tail -f ~/antgain.log
```


### 4. Enable autostart (optional)

```bash
./antgain.sh enable-autostart
```


### 5. Disable autostart (optional)

```bash
./antgain.sh disable-autostart
```


### 6. Uninstall AntGain

```bash
./antgain.sh uninstall
```

---

## Benefits of Using the Script

- No need for GUI environments
- Runs minimalistic headless nodes on Linux
- Works detached so your terminal stays free
- Easy management via logs and systemd autostart
- Clean uninstallation procedure

---

## Notes

- Only tested on x86_64 Ubuntu/Debian-based distributions.
- ARM or other architectures are not supported.
- The script is designed to work even if some optional libraries are already installed on your system.

---

Use https://link.antgain.app/MA0RCSZ3 to create your Antgain account if you found this repository helpful.

---

## Donations

**Bitcoin wallet address**
```text
bc1qpcfex53u7mqx4dc25gw7j7446amw9vn6743cn5
```

**EVM / Metamask  (ETH, ETC, OCTA, POL, PEAQ, MONAD, BASE etc.)**
```text
0xbE4879888d95B02B2FCaed2FcAeBbcf36829BDC9
```

**Solana wallet address**
```text
7EHWvShXfjLJ2HhzTf4CsHgjKckivfMQMjnEoUAEqau
```

**Sui wallet address**
```text
0x421a5a462f99c2d675d035d0c741ba5765a47c1e28f95d33ad770cd34a36a6ea
```

**Thank you!**
