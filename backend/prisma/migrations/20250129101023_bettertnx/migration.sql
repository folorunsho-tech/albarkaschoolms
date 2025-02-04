/*
  Warnings:

  - You are about to drop the column `payment_method` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `teller_no` on the `transactions` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `feesgroup` ADD COLUMN `class_id` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `payments` ADD COLUMN `paid` INTEGER NULL,
    ADD COLUMN `payment_method` VARCHAR(191) NULL,
    ADD COLUMN `status` VARCHAR(191) NULL,
    ADD COLUMN `teller_no` VARCHAR(191) NULL,
    ADD COLUMN `total` INTEGER NULL;

-- AlterTable
ALTER TABLE `transactions` DROP COLUMN `payment_method`,
    DROP COLUMN `teller_no`;

-- AddForeignKey
ALTER TABLE `FeesGroup` ADD CONSTRAINT `FeesGroup_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
