#!/bin/bash


# Hàm cài đặt PostgreSQL Server
function install_PostgreSQL {
    if ! dpkg -l | grep -q "postgresql"; then
        echo "PostgreSQL is not installed. Installing PostgreSQL..."
        
        # Install PostgreSQL
        echo "Update system...."
        sudo apt update
        echo "Installing PostgreSQL Server...."
        sudo apt install -y postgresql postgresql-contrib
        
        # Check installation status
        if dpkg -l | grep -q "postgresql"; then
            echo "PostgreSQL has been successfully installed!"
        else
            echo "Error: Failed to install PostgreSQL."
            exit 1
        fi
    else
        echo "PostgreSQL is already installed!"
    fi
}

# Hàm khởi tạo User PostgreSQL Server
function user_PostgreSQL {
    
}
