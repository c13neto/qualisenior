/*
  Warnings:

  - You are about to drop the column `daysOfWeek` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `hoursOfWork` on the `Session` table. All the data in the column will be lost.
  - Added the required column `dayEnd` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dayStart` to the `Session` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Session" DROP COLUMN "daysOfWeek",
DROP COLUMN "hoursOfWork",
ADD COLUMN     "dayEnd" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "dayStart" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "daysWeek" TEXT[],
ADD COLUMN     "hoursWork" TEXT[];
