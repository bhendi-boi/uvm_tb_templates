import pandas as pd


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
    print("Opening interface.sv")
    file = open("interface.sv", "w+")

    has_clk_as_input = input(
        "Do you wish to have clk as an input to the interface (y/n)"
    )

    if has_clk_as_input == "y" or has_clk_as_input == "":
        clk_port_name = input("Enter your clk port name (case sensitive) ")
        print(clk_port_name)
        if clk_port_name not in input_ports["port_name"].values:
            clk_port_name = input(
                f"Unable to find {clk_port_name}. Please enter clk port name again "
            )
            if clk_port_name not in input_ports["port_name"].values:
                print(f"Unable to find {clk_port_name}. Closing interface.sv")
                file.close()
                print("Abort")
                return
        else:
            file.write(f"interface intf (input logic {clk_port_name});\n")

    else:
        file.write("interface intf ();\n")
    file.write("\t// input ports\n")

    # add input ports
    for _, row in input_ports.iterrows():
        port_name = row["port_name"]
        logic_or_bit = row["logic_or_bit"]
        no_of_bits = row["no_of_bits"]

        # if clk is a input port for the interface, don't add it again.
        if has_clk_as_input == "y" or has_clk_as_input == "":
            if port_name == clk_port_name:
                continue

        if no_of_bits == 1:
            if logic_or_bit:
                file.write(f"\tlogic {port_name};\n")
            else:
                file.write(f"\tbit {port_name};\n")
        else:
            high = no_of_bits - 1
            if logic_or_bit:
                file.write(f"\tlogic [{high}:0] {port_name};\n")
            else:
                file.write(f"\tbit [{high}:0] {port_name};\n")

    file.write("\n\t// output ports\n")

    # add output ports
    for _, row in output_ports.iterrows():
        port_name = row["port_name"]
        logic_or_bit = row["logic_or_bit"]
        no_of_bits = row["no_of_bits"]

        if no_of_bits == 1:
            if logic_or_bit:
                file.write(f"\tlogic {port_name};\n")
            else:
                file.write(f"\tbit {port_name};\n")
        else:
            high = no_of_bits - 1
            if logic_or_bit:
                file.write(f"\tlogic [{high}:0] {port_name};\n")
            else:
                file.write(f"\tbit [{high}:0] {port_name};\n")

    file.write("endinterface : intf\n")
    file.close()

    print("Populated interface with port information")


def write_to_seq_item(input_ports, output_ports):
    print("Opening seq_item.sv")
    file = open("seq_item.sv", "r")
    raw_content = file.readlines()
    file.close()

    clk_port_name = input(
        "Please enter clk port name. We ask this to omit clk port from seq_item. "
    )
    if clk_port_name not in input_ports["port_name"].values:
        clk_port_name = input(
            f"Unable to find {clk_port_name}.Please enter clk port name again. "
        )
        if clk_port_name not in input_ports["port_name"].values:
            print(f"Unable to find {clk_port_name}. Closing seq_item.sv")
            file.close()
            print("Abort")
            return

    input_port_content = ""
    # add input ports
    for _, row in input_ports.iterrows():
        port_name = row["port_name"]
        logic_or_bit = row["logic_or_bit"]
        no_of_bits = row["no_of_bits"]

        # not declaring clk port
        if port_name == clk_port_name:
            continue

        if no_of_bits == 1:
            if logic_or_bit:
                input_port_content += f"\trand logic {port_name};\n"
            else:
                input_port_content += f"\trand bit {port_name};\n"
        else:
            high = no_of_bits - 1
            if logic_or_bit:
                input_port_content += f"\trand logic [{high}:0] {port_name};\n"
            else:
                input_port_content += f"\trand bit [{high}:0] {port_name};\n"

    raw_content[4] += input_port_content

    output_port_content = ""
    # add input ports
    for _, row in output_ports.iterrows():
        port_name = row["port_name"]
        logic_or_bit = row["logic_or_bit"]
        no_of_bits = row["no_of_bits"]

        if no_of_bits == 1:
            if logic_or_bit:
                output_port_content += f"\tlogic {port_name};\n"
            else:
                output_port_content += f"\tbit {port_name};\n"
        else:
            high = no_of_bits - 1
            if logic_or_bit:
                output_port_content += f"\tlogic [{high}:0] {port_name};\n"
            else:
                output_port_content += f"\tbit [{high}:0] {port_name};\n"

    raw_content[7] += output_port_content

    new_raw_content = ""
    for line in raw_content:
        new_raw_content += line

    file = open("seq_item.sv", "w")
    file.write(new_raw_content)
    file.close()
    print("Populated seq_item with port information.")


