#!/bin/bash

# Database Setup Script for Help Krok Platform
# This script helps you set up the database for the Telegram authentication system

echo "🚀 Help Krok Platform - Database Setup"
echo "======================================"

# Check if .env.local exists
if [ ! -f ".env.local" ]; then
    echo "❌ .env.local file not found!"
    echo "📋 Please copy env.example to .env.local and configure your database:"
    echo "   cp env.example .env.local"
    echo "   # Then edit .env.local with your database credentials"
    exit 1
fi

echo "✅ .env.local file found"

# Check if DATABASE_URL is set
if ! grep -q "DATABASE_URL=" .env.local; then
    echo "❌ DATABASE_URL not found in .env.local"
    echo "📋 Please add your database URL to .env.local:"
    echo "   DATABASE_URL=\"postgresql://username:password@localhost:5432/help_krok_platform?schema=public\""
    exit 1
fi

echo "✅ DATABASE_URL configured"

# Generate Prisma client
echo "🔧 Generating Prisma client..."
npx prisma generate

if [ $? -eq 0 ]; then
    echo "✅ Prisma client generated successfully"
else
    echo "❌ Failed to generate Prisma client"
    exit 1
fi

# Push database schema
echo "🗄️  Pushing database schema..."
npx prisma db push

if [ $? -eq 0 ]; then
    echo "✅ Database schema pushed successfully"
else
    echo "❌ Failed to push database schema"
    echo "💡 Make sure your database is running and accessible"
    exit 1
fi

echo ""
echo "🎉 Database setup completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Run: npm run dev"
echo "2. Run: ngrok http 3000"
echo "3. Update BotFather with your ngrok URL"
echo "4. Test the Telegram authentication"
echo ""
echo "📚 For detailed instructions, see TELEGRAM_AUTH_SETUP.md"
