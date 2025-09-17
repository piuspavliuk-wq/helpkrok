#!/bin/bash

# Quick Start Script for Help Krok Platform
# This script helps you quickly start the development environment

echo "🚀 Help Krok Platform - Quick Start"
echo "=================================="

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ Failed to install dependencies"
        exit 1
    fi
    echo "✅ Dependencies installed"
else
    echo "✅ Dependencies already installed"
fi

# Check if .env.local exists
if [ ! -f ".env.local" ]; then
    echo "⚠️  .env.local not found!"
    echo "📋 Please copy env.example to .env.local and configure:"
    echo "   cp env.example .env.local"
    echo "   # Then edit .env.local with your settings"
    echo ""
    echo "🔧 Required settings:"
    echo "   - DATABASE_URL (PostgreSQL connection string)"
    echo "   - NEXTAUTH_SECRET (random secret key)"
    echo "   - TELEGRAM_BOT_TOKEN (already configured)"
    echo ""
    read -p "Press Enter after configuring .env.local..."
fi

# Check if database is set up
if [ ! -f ".env.local" ] || ! grep -q "DATABASE_URL=" .env.local; then
    echo "❌ Database not configured"
    echo "📋 Please set up your database first:"
    echo "   ./setup-db.sh"
    exit 1
fi

echo "✅ Environment configured"

# Start the development server
echo "🚀 Starting development server..."
echo "📱 Open http://localhost:3000 in your browser"
echo "🔗 Run 'ngrok http 3000' in another terminal for Telegram testing"
echo ""

npm run dev
