/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _classestofeesgroup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_classestofeesgroup`;
CREATE TABLE `_classestofeesgroup` (
  `A` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `B` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `_ClassesToFeesGroup_AB_unique` (`A`, `B`),
  KEY `_ClassesToFeesGroup_B_index` (`B`),
  CONSTRAINT `_ClassesToFeesGroup_A_fkey` FOREIGN KEY (`A`) REFERENCES `classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `_ClassesToFeesGroup_B_fkey` FOREIGN KEY (`B`) REFERENCES `feesgroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _classestosubjects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_classestosubjects`;
CREATE TABLE `_classestosubjects` (
  `A` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `B` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `_ClassesToSubjects_AB_unique` (`A`, `B`),
  KEY `_ClassesToSubjects_B_index` (`B`),
  CONSTRAINT `_ClassesToSubjects_A_fkey` FOREIGN KEY (`A`) REFERENCES `classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `_ClassesToSubjects_B_fkey` FOREIGN KEY (`B`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _prisma_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_prisma_migrations`;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _staffstosubjects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_staffstosubjects`;
CREATE TABLE `_staffstosubjects` (
  `A` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `B` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `_StaffsToSubjects_AB_unique` (`A`, `B`),
  KEY `_StaffsToSubjects_B_index` (`B`),
  CONSTRAINT `_StaffsToSubjects_A_fkey` FOREIGN KEY (`A`) REFERENCES `staffs` (`empid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `_StaffsToSubjects_B_fkey` FOREIGN KEY (`B`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passHash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permissions` json DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `role` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Accounts_empid_key` (`empid`),
  CONSTRAINT `Accounts_empid_fkey` FOREIGN KEY (`empid`) REFERENCES `staffs` (`empid`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: appointments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: authhistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `authhistory`;
CREATE TABLE `authhistory` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Logged-in',
  `logged_in_at` datetime(3) DEFAULT NULL,
  `logged_out_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `AuthHistory_account_id_fkey` (`account_id`),
  CONSTRAINT `AuthHistory_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: classes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teacher_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Classes_teacher_id_key` (`teacher_id`),
  CONSTRAINT `Classes_teacher_id_fkey` FOREIGN KEY (`teacher_id`) REFERENCES `staffs` (`empid`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: classhistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classhistory`;
CREATE TABLE `classhistory` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ClassHistory_class_id_fkey` (`class_id`),
  KEY `ClassHistory_student_id_fkey` (`student_id`),
  CONSTRAINT `ClassHistory_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `ClassHistory_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: demotions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demotions`;
CREATE TABLE `demotions` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_salary` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `curr_salary` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `demotedOn` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `Demotions_staff_id_fkey` (`staff_id`),
  KEY `Demotions_to_id_fkey` (`to_id`),
  KEY `Demotions_createdById_fkey` (`createdById`),
  CONSTRAINT `Demotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Demotions_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`empid`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Demotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `appointments` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: disengagedstudent
# ------------------------------------------------------------

DROP TABLE IF EXISTS `disengagedstudent`;
CREATE TABLE `disengagedstudent` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_disengagement` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `method_of_disengagement` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Disengagedstudent_createdById_fkey` (`createdById`),
  KEY `Disengagedstudent_student_id_fkey` (`student_id`),
  CONSTRAINT `Disengagedstudent_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Disengagedstudent_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: disengagemnets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `disengagemnets`;
CREATE TABLE `disengagemnets` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_disengagement` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `method_of_disengagement` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employer_comment` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Disengagemnets_staff_id_fkey` (`staff_id`),
  KEY `Disengagemnets_createdById_fkey` (`createdById`),
  CONSTRAINT `Disengagemnets_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Disengagemnets_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`empid`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: examresults
# ------------------------------------------------------------

DROP TABLE IF EXISTS `examresults`;
CREATE TABLE `examresults` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` int DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ExamResults_class_id_fkey` (`class_id`),
  KEY `ExamResults_subject_id_fkey` (`subject_id`),
  KEY `ExamResults_createdById_fkey` (`createdById`),
  KEY `ExamResults_student_id_fkey` (`student_id`),
  CONSTRAINT `ExamResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `ExamResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `ExamResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `ExamResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: fcaresults
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fcaresults`;
CREATE TABLE `fcaresults` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` int DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FCAResults_class_id_fkey` (`class_id`),
  KEY `FCAResults_subject_id_fkey` (`subject_id`),
  KEY `FCAResults_createdById_fkey` (`createdById`),
  KEY `FCAResults_student_id_fkey` (`student_id`),
  CONSTRAINT `FCAResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `FCAResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `FCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `FCAResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: feesgroup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feesgroup`;
CREATE TABLE `feesgroup` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `payment_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `amount` int DEFAULT NULL,
  `item_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transactionId` int DEFAULT NULL,
  `paid` int DEFAULT NULL,
  `payment_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teller_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `Payments_item_id_fkey` (`item_id`),
  KEY `Payments_transactionId_fkey` (`transactionId`),
  CONSTRAINT `Payments_item_id_fkey` FOREIGN KEY (`item_id`) REFERENCES `feesgroup` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Payments_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `transactions` (`tnxId`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: promotions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `promotions`;
CREATE TABLE `promotions` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_salary` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `curr_salary` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `promotedOn` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `Promotions_staff_id_fkey` (`staff_id`),
  KEY `Promotions_to_id_fkey` (`to_id`),
  KEY `Promotions_createdById_fkey` (`createdById`),
  CONSTRAINT `Promotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Promotions_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`empid`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Promotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `appointments` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: scaresults
# ------------------------------------------------------------

DROP TABLE IF EXISTS `scaresults`;
CREATE TABLE `scaresults` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` int DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `SCAResults_class_id_fkey` (`class_id`),
  KEY `SCAResults_subject_id_fkey` (`subject_id`),
  KEY `SCAResults_createdById_fkey` (`createdById`),
  KEY `SCAResults_student_id_fkey` (`student_id`),
  CONSTRAINT `SCAResults_class_id_fkey` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `SCAResults_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `SCAResults_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `SCAResults_subject_id_fkey` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: staffs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `staffs`;
CREATE TABLE `staffs` (
  `empid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_of_origin` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lga` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qualification` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade_level` int DEFAULT NULL,
  `salary` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` datetime(3) DEFAULT NULL,
  `sex` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marital_status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointed_as` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `curr_appointment_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_emp` datetime(3) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `updatedAt` datetime(3) NOT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`empid`),
  KEY `Staffs_curr_appointment_id_fkey` (`curr_appointment_id`),
  CONSTRAINT `Staffs_curr_appointment_id_fkey` FOREIGN KEY (`curr_appointment_id`) REFERENCES `appointments` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: students
# ------------------------------------------------------------

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admission_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` datetime(3) DEFAULT NULL,
  `sex` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_of_origin` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lga` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_admission` datetime(3) DEFAULT NULL,
  `admission_session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_class` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `guardian_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_telephone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `curr_class_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedAt` datetime(3) NOT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Students_admission_no_key` (`admission_no`),
  KEY `Students_curr_class_id_fkey` (`curr_class_id`),
  KEY `Students_createdById_fkey` (`createdById`),
  CONSTRAINT `Students_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Students_curr_class_id_fkey` FOREIGN KEY (`curr_class_id`) REFERENCES `classes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: studentsdemotions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `studentsdemotions`;
CREATE TABLE `studentsdemotions` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `demotedOn` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `StudentsDemotions_student_id_fkey` (`student_id`),
  KEY `StudentsDemotions_to_id_fkey` (`to_id`),
  KEY `StudentsDemotions_createdById_fkey` (`createdById`),
  CONSTRAINT `StudentsDemotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `StudentsDemotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `StudentsDemotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `classes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: studentspromotions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `studentspromotions`;
CREATE TABLE `studentspromotions` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `promotedOn` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `StudentsPromotions_student_id_fkey` (`student_id`),
  KEY `StudentsPromotions_to_id_fkey` (`to_id`),
  KEY `StudentsPromotions_createdById_fkey` (`createdById`),
  CONSTRAINT `StudentsPromotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `StudentsPromotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `StudentsPromotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `classes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: subjects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: transactionhistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transactionhistory`;
CREATE TABLE `transactionhistory` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tnxId` int NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `items` json DEFAULT NULL,
  `total` int DEFAULT NULL,
  `paid` int DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactionHistory_tnxId_fkey` (`tnxId`),
  KEY `transactionHistory_student_id_fkey` (`student_id`),
  KEY `transactionHistory_createdById_fkey` (`createdById`),
  CONSTRAINT `transactionHistory_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `transactionHistory_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `transactionHistory_tnxId_fkey` FOREIGN KEY (`tnxId`) REFERENCES `transactions` (`tnxId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` int DEFAULT NULL,
  `paid` int DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) DEFAULT NULL,
  `tnxId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tnxId`),
  KEY `Transactions_student_id_fkey` (`student_id`),
  KEY `Transactions_createdById_fkey` (`createdById`),
  CONSTRAINT `Transactions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Transactions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: _classestofeesgroup
# ------------------------------------------------------------

INSERT INTO
  `_classestofeesgroup` (`A`, `B`)
VALUES
  ('2_fPzDw', '0jcBxk5');
INSERT INTO
  `_classestofeesgroup` (`A`, `B`)
VALUES
  ('Ifq45cL', '0jcBxk5');
INSERT INTO
  `_classestofeesgroup` (`A`, `B`)
VALUES
  ('OMVKFac', '0jcBxk5');
INSERT INTO
  `_classestofeesgroup` (`A`, `B`)
VALUES
  ('2_fPzDw', 'Exo4omu');
INSERT INTO
  `_classestofeesgroup` (`A`, `B`)
VALUES
  ('Ifq45cL', 'Exo4omu');
INSERT INTO
  `_classestofeesgroup` (`A`, `B`)
VALUES
  ('QA1juMZ', 'Exo4omu');
INSERT INTO
  `_classestofeesgroup` (`A`, `B`)
VALUES
  ('Ifq45cL', 'qXJJvNo');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: _classestosubjects
# ------------------------------------------------------------

INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', '18mZBlZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', '18mZBlZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', '18mZBlZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', '18mZBlZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', '18mZBlZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', '18mZBlZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', '3c9EWTV');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', '3c9EWTV');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', '3c9EWTV');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'bDliUQN');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'bDliUQN');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'bDliUQN');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'Bo69IyB');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'Bo69IyB');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'Bo69IyB');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'bT759gG');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'bT759gG');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'bT759gG');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'E7JETdx');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'E7JETdx');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'E7JETdx');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'E7JETdx');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'E7JETdx');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'E7JETdx');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'eIi5HQm');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'eIi5HQm');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'eIi5HQm');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'eIi5HQm');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'eIi5HQm');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'eIi5HQm');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'ElqqBT7');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'ElqqBT7');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'ElqqBT7');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'FnMLAER');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'FnMLAER');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'FnMLAER');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'g9NIUEF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'g9NIUEF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'g9NIUEF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'GQjbl0E');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'GQjbl0E');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'GQjbl0E');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'IC1gVq9');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'IC1gVq9');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'IC1gVq9');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'JFhxsq5');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'JFhxsq5');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'JFhxsq5');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'l95dKX8');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'l95dKX8');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'l95dKX8');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'lRKKmoa');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'lRKKmoa');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'lRKKmoa');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'lRKKmoa');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'lRKKmoa');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'lRKKmoa');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'M5Vv1pi');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'M5Vv1pi');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'M5Vv1pi');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'nGFxkVf');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'nGFxkVf');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'nGFxkVf');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'nMFpFkZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'nMFpFkZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'nMFpFkZ');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'o9bUcgF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'o9bUcgF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'o9bUcgF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'pFZPf3T');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'pFZPf3T');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'pFZPf3T');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'TJSQ_-v');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'TJSQ_-v');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'TJSQ_-v');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('1HN7a2S', 'uis6FkF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('OMVKFac', 'uis6FkF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('T9Bo3Ne', 'uis6FkF');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'Vx7JKMR');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'Vx7JKMR');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'Vx7JKMR');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'x9oVrQ9');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'x9oVrQ9');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'x9oVrQ9');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('2_fPzDw', 'YOb8XbD');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('Ifq45cL', 'YOb8XbD');
INSERT INTO
  `_classestosubjects` (`A`, `B`)
VALUES
  ('QA1juMZ', 'YOb8XbD');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: _prisma_migrations
# ------------------------------------------------------------

INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '035286a1-1825-40a3-941b-629b0ec55961',
    'e30ba24c8705dbdcf1c8cd4d9395b11042260b80efdf08e25e1d91626cdddca3',
    '2024-12-03 20:46:49.263',
    '20241203204648_updated_acc',
    NULL,
    NULL,
    '2024-12-03 20:46:48.972',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '03d7e293-7d12-4d85-8326-f04c8319d601',
    '435510e7ae03883d9c36589835b9359d01d485bbbf989b27a67cfa2bf199cf6f',
    '2025-01-23 16:56:48.216',
    '20250123165647_updates',
    NULL,
    NULL,
    '2025-01-23 16:56:47.719',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '1d18bb52-47e5-4976-b852-ffc6a821d9b1',
    '686cf74b105b6c2897b03b606ab8bcead5d72d927deafdaa876f495a6ffdaf9d',
    '2024-12-03 20:50:50.291',
    '20241203205050_hmmm',
    NULL,
    NULL,
    '2024-12-03 20:50:50.168',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '6e619f25-0679-49c4-a60e-fae569f57070',
    'd200a96ae7ca3fd69406177a888b4ddbbed732a7efaa4361dccd0d94612ec02b',
    '2024-11-29 21:23:51.605',
    '20241129210316_knowing',
    NULL,
    NULL,
    '2024-11-29 21:23:50.794',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '87675ca8-a829-4656-a16b-414c8e7762e4',
    'c7f9f6b6785172c981d21e4bb617d3cd6ed96fbbc4683ff7e5bcfe1dd66c2a15',
    '2024-11-29 21:23:50.789',
    '20241128101525_init',
    NULL,
    NULL,
    '2024-11-29 21:23:46.535',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '8a37487f-0a6a-4c9b-bc81-70f22d66a5de',
    '430676788045d9c496279540d737f16f4dbd534a86659f76219093f1da8e2ca3',
    '2025-01-23 11:53:05.246',
    '20250123115304_added_transactions',
    NULL,
    NULL,
    '2025-01-23 11:53:04.091',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'ad035029-eb53-4007-bdd2-522cb78496e7',
    '152fb14ab1c12b51ea72f22b4005070137b600b1acb3957f84fc09888167d69d',
    '2024-12-03 03:02:05.323',
    '20241203030204_account_updated',
    NULL,
    NULL,
    '2024-12-03 03:02:04.819',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'ca4ff5c5-bb73-4491-bff4-e7d8fe8b013e',
    '42e1c8e5e3174fe8f8e0b65039afb97f7e781d85a0e68381984a7ea6c5e244fe',
    '2024-12-04 16:29:50.873',
    '20241204162950_updated',
    NULL,
    NULL,
    '2024-12-04 16:29:50.626',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'd423b8aa-4ead-456f-8fe4-2140993e52d3',
    '395757ae3a1b38a1619b18e4aa27b4ea7fc6282a75e50cc379fa6ceea4be890e',
    '2025-02-08 09:39:27.928',
    '20250208093927_updates',
    NULL,
    NULL,
    '2025-02-08 09:39:27.849',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'dbe55f3e-a53e-47ab-89c5-6b2769ac8f67',
    '3f681dc94e34e6a2f5f1a87ab3a6f90a0cd1ae6568c4e505caa60c13f8c2b320',
    '2025-02-08 09:58:13.503',
    '20250208095812_hmm',
    NULL,
    NULL,
    '2025-02-08 09:58:12.256',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'e48007b2-2354-4bc7-b1b6-f8e816ed70e0',
    '617cf1fcb3496fae5c068d2af0ebf11a9f924ae1aecfdca6817dd367bcac4b66',
    '2024-12-03 20:02:54.718',
    '20241203200254_classhistory',
    NULL,
    NULL,
    '2024-12-03 20:02:54.299',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'e63f4e16-bf73-42dc-a95a-c00cb9ba6558',
    'c9c1cf5666ec29a39ef35ab0415fecc808cbcc717a56502986ca752c594eec79',
    '2025-01-29 17:49:56.368',
    '20250129174955_transactionhist',
    NULL,
    NULL,
    '2025-01-29 17:49:55.597',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'f735d3c5-cce8-4305-9ea1-215aa8fdeda2',
    '9b338c8898f0ef68f459a589e63a2ca35c394b7bb57ffbd9bb0d0358a5381baa',
    '2025-02-01 07:06:44.931',
    '20250201070644_fees',
    NULL,
    NULL,
    '2025-02-01 07:06:44.812',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'fa8090b9-5985-4ad6-a29f-b44d1fdb8822',
    'feadb5ff78adfdf71f417e93aa1bd4651db401b4c2c08161e50ea6a86032e690',
    '2025-01-29 10:10:23.774',
    '20250129101023_bettertnx',
    NULL,
    NULL,
    '2025-01-29 10:10:23.184',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: _staffstosubjects
# ------------------------------------------------------------

INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0000', '18mZBlZ');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP3', '18mZBlZ');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP4', 'bDliUQN');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0000', 'E7JETdx');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP3', 'E7JETdx');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP3', 'o9bUcgF');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0000', 'Vx7JKMR');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP3', 'Vx7JKMR');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: accounts
# ------------------------------------------------------------

