'use client';

import UniversalTest from '@/components/testing/UniversalTest';
import AuthGuard from '@/components/auth/AuthGuard';

export default function OrganicChemistryPharmaceuticalTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="organic-chemistry-pharmaceutical" 
        testName="Органічна хімія" 
      />
    </AuthGuard>
  );
}