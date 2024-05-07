#!/usr/bin/env python3
import subprocess
import sys


def is_single_port(argument):
    """Check if the argument is a single port number."""
    return argument.isdigit()


def is_port_range(argument):
    """Check if the argument is a port range like '3000-3100'."""
    if "-" in argument:
        parts = argument.split("-")
        if len(parts) == 2 and all(part.isdigit() for part in parts):
            return True
    return False


def remote_ssh(host, *args):
    if len(args) == 0:
        # If there are no additional arguments, simple SSH without port forwarding
        ssh_command = ["ssh", host]
    else:
        first_arg = args[0]
        if is_single_port(first_arg):
            # Single port forwarding
            port = int(first_arg)
            forwards = [f"-L {port}:localhost:{port}"]
            ssh_options = args[1:]  # Treat remaining arguments as SSH options
            ssh_command = ["ssh", host] + forwards + list(ssh_options)
        elif is_port_range(first_arg):
            # Handle port forwarding if a valid range is provided
            start_port, end_port = map(int, first_arg.split("-"))
            forwards = [
                f"-L {port}:localhost:{port}"
                for port in range(start_port, end_port + 1)
            ]
            ssh_options = args[1:]  # Treat remaining arguments as SSH options
            ssh_command = ["ssh", host] + forwards + list(ssh_options)
        else:
            # No port forwarding; treat all as SSH options
            ssh_command = ["ssh", host] + list(args)

    # Executing the SSH command
    print(f"Executing SSH command: {' '.join(ssh_command)}")
    process = subprocess.run(ssh_command)

    # Return the process return code
    return process.returncode


def main():
    if len(sys.argv) < 2:
        print(
            "Usage: ./remote_ssh.py <host> [port_number|port_range] [additional ssh options]"
        )
        sys.exit(1)

    # Extracting host and all subsequent arguments
    host = sys.argv[1]
    additional_params = sys.argv[2:]

    # Pass parameters to `remote_ssh`
    return_code = remote_ssh(host, *additional_params)
    sys.exit(return_code)


if __name__ == "__main__":
    main()
