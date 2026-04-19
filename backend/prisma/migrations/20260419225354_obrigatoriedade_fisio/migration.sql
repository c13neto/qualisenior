/*
  Warnings:

  - Made the column `senior` on table `FisioModel` required. This step will fail if there are existing NULL values in that column.
  - Made the column `specialization` on table `FisioModel` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "FisioModel" ALTER COLUMN "senior" SET NOT NULL,
ALTER COLUMN "specialization" SET NOT NULL;
