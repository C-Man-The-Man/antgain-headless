#!/bin/bash

# Minimal AntGain manager script with auto-start at boot
# Usage: ./antgain.sh install API_KEY
#        ./antgain.sh uninstall
#        ./antgain.sh enable-autostart
#        ./antgain.sh disable-autostart

INSTALL_PATH="/usr/bin/AntGain"
RUN_SCRIPT="$HOME/run_antgain.sh"
LOG_FILE="$HOME/antgain.log"
PID_FILE="$HOME/antgain.pid"
SERVICE_FILE="$HOME/.config/systemd/user/antgain.service"

case "$1" in
  install)
    API_KEY="$2"
    if [ -z "$API_KEY" ]; then
      echo "Error: API key required"
      exit 1
    fi

    # Create a small detached run script
    mkdir -p "$HOME"
    cat > "$RUN_SCRIPT" <<EOF
#!/bin/bash
$INSTALL_PATH --api-key $API_KEY >> "$LOG_FILE" 2>&1 &
echo \$! > "$PID_FILE"
EOF
    chmod +x "$RUN_SCRIPT"

    # Run detached
    bash "$RUN_SCRIPT"
    echo "AntGain running detached (PID: $(cat $PID_FILE))"
    echo "Logs at: $LOG_FILE"
    ;;

  uninstall)
    if [ -f "$PID_FILE" ]; then
      PID=$(cat "$PID_FILE")
      echo "Stopping AntGain (PID $PID)..."
      kill "$PID"
      rm -f "$PID_FILE"
    else
      echo "No PID file found, AntGain may not be running"
    fi

    # Remove run script
    rm -f "$RUN_SCRIPT"

    # Remove autostart service if exists
    if [ -f "$SERVICE_FILE" ]; then
      systemctl --user disable antgain.service 2>/dev/null
      rm -f "$SERVICE_FILE"
    fi

    echo "AntGain fully uninstalled."
    ;;

  enable-autostart)
    if [ ! -f "$RUN_SCRIPT" ]; then
      echo "Error: Run script not found. Install first."
      exit 1
    fi

    mkdir -p "$(dirname "$SERVICE_FILE")"
    cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=AntGain Headless Node
After=network.target

[Service]
Type=forking
ExecStart=$RUN_SCRIPT
Restart=on-failure

[Install]
WantedBy=default.target
EOF

    systemctl --user daemon-reload
    systemctl --user enable antgain.service
    systemctl --user start antgain.service
    echo "AntGain autostart enabled (systemd user service)."
    ;;

  disable-autostart)
    if [ -f "$SERVICE_FILE" ]; then
      systemctl --user stop antgain.service
      systemctl --user disable antgain.service
      rm -f "$SERVICE_FILE"
      echo "AntGain autostart disabled."
    else
      echo "Autostart service not found."
    fi
    ;;

  *)
    echo "Usage: $0 install API_KEY | uninstall | enable-autostart | disable-autostart"
    ;;
esac

