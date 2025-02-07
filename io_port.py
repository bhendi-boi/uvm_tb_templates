def get_port_name_and_no_of_bits(port_name_bits_split: len):
    port_name = ""
    no_of_bits = 1
    if len(port_name_bits_split) == 1:
        port_name = port_name_bits_split[0]
        no_of_bits = 1
    else:
        port_name = port_name_bits_split[1]
        bits_info = port_name_bits_split[0]

        # removing [
        bits_info = bits_info[1:]
        low = int(bits_info.split(":")[1])
        high = int(bits_info.split(":")[0])

        # using abs to address [0:10] declarations as well
        no_of_bits = abs(high - low) + 1
    return [port_name, no_of_bits]


def write_to_interface(input_ports, output_ports):
    file = open("interface.sv", "w+")
    file.write("interface intf ();\n")

    file.write("\t// input ports\n")
    # add input ports
    for port_name in input_ports.keys():
        if input_ports[port_name] == 1:
            file.write(f"\tlogic {port_name};\n")
        else:
            high = input_ports[port_name] - 1
            file.write(f"\tlogic [{high}:0] {port_name};\n")

    file.write("\n\t// output ports\n")
    # add output ports
    for port_name in output_ports.keys():
        if output_ports[port_name] == 1:
            file.write(f"\tlogic {port_name};\n")
        else:
            high = output_ports[port_name] - 1
            file.write(f"\tlogic [{high}:0] {port_name};\n")

    file.write("endinterface : intf\n")
    file.close()


def main():

    # Taking filename as a parameter
    file_name = input(
        "Enter design file name (Hit enter to consider default `design.sv`)"
    )
    if file_name == "":
        file_name = "design.sv"

    print(f"Opening {file_name}")

    try:
        file = open(file_name, "r")
    except:
        print("File not found")
        return  # Quitting if file is not found

    raw_content_as_lines = file.readlines()
    raw_content = ""
    file.close()

    print(f"Read {file_name}")

    # removing EOLs
    for line in raw_content_as_lines:
        line_without_eol = line.removesuffix("\n")
        raw_content += line_without_eol

    # removing empty spaces
    content = ""
    for char in raw_content:
        if char != " ":
            content += char

    print("Sanitised contents")

    # retrieve port content
    temp = content.split("(")[1]  # first member is always module module_name
    if temp.startswith("parameter"):
        temp = content.split("(")[2]  # module has parameters

    port_content = temp.split(")")[0]
    port_content_list = port_content.split(",")

    # inputs map
    # key is port name and val is no of bits per port
    inputs_map = dict()
    outputs_map = dict()

    input_matchings = ["inputlogic", "inputbit"]
    output_matchings = ["outputlogic", "outputbit"]

    for port in port_content_list:
        port_name = ""
        no_of_bits = 1
        if port.startswith(input_matchings[0]):
            str_len = len(input_matchings[0])
            port_name_with_bits = port[str_len:]
            port_name_bits_split = port_name_with_bits.split("]")

            [port_name, no_of_bits] = get_port_name_and_no_of_bits(
                port_name_bits_split=port_name_bits_split
            )

            inputs_map[port_name] = no_of_bits
        if port.startswith(output_matchings[0]):
            str_len = len(output_matchings[0])
            port_name_with_bits = port[str_len:]
            port_name_bits_split = port_name_with_bits.split("]")

            [port_name, no_of_bits] = get_port_name_and_no_of_bits(
                port_name_bits_split=port_name_bits_split
            )

            outputs_map[port_name] = no_of_bits

    print("Found these input ports")
    print(inputs_map)

    print("Found these output ports")
    print(outputs_map)

    write_to_interface(inputs_map, outputs_map)


if __name__ == "__main__":
    main()
