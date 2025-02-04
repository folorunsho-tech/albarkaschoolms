/*
  Warnings:

  - You are about to drop the column `class` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `createdById` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `item` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `paid` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `payment_method` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `section` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `student_id` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `teller_no` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `total` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `payments` table. All the data in the column will be lost.
  - You are about to drop the column `updatedById` on the `payments` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `payments` DROP FOREIGN KEY `Payments_createdById_fkey`;

-- DropForeignKey
ALTER TABLE `payments` DROP FOREIGN KEY `Payments_student_id_fkey`;

-- AlterTable
ALTER TABLE `accounts` ADD COLUMN `role` VARCHAR(191) NOT NULL DEFAULT 'user';

-- AlterTable
ALTER TABLE `payments` DROP COLUMN `class`,
    DROP COLUMN `createdById`,
    DROP COLUMN `item`,
    DROP COLUMN `paid`,
    DROP COLUMN `payment_method`,
    DROP COLUMN `section`,
    DROP COLUMN `status`,
    DROP COLUMN `student_id`,
    DROP COLUMN `teller_no`,
    DROP COLUMN `total`,
    DROP COLUMN `updatedAt`,
    DROP COLUMN `updatedById`,
    ADD COLUMN `amount` INTEGER NULL,
    ADD COLUMN `item_id` VARCHAR(191) NULL,
    ADD COLUMN `transactionId` INTEGER NULL;

-- CreateTable
CREATE TABLE `Transactions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `student_id` VARCHAR(191) NULL,
    `payment_method` VARCHAR(191) NULL,
    `teller_no` VARCHAR(191) NULL,
    `total` INTEGER NULL,
    `paid` INTEGER NULL,
    `status` VARCHAR(191) NULL,
    `class` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `updatedById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Transactions` ADD CONSTRAINT `Transactions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transactions` ADD CONSTRAINT `Transactions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payments` ADD CONSTRAINT `Payments_item_id_fkey` FOREIGN KEY (`item_id`) REFERENCES `FeesGroup`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payments` ADD CONSTRAINT `Payments_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `Transactions`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
