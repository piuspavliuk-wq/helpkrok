'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function PharmacologyTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="pharmacology" 
        testName="Фармакології" 
      />
    </AuthGuard>
  );
}
