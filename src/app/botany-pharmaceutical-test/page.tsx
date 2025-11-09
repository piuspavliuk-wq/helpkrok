'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function BotanyPharmaceuticalTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="botany-pharmaceutical" 
        testName="Ботаніка" 
      />
    </AuthGuard>
  );
}
