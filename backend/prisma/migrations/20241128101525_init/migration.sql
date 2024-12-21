-- CreateTable
CREATE TABLE `Accounts` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `username` VARCHAR(191) NULL,
    `passHash` VARCHAR(191) NULL,
    `empid` VARCHAR(191) NULL,
    `permissions` JSON NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `authAccess` VARCHAR(191) NULL DEFAULT 'Allowed',
    `updatedById` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthHistory` (
    `id` VARCHAR(191) NOT NULL,
    `account_id` VARCHAR(191) NULL,
    `auth_status` VARCHAR(191) NULL,
    `logged_in_at` DATETIME(3) NULL,
    `logged_out_at` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Staffs` (
    `empid` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `telephone` VARCHAR(191) NULL,
    `state_of_origin` VARCHAR(191) NULL,
    `lga` VARCHAR(191) NULL,
    `qualification` VARCHAR(191) NULL,
    `grade_level` INTEGER NULL,
    `salary` VARCHAR(191) NULL,
    `school_section` VARCHAR(191) NULL,
    `passport` VARCHAR(191) NULL,
    `first_name` VARCHAR(191) NULL,
    `last_name` VARCHAR(191) NULL,
    `date_of_birth` DATETIME(3) NULL,
    `sex` VARCHAR(191) NULL,
    `religion` VARCHAR(191) NULL,
    `marital_status` VARCHAR(191) NULL,
    `appointed_as` VARCHAR(191) NULL,
    `curr_appointment_id` VARCHAR(191) NULL,
    `date_of_emp` DATETIME(3) NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,
    `createdBy_id` VARCHAR(191) NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`empid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Disengagemnets` (
    `id` VARCHAR(191) NOT NULL,
    `staff_id` VARCHAR(191) NULL,
    `date_of_disengagement` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `method_of_disengagement` VARCHAR(191) NULL,
    `reason` VARCHAR(191) NULL,
    `employer_comment` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Students` (
    `id` VARCHAR(191) NOT NULL,
    `admission_no` VARCHAR(191) NULL,
    `first_name` VARCHAR(191) NULL,
    `last_name` VARCHAR(191) NULL,
    `date_of_birth` DATETIME(3) NULL,
    `sex` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `state_of_origin` VARCHAR(191) NULL,
    `school_section` VARCHAR(191) NULL,
    `lga` VARCHAR(191) NULL,
    `religion` VARCHAR(191) NULL,
    `date_of_admission` DATETIME(3) NULL,
    `admission_session` VARCHAR(191) NULL,
    `admission_term` VARCHAR(191) NULL,
    `admission_class` VARCHAR(191) NULL,
    `student_passport` VARCHAR(191) NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,
    `guardian_name` VARCHAR(191) NULL,
    `guardian_telephone` VARCHAR(191) NULL,
    `guardian_passport` VARCHAR(191) NULL,
    `curr_class_id` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
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
CREATE TABLE `Files` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `mimetype` VARCHAR(191) NULL,
    `path` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

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
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Classes` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `teacher_id` VARCHAR(191) NULL,
    `school_section` VARCHAR(191) NULL,

    UNIQUE INDEX `Classes_teacher_id_key`(`teacher_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payments` (
    `payment_id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `items` JSON NULL,
    `term` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `payment_method` VARCHAR(191) NULL,
    `teller_no` VARCHAR(191) NULL DEFAULT '---',
    `total` INTEGER NULL,
    `paid` INTEGER NULL,
    `status` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`payment_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Promotions` (
    `id` VARCHAR(191) NOT NULL,
    `staff_id` VARCHAR(191) NULL,
    `from` VARCHAR(191) NULL,
    `from_section` VARCHAR(191) NULL,
    `prev_salary` VARCHAR(191) NULL,
    `to_id` VARCHAR(191) NULL,
    `curr_salary` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `promotedOn` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Demotions` (
    `id` VARCHAR(191) NOT NULL,
    `staff_id` VARCHAR(191) NULL,
    `from` VARCHAR(191) NULL,
    `from_section` VARCHAR(191) NULL,
    `prev_salary` VARCHAR(191) NULL,
    `to_id` VARCHAR(191) NULL,
    `curr_salary` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `demotedOn` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StudentsPromotions` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `from` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `to_id` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `promotedOn` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StudentsDemotions` (
    `id` VARCHAR(191) NOT NULL,
    `student_id` VARCHAR(191) NULL,
    `from` VARCHAR(191) NULL,
    `term` VARCHAR(191) NULL,
    `session` VARCHAR(191) NULL,
    `to_id` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NULL,
    `demotedOn` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Subjects` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Appointments` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `salary` VARCHAR(191) NULL,
    `school_section` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FeesGroup` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `amount` VARCHAR(191) NULL,
    `school_section` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_StaffsToSubjects` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_StaffsToSubjects_AB_unique`(`A`, `B`),
    INDEX `_StaffsToSubjects_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ClassesToSubjects` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ClassesToSubjects_AB_unique`(`A`, `B`),
    INDEX `_ClassesToSubjects_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `AuthHistory` ADD CONSTRAINT `AuthHistory_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Staffs` ADD CONSTRAINT `Staffs_curr_appointment_id_fkey` FOREIGN KEY (`curr_appointment_id`) REFERENCES `Appointments`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Staffs` ADD CONSTRAINT `Staffs_createdBy_id_fkey` FOREIGN KEY (`createdBy_id`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Disengagemnets` ADD CONSTRAINT `Disengagemnets_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `Staffs`(`empid`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Disengagemnets` ADD CONSTRAINT `Disengagemnets_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Students` ADD CONSTRAINT `Students_curr_class_id_fkey` FOREIGN KEY (`curr_class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Students` ADD CONSTRAINT `Students_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Disengagedstudent` ADD CONSTRAINT `Disengagedstudent_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`admission_no`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Disengagedstudent` ADD CONSTRAINT `Disengagedstudent_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Files` ADD CONSTRAINT `Files_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`admission_no`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `Subjects`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FCAResults` ADD CONSTRAINT `FCAResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`admission_no`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `Subjects`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCAResults` ADD CONSTRAINT `SCAResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`admission_no`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `Subjects`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResults` ADD CONSTRAINT `ExamResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Classes` ADD CONSTRAINT `Classes_teacher_id_fkey` FOREIGN KEY (`teacher_id`) REFERENCES `Staffs`(`empid`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payments` ADD CONSTRAINT `Payments_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payments` ADD CONSTRAINT `Payments_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Promotions` ADD CONSTRAINT `Promotions_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `Staffs`(`empid`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Promotions` ADD CONSTRAINT `Promotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Appointments`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Promotions` ADD CONSTRAINT `Promotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Demotions` ADD CONSTRAINT `Demotions_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `Staffs`(`empid`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Demotions` ADD CONSTRAINT `Demotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Appointments`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Demotions` ADD CONSTRAINT `Demotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsPromotions` ADD CONSTRAINT `StudentsPromotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `Students`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `Classes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StudentsDemotions` ADD CONSTRAINT `StudentsDemotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Accounts`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_StaffsToSubjects` ADD CONSTRAINT `_StaffsToSubjects_A_fkey` FOREIGN KEY (`A`) REFERENCES `Staffs`(`empid`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_StaffsToSubjects` ADD CONSTRAINT `_StaffsToSubjects_B_fkey` FOREIGN KEY (`B`) REFERENCES `Subjects`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToSubjects` ADD CONSTRAINT `_ClassesToSubjects_A_fkey` FOREIGN KEY (`A`) REFERENCES `Classes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ClassesToSubjects` ADD CONSTRAINT `_ClassesToSubjects_B_fkey` FOREIGN KEY (`B`) REFERENCES `Subjects`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