INSERT INTO
  `accounts` (
    `id`,
    `name`,
    `username`,
    `passHash`,
    `empid`,
    `permissions`,
    `createdAt`,
    `updatedAt`,
    `updatedById`,
    `active`,
    `role`
  )
VALUES
  (
    '8uIPHRQ',
    'Ibrahim Folorunsho',
    'tacheyon',
    '00a49fa200fb624f879f26b296fa89f0f3676f1f2ba10de2b5f39b800b34fcb4',
    'EMP0000',
    '{\"staffs\": {\"edit\": true, \"view\": true, \"create\": true}, \"classes\": {\"edit\": true, \"view\": true}, \"results\": {\"edit\": true, \"view\": true, \"create\": true}, \"accounts\": true, \"payments\": {\"edit\": true, \"view\": true, \"create\": true}, \"students\": {\"edit\": true, \"view\": true, \"create\": true}, \"statement\": true, \"studentPromotions\": true}',
    '2024-11-29 11:11:24.098',
    '2025-02-08 10:56:51.717',
    'pS2M79v',
    1,
    'admin'
  );
INSERT INTO
  `accounts` (
    `id`,
    `name`,
    `username`,
    `passHash`,
    `empid`,
    `permissions`,
    `createdAt`,
    `updatedAt`,
    `updatedById`,
    `active`,
    `role`
  )
VALUES
  (
    'f4RocSh',
    'Alexander Ehichioya Samuel',
    'Alexander',
    'e8a00edfff2862bfdef5f90ac0ac9db32d17060f1e0f388874127bf8fa03785f',
    'EMP2',
    '{\"staffs\": {\"edit\": true, \"view\": true, \"create\": true}, \"classes\": {\"edit\": true, \"view\": true}, \"results\": {\"edit\": true, \"view\": true, \"create\": true}, \"accounts\": true, \"payments\": {\"edit\": true, \"view\": true, \"create\": true}, \"students\": {\"edit\": true, \"view\": true, \"create\": true}, \"statement\": true, \"staffPromotions\": false, \"studentPromotions\": true}',
    '2024-12-08 11:32:18.959',
    '2025-01-22 22:11:20.613',
    'pS2M79v',
    1,
    'user'
  );
