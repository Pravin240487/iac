import argparse
def toggle_comments_after_delimiter(input_file, delimiter):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    output_lines = []
    comment_mode = False

    for line in lines:
       #  Check for the delimiter
        if delimiter in line:
            comment_mode = not comment_mode  # Toggle the comment mode

        if comment_mode:
            # If we're in comment mode, add '#' at the start of the line
            output_lines.append(f"# {line}")  # Comment the line
        else:
            # If we're not in comment mode, keep the line as is
            output_lines.append(line)

    # Write the modified lines back to the file
    with open(input_file, 'w') as file:
        file.writelines(output_lines)

def toggle_uncomments_after_delimiter(input_file, delimiter):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    output_lines = []
    comment_mode = False

    for line in lines:
       #  Check for the delimiter
        if delimiter in line:
            comment_mode = not comment_mode  # Toggle the comment mode

        if comment_mode:
            # If we're in comment mode, add '#' at the start of the line
            output_lines.append(line[2:])  # Remove the comment symbol but preserve the rest
        else:
            # If we're not in comment mode, keep the line as is
            output_lines.append(line)

    # Write the modified lines back to the file
    with open(input_file, 'w') as file:
        file.writelines(output_lines)

def t_or_f(arg):
    ua = str(arg).upper()
    if 'TRUE'.startswith(ua):
       return True
    elif 'FALSE'.startswith(ua):
       return False
    else:
       pass  #error condition maybe?

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Comment or uncomment lines after a specified delimiter in a file.')
    parser.add_argument('input_file', type=str, help='Path to the input file')
    parser.add_argument('delimiter', type=str, help='Delimiter to toggle comments after')
    parser.add_argument('comment', type=str, help= "provide either true or false")
    args = parser.parse_args()
    if t_or_f(args.comment):
        toggle_comments_after_delimiter(args.input_file, args.delimiter)
    else:
        toggle_uncomments_after_delimiter(args.input_file, args.delimiter)
