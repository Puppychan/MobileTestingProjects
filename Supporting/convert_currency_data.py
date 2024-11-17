import json

# File paths
file1_path = "flag_currencies.json"
file2_path = "rendered_currencies.json"
file3_path = "final_currencies.json"

# Load File 1 content
with open(file1_path, "r", encoding="utf-8") as file1:
    file1_content = json.load(file1)

# Load File 2 content
with open(file2_path, "r", encoding="utf-8") as file2:
    file2_content = json.load(file2)

# Add "symbol" from File 2 to File 1
for entry in file1_content:
    code = entry.get("code")
    if code in file2_content:
        entry["symbol"] = file2_content[code]["symbol"]

# Export to File 3
with open(file3_path, "w", encoding="utf-8") as file3:
    json.dump(file1_content, file3, ensure_ascii=False, indent=4)

print(f"File 3 has been created: {file3_path}")