INSERT INTO
  `accounts` (
    `id`,
    `name`,
    `username`,
    `passHash`,
    `empid`,
    `permissions`,
    `createdAt`,
    `updatedAt`,
    `updatedById`,
    `active`,
    `role`
  )
VALUES
  (
    'MwA8gDw',
    'Ibrahim Folorunsho',
    'Ibrahim',
    '2c8cf0b74fac368f6c58c87f32e4e04accfc54da5fe0b43b2b4941517cda3cf0',
    'EMP3',
    '{\"staffs\": {\"edit\": true, \"view\": true, \"create\": true}, \"classes\": {\"edit\": true, \"view\": true}, \"results\": {\"edit\": true, \"view\": true, \"create\": true}, \"accounts\": true, \"payments\": {\"edit\": false, \"view\": false, \"create\": false}, \"students\": {\"edit\": true, \"view\": true, \"create\": true}, \"statement\": true, \"studentPromotions\": true}',
    '2025-01-05 18:19:32.441',
    '2025-02-08 10:31:36.865',
    'pS2M79v',
    0,
    'admin'
  );
INSERT INTO
  `accounts` (
    `id`,
    `name`,
    `username`,
    `passHash`,
    `empid`,
    `permissions`,
    `createdAt`,
    `updatedAt`,
    `updatedById`,
    `active`,
    `role`
  )
VALUES
  (
    'oVUonwk',
    'Folorunsho Ibrahim',
    'Ibrahim',
    'af9d5f1717a38326fff01512ad46f5dd55b013428b7d53456d6b65538fd959f7',
    'EMP4',
    '{\"staffs\": {\"edit\": false, \"view\": false, \"create\": false}, \"classes\": {\"edit\": false, \"view\": false}, \"results\": {\"edit\": false, \"view\": true, \"create\": true}, \"accounts\": false, \"payments\": {\"edit\": false, \"view\": false, \"create\": false}, \"students\": {\"edit\": false, \"view\": false, \"create\": false}, \"statement\": true, \"studentPromotions\": false}',
    '2025-02-08 10:44:11.100',
    '2025-02-08 10:53:55.154',
    'pS2M79v',
    0,
    'user'
  );
INSERT INTO
  `accounts` (
    `id`,
    `name`,
    `username`,
    `passHash`,
    `empid`,
    `permissions`,
    `createdAt`,
    `updatedAt`,
    `updatedById`,
    `active`,
    `role`
  )
