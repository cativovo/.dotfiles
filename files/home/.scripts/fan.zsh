#!/bin/zsh

rpm=$(awk '/^speed:/ {print $2}' /proc/acpi/ibm/fan)

if [ "$rpm" -gt 0 ]; then
    echo '{"text": "󱑭", "class": "on"}'
else
    echo '{"text": "󱑱", "class": "off"}'
fi

