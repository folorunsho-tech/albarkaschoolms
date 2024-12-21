/*
  Warnings:

  - You are about to drop the column `authAccess` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `passport` on the `staffs` table. All the data in the column will be lost.
  - You are about to drop the column `guardian_passport` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `student_passport` on the `students` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `accounts` DROP COLUMN `authAccess`,
    ADD COLUMN `active` BOOLEAN NULL DEFAULT true;

-- AlterTable
ALTER TABLE `classhistory` ADD COLUMN `session` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `staffs` DROP COLUMN `passport`;

-- AlterTable
ALTER TABLE `students` DROP COLUMN `guardian_passport`,
    DROP COLUMN `student_passport`;
