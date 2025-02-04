/*
  Warnings:

  - You are about to drop the column `class_id` on the `feesgroup` table. All the data in the column will be lost.
  - You are about to drop the column `total` on the `payments` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `feesgroup` DROP FOREIGN KEY `FeesGroup_class_id_fkey`;

-- AlterTable
ALTER TABLE `feesgroup` DROP COLUMN `class_id`;

-- AlterTable
ALTER TABLE `payments` DROP COLUMN `total`;

-- CreateTable
CREATE TABLE `transactionHistory` (
    `id` VARCHAR(191) NOT NULL,
    `tnxId` INTEGER NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `items` JSON NULL,
    `total` INTEGER NULL,
    `paid` INTEGER NULL,
    `status` VARCHAR(191) NULL,
    `class` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ClassesToFeesGroup` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ClassesToFeesGroup_AB_unique`(`A`, `B`),
    INDEX `_ClassesToFeesGroup_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `transactionHistory` ADD CONSTRAINT `transactionHistory_tnxId_fkey` FOREIGN KEY (`tnxId`) REFERENCES `Transactions`(`tnxId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactionHistory` ADD CONSTRAINT `transactionHistory_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactionHistory` ADD CONSTRAINT `transactionHistory_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToFeesGroup` ADD CONSTRAINT `_ClassesToFeesGroup_A_fkey` FOREIGN KEY (`A`) REFERENCES `Classes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToFeesGroup` ADD CONSTRAINT `_ClassesToFeesGroup_B_fkey` FOREIGN KEY (`B`) REFERENCES `FeesGroup`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
