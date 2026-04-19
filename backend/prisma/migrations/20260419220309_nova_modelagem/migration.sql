/*
  Warnings:

  - The `status` column on the `Cost` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `patientId` on the `Report` table. All the data in the column will be lost.
  - The `status` column on the `Session` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `contract` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `senior` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `specialization` on the `User` table. All the data in the column will be lost.
  - The `status` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `whoCreated` to the `Cost` table without a default value. This is not possible if the table is not empty.
  - Added the required column `whoCreated` to the `Report` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contract` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `specialization` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `whoCreated` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `whoCreated` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ATIVO', 'INATIVO', 'PENDENTE');

-- CreateEnum
CREATE TYPE "SessionStatus" AS ENUM ('PROGRESSO', 'CONCLUIDO', 'CANCELADO', 'PENDENTE');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('A_PAGAR', 'PAGO', 'ATRASADO', 'CANCELADO');

-- DropForeignKey
ALTER TABLE "Report" DROP CONSTRAINT "Report_fisioId_fkey";

-- DropForeignKey
ALTER TABLE "Report" DROP CONSTRAINT "Report_patientId_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_fisioId_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_patientId_fkey";

-- AlterTable
ALTER TABLE "Cost" ADD COLUMN     "whoCreated" TEXT NOT NULL,
ADD COLUMN     "whoUpdated" TEXT[],
DROP COLUMN "status",
ADD COLUMN     "status" "PaymentStatus" NOT NULL DEFAULT 'A_PAGAR';

-- AlterTable
ALTER TABLE "Report" DROP COLUMN "patientId",
ADD COLUMN     "status" "SessionStatus" NOT NULL DEFAULT 'CONCLUIDO',
ADD COLUMN     "whoCreated" TEXT NOT NULL,
ADD COLUMN     "whoUpdated" TEXT[];

-- AlterTable
ALTER TABLE "Session" ADD COLUMN     "contract" "Contract" NOT NULL,
ADD COLUMN     "specialization" "Specialization" NOT NULL,
ADD COLUMN     "whoCreated" TEXT NOT NULL,
ADD COLUMN     "whoUpdated" TEXT[],
DROP COLUMN "status",
ADD COLUMN     "status" "SessionStatus" NOT NULL DEFAULT 'PROGRESSO';

-- AlterTable
ALTER TABLE "User" DROP COLUMN "contract",
DROP COLUMN "senior",
DROP COLUMN "specialization",
ADD COLUMN     "whoCreated" TEXT NOT NULL,
ADD COLUMN     "whoUpdated" TEXT[],
DROP COLUMN "status",
ADD COLUMN     "status" "UserStatus" NOT NULL DEFAULT 'ATIVO';

-- DropEnum
DROP TYPE "Status";

-- CreateTable
CREATE TABLE "FisioModel" (
    "id" TEXT NOT NULL,
    "senior" "Senior",
    "specialization" "Specialization",
    "status" "UserStatus" NOT NULL DEFAULT 'ATIVO',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "whoCreated" TEXT NOT NULL,
    "whoUpdated" TEXT[],
    "fisioId" TEXT NOT NULL,

    CONSTRAINT "FisioModel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PatientModel" (
    "id" TEXT NOT NULL,
    "status" "UserStatus" NOT NULL DEFAULT 'ATIVO',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "whoCreated" TEXT NOT NULL,
    "whoUpdated" TEXT[],
    "patientId" TEXT NOT NULL,

    CONSTRAINT "PatientModel_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FisioModel_fisioId_key" ON "FisioModel"("fisioId");

-- CreateIndex
CREATE UNIQUE INDEX "PatientModel_patientId_key" ON "PatientModel"("patientId");

-- AddForeignKey
ALTER TABLE "FisioModel" ADD CONSTRAINT "FisioModel_fisioId_fkey" FOREIGN KEY ("fisioId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientModel" ADD CONSTRAINT "PatientModel_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_fisioId_fkey" FOREIGN KEY ("fisioId") REFERENCES "FisioModel"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "PatientModel"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_fisioId_fkey" FOREIGN KEY ("fisioId") REFERENCES "FisioModel"("id") ON DELETE CASCADE ON UPDATE CASCADE;
