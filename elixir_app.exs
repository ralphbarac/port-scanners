# Basic Structure
## Ask user for host and port numbers
## spawn process for each port number
## attempt to connect, if successfull report that, otherwise report error

remote_host = String.trim(IO.gets("Enter a host to check:"), "\n")
host = String.to_charlist(remote_host)
port_range_input = IO.gets("Enter a range of ports to check:")
port_range_list = String.split(port_range_input, "-")
start_port = Enum.at(port_range_list, 0)
end_port = Enum.at(port_range_list, 1) |> String.trim("\n")
port_range = Range.new(String.to_integer(start_port), String.to_integer(end_port))
options = [:binary, :inet, active: false]

IO.puts("Please wait, scanning host... (this can take some time)")

start_time = :erlang.now()

Enum.each port_range, fn x -> 
    case :gen_tcp.connect(host, x, options) do
        {:ok, _socket} ->
            IO.puts("Port #{x}: Open")
        {:error, _data} ->
            IO.puts("Port #{x}: Closed")
    end
end

finish_time = :erlang.now()
time = :timer.now_diff(finish_time, start_time) /1000000
IO.puts("Scan completed in #{time} seconds.")
