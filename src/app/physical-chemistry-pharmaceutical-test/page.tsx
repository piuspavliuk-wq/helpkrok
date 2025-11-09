'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function PhysicalChemistryPharmaceuticalTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="physical-chemistry-pharmaceutical" 
        testName="Фізична та колоїдна хімія" 
      />
    </AuthGuard>
  );
}
