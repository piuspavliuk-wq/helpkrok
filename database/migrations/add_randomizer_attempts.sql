-- Migration: Add Randomizer PRO attempts system
-- Date: 2025-11-09

-- Update user_subscriptions table to support randomizer type
ALTER TABLE user_subscriptions 
DROP CONSTRAINT IF EXISTS user_subscriptions_subscription_type_check;

ALTER TABLE user_subscriptions 
ADD CONSTRAINT user_subscriptions_subscription_type_check 
CHECK (subscription_type IN ('medical', 'pharmaceutical', 'premium', 'randomizer'));

ALTER TABLE user_subscriptions 
DROP CONSTRAINT IF EXISTS user_subscriptions_status_check;

ALTER TABLE user_subscriptions 
ADD CONSTRAINT user_subscriptions_status_check 
CHECK (status IN ('pending', 'active', 'expired', 'cancelled'));

-- Create randomizer_attempts table
CREATE TABLE IF NOT EXISTS randomizer_attempts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    total_attempts INTEGER NOT NULL DEFAULT 0,
    used_attempts INTEGER NOT NULL DEFAULT 0,
    remaining_attempts INTEGER GENERATED ALWAYS AS (total_attempts - used_attempts) STORED,
    purchase_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE,
    payment_id VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_randomizer_attempts_user_id ON randomizer_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_randomizer_attempts_expires_at ON randomizer_attempts(expires_at);

-- Create randomizer_test_history table
CREATE TABLE IF NOT EXISTS randomizer_test_history (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    faculty VARCHAR(20) CHECK (faculty IN ('medical', 'pharmaceutical')) NOT NULL,
    questions_count INTEGER NOT NULL,
    correct_answers INTEGER NOT NULL,
    score_percentage DECIMAL(5,2) NOT NULL,
    time_spent_seconds INTEGER,
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_randomizer_history_user_id ON randomizer_test_history(user_id);
CREATE INDEX IF NOT EXISTS idx_randomizer_history_completed_at ON randomizer_test_history(completed_at);

-- Add trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_randomizer_attempts_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER randomizer_attempts_updated_at
    BEFORE UPDATE ON randomizer_attempts
    FOR EACH ROW
    EXECUTE FUNCTION update_randomizer_attempts_updated_at();

-- Grant permissions (adjust as needed for your setup)
-- GRANT ALL ON randomizer_attempts TO authenticated;
-- GRANT ALL ON randomizer_test_history TO authenticated;

