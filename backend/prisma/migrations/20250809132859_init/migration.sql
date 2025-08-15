-- CreateTable
CREATE TABLE `Accounts` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `username` VARCHAR(191) NULL,
    `passHash` VARCHAR(191) NULL,
    `role` VARCHAR(191) NOT NULL DEFAULT 'user',
    `permissions` JSON NULL,
    `active` BOOLEAN NULL DEFAULT true,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `updatedById` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Students` (
    `id` VARCHAR(191) NOT NULL,
    `admission_no` VARCHAR(191) NULL,
    `first_name` VARCHAR(191) NULL,
    `last_name` VARCHAR(191) NULL,
    `date_of_birth` DATETIME(3) NULL,
    `sex` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `state_of_origin` VARCHAR(191) NULL,
    `school_section` VARCHAR(191) NULL,
    `lga` VARCHAR(191) NULL,
    `religion` VARCHAR(191) NULL,
    `date_of_admission` DATETIME(3) NULL,
    `admission_session` VARCHAR(191) NULL,
    `admission_term` VARCHAR(191) NULL,
    `admission_class` VARCHAR(191) NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,
    `guardian_name` VARCHAR(191) NULL,
    `guardian_telephone` VARCHAR(191) NULL,
    `curr_class_id` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `updatedById` VARCHAR(191) NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Students_admission_no_key`(`admission_no`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Disengagedstudent` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `date_of_disengagement` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `method_of_disengagement` VARCHAR(191) NULL,
    `reason` VARCHAR(191) NULL,
    `comment` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ClassHistory` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `class_id` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FCAResults` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `class_id` VARCHAR(191) NULL,
    `subject_id` VARCHAR(191) NULL,
    `score` INTEGER NULL,
    `session` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `updatedById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SCAResults` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `class_id` VARCHAR(191) NULL,
    `subject_id` VARCHAR(191) NULL,
    `score` INTEGER NULL,
    `session` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `updatedById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ExamResults` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `class_id` VARCHAR(191) NULL,
    `subject_id` VARCHAR(191) NULL,
    `score` INTEGER NULL,
    `session` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `updatedById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transaction` (
    `id` VARCHAR(191) NOT NULL,
    `total` INTEGER NOT NULL,
    `balance` INTEGER NOT NULL,
    `year` INTEGER NOT NULL,
    `month` VARCHAR(191) NOT NULL,
    `class` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL,
    `createdById` VARCHAR(191) NULL,
    `updatedById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `studentId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TnxItem` (
    `id` VARCHAR(191) NOT NULL,
    `transactionId` VARCHAR(191) NOT NULL,
    `feeId` VARCHAR(191) NOT NULL,
    `price` INTEGER NOT NULL,
    `paid` INTEGER NOT NULL,
    `balance` INTEGER NOT NULL,
    `class` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,
    `year` INTEGER NULL,
    `month` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payment` (
    `id` VARCHAR(191) NOT NULL,
    `tnxId` VARCHAR(191) NULL,
    `itemId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `paid` INTEGER NOT NULL,
    `method` VARCHAR(191) NULL,
    `class` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `type` VARCHAR(191) NOT NULL DEFAULT 'payment',
    `year` INTEGER NULL,
    `month` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Reciept` (
    `id` VARCHAR(191) NOT NULL,
    `items` JSON NOT NULL,
    `tnxId` VARCHAR(191) NOT NULL,
    `year` INTEGER NOT NULL,
    `month` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `createdById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StudentsPromotions` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NOT NULL,
    `from` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `to_id` VARCHAR(191) NOT NULL,
    `createdById` VARCHAR(191) NULL,
    `promotedOn` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StudentsDemotions` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NOT NULL,
    `from` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `to_id` VARCHAR(191) NOT NULL,
    `createdById` VARCHAR(191) NULL,
    `demotedOn` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Classes` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `school_section` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Subjects` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FeesGroup` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `amount` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ClassesToSubjects` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ClassesToSubjects_AB_unique`(`A`, `B`),
    INDEX `_ClassesToSubjects_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ClassesToFeesGroup` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ClassesToFeesGroup_AB_unique`(`A`, `B`),
    INDEX `_ClassesToFeesGroup_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Students` ADD CONSTRAINT `Students_curr_class_id_fkey` FOREIGN KEY (`curr_class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Students` ADD CONSTRAINT `Students_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Disengagedstudent` ADD CONSTRAINT `Disengagedstudent_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Disengagedstudent` ADD CONSTRAINT `Disengagedstudent_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ClassHistory` ADD CONSTRAINT `ClassHistory_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ClassHistory` ADD CONSTRAINT `ClassHistory_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `Subjects`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `Subjects`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `Subjects`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_updatedById_fkey` FOREIGN KEY (`updatedById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TnxItem` ADD CONSTRAINT `TnxItem_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `Transaction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TnxItem` ADD CONSTRAINT `TnxItem_feeId_fkey` FOREIGN KEY (`feeId`) REFERENCES `FeesGroup`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_tnxId_fkey` FOREIGN KEY (`tnxId`) REFERENCES `Transaction`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_itemId_fkey` FOREIGN KEY (`itemId`) REFERENCES `TnxItem`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reciept` ADD CONSTRAINT `Reciept_tnxId_fkey` FOREIGN KEY (`tnxId`) REFERENCES `Transaction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reciept` ADD CONSTRAINT `Reciept_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Classes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Classes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToSubjects` ADD CONSTRAINT `_ClassesToSubjects_A_fkey` FOREIGN KEY (`A`) REFERENCES `Classes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToSubjects` ADD CONSTRAINT `_ClassesToSubjects_B_fkey` FOREIGN KEY (`B`) REFERENCES `Subjects`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToFeesGroup` ADD CONSTRAINT `_ClassesToFeesGroup_A_fkey` FOREIGN KEY (`A`) REFERENCES `Classes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToFeesGroup` ADD CONSTRAINT `_ClassesToFeesGroup_B_fkey` FOREIGN KEY (`B`) REFERENCES `FeesGroup`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