def write_to_testbench(input_ports, output_ports, parameters, dut_name):
    dut_instantiation = "\t"

    dut_instantiation += dut_name
    dut_instantiation += " dut"

    if len(parameters) > 0:
        dut_instantiation += "#(\n"
        for i, row in parameters.iterrows():
            name = row["name"]
            default = row["default"]
            value = row["default_val"]

            if not default:
                value = input(f"Please enter value for parameter {name}: ")

            dut_instantiation += f"\t\t{name}={value}"

            if i != (len(parameters) - 1):
                dut_instantiation += ",\n"
            else:
                dut_instantiation += "\n"
        dut_instantiation += "\t)"

    dut_instantiation += "(\n"

    for i, row in input_ports.iterrows():
        port_name = row["port_name"]
        dut_instantiation += f"\t\t.{port_name}(vif.{port_name})"
        dut_instantiation += ",\n"

    for i, row in output_ports.iterrows():
        port_name = row["port_name"]
        dut_instantiation += f"\t\t.{port_name}(vif.{port_name})"

        if i != (len(output_ports) - 1):
            dut_instantiation += ","

        dut_instantiation += "\n"

    dut_instantiation += "\t);"
    dut_instantiation += "\n"

    print("Opening testbench.sv")
    file = open("testbench.sv", "r")
    raw_lines = file.readlines()
    file.close()

    raw_lines[27] = dut_instantiation

    new_file_as_string = ""

    for i in raw_lines:
        new_file_as_string += i

    print("Writing this dut instantiation to testbench.sv")
    print("\n")
    print(dut_instantiation)
    print("\n")

    file = open("testbench.sv", "w")
    file.write(new_file_as_string)
    file.close()
    print("Closing testbench.sv")


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

    # module has 6 characters
    dut_name = (content.split("(")[0])[6:]

    # retrieve port content
    temp = content.split("(")[1]  # first member is always module module_name

    # retrieve parameter info
    parameters = pd.DataFrame(
        {
            "name": pd.Series(dtype="str"),
            "default": pd.Series(dtype=bool),
            "default_val": pd.Series(dtype=int),
        }
    )
    if temp.startswith("parameter"):

        dut_name = dut_name[:-1]  # has # as the last char
        print(f"DUT name: {dut_name}")
        parameter_text = temp
        temp = content.split("(")[2]  # module has parameters
        parameters_raw = parameter_text.split(",")

        print("Modules has parameters")
        for raw_parameter in parameters_raw:
            # parameter has 9 characters
            pieces = raw_parameter.split("=")

            name = pieces[0][9:]
            if name.endswith(")"):
                name = name[:-1]  # last parameter will have ) at the end

            default = False
            if len(pieces) > 1:
                default = True

            default_value = -1
            if default:
                default_value = pieces[1]

            new_parameter = {
                "name": name,
                "default": default,
                "default_val": default_value,
            }

            parameters.loc[len(parameters)] = new_parameter

        print("\n")
        print("Found these parameters (-1 indicated no default value)\n")
        print(parameters)
        print("\n")

    if len(parameters) == 0:
        print(f"DUT name: {dut_name}")

    port_content = temp.split(")")[0]
    port_content_list = port_content.split(",")

    # inputs map
    # key is port name and val is no of bits per port
    inputs_df = pd.DataFrame(
        {
            "port_name": pd.Series(dtype="str"),  # Or 'object'
            "logic_or_bit": pd.Series(dtype="bool"),  # Or 'int' if it's an integer
            "no_of_bits": pd.Series(dtype="int"),
        }
    )
    outputs_df = pd.DataFrame(
        {
            "port_name": pd.Series(dtype="str"),  # Or 'object'
            "logic_or_bit": pd.Series(dtype="bool"),  # Or 'int' if it's an integer
            "no_of_bits": pd.Series(dtype="int"),
        }
    )

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

            new_port = {
                "port_name": port_name,
                "logic_or_bit": 1,
                "no_of_bits": no_of_bits,
            }
            inputs_df.loc[len(inputs_df)] = new_port

        if port.startswith(input_matchings[1]):
            str_len = len(input_matchings[1])
            port_name_with_bits = port[str_len:]
            port_name_bits_split = port_name_with_bits.split("]")

            [port_name, no_of_bits] = get_port_name_and_no_of_bits(
                port_name_bits_split=port_name_bits_split
            )

            new_port = {
                "port_name": port_name,
                "logic_or_bit": 0,
                "no_of_bits": no_of_bits,
            }
            inputs_df.loc[len(inputs_df)] = new_port

        if port.startswith(output_matchings[0]):
            str_len = len(output_matchings[0])
            port_name_with_bits = port[str_len:]
            port_name_bits_split = port_name_with_bits.split("]")

            [port_name, no_of_bits] = get_port_name_and_no_of_bits(
                port_name_bits_split=port_name_bits_split
            )
            new_port = {
                "port_name": port_name,
                "logic_or_bit": 1,
                "no_of_bits": no_of_bits,
            }
            outputs_df.loc[len(outputs_df)] = new_port

        if port.startswith(output_matchings[1]):
            str_len = len(output_matchings[1])
            port_name_with_bits = port[str_len:]
            port_name_bits_split = port_name_with_bits.split("]")

            [port_name, no_of_bits] = get_port_name_and_no_of_bits(
                port_name_bits_split=port_name_bits_split
            )
            new_port = {
                "port_name": port_name,
                "logic_or_bit": 0,
                "no_of_bits": no_of_bits,
            }
            outputs_df.loc[len(outputs_df)] = new_port

    print("\n\n")
    print("Found these input ports\n")
    print(inputs_df)
    print("\n\n")

    print("Found these output ports\n")
    print(outputs_df)
    print("\n\n")

    should_write_to_interface = input(
        "Do you wish to populate interface with these ports? (y/n)"
    )
    if should_write_to_interface == "y" or should_write_to_interface == "":
        write_to_interface(inputs_df, outputs_df)

    print("\n")
    should_write_to_seq_item = input(
        "Do you wish to populate seq_item with these ports? (y/n)"
    )
    if should_write_to_seq_item == "y" or should_write_to_seq_item == "":
        write_to_seq_item(inputs_df, outputs_df)

    print("\n")
    should_write_to_testbench = input(
        "Do you wish to update testbench with dut instantiation (y/n)?"
    )
    if should_write_to_testbench == "y" or should_write_to_testbench == "":
        write_to_testbench(inputs_df, outputs_df, parameters, dut_name)


if __name__ == "__main__":
    main()