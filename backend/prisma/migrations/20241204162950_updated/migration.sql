/*
  Warnings:

  - You are about to drop the column `salary` on the `appointments` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `appointments` DROP COLUMN `salary`;

-- AlterTable
ALTER TABLE `payments` ADD COLUMN `class` VARCHAR(191) NULL;
