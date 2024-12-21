/*
  Warnings:

  - You are about to drop the column `createdBy_id` on the `staffs` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `disengagedstudent` DROP FOREIGN KEY `Disengagedstudent_student_id_fkey`;

-- DropForeignKey
ALTER TABLE `examresults` DROP FOREIGN KEY `ExamResults_student_id_fkey`;

-- DropForeignKey
ALTER TABLE `fcaresults` DROP FOREIGN KEY `FCAResults_student_id_fkey`;

-- DropForeignKey
ALTER TABLE `scaresults` DROP FOREIGN KEY `SCAResults_student_id_fkey`;

-- DropForeignKey
ALTER TABLE `staffs` DROP FOREIGN KEY `Staffs_createdBy_id_fkey`;

-- AlterTable
ALTER TABLE `authhistory` MODIFY `auth_status` VARCHAR(191) NULL DEFAULT 'Logged-in';

-- AlterTable
ALTER TABLE `examresults` ADD COLUMN `updatedById` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `fcaresults` ADD COLUMN `updatedById` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `payments` ADD COLUMN `updatedById` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `scaresults` ADD COLUMN `updatedById` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `staffs` DROP COLUMN `createdBy_id`,
    ADD COLUMN `createdById` VARCHAR(191) NULL,
    ADD COLUMN `updatedById` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `students` ADD COLUMN `updatedById` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Staffs` ADD CONSTRAINT `Staffs_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Disengagedstudent` ADD CONSTRAINT `Disengagedstudent_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
