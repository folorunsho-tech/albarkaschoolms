/*
  Warnings:

  - Made the column `student_id` on table `studentsdemotions` required. This step will fail if there are existing NULL values in that column.
  - Made the column `to_id` on table `studentsdemotions` required. This step will fail if there are existing NULL values in that column.
  - Made the column `student_id` on table `studentspromotions` required. This step will fail if there are existing NULL values in that column.
  - Made the column `to_id` on table `studentspromotions` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `studentsdemotions` DROP FOREIGN KEY `StudentsDemotions_student_id_fkey`;

-- DropForeignKey
ALTER TABLE `studentsdemotions` DROP FOREIGN KEY `StudentsDemotions_to_id_fkey`;

-- DropForeignKey
ALTER TABLE `studentspromotions` DROP FOREIGN KEY `StudentsPromotions_student_id_fkey`;

-- DropForeignKey
ALTER TABLE `studentspromotions` DROP FOREIGN KEY `StudentsPromotions_to_id_fkey`;

-- AlterTable
ALTER TABLE `studentsdemotions` MODIFY `student_id` VARCHAR(191) NOT NULL,
    MODIFY `to_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `studentspromotions` MODIFY `student_id` VARCHAR(191) NOT NULL,
    MODIFY `to_id` VARCHAR(191) NOT NULL;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Classes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Classes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
