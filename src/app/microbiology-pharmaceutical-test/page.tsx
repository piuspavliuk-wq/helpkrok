'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function MicrobiologyPharmaceuticalTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="microbiology-pharmaceutical" 
        testName="Мікробіологія (Фармація)" 
      />
    </AuthGuard>
  );
}
