#!/bin/bash

services=()

# Register a service
register_service() {
    alias=$1
    script_path=$2
    services["$alias"]=$script_path
    echo "Registered service '$alias'."
}

# Start a service
start_service() {
    alias=$1
    if [[ -z ${services[$alias]} ]]; then
        echo "Service '$alias' is not registered."
        return
    fi
    script_path=${services[$alias]}
    nohup python3 "$script_path" >/dev/null 2>&1 &
    echo "Started service '$alias'."
}

# Show the status of a service
show_service_status() {
    alias=$1
    if [[ -z $(pgrep -f "${services[$alias]}") ]]; then
        echo "Service '$alias' is not running."
    else
        echo "Service '$alias' is running."
    fi
}

# Stop a service
stop_service() {
    alias=$1
    if [[ -z $(pgrep -f "${services[$alias]}") ]]; then
        echo "Service '$alias' is not running."
        return
    fi
    pkill -f "${services[$alias]}"
    echo "Stopped service '$alias'."
}

# Change the priority of a service
change_service_priority() {
    alias=$1
    priority=$2
    if [[ -z $(pgrep -f "${services[$alias]}") ]]; then
        echo "Service '$alias' is not running."
        return
    fi
    renice "$priority" -p $(pgrep -f "${services[$alias]}")
    echo "Changed priority of service '$alias' to '$priority'."
}

# List the details of a service
list_service_details() {
    alias=$1
    if [[ -z ${services[$alias]} ]]; then
        echo "Service '$alias' is not registered."
        return
    fi
    script_path=${services[$alias]}
    echo "Service '$alias' is registered with script path '$script_path'."
}

# Main program loop
while true; do
    echo "Enter a command: register, start, status, stop, priority, list, or quit"
    read command

    case $command in
        register)
            echo "Enter service alias:"
            read alias
            echo "Enter script path:"
            read script_path
            register_service "$alias" "$script_path"
            ;;
        start)
            echo "Enter service alias:"
            read alias
            start_service "$alias"
            ;;
        status)
            echo "Enter service alias:"
            read alias
            show_service_status "$alias"
            ;;
        stop)
            echo "Enter service alias:"
            read alias
            stop_service "$alias"
            ;;
        priority)
            echo "Enter service alias:"
            read alias
            echo "Enter priority value:"
            read priority
            change_service_priority "$alias" "$priority"
            ;;
        list)
            echo "Enter service alias:"
            read alias
            list_service_details "$alias"
            ;;
        quit)
            exit 0
            ;;
        *)
            echo "Invalid command. Please try again."
            ;;
    esac
done

