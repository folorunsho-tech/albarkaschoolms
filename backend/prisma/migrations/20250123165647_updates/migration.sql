/*
  Warnings:

  - The primary key for the `transactions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `transactions` table. All the data in the column will be lost.
  - Added the required column `tnxId` to the `Transactions` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `payments` DROP FOREIGN KEY `Payments_transactionId_fkey`;

-- AlterTable
ALTER TABLE `transactions` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    ADD COLUMN `tnxId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`tnxId`);

-- AddForeignKey
ALTER TABLE `Payments` ADD CONSTRAINT `Payments_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `Transactions`(`tnxId`) ON DELETE SET NULL ON UPDATE CASCADE;
