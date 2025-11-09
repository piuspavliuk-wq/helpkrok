'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function PharmacologyPharmaceuticalTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="pharmacology-pharmaceutical" 
        testName="Фармакологія" 
      />
    </AuthGuard>
  );
}
