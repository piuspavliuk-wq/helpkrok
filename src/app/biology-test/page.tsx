'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function BiologyTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="biology" 
        testName="Біології" 
      />
    </AuthGuard>
  );
}
