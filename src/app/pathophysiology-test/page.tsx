'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function PathophysiologyTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="pathophysiology" 
        testName="Патологічної фізіології" 
      />
    </AuthGuard>
  );
}