VALUES
  (
    'pS2M79v',
    'Razaq Folorunsho',
    'dr',
    '03138dbab02312ee1cf70c1d55ba7dd74a93ddd8b6d03e1e0a796bc526e02e41',
    'EMP0001',
    '{\"backup\": true, \"staffs\": {\"edit\": true, \"view\": true, \"create\": true}, \"classes\": {\"edit\": true, \"view\": true}, \"results\": {\"edit\": true, \"view\": true, \"create\": true}, \"accounts\": true, \"payments\": {\"edit\": true, \"view\": true, \"create\": true}, \"settings\": true, \"students\": {\"edit\": true, \"view\": true, \"create\": true}, \"statement\": true, \"staffPromotions\": true, \"studentPromotions\": true}',
    '2024-11-29 21:49:23.119',
    '2025-01-23 11:54:49.349',
    'pS2M79v',
    1,
    'admin'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: appointments
# ------------------------------------------------------------

INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('03H7jxR', 'Head Teacher', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('3Kn876O', 'Account Officer', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('4yWz-bS', 'Subject teacher', 'Secondary');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('5wYRmkl', 'Class teacher', 'Primary');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('aKlSHER', 'Exam Officer', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('DqRIY54', 'Subject teacher', 'Primary');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('h8sbK6M', 'Subject teacher', 'Nursery');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('hgMVtMr', 'Subject teacher', 'JSS');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('K-cqp6M', 'Vice Principal', 'Secondary');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('kYcRLZ6', 'Principal', 'Secondary');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  (
    'MmatXY7',
    'Subject teacher',
    'Nursery and Primary'
  );
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('mwGlYtA', 'Subject teacher', 'Pre-nursery');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('PPwTovO', 'Proprietor', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('qWdQ43r', 'Bursar', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('sBVosZx', 'Vice Principal', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('U4oJShh', 'Principal', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('V1Ya3y2', 'Clerk', 'All');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  (
    'VY7Trt7',
    'Vice Head Master',
    'Nursery and Primary'
  );
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('WVDV0SO', 'Head Master', 'Nursery and Primary');
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('xRyGm5N', 'Subject teacher', 'SSS');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: authhistory
# ------------------------------------------------------------

INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5jux6gn000110b3l4rzvs8w',
    'f4RocSh',
    'Logged-in',
    '2025-01-05 16:58:35.634',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5jvacdg0001ldlla2dxiqvg',
    'f4RocSh',
    'Logged-in',
    '2025-01-05 17:08:49.826',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5jxtpd70003dbszqzlgaq6l',
    'pS2M79v',
    'Logged-in',
    '2025-01-05 18:19:52.361',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5jxu29v0005dbszf9t0vf5r',
    'MwA8gDw',
    'Logged-in',
    '2025-01-05 18:20:09.090',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5jxxtds0007dbszed3l5chg',
    'pS2M79v',
    'Logged-in',
    '2025-01-05 18:23:04.190',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5jxy3u40009dbszz2l0ps6l',
    'MwA8gDw',
    'Logged-in',
    '2025-01-05 18:23:17.739',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5jy2m83000bdbszu5k9fyk5',
    'MwA8gDw',
    'Logged-in',
    '2025-01-05 18:26:48.194',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5laci2i0001ro2h8nn4lk49',
    'MwA8gDw',
    'Logged-in',
    '2025-01-06 16:58:10.932',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5ld8alo0001y1gntm7b6u3l',
    'MwA8gDw',
    'Logged-in',
    '2025-01-06 18:18:53.478',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5ld8jbc0003y1gnd0du52jc',
    'f4RocSh',
    'Logged-in',
    '2025-01-06 18:19:04.775',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm5msb4it0001hv3s48gcfzj0',
    'f4RocSh',
    'Logged-in',
    '2025-01-07 18:08:45.984',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm68clrfl000111uewj44dtur',
    'f4RocSh',
    'Logged-in',
    '2025-01-22 20:20:04.252',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm68g6vng0001rwkgh2wcnh26',
    '8uIPHRQ',
    'Logged-in',
    '2025-01-22 22:00:28.340',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm68g7kjg0003rwkgysux24y0',
    'pS2M79v',
    'Logged-in',
    '2025-01-22 22:01:00.602',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm68gl6fo0005rwkgqg9c6eig',
    'f4RocSh',
    'Logged-in',
    '2025-01-22 22:11:35.506',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm697617m0001sqdnpd5zcwsb',
    'pS2M79v',
    'Logged-in',
    '2025-01-23 10:35:38.524',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm69a03qr0001ap7nl68oghaf',
    'pS2M79v',
    'Logged-in',
    '2025-01-23 11:55:00.715',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm69a3slh000112t8hm14kt3e',
    'pS2M79v',
    'Logged-in',
    '2025-01-23 11:57:52.899',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm69cn1e50001xjptquius94c',
    'MwA8gDw',
    'Logged-in',
    '2025-01-23 13:08:49.987',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm69cqueg0001xjdczg8tmjyx',
    'pS2M79v',
    'Logged-in',
    '2025-01-23 13:11:47.557',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm69cr7d40003xjdc9n7d6ywq',
    'MwA8gDw',
    'Logged-in',
    '2025-01-23 13:12:04.357',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6akanzz000484ez8din2m5d',
    'f4RocSh',
    'Logged-in',
    '2025-01-24 09:30:55.866',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6clflw60001fcv51f81oyl1',
    'pS2M79v',
    'Logged-in',
    '2025-01-25 19:38:18.366',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6clfqb30003fcv5usmhq3l8',
    'pS2M79v',
    'Logged-in',
    '2025-01-25 19:38:24.109',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6tngf0b0001ym93hm9y3lv9',
    'pS2M79v',
    'Logged-in',
    '2025-02-06 18:07:00.345',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6tnqwli0003ym93l7oisk8k',
    'pS2M79v',
    'Logged-in',
    '2025-02-06 18:15:09.701',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6vyw7qw0001qz7hq2t5y6us',
    'pS2M79v',
    'Logged-in',
    '2025-02-08 09:02:45.553',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6w2sreb0001gdfzfojfdebs',
    'oVUonwk',
    'Logged-in',
    '2025-02-08 10:52:02.858',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6w2uk8e0003gdfzvme5ry2p',
    'pS2M79v',
    'Logged-in',
    '2025-02-08 10:53:26.892',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6w2w9ut0007gdfztrxqlaax',
    'pS2M79v',
    'Logged-in',
    '2025-02-08 10:54:46.755',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6w2wz6h0009gdfz8jch6vue',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-08 10:55:19.575',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6w2xcy7000bgdfzyv8i6bra',
    'pS2M79v',
    'Logged-in',
    '2025-02-08 10:55:37.421',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm6w2zpn50001el6bzyuqkrpb',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-08 10:57:27.182',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm7d05ih50005f2ncabjgytew',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-20 07:10:03.976',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm7d0et81000173n0jyg0uivc',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-20 07:17:17.803',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm7d0l1ye0001atdrjib15ts3',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-20 07:22:09.060',
    NULL
  );
INSERT INTO
  `authhistory` (
    `id`,
    `account_id`,
    `auth_status`,
    `logged_in_at`,
    `logged_out_at`
  )
VALUES
  (
    'cm7d0nxxz0001s85bjr1ggtzf',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-20 07:24:23.829',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: classes
# ------------------------------------------------------------

INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('1HN7a2S', 'JSS 3', NULL, 'JSS');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('2_fPzDw', 'SSS 2', NULL, 'SSS');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('2Swr2b9', 'Primary 4', NULL, 'Primary');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('3KinXhL', 'Nursery 2', NULL, 'Nursery');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('Am11LSd', 'Primary 2', NULL, 'Primary');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('dN0jTMw', 'Primary 5', NULL, 'Primary');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('Ifq45cL', 'SSS 1', NULL, 'SSS');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('l70u-3O', 'Pre-nursery', NULL, 'Pre-nursery');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('MSGxhsy', 'Primary 1', NULL, 'Primary');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('OG88Mt7', 'Primary 3', NULL, 'Primary');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('OiarM_a', 'Nursery 1', NULL, 'Nursery');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('OMVKFac', 'JSS 1', 'EMP3', 'JSS');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('QA1juMZ', 'SSS 3', NULL, 'SSS');
INSERT INTO
  `classes` (`id`, `name`, `teacher_id`, `school_section`)
VALUES
  ('T9Bo3Ne', 'JSS 2', NULL, 'JSS');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: classhistory
# ------------------------------------------------------------

INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '14e2d575-f1bb-4469-ba6d-02a7968eac04',
    'AJ3njGo',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '16198cfe-4865-4a63-911b-7899ee7111c9',
    'AJ3njGo',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '21a3ddb5-489a-4eca-9116-32f5ad7f911d',
    'AJ3njGo',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '27b08bf5-1f2b-45bd-b3a6-56d81d0bb711',
    'AJ3njGo',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '3b597354-20a0-4e6f-8460-a9c0ded220c2',
    'AJ3njGo',
    'QA1juMZ',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '457bdfc7-428f-4596-920f-032509c122b7',
    'FWpZizc',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '93e99ba1-6336-46b1-a3c9-dfff414ec4ab',
    'FWpZizc',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '946e3753-3e45-439c-a53a-5d454ac0a021',
    'FWpZizc',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'c46153c8-4eee-4814-86f2-6e4bfa8635b8',
    'RAN1AcR',
    'OMVKFac',
    '2023/2024'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'c6f3f874-2220-4d4e-8a1a-3fc333656008',
    'RAN1AcR',
    'T9Bo3Ne',
    '2023/2024'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'ca4120a5-5632-41ec-8952-a04fbb2fab02',
    'FWpZizc',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'd9ad3dcb-79f5-4711-80da-2117740107bc',
    'AJ3njGo',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e5b29ded-6b34-4e28-b2b6-4d98594716d4',
    'RZ2jHBA',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e6a8658d-e1b5-4ba4-bf29-1d0ebd05395d',
    'AJ3njGo',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'f44f1bcf-566c-43a8-b4ea-52115b520bec',
    'JfjwfqB',
    'Ifq45cL',
    '2024/2025'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: demotions
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: disengagedstudent
# ------------------------------------------------------------

INSERT INTO
  `disengagedstudent` (
    `id`,
    `student_id`,
    `session`,
    `term`,
    `date_of_disengagement`,
    `method_of_disengagement`,
    `reason`,
    `comment`,
    `createdById`
  )
VALUES
  (
    'cm5jxr36g0001dbsz5arcpbvx',
    'JfjwfqB',
    '2024/2025',
    '2nd term',
    '2025-01-05 18:17:50.292',
    'Relocation',
    NULL,
    '',
    'f4RocSh'
  );
INSERT INTO
  `disengagedstudent` (
    `id`,
    `student_id`,
    `session`,
    `term`,
    `date_of_disengagement`,
    `method_of_disengagement`,
    `reason`,
    `comment`,
    `createdById`
  )
VALUES
  (
    'cm6w28a6j0001ap6bquxefo17',
    'RZ2jHBA',
    '2024/2025',
    '2nd term',
    '2025-02-08 10:36:07.430',
    'Relocation',
    NULL,
    'tacheyonRedmi',
    'pS2M79v'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: disengagemnets
# ------------------------------------------------------------

INSERT INTO
  `disengagemnets` (
    `id`,
    `staff_id`,
    `date_of_disengagement`,
    `method_of_disengagement`,
    `reason`,
    `employer_comment`,
    `createdById`
  )
VALUES
  (
    'cm6w2v5zv0005gdfziwuzlibq',
    'EMP4',
    '2025-02-08 10:53:55.100',
    'Sacked',
    '',
    '',
    'pS2M79v'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: examresults
# ------------------------------------------------------------

INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '_pVrFC6',
    'AJ3njGo',
    'Ifq45cL',
    'lRKKmoa',
    36,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.645',
    '2024-11-30 22:17:13.645',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '_qWjTeD',
    'AJ3njGo',
    'Ifq45cL',
    'l95dKX8',
    30,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.663',
    '2024-11-30 22:17:13.663',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '19UoFPB',
    'RAN1AcR',
    'OMVKFac',
    '18mZBlZ',
    35,
    '2023/2024',
    '1st term',
    'pS2M79v',
    '2024-12-08 16:32:18.035',
    '2024-12-08 16:41:11.481',
    'pS2M79v'
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '46hJGke',
    'AJ3njGo',
    'Ifq45cL',
    '18mZBlZ',
    40,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:15:59.780',
    '2024-11-30 22:17:13.686',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '5GpPDvH',
    'AJ3njGo',
    'Ifq45cL',
    'nMFpFkZ',
    36,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.627',
    '2024-11-30 22:17:13.627',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'AvRx8Mi',
    'AJ3njGo',
    'Ifq45cL',
    'bDliUQN',
    40,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:15:59.760',
    '2024-11-30 22:17:13.686',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'gx8-tO4',
    'AJ3njGo',
    'Ifq45cL',
    'o9bUcgF',
    56,
    '2024/2025',
    '1st term',
    'pS2M79v',
    '2025-01-29 16:23:01.914',
    '2025-01-29 16:23:01.914',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'H7Ih8Ps',
    'AJ3njGo',
    'Ifq45cL',
    'eIi5HQm',
    38,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.678',
    '2024-11-30 22:17:13.678',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'hGpYWGh',
    'AJ3njGo',
    'Ifq45cL',
    'pFZPf3T',
    36,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.626',
    '2024-11-30 22:17:13.626',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'k-Uxoth',
    'AJ3njGo',
    'Ifq45cL',
    'x9oVrQ9',
    34,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.646',
    '2024-11-30 22:17:13.646',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'NnQJxyi',
    'AJ3njGo',
    'Ifq45cL',
    'g9NIUEF',
    30,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.665',
    '2024-11-30 22:17:13.665',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'ogcHkex',
    'AJ3njGo',
    'Ifq45cL',
    'bT759gG',
    40,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.681',
    '2024-11-30 22:17:13.681',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'rTF_0SR',
    'AJ3njGo',
    'Ifq45cL',
    'YOb8XbD',
    34,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.645',
    '2024-11-30 22:17:13.645',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'VrV5LV_',
    'AJ3njGo',
    'Ifq45cL',
    'nGFxkVf',
    36,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.628',
    '2024-11-30 22:17:13.628',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'WV-uKv_',
    'AJ3njGo',
    'Ifq45cL',
    'Vx7JKMR',
    34,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.627',
    '2024-11-30 22:17:13.627',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'Xe53eOU',
    'AJ3njGo',
    'Ifq45cL',
    'IC1gVq9',
    30,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.674',
    '2024-11-30 22:17:13.674',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'zG88X4v',
    'AJ3njGo',
    'QA1juMZ',
    'bDliUQN',
    50,
    '2024/2025',
    '2nd term',
    'pS2M79v',
    '2025-02-08 10:29:53.670',
    '2025-02-08 10:29:53.670',
    NULL
  );
INSERT INTO
  `examresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'ZYE2vh1',
    'AJ3njGo',
    'Ifq45cL',
    'E7JETdx',
    50,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:17:13.679',
    '2024-11-30 22:17:13.679',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fcaresults
# ------------------------------------------------------------

INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '_cjL5Zx',
    'AJ3njGo',
    'Ifq45cL',
    'l95dKX8',
    15,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.113',
    '2024-11-30 22:09:39.670',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '1nny7vz',
    'RAN1AcR',
    'OMVKFac',
    '18mZBlZ',
    6,
    '2023/2024',
    '1st term',
    'pS2M79v',
    '2024-12-08 16:27:34.702',
    '2025-01-05 17:02:16.528',
    'f4RocSh'
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '4lc20jM',
    'AJ3njGo',
    'Ifq45cL',
    '18mZBlZ',
    20,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.144',
    '2024-12-03 10:13:16.439',
    '8uIPHRQ'
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '4qTcj7q',
    'AJ3njGo',
    'Ifq45cL',
    'bDliUQN',
    18,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.142',
    '2024-11-30 22:09:39.708',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '6R_sCkk',
    'AJ3njGo',
    'Ifq45cL',
    'eIi5HQm',
    18,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.124',
    '2024-11-30 22:09:39.697',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '95WOZAA',
    'RZ2jHBA',
    'OMVKFac',
    'bDliUQN',
    1,
    '2024/2025',
    '2nd term',
    'oVUonwk',
    '2025-02-08 10:52:48.863',
    '2025-02-08 10:52:48.863',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'agliA_f',
    'AJ3njGo',
    'Ifq45cL',
    'o9bUcgF',
    19,
    '2024/2025',
    '1st term',
    'pS2M79v',
    '2025-01-29 16:25:51.914',
    '2025-02-08 10:28:09.426',
    'pS2M79v'
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'BEQnTJS',
    'AJ3njGo',
    'Ifq45cL',
    'bT759gG',
    18,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.129',
    '2024-11-30 22:09:39.699',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'bY0hJUm',
    'AJ3njGo',
    'Ifq45cL',
    'YOb8XbD',
    19,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:11.981',
    '2024-11-30 22:09:39.668',
    '8uIPHRQ'
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'dAbS7Ng',
    'AJ3njGo',
    'Ifq45cL',
    'IC1gVq9',
    15,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.117',
    '2024-11-30 22:09:39.691',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'fd3B0JT',
    'AJ3njGo',
    'Ifq45cL',
    'nGFxkVf',
    9,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:11.993',
    '2024-11-30 22:08:14.508',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'GxiHTaE',
    'AJ3njGo',
    'Ifq45cL',
    'pFZPf3T',
    15,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:11.984',
    '2024-11-30 22:09:39.669',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'hh5Q0sW',
    'AJ3njGo',
    'Ifq45cL',
    'E7JETdx',
    20,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.126',
    '2024-11-30 22:09:39.697',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'j9MG_G2',
    'AJ3njGo',
    'Ifq45cL',
    'nMFpFkZ',
    15,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:11.989',
    '2024-11-30 22:09:39.669',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'kPVK0Mt',
    'AJ3njGo',
    'QA1juMZ',
    'bDliUQN',
    12,
    '2024/2025',
    '2nd term',
    'pS2M79v',
    '2025-02-08 10:28:50.819',
    '2025-02-08 10:28:50.819',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'mWvZoad',
    'AJ3njGo',
    'Ifq45cL',
    'g9NIUEF',
    15,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.121',
    '2024-11-30 22:09:39.695',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'PcUKdL5',
    'FWpZizc',
    'Ifq45cL',
    '18mZBlZ',
    2,
    '2023/2024',
    '1st term',
    '8uIPHRQ',
    '2024-12-03 16:44:12.541',
    '2024-12-03 16:44:12.541',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'Q-vJ2YW',
    'AJ3njGo',
    'Ifq45cL',
    'lRKKmoa',
    15,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:11.995',
    '2024-11-30 22:09:39.671',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'vFkTTkQ',
    'AJ3njGo',
    'Ifq45cL',
    'x9oVrQ9',
    15,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:11.987',
    '2024-11-30 22:09:39.672',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'vTnzYfx',
    'AJ3njGo',
    'Ifq45cL',
    '18mZBlZ',
    1,
    '2021/2022',
    '1st term',
    '8uIPHRQ',
    '2024-12-03 21:40:24.608',
    '2024-12-03 21:40:24.608',
    NULL
  );
INSERT INTO
  `fcaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'zgqy0Tb',
    'AJ3njGo',
    'Ifq45cL',
    'Vx7JKMR',
    20,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-29 23:51:12.146',
    '2024-11-30 22:09:39.697',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: feesgroup
# ------------------------------------------------------------

INSERT INTO
  `feesgroup` (`id`, `name`, `amount`)
VALUES
  ('0jcBxk5', 'PTA', '3500');
INSERT INTO
  `feesgroup` (`id`, `name`, `amount`)
VALUES
  ('Exo4omu', 'School fee', '12000');
INSERT INTO
  `feesgroup` (`id`, `name`, `amount`)
VALUES
  ('qXJJvNo', 'First Term', '12000');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: payments
# ------------------------------------------------------------

INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm69ktqei000084ezjtomalln',
    '2nd term',
    '2024/2025',
    '2025-01-23 00:00:00.000',
    12000,
    'Exo4omu',
    1,
    12000,
    'Cash',
    'Paid',
    NULL,
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm69ktqek000184ezfj7mos7b',
    '2nd term',
    '2024/2025',
    '2025-01-23 00:00:00.000',
    3500,
    '0jcBxk5',
    1,
    3500,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm69kubt7000284ezg2snu81z',
    '2nd term',
    '2024/2025',
    '2025-01-23 00:00:00.000',
    3500,
    '0jcBxk5',
    2,
    3500,
    'Cash',
    'Paid',
    NULL,
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6ev387n000010vlind2627m',
    '2nd term',
    '2024/2025',
    '2025-01-27 00:00:00.000',
    3500,
    '0jcBxk5',
    3,
    3500,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6ev5nd9000110vl168fswhm',
    '2nd term',
    '2024/2025',
    '2025-01-27 00:00:00.000',
    12000,
    'Exo4omu',
    4,
    12000,
    'Cash',
    'Paid',
    NULL,
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6iguk5r00007ocw64am0vlj',
    '2nd term',
    '2024/2025',
    '2025-01-29 00:00:00.000',
    12000,
    'Exo4omu',
    5,
    12000,
    'Cash',
    'Paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6iguk5v00017ocw8nvzhpg7',
    '2nd term',
    '2024/2025',
    '2025-01-29 00:00:00.000',
    3500,
    '0jcBxk5',
    5,
    3500,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6jn0ezj00003t2uq19o9lxv',
    '2nd term',
    '2024/2025',
    '2025-01-30 00:00:00.000',
    12000,
    'Exo4omu',
    6,
    12000,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6jn0ezn00013t2ujaokmnka',
    '2nd term',
    '2024/2025',
    '2025-01-30 00:00:00.000',
    3500,
    '0jcBxk5',
    6,
    3500,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6m0f0y50000i4t8wb1hj4mh',
    '2nd term',
    '2024/2025',
    '2025-02-01 00:00:00.000',
    12000,
    'qXJJvNo',
    7,
    12000,
    'Cash',
    'Paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6m0f0y70001i4t80km3heo1',
    '2nd term',
    '2024/2025',
    '2025-02-01 00:00:00.000',
    12000,
    'Exo4omu',
    7,
    12000,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6m0f0y70002i4t8fj5zlkrn',
    '2nd term',
    '2024/2025',
    '2025-02-01 00:00:00.000',
    3500,
    '0jcBxk5',
    7,
    3500,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6m0lqgo0003i4t8kuexb1o1',
    '2nd term',
    '2024/2025',
    '2025-02-01 00:00:00.000',
    12000,
    'qXJJvNo',
    8,
    12000,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6myilz40000k5ms1z1v4o86',
    '2nd term',
    '2024/2025',
    '2025-02-02 00:00:00.000',
    12000,
    'qXJJvNo',
    9,
    11000,
    'Cash',
    'Partly paid',
    '',
    NULL
  );
INSERT INTO
  `payments` (
    `payment_id`,
    `term`,
    `session`,
    `createdAt`,
    `amount`,
    `item_id`,
    `transactionId`,
    `paid`,
    `payment_method`,
    `status`,
    `teller_no`,
    `updatedAt`
  )
VALUES
  (
    'cm6myilz80001k5msejsw5e6n',
    '2nd term',
    '2024/2025',
    '2025-02-02 00:00:00.000',
    3500,
    '0jcBxk5',
    9,
    3500,
    'Cash',
    'Partly paid',
    '',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: promotions
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: scaresults
# ------------------------------------------------------------

INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '08rWeOH',
    'AJ3njGo',
    'Ifq45cL',
    'IC1gVq9',
    11,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:30.981',
    '2024-11-30 22:14:30.981',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '0tmodQg',
    'AJ3njGo',
    'Ifq45cL',
    'x9oVrQ9',
    11,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.030',
    '2024-11-30 22:14:31.030',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    '4raoHq8',
    'AJ3njGo',
    'Ifq45cL',
    'E7JETdx',
    18,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.030',
    '2024-11-30 22:14:31.030',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'b-FMUP-',
    'AJ3njGo',
    'Ifq45cL',
    'o9bUcgF',
    18,
    '2024/2025',
    '1st term',
    'pS2M79v',
    '2025-01-29 16:24:15.093',
    '2025-01-29 16:24:15.093',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'BFd8PBX',
    'AJ3njGo',
    'QA1juMZ',
    'bDliUQN',
    12,
    '2024/2025',
    '2nd term',
    'pS2M79v',
    '2025-02-08 10:29:19.327',
    '2025-02-08 10:29:19.327',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'ctaCXEn',
    'AJ3njGo',
    'Ifq45cL',
    'bT759gG',
    14,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.031',
    '2024-11-30 22:14:31.031',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'E3vF_GE',
    'AJ3njGo',
    'Ifq45cL',
    'nMFpFkZ',
    11,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.031',
    '2024-11-30 22:14:31.031',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'fqECakE',
    'AJ3njGo',
    'Ifq45cL',
    'pFZPf3T',
    11,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.050',
    '2024-11-30 22:14:31.050',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'gpPQlGT',
    'AJ3njGo',
    'Ifq45cL',
    'Vx7JKMR',
    11,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:30.981',
    '2024-11-30 22:14:30.981',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'MDhij73',
    'AJ3njGo',
    'Ifq45cL',
    'eIi5HQm',
    14,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.030',
    '2024-11-30 22:14:31.030',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'MYVhTrQ',
    'AJ3njGo',
    'Ifq45cL',
    'bDliUQN',
    12,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.048',
    '2024-11-30 22:14:31.048',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'OJgbiT4',
    'AJ3njGo',
    'Ifq45cL',
    'eIi5HQm',
    11,
    '2024/2025',
    '2nd term',
    'f4RocSh',
    '2025-01-05 18:14:45.368',
    '2025-01-06 18:16:12.609',
    'MwA8gDw'
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'q9JG9UC',
    'AJ3njGo',
    'Ifq45cL',
    'l95dKX8',
    8,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:30.988',
    '2024-11-30 22:14:30.988',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'qnvdaHP',
    'AJ3njGo',
    'Ifq45cL',
    'lRKKmoa',
    10,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:30.982',
    '2024-11-30 22:14:30.982',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    's-ETnMr',
    'AJ3njGo',
    'Ifq45cL',
    '18mZBlZ',
    12,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.048',
    '2024-11-30 22:14:31.048',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'T5XzU06',
    'AJ3njGo',
    'Ifq45cL',
    'g9NIUEF',
    8,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:31.030',
    '2024-11-30 22:14:31.030',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'UJ2TA9H',
    'AJ3njGo',
    'Ifq45cL',
    'YOb8XbD',
    18,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:30.980',
    '2024-11-30 22:14:30.980',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'VPnMUOa',
    'AJ3njGo',
    'Ifq45cL',
    'nGFxkVf',
    8,
    '2024/2025',
    '1st term',
    '8uIPHRQ',
    '2024-11-30 22:14:30.984',
    '2024-11-30 22:14:30.984',
    NULL
  );
INSERT INTO
  `scaresults` (
    `id`,
    `student_id`,
    `class_id`,
    `subject_id`,
    `score`,
    `session`,
    `term`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'Z149YA1',
    'RAN1AcR',
    'OMVKFac',
    '1oHZ6vY',
    7,
    '2023/2024',
    '1st term',
    'pS2M79v',
    '2024-12-08 16:31:48.148',
    '2024-12-08 16:40:23.141',
    'pS2M79v'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: staffs
# ------------------------------------------------------------

INSERT INTO
  `staffs` (
    `empid`,
    `address`,
    `telephone`,
    `state_of_origin`,
    `lga`,
    `qualification`,
    `grade_level`,
    `salary`,
    `school_section`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `religion`,
    `marital_status`,
    `appointed_as`,
    `curr_appointment_id`,
    `date_of_emp`,
    `active`,
    `updatedAt`,
    `createdById`,
    `updatedById`
  )
VALUES
  (
    'EMP0000',
    'Al barka hospital Wawa',
    '08119513281',
    'Kwara',
    'Oyun',
    'Bsc. Computer science',
    2,
    '0',
    'All',
    'Ibrahim',
    'Folorunsho',
    '2001-10-25 00:00:00.000',
    'Male',
    'Islam',
    'Single',
    '',
    'xRyGm5N',
    '2024-10-01 00:00:00.000',
    1,
    '2025-01-29 16:19:41.119',
    NULL,
    '8uIPHRQ'
  );
INSERT INTO
  `staffs` (
    `empid`,
    `address`,
    `telephone`,
    `state_of_origin`,
    `lga`,
    `qualification`,
    `grade_level`,
    `salary`,
    `school_section`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `religion`,
    `marital_status`,
    `appointed_as`,
    `curr_appointment_id`,
    `date_of_emp`,
    `active`,
    `updatedAt`,
    `createdById`,
    `updatedById`
  )
VALUES
  (
    'EMP0001',
    'Al barka hospital Wawa',
    '',
    'Niger',
    '',
    '',
    0,
    '',
    'All',
    'Razaq',
    'Folorunsho',
    '1970-01-01 00:00:00.000',
    'Male',
    'Islam',
    'Married',
    'Proprietor - All',
    'PPwTovO',
    '2024-11-04 00:00:00.000',
    1,
    '2024-12-06 00:41:03.032',
    NULL,
    'pS2M79v'
  );
INSERT INTO
  `staffs` (
    `empid`,
    `address`,
    `telephone`,
    `state_of_origin`,
    `lga`,
    `qualification`,
    `grade_level`,
    `salary`,
    `school_section`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `religion`,
    `marital_status`,
    `appointed_as`,
    `curr_appointment_id`,
    `date_of_emp`,
    `active`,
    `updatedAt`,
    `createdById`,
    `updatedById`
  )
VALUES
  (
    'EMP2',
    'IRRUA',
    '08069524833',
    'Edo',
    '',
    'B.TECH(INDUSTRIAL CHEMISTRY)',
    0,
    '',
    'Secondary',
    'Alexander',
    'Ehichioya Samuel',
    '1970-01-01 00:00:00.000',
    'Male',
    'Christianity',
    'Married',
    'Class teacher - Primary',
    'kYcRLZ6',
    '2020-05-27 11:25:06.378',
    1,
    '2025-01-22 20:33:04.279',
    'pS2M79v',
    'f4RocSh'
  );
INSERT INTO
  `staffs` (
    `empid`,
    `address`,
    `telephone`,
    `state_of_origin`,
    `lga`,
    `qualification`,
    `grade_level`,
    `salary`,
    `school_section`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `religion`,
    `marital_status`,
    `appointed_as`,
    `curr_appointment_id`,
    `date_of_emp`,
    `active`,
    `updatedAt`,
    `createdById`,
    `updatedById`
  )
VALUES
  (
    'EMP3',
    'Al barka hospital Wawa',
    '08119513281',
    'Niger',
    '',
    '',
    0,
    '',
    'All',
    'Ibrahim',
    'Folorunsho',
    '1970-01-01 00:00:00.000',
    '',
    '',
    '',
    'Proprietor - All',
    'xRyGm5N',
    '2025-01-05 18:18:21.997',
    1,
    '2025-01-05 18:22:48.497',
    'f4RocSh',
    'MwA8gDw'
  );
INSERT INTO
  `staffs` (
    `empid`,
    `address`,
    `telephone`,
    `state_of_origin`,
    `lga`,
    `qualification`,
    `grade_level`,
    `salary`,
    `school_section`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `religion`,
    `marital_status`,
    `appointed_as`,
    `curr_appointment_id`,
    `date_of_emp`,
    `active`,
    `updatedAt`,
    `createdById`,
    `updatedById`
  )
VALUES
  (
    'EMP4',
    'Alon Malale Road',
    '',
    'Niger',
    '',
    '',
    0,
    '',
    'Secondary',
    'Folorunsho',
    'Ibrahim',
    NULL,
    'Male',
    'Islam',
    'Single',
    '',
    NULL,
    '2025-02-08 10:42:09.129',
    0,
    '2025-02-08 10:53:55.122',
    'pS2M79v',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: students
# ------------------------------------------------------------

INSERT INTO
  `students` (
    `id`,
    `admission_no`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `address`,
    `state_of_origin`,
    `school_section`,
    `lga`,
    `religion`,
    `date_of_admission`,
    `admission_session`,
    `admission_term`,
    `admission_class`,
    `active`,
    `guardian_name`,
    `guardian_telephone`,
    `curr_class_id`,
    `createdById`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'AJ3njGo',
    'ASW/2024/500',
    'Ibrahim',
    'Folorunsho',
    '2008-10-25 00:00:00.000',
    'Male',
    'Al barka hospital Wawa',
    'Niger',
    'SSS',
    'Borgu',
    'Islam',
    '2022-09-05 00:00:00.000',
    '2024/2025',
    '1st term',
    'SSS 1',
    1,
    'Folorunsho Razaq',
    '08119513281',
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-08 10:04:25.456',
    NULL
  );
INSERT INTO
  `students` (
    `id`,
    `admission_no`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `address`,
    `state_of_origin`,
    `school_section`,
    `lga`,
    `religion`,
    `date_of_admission`,
    `admission_session`,
    `admission_term`,
    `admission_class`,
    `active`,
    `guardian_name`,
    `guardian_telephone`,
    `curr_class_id`,
    `createdById`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'FWpZizc',
    'ASW/2024/501',
    'Ibrahim',
    'Folorunsho',
    '2010-10-25 00:00:00.000',
    'Male',
    'Al barka hospital Wawa',
    'Niger',
    'SSS',
    'Oyun',
    'Islam',
    '2020-09-07 00:00:00.000',
    '2024/2025',
    '1st term',
    'SSS 1',
    1,
    'Folorunsho razaq',
    '08119513281',
    'Ifq45cL',
    '8uIPHRQ',
    '2025-01-05 17:04:28.444',
    NULL
  );
INSERT INTO
  `students` (
    `id`,
    `admission_no`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `address`,
    `state_of_origin`,
    `school_section`,
    `lga`,
    `religion`,
    `date_of_admission`,
    `admission_session`,
    `admission_term`,
    `admission_class`,
    `active`,
    `guardian_name`,
    `guardian_telephone`,
    `curr_class_id`,
    `createdById`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'JfjwfqB',
    'ASW/2021/110',
    'Folorunsho',
    'Ibrahim',
    '2025-01-09 00:00:00.000',
    'Male',
    'Alon Malale Road',
    'Niger',
    'SSS',
    'Borgu',
    'Islam',
    '2024-09-09 00:00:00.000',
    '2024/2025',
    '1st term',
    'SSS 1',
    0,
    'Folorunsho razaq',
    '',
    'Ifq45cL',
    'f4RocSh',
    '2025-01-05 18:17:50.309',
    NULL
  );
INSERT INTO
  `students` (
    `id`,
    `admission_no`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `address`,
    `state_of_origin`,
    `school_section`,
    `lga`,
    `religion`,
    `date_of_admission`,
    `admission_session`,
    `admission_term`,
    `admission_class`,
    `active`,
    `guardian_name`,
    `guardian_telephone`,
    `curr_class_id`,
    `createdById`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'RAN1AcR',
    'ASW/2021/105',
    'Folorunshocc',
    'Ibrahimcxc',
    '2024-12-03 00:00:00.000',
    'Male',
    'Alon Malale Road',
    'Niger',
    'JSS',
    'Borgu',
    'Islam',
    '2024-12-03 00:00:00.000',
    '2023/2024',
    '1st term',
    'JSS 2',
    0,
    'Folorunsho razaq',
    '08119513281',
    'T9Bo3Ne',
    'pS2M79v',
    '2024-12-05 01:11:47.055',
    'pS2M79v'
  );
INSERT INTO
  `students` (
    `id`,
    `admission_no`,
    `first_name`,
    `last_name`,
    `date_of_birth`,
    `sex`,
    `address`,
    `state_of_origin`,
    `school_section`,
    `lga`,
    `religion`,
    `date_of_admission`,
    `admission_session`,
    `admission_term`,
    `admission_class`,
    `active`,
    `guardian_name`,
    `guardian_telephone`,
    `curr_class_id`,
    `createdById`,
    `updatedAt`,
    `updatedById`
  )
VALUES
  (
    'RZ2jHBA',
    'ASW/2021/106',
    'Ibrahima',
    'Folorunshoz',
    '1970-01-01 00:00:00.000',
    'Male',
    'Al barka hospital Wawax',
    'Niger',
    'JSS',
    'Borgu',
    'Islam',
    '2025-02-06 00:00:00.000',
    '2024/2025',
    '2nd term',
    'JSS 1',
    0,
    'Folorunsho Razaq',
    '08119513281',
    'OMVKFac',
    'pS2M79v',
    '2025-02-08 10:36:07.458',
    'pS2M79v'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: studentsdemotions
# ------------------------------------------------------------

INSERT INTO
  `studentsdemotions` (
    `id`,
    `student_id`,
    `from`,
    `term`,
    `session`,
    `to_id`,
    `createdById`,
    `demotedOn`
  )
VALUES
  (
    'AfZHOnm',
    'AJ3njGo',
    'SSS 2',
    '2nd term',
    '2024/2025',
    'Ifq45cL',
    'f4RocSh',
    '2025-01-05 17:04:28.428'
  );
INSERT INTO
  `studentsdemotions` (
    `id`,
    `student_id`,
    `from`,
    `term`,
    `session`,
    `to_id`,
    `createdById`,
    `demotedOn`
  )
VALUES
  (
    'jO6BWXf',
    'AJ3njGo',
    'SSS 3',
    '2nd term',
    '2024/2025',
    '2_fPzDw',
    'pS2M79v',
    '2025-02-08 10:04:25.437'
  );
INSERT INTO
  `studentsdemotions` (
    `id`,
    `student_id`,
    `from`,
    `term`,
    `session`,
    `to_id`,
    `createdById`,
    `demotedOn`
  )
VALUES
  (
    'lYGpXJ6',
    'FWpZizc',
    'SSS 2',
    '2nd term',
    '2024/2025',
    'Ifq45cL',
    'f4RocSh',
    '2025-01-05 17:04:28.429'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: studentspromotions
# ------------------------------------------------------------

INSERT INTO
  `studentspromotions` (
    `id`,
    `student_id`,
    `from`,
    `term`,
    `session`,
    `to_id`,
    `createdById`,
    `promotedOn`
  )
VALUES
  (
    'Mb2gR2I',
    'AJ3njGo',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'QA1juMZ',
    'pS2M79v',
    '2025-02-08 10:03:21.728'
  );
INSERT INTO
  `studentspromotions` (
    `id`,
    `student_id`,
    `from`,
    `term`,
    `session`,
    `to_id`,
    `createdById`,
    `promotedOn`
  )
VALUES
  (
    'NHkpFpZ',
    'AJ3njGo',
    'SSS 1',
    '2nd term',
    '2024/2025',
    '2_fPzDw',
    'f4RocSh',
    '2025-01-05 17:04:05.763'
  );
INSERT INTO
  `studentspromotions` (
    `id`,
    `student_id`,
    `from`,
    `term`,
    `session`,
    `to_id`,
    `createdById`,
    `promotedOn`
  )
VALUES
  (
    'yG-LnYm',
    'FWpZizc',
    'SSS 1',
    '2nd term',
    '2024/2025',
    '2_fPzDw',
    'f4RocSh',
    '2025-01-05 17:04:05.765'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: subjects
# ------------------------------------------------------------

INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('18mZBlZ', 'Mathematics');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('1oHZ6vY', 'Health education');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('3c9EWTV', 'Cultural and Creative Art');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('aVninf3', 'Yoruba/Hausa');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('bDliUQN', 'Biology');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('Bo69IyB', 'Business studies');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('bT759gG', 'Chemistry');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('CfPv-dn', 'Social studies');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('DvclqC0', 'Oral english');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('E7JETdx', 'Computer studies');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('eIi5HQm', 'English language');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('ElqqBT7', 'National values');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('FnMLAER', 'Home economics');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('g9NIUEF', 'Government');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('GQjbl0E', 'History');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('IC1gVq9', 'Geography');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('JFhxsq5', 'Basic science');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('l95dKX8', 'Financial Acounting');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('lqUtsDB', 'IRS/CRS');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('lRKKmoa', 'Agricultural science');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('M5Vv1pi', 'Basic technology');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('MjrnCzB', 'Integrated science');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('nGFxkVf', 'Literature in english');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('nMFpFkZ', 'Commerce');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('nmkGlgl', 'Verbal reasoning');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('nTKfuNC', 'Pre-vocational studies');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('o9bUcgF', 'Further mathematics');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('pFZPf3T', 'Fisheries');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('PyejTsh', 'Rhythm');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('qnPwjEd', 'Quantitave reasoning');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('TFlldgc', 'Religion and national values');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('TJSQ_-v', 'Religion');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('uis6FkF', 'Physical and health education');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('Vx7JKMR', 'Physics');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('x9oVrQ9', 'Economics');
INSERT INTO
  `subjects` (`id`, `name`)
VALUES
  ('YOb8XbD', 'Civic Education');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: transactionhistory
# ------------------------------------------------------------

INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '12be2b5e-1e98-4f1e-8178-6ee899b5a6be',
    7,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm6m0f0y70002i4t8fj5zlkrn\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":1000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":2500,\\\"paidToday\\\":1000}]\"',
    27500,
    25500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-01 00:00:00.000',
    '2025-02-01 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '14b99dd7-1000-4d9b-a7d1-4658b6a5b5c0',
    1,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm69ktqek000184ezfj7mos7b\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":500,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":3000,\\\"paidToday\\\":500},{\\\"payment_id\\\":\\\"cm69ktqei000084ezjtomalln\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":0,\\\"status\\\":\\\"Paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":null,\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":1,\\\"createdAt\\\":\\\"2025-01-23T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"Exo4omu\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":\\\"12000\\\",\\\"school_section\\\":\\\"SSS\\\"},\\\"name\\\":\\\"School fee\\\",\\\"paidToday\\\":0}]\"',
    15500,
    14500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1f03e8a9-4a87-444c-92c9-dcde14ba350f',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":300,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11700,\\\"paidToday\\\":300}]\"',
    15500,
    15400,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '28c475fa-bacc-413c-8c85-2e38197d8a35',
    8,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6m0lqgo0003i4t8kuexb1o1\\\",\\\"name\\\":\\\"First Term\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"qXJJvNo\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":2000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":10000,\\\"paidToday\\\":2000}]\"',
    12000,
    12000,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-01 00:00:00.000',
    '2025-02-01 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '30b796aa-406b-4c18-8584-d765f0c5459d',
    9,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6myilz40000k5ms1z1v4o86\\\",\\\"item_id\\\":\\\"qXJJvNo\\\",\\\"amount\\\":12000,\\\"paid\\\":10000,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":9,\\\"createdAt\\\":\\\"2025-02-02T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"qXJJvNo\\\",\\\"name\\\":\\\"First Term\\\",\\\"amount\\\":\\\"12000\\\"}},{\\\"payment_id\\\":\\\"cm6myilz80001k5msejsw5e6n\\\",\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"amount\\\":3500,\\\"paid\\\":3000,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":9,\\\"createdAt\\\":\\\"2025-02-02T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"0jcBxk5\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":\\\"3500\\\"}}]\"',
    15500,
    13000,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-02 00:00:00.000',
    '2025-02-02 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '31a3f762-c122-427d-adfc-c4f28004a86b',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezn00013t2ujaokmnka\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":1000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":2500,\\\"paidToday\\\":1000}]\"',
    15500,
    13500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '38e44ae7-23a0-40d3-a807-8a172c6c0ee2',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":500,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11500,\\\"paidToday\\\":500}]\"',
    15500,
    15000,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '57512d9c-c97d-4dcd-a04d-c5e0a26f13cd',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":10000,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":6,\\\"createdAt\\\":\\\"2025-01-30T00:00:00.000Z\\\"},{\\\"payment_id\\\":\\\"cm6jn0ezn00013t2ujaokmnka\\\",\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"amount\\\":3500,\\\"paid\\\":2500,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":6,\\\"createdAt\\\":\\\"2025-01-30T00:00:00.000Z\\\"}]\"',
    15500,
    NULL,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '64d75b5c-2575-4929-8079-cf27d67484d5',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":20,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11980,\\\"paidToday\\\":20}]\"',
    15500,
    15470,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '70d3b7e1-04cb-4e81-8160-8083b04eaf8e',
    8,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6m0lqgo0003i4t8kuexb1o1\\\",\\\"item_id\\\":\\\"qXJJvNo\\\",\\\"amount\\\":12000,\\\"paid\\\":10000,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":8,\\\"createdAt\\\":\\\"2025-02-01T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"qXJJvNo\\\",\\\"name\\\":\\\"First Term\\\",\\\"amount\\\":\\\"12000\\\"}}]\"',
    12000,
    NULL,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-01 00:00:00.000',
    '2025-02-01 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '742db500-ce1c-4896-b203-aec170f37534',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":100,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11900,\\\"paidToday\\\":100}]\"',
    15500,
    15100,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8a3e0dfe-57e3-4214-9e42-146818819759',
    5,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm6iguk5v00017ocw8nvzhpg7\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":500,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":3000,\\\"paidToday\\\":500},{\\\"payment_id\\\":\\\"cm6iguk5r00007ocw64am0vlj\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":0,\\\"status\\\":\\\"Paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":5,\\\"createdAt\\\":\\\"2025-01-29T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"Exo4omu\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":\\\"12000\\\",\\\"school_section\\\":\\\"SSS\\\"},\\\"name\\\":\\\"School fee\\\",\\\"paidToday\\\":0}]\"',
    15500,
    15500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '92632a0c-26f0-441d-bbd5-fea613c20a77',
    1,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm69ktqek000184ezfj7mos7b\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":500,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":3000,\\\"paidToday\\\":500},{\\\"payment_id\\\":\\\"cm69ktqei000084ezjtomalln\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":0,\\\"status\\\":\\\"Paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":null,\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":1,\\\"createdAt\\\":\\\"2025-01-23T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"Exo4omu\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":\\\"12000\\\",\\\"school_section\\\":\\\"SSS\\\"},\\\"name\\\":\\\"School fee\\\",\\\"paidToday\\\":0}]\"',
    15500,
    15000,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '92ad68ba-3bfd-4da5-9fd1-d13b0b58f069',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":500,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11500,\\\"paidToday\\\":500}]\"',
    15500,
    15000,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a2711007-68ed-4c66-94fe-6040401af83c',
    9,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6myilz80001k5msejsw5e6n\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"item\\\":{\\\"id\\\":\\\"0jcBxk5\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":\\\"3500\\\"},\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":500,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":3000,\\\"paidToday\\\":500}]\"',
    15500,
    13500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-02 00:00:00.000',
    '2025-02-02 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a548ee42-673c-4dea-af91-4f602b6fd576',
    5,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm6iguk5r00007ocw64am0vlj\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":12000,\\\"status\\\":\\\"Paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":5,\\\"createdAt\\\":\\\"2025-01-29T00:00:00.000Z\\\"},{\\\"payment_id\\\":\\\"cm6iguk5v00017ocw8nvzhpg7\\\",\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"amount\\\":3500,\\\"paid\\\":2000,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":5,\\\"createdAt\\\":\\\"2025-01-29T00:00:00.000Z\\\"}]\"',
    15500,
    NULL,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-01-29 00:00:00.000',
    '2025-01-29 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'bc3e6722-ffb5-4ebe-9709-e00feea3d869',
    1,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm69ktqek000184ezfj7mos7b\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":500,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":3000,\\\"paidToday\\\":500},{\\\"payment_id\\\":\\\"cm69ktqei000084ezjtomalln\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":0,\\\"status\\\":\\\"Paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":null,\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":1,\\\"createdAt\\\":\\\"2025-01-23T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"Exo4omu\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":\\\"12000\\\",\\\"school_section\\\":\\\"SSS\\\"},\\\"name\\\":\\\"School fee\\\",\\\"paidToday\\\":0}]\"',
    15500,
    15500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'bdc6fdfa-a3ce-4e0e-a6d1-6da04c25f2c3',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":50,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11950,\\\"paidToday\\\":50}]\"',
    15500,
    15450,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c0edc517-1d2b-4ccd-952c-1fe5bfe41fe3',
    9,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6myilz40000k5ms1z1v4o86\\\",\\\"name\\\":\\\"First Term\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"qXJJvNo\\\",\\\"item\\\":{\\\"id\\\":\\\"qXJJvNo\\\",\\\"name\\\":\\\"First Term\\\",\\\"amount\\\":\\\"12000\\\"},\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":1000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11000,\\\"paidToday\\\":1000}]\"',
    15500,
    14500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-02 00:00:00.000',
    '2025-02-02 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c52a8428-9b54-4467-b057-1d05295a275c',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":1000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11000,\\\"paidToday\\\":1000},{\\\"payment_id\\\":\\\"cm6jn0ezn00013t2ujaokmnka\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":1000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":2500,\\\"paidToday\\\":1000}]\"',
    15500,
    14500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'cb1488b2-f079-427f-9e1f-4821ef2cb05f',
    7,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm6m0f0y50000i4t8wb1hj4mh\\\",\\\"item_id\\\":\\\"qXJJvNo\\\",\\\"amount\\\":12000,\\\"paid\\\":12000,\\\"status\\\":\\\"Paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":7,\\\"createdAt\\\":\\\"2025-02-01T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"qXJJvNo\\\",\\\"name\\\":\\\"First Term\\\",\\\"amount\\\":\\\"12000\\\"}},{\\\"payment_id\\\":\\\"cm6m0f0y70001i4t80km3heo1\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":10000,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":7,\\\"createdAt\\\":\\\"2025-02-01T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"Exo4omu\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":\\\"12000\\\"}},{\\\"payment_id\\\":\\\"cm6m0f0y70002i4t8fj5zlkrn\\\",\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"amount\\\":3500,\\\"paid\\\":2500,\\\"status\\\":\\\"Partly paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":7,\\\"createdAt\\\":\\\"2025-02-01T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"0jcBxk5\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":\\\"3500\\\"}}]\"',
    27500,
    NULL,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-01 00:00:00.000',
    '2025-02-01 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'cc29216b-e669-4174-86d9-f86bf2fba7c9',
    7,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm6m0f0y70001i4t80km3heo1\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"item\\\":{\\\"id\\\":\\\"Exo4omu\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":\\\"12000\\\"},\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":2000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":10000,\\\"paidToday\\\":2000}]\"',
    27500,
    27500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-02 00:00:00.000',
    '2025-02-02 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e2fe1556-337f-4a12-9926-4976927da9b1',
    3,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm6ev387n000010vlind2627m\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"item\\\":{\\\"id\\\":\\\"0jcBxk5\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":\\\"3500\\\"},\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":3000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":500,\\\"paidToday\\\":3000}]\"',
    3500,
    3500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-02-02 08:12:58.282',
    '2025-02-02 08:12:58.282'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f02f8bb2-7257-4411-aa28-d3f3c3b8bf1b',
    5,
    'FWpZizc',
    '\"[{\\\"payment_id\\\":\\\"cm6iguk5v00017ocw8nvzhpg7\\\",\\\"name\\\":\\\"PTA\\\",\\\"amount\\\":3500,\\\"item_id\\\":\\\"0jcBxk5\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":1000,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":2500,\\\"paidToday\\\":1000},{\\\"payment_id\\\":\\\"cm6iguk5r00007ocw64am0vlj\\\",\\\"item_id\\\":\\\"Exo4omu\\\",\\\"amount\\\":12000,\\\"paid\\\":0,\\\"status\\\":\\\"Paid\\\",\\\"term\\\":\\\"2nd term\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"transactionId\\\":5,\\\"createdAt\\\":\\\"2025-01-29T00:00:00.000Z\\\",\\\"item\\\":{\\\"id\\\":\\\"Exo4omu\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":\\\"12000\\\",\\\"school_section\\\":\\\"SSS\\\"},\\\"name\\\":\\\"School fee\\\",\\\"paidToday\\\":0}]\"',
    15500,
    15000,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    NULL,
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );
INSERT INTO
  `transactionhistory` (
    `id`,
    `tnxId`,
    `student_id`,
    `items`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'fc87c1e9-68be-4120-8ea6-0bc68ae66457',
    6,
    'AJ3njGo',
    '\"[{\\\"payment_id\\\":\\\"cm6jn0ezj00003t2uq19o9lxv\\\",\\\"name\\\":\\\"School fee\\\",\\\"amount\\\":12000,\\\"item_id\\\":\\\"Exo4omu\\\",\\\"session\\\":\\\"2024/2025\\\",\\\"term\\\":\\\"2nd term\\\",\\\"paid\\\":30,\\\"status\\\":\\\"Partly paid\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"teller_no\\\":\\\"\\\",\\\"balance\\\":11970,\\\"paidToday\\\":30}]\"',
    15500,
    15500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: transactions
# ------------------------------------------------------------

INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'FWpZizc',
    15500,
    15500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'MwA8gDw',
    'pS2M79v',
    '2025-01-23 00:00:00.000',
    '2025-01-30 00:00:00.000',
    1
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'AJ3njGo',
    3500,
    3500,
    'Cancelled',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'MwA8gDw',
    'pS2M79v',
    '2025-01-23 00:00:00.000',
    '2025-02-02 01:47:52.051',
    2
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'FWpZizc',
    3500,
    3500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    'pS2M79v',
    '2025-01-27 00:00:00.000',
    '2025-02-02 08:12:58.091',
    3
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'FWpZizc',
    12000,
    12000,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    'pS2M79v',
    '2025-01-27 00:00:00.000',
    '2025-02-02 01:47:46.073',
    4
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'FWpZizc',
    15500,
    15500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    'pS2M79v',
    '2025-01-29 00:00:00.000',
    '2025-02-02 01:47:46.073',
    5
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'AJ3njGo',
    15500,
    15500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    'pS2M79v',
    '2025-01-30 00:00:00.000',
    '2025-01-30 00:00:00.000',
    6
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'FWpZizc',
    27500,
    27500,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    'pS2M79v',
    '2025-02-01 00:00:00.000',
    '2025-02-02 00:00:00.000',
    7
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'AJ3njGo',
    12000,
    12000,
    'Paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    'pS2M79v',
    '2025-02-01 00:00:00.000',
    '2025-02-01 00:00:00.000',
    8
  );
INSERT INTO
  `transactions` (
    `student_id`,
    `total`,
    `paid`,
    `status`,
    `class`,
    `term`,
    `session`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `tnxId`
  )
VALUES
  (
    'AJ3njGo',
    15500,
    14500,
    'Partly paid',
    'SSS 1',
    '2nd term',
    '2024/2025',
    'pS2M79v',
    'pS2M79v',
    '2025-02-02 00:00:00.000',
    '2025-02-02 00:00:00.000',
    9
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
