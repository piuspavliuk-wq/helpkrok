'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function PathophysiologyPharmaceuticalTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="pathophysiology-pharmaceutical" 
        testName="Патофізіологія" 
      />
    </AuthGuard>
  );
}
