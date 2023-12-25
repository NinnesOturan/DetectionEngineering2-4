#!/bin/bash

# Check if the sigmac tool is installed
if ! command -v sigmac &> /dev/null
then
    echo "sigmac could not be found"
    echo "Please install it from PyPI using:"
    echo "pip install sigmatools"
    exit
fi

# Validate all the Sigma rules in the current directory
echo "Converting Sigma rules to Elastalert"
#check-jsonschema --schemafile tests/sigma-schema.json $(find ./rules  -type f -name "*.yml")
#sigmac -t elastalert-dsl -c tests/winlogbeat.yml -r $(find ./rules  -type f -name "*.yml") --output $(find ./ESRules)
for file in rules/*.yml; do
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"
    output_directory="ESRules/$filename.yaml"
    sigmac -t elastalert -c winlogbeat.yml --output "$output_directory" "$file"
done
