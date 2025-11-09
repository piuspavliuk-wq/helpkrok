'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function PathologyTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="pathology" 
        testName="Патології" 
      />
    </AuthGuard>
  );
}
