/*
  Warnings:

  - You are about to drop the `FisioModel` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PatientModel` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "FisioModel" DROP CONSTRAINT "FisioModel_fisioId_fkey";

-- DropForeignKey
ALTER TABLE "PatientModel" DROP CONSTRAINT "PatientModel_patientId_fkey";

-- DropForeignKey
ALTER TABLE "Report" DROP CONSTRAINT "Report_fisioId_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_fisioId_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_patientId_fkey";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "seniority" "Senior",
ADD COLUMN     "specialization" "Specialization";

-- DropTable
DROP TABLE "FisioModel";

-- DropTable
DROP TABLE "PatientModel";

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_fisioId_fkey" FOREIGN KEY ("fisioId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_fisioId_fkey" FOREIGN KEY ("fisioId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
