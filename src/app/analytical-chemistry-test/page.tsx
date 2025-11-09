'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function AnalyticalChemistryTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="pharmaceutical" 
        testName="Аналітичної хімії" 
      />
    </AuthGuard>
  );
}
