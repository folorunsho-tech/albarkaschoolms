/*
  Warnings:

  - A unique constraint covering the columns `[empid]` on the table `Accounts` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `staffs` DROP FOREIGN KEY `Staffs_createdById_fkey`;

-- CreateIndex
CREATE UNIQUE INDEX `Accounts_empid_key` ON `Accounts`(`empid`);

-- AddForeignKey
ALTER TABLE `Accounts` ADD CONSTRAINT `Accounts_empid_fkey` FOREIGN KEY (`empid`) REFERENCES `Staffs`(`empid`) ON DELETE SET NULL ON UPDATE CASCADE;
