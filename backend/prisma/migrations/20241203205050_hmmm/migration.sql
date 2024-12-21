-- DropForeignKey
ALTER TABLE `classhistory` DROP FOREIGN KEY `ClassHistory_student_id_fkey`;

-- AddForeignKey
ALTER TABLE `ClassHistory` ADD CONSTRAINT `ClassHistory_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
