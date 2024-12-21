/*
  Warnings:

  - You are about to drop the column `items` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the `files` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `files` DROP FOREIGN KEY `Files_createdById_fkey`;

-- DropIndex
DROP INDEX `Staffs_createdById_fkey` ON `staffs`;

-- AlterTable
ALTER TABLE `payments` DROP COLUMN `items`,
    ADD COLUMN `item` VARCHAR(191) NULL,
    ADD COLUMN `section` VARCHAR(191) NULL,
    ALTER COLUMN `teller_no` DROP DEFAULT;

-- DropTable
DROP TABLE `files`;

-- CreateTable
CREATE TABLE `ClassHistory` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `class_id` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `ClassHistory` ADD CONSTRAINT `ClassHistory_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`admission_no`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ClassHistory` ADD CONSTRAINT `ClassHistory_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
