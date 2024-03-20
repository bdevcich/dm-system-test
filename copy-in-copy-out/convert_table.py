#!/usr/bin/env python3

import sys
import json
import re

def markdown_table_to_json(md_table):
    # Split the markdown table into rows
    rows = md_table.strip().split('\n')
    
    # Extract header and data rows
    header = rows[0].split('|')[1:-1]
    data = [row.split('|')[1:-1] for row in rows[2:]]  # Exclude first and last rows (header separator and empty row)
    
    # Convert to JSON
    json_data = []
    for row in data:
        json_row = {}
        for i, value in enumerate(row):
            json_row[header[i].strip()] = value.strip()
        json_data.append(json_row)
    
    return json_data

def write_json_to_file(json_data, filename):
    with open(filename, 'w') as f:
        json.dump(json_data, f, indent=4)

def read_markdown_table_from_file(filename):
    with open(filename, 'r') as f:
        return f.read()

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python convert_table2.py my_table.md my_table.json")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    # Read markdown table from input file
    markdown_table = read_markdown_table_from_file(input_file)

    # Check if the input string is a valid markdown table
    if not re.match(r'^\|(.*\|)+\s*$', markdown_table, re.MULTILINE):
        print("Error: Input is not a valid markdown table.")
        sys.exit(1)

    json_data = markdown_table_to_json(markdown_table)
    write_json_to_file(json_data, output_file)
    print("Conversion successful. JSON data has been written to", output_file)
