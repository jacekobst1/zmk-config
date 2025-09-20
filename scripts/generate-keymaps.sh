#!/bin/bash

# Generate keymap YAML and SVG files for all keymap configs
# Usage: ./scripts/generate-keymaps.sh

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required commands exist
check_dependencies() {
    if ! command -v keymap &> /dev/null; then
        print_error "keymap command not found. Please install keymap-drawer."
        print_error "You can install it with: pip install keymap-drawer"
        exit 1
    fi
}

# Main function
main() {
    print_status "Starting keymap generation process..."

    # Check dependencies
    check_dependencies

    # Ensure output directory exists
    mkdir -p tools/keymap-drawer

    # Find all .keymap files in config directory
    keymap_files=(config/*.keymap)

    if [ ! -e "${keymap_files[0]}" ]; then
        print_error "No .keymap files found in config/ directory"
        exit 1
    fi

    total_files=${#keymap_files[@]}
    print_status "Found $total_files keymap file(s) to process"

    success_count=0
    error_count=0

    # Process each keymap file
    for keymap_file in "${keymap_files[@]}"; do
        # Extract base name (e.g., cradio from config/cradio.keymap)
        base_name=$(basename "$keymap_file" .keymap)

        print_status "Processing $base_name..."

        # Define output files
        yaml_file="tools/keymap-drawer/${base_name}.yaml"
        svg_file="tools/keymap-drawer/${base_name}.svg"

        # Generate YAML file
        print_status "  Parsing $keymap_file -> $yaml_file"
        if keymap parse -c 10 -z "$keymap_file" > "$yaml_file" 2>/dev/null; then
            print_success "  Generated $yaml_file"
        else
            print_error "  Failed to parse $keymap_file"
            ((error_count++))
            continue
        fi

        # Generate SVG file
        print_status "  Drawing $yaml_file -> $svg_file"
        if keymap draw "$yaml_file" > "$svg_file" 2>/dev/null; then
            print_success "  Generated $svg_file"
            ((success_count++))
        else
            print_error "  Failed to draw $yaml_file"
            ((error_count++))
            # Clean up the yaml file if SVG generation failed
            rm -f "$yaml_file"
        fi

        echo  # Empty line for readability
    done

    # Summary
    echo "=================================="
    if [ $success_count -eq $total_files ]; then
        print_success "All $total_files keymap(s) processed successfully!"
    else
        print_warning "$success_count/$total_files keymap(s) processed successfully"
        if [ $error_count -gt 0 ]; then
            print_error "$error_count keymap(s) failed to process"
        fi
    fi

    if [ $error_count -gt 0 ]; then
        exit 1
    fi
}

# Run main function
main "$@"