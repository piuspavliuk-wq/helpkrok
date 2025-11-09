'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function BiochemistryPharmaceuticalTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="biochemistry-pharmaceutical" 
        testName="Біохімія (Фармація)" 
      />
    </AuthGuard>
  );
}
