import socket
import subprocess
import sys
from datetime import datetime

remote_host = input("Enter a host to check:")
host_ip = socket.gethostbyname(remote_host)
port_range_input = input("Enter a range of ports to check:")
port_range = port_range_input.split("-")
start_port = int(port_range[0])
end_port = int(port_range[1])

print("Please wait, scanning host... (this can take some time)")

start_time = datetime.now()

try:
    for port in range(start_port, end_port):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex((host_ip, port))
        if result == 0:
            print("Port {}: Open | Service: {}".format(port, socket.getservbyport(port)))
        else:
            print("Port {}: Closed".format(port))
        sock.close()

except KeyboardInterrupt:
    print("Interrupted with CTRL+C")
    sys.exit()

except socket.error:
    print("Couldn't connect to server.")
    sys.exit()

finish_time = datetime.now()

time = finish_time - start_time

print("Scan comleted in {}.".format(time))


