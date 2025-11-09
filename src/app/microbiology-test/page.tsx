'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function MicrobiologyTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="microbiology" 
        testName="Мікробіології" 
      />
    </AuthGuard>
  );
}
