#!/bin/bash

# Git hooks installation script
# This script installs the pre-commit hook for automatic keymap generation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}[INSTALL]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[INSTALL]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[INSTALL]${NC} $1"
}

print_error() {
    echo -e "${RED}[INSTALL]${NC} $1"
}

# Check if we're in a git repository
check_git_repo() {
    if [ ! -d ".git" ]; then
        print_error "Not in a git repository root directory"
        print_error "Please run this script from the project root"
        exit 1
    fi
}

# Backup existing hook if it exists
backup_existing_hook() {
    if [ -f ".git/hooks/pre-commit" ]; then
        local backup_name=".git/hooks/pre-commit.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Existing pre-commit hook found"
        print_info "Backing up to: $backup_name"
        mv ".git/hooks/pre-commit" "$backup_name"
    fi
}

# Install the pre-commit hook
install_hook() {
    if [ ! -f "hooks/pre-commit" ]; then
        print_error "hooks/pre-commit not found"
        print_error "Make sure you're running this from the project root"
        exit 1
    fi

    print_info "Installing pre-commit hook..."
    cp "hooks/pre-commit" ".git/hooks/pre-commit"
    chmod +x ".git/hooks/pre-commit"
    print_success "Pre-commit hook installed successfully!"
}

# Verify installation
verify_installation() {
    if [ -f ".git/hooks/pre-commit" ] && [ -x ".git/hooks/pre-commit" ]; then
        print_success "Hook installation verified ✓"
        return 0
    else
        print_error "Hook installation failed ✗"
        return 1
    fi
}

# Main installation process
main() {
    print_info "Installing git hooks for automatic keymap generation..."
    echo

    check_git_repo
    backup_existing_hook
    install_hook

    if verify_installation; then
        echo
        print_success "Installation complete!"
        echo
        print_info "The pre-commit hook will now:"
        echo "  • Detect changes to config/* files"
        echo "  • Automatically run generate-keymaps.sh"
        echo "  • Add generated files to your commit"
        echo
        print_info "To bypass the hook (if needed): git commit --no-verify"
    else
        exit 1
    fi
}

# Run the installer
main "$@"