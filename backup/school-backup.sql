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
  ('EMP0000', 'E7JETdx');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0000', 'Vx7JKMR');

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
    'cm7m7q73q0001uqv0d47n85ib',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-26 17:52:01.904',
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
    'cm7nmxzhz0001uqt47op1k3zq',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-27 17:45:45.716',
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
    'cm7no6v500001uq6s8h1jwbgl',
    '8uIPHRQ',
    'Logged-in',
    '2025-02-27 18:20:39.586',
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
    'cm7wbu9lx0001uq5gduna3xdu',
    'pS2M79v',
    'Logged-in',
    '2025-03-05 19:44:51.997',
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
    'cm986cu5y0001uqykbanj23qz',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:24:17.202',
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
    'cm986i5bn0001uqjchtzgi2x5',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:28:24.945',
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
    'cm986kz8j0001uq20fwi31278',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:30:37.028',
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
    'cm986ldda0003uq20pedtzlvr',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:30:55.344',
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
    'cm986u2220005uq200ofspx0l',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:37:40.585',
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
    'cm986ukjr0007uq201isqvpj5',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:38:04.552',
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
    'cm9873bfl0009uq20wa4kjnqx',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:44:52.642',
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
    'cm987fk9y000buq2075wpsyal',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:54:23.973',
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
    'cm987mngp000duq20zsy498kq',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 07:59:54.692',
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
    'cm988ws4c0001uqqocecx2kpv',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 08:35:46.902',
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
    'cm9892rmf0001uqp8u2o4pkkz',
    'pS2M79v',
    'Logged-in',
    '2025-04-08 08:40:26.197',
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
    'cm99k67o70001uqa08s3jz5ge',
    'pS2M79v',
    'Logged-in',
    '2025-04-09 06:38:48.915',
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
    'cm99keqte0003uqa0bkkag0ji',
    'pS2M79v',
    'Logged-in',
    '2025-04-09 06:45:26.977',
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
    'cm99kg3r00005uqa03r8glxjc',
    'pS2M79v',
    'Logged-in',
    '2025-04-09 06:46:30.394',
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
    'cm99kivko0007uqa01oouthma',
    'pS2M79v',
    'Logged-in',
    '2025-04-09 06:48:39.767',
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
  ('OMVKFac', 'JSS 1', NULL, 'JSS');
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
    '00e482a3-2aa5-4cd8-bb90-50e87afcedb5',
    's7OprJI',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '01100736-d4bc-4236-8b57-ecee07902549',
    'hze8AHg',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '023205e3-bd94-468d-91d3-d2e0bb5a67c5',
    '_2-r5MV',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '0260bb1a-d486-4409-93a5-24f0a075a568',
    'L3A7LAe',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '03c2f1b7-6f4f-4965-b069-037521ad1ae6',
    'JAK4Ph7',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '0475a2c9-f86c-4fc5-b1c5-fd922409d91e',
    'JOQG0hx',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '064d939f-52d5-4c4d-b3c2-4d496af32224',
    'zZszPtu',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '075b4a00-64b9-4f38-b62f-92fc72cf3fbe',
    'RcvAZak',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '07a8c557-5cca-4bd8-87a4-dbede80746fe',
    'xIXqRvq',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '0f7f5c63-f83b-454f-b085-3d4c0a47b862',
    'JMPukvS',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '0fbd7e3a-3ac7-47c3-8265-a6f3b9826f3f',
    'ixm8OxF',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '0fca41fa-7734-4ec8-b078-c74c8f83bc0d',
    'LF4VphQ',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '0fe77b9c-6662-4ae8-bb3f-902e97451550',
    'blQ3H8f',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1000e6d3-00bd-4f2d-a594-d04a59f13a8d',
    'SJj5gNt',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '10ee9f2d-836d-415a-9b25-0d6cc69a0216',
    'w9LRsUe',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '124cc218-1d79-49db-842e-87ead0a98998',
    'y0lWnRZ',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '138ecb13-e580-4f20-9cde-88a9aa1f1edb',
    'J4IyWc9',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '143583b0-3d72-420c-83be-5abeae3176be',
    'ZyXUMwr',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '158527e2-3cd1-4804-bef0-3400089d6051',
    'q4Opj0v',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1678d899-9ef7-4804-a89c-64fdf1ff0960',
    'U74z55T',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '18dbd265-48e6-4787-a957-f3364e38a51b',
    '4c1wUN0',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1a46aa13-1fab-4a2d-ad60-138cc9a2af0c',
    'lgyn_68',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1b4e1302-9f78-4284-b659-df0ba2c0a484',
    'V_h15eL',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1b7bc570-e828-4d51-ae76-4ef9810a3621',
    'f1kac6R',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1c1d3a1e-8462-4538-9f7d-52f9e892132e',
    'PQxjmvI',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1c273d95-8b61-4106-a44f-43b8c99baa2b',
    'Vtyfh9s',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1dae8f6a-81b2-4276-8a1b-5bdadd381c78',
    'rGTOqTH',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '1fe8dbe5-9574-41f6-8e13-b883064f53cc',
    'uca0qjU',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '23082a96-6a06-42fa-a7b6-00d538f93291',
    'OFtSqMv',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2418a00a-1ca3-484b-b16f-62ac0e5a55f8',
    'jYAfwdy',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '26fdeb95-a029-446f-a98e-20900e456ce2',
    'SdzqVdO',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '29380865-6ebe-4b0c-ac7a-4d9549678519',
    'NNemuPa',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2a2e3959-0ce1-490a-9608-fbef8503e630',
    'SELc4Mi',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2a76c994-7186-461e-8d88-05e610c2e837',
    'WtLwgSo',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2aa9e9df-1236-49ab-bedd-e5db5b48e94f',
    'JbwaLn2',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2bac3013-c3d2-4493-9874-c22ec0c2c8b2',
    'Gf0AASl',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2e4e65d5-1a82-4157-b74e-26ff3aee3333',
    'OOGQwL-',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2e931b3b-95f1-4887-a595-ee94ed5373bb',
    'ns_z6MX',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '2e96ed8c-da56-4473-902d-d2fb4a52db69',
    'O15ns2-',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '30caef63-4653-4313-afcb-bcae993b5cdf',
    'T9n-LDr',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '31a8b0bb-4a45-46c5-a76f-9497cb628857',
    '62EmXiv',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '322a47bb-9136-44bc-9edb-496a81a16b52',
    'BdgSX6c',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '343d483d-43da-4bc4-914e-256cb5894f8f',
    '0lO3mFy',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '3539f289-e94f-485c-acaf-1071ad66e9ad',
    'CU8rlb4',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '358506df-11eb-41a5-8673-410c833b072e',
    'ofFg_L7',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '36e5d126-0e56-4e8d-b07f-ce617f851b08',
    'psaw364',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '3b9de2da-d138-4a11-820c-86bf6413718b',
    'QoWg4yT',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '3e168995-4b13-4bc4-95ab-545730a88b64',
    'NeO9xAc',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '3e4d0606-5583-40b8-825e-e3b83574ff79',
    'BcsW68Z',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '3e54f1b6-da7f-4070-bc65-70200dd43066',
    'H7N8FSO',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '47179732-614b-49e5-8900-413dd6bc8b8a',
    'CBDSKk5',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '482b4596-02ee-4dab-868c-7a5793662eb2',
    'iHjHZ6B',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '4a3baac2-1169-4c06-988a-90dd43fa7a9c',
    '8Y2R6k8',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '4aa7e3d2-8b0a-47ec-8b94-792bdbe311ae',
    '9SqurkF',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '4be3f755-7c75-4323-b14c-47ca86d0a912',
    'wgK4IPv',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '4d0b871a-3cc3-489e-a3e3-0788b63f2480',
    '-2mqYIs',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '4d0d5f30-0b83-4a56-ad91-93d9970d7bfc',
    'qR6Ub0E',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '4ef22198-123a-4042-90f6-9745e6f6c6e1',
    'CdlKQfx',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '522581c5-0840-4976-9266-3a449890d49f',
    'eTPMVJZ',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '54530e46-665e-47db-b84e-95526978066c',
    'L0jNDG4',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '57c5e402-b7cd-45f1-87f1-240ffd1a58d7',
    'tuEBdwJ',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '58c56600-bc93-4507-a802-6acda908c1e0',
    'NMmACV8',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '59fb9932-d375-4d42-aec0-552eebd77d68',
    'XPOJQ9K',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5a2db61f-680d-4a35-8b2c-62ea61b0beef',
    'COqnp45',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5a7dea3c-7fdd-4663-b384-ef91ce600de2',
    'uMVDUg7',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5b5e8ed6-5c42-4c1d-a5cf-00f5f1c9ca34',
    'J7O_TgC',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5d51b87c-91e3-427a-9618-a5c98c789ba7',
    'Gb4Rb4V',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5eb48292-5641-4c99-95ef-d43d25cffc04',
    'DE8vnQe',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5ed1c740-47b7-4a3d-9d10-7907293c7101',
    'TSoX_nt',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5f34c518-3167-41a6-a439-403dec2a5909',
    '0RiufTC',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5f4d4e0f-7c98-46e5-9417-ba6b940154e6',
    'IQWvOv7',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '5f5e5748-070f-42af-8b36-1090d1245c3d',
    'micHP4u',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '6235796c-b946-4f1f-88cd-8e472c93af2b',
    'f7mrWyk',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '62de8aa9-743f-4950-955e-468298c492b2',
    'o881JSI',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '64aa1f73-6a38-4ab1-8d0e-5d0d1f482b7c',
    'stDnP0q',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '6571851f-412c-4a74-99d0-61355b1184b4',
    'LK7nyUB',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '66afc141-2c7c-4f47-8560-c014be0f66c7',
    'tzvCUP_',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '6ba4fd4c-82c0-4f9a-b78b-7c104c8dfe3d',
    'MLv8o22',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '6c67c838-fa5d-47f8-94cd-669689b5b044',
    '96FpJJy',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '6fee285f-f092-44b1-89f7-d2e2d50b0712',
    'hXGMGZw',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '708dd5ff-4f32-4f38-b3e1-108cdb2cbeaf',
    'P6qBoAh',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '71af97d3-f6ec-4cc7-b527-0ff22af834e7',
    'TkO95R9',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '71cb9b39-c4a3-4992-adc1-e311c8ce5e14',
    'HtphcSz',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '72d79dac-693a-471d-bee7-89feb94bc713',
    'eGzyzQg',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '768c6ec7-3c01-491a-88d7-8c3c28f6fa8d',
    'smFeBzU',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '7728cbb1-57f6-4928-9e74-ffd4d1f614eb',
    'jgti7uM',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '779bae39-e1ea-4599-8054-9e9c4d29e631',
    'nZu2qpp',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '791ec8da-e1c2-4665-adf3-2d8bf6e7bfc0',
    'N4hOJra',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '7a6625c4-7646-44c3-b957-1aa53094632c',
    'XsSuiaH',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '7b2236f8-e428-4b00-82cd-0de241e61d36',
    '0tA7Xmw',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '7d45d6dc-0181-492f-9275-15926785c3d1',
    '4vF7HEJ',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '7dd5b00d-e86f-4e98-948a-c4eda9d2c6fc',
    'BWt4nH0',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '7dff4dfc-7fde-46ee-bb81-6f552e5694ce',
    '7Iv7ITI',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '7fe57d96-4bb8-47b1-9532-1a41ff700e07',
    'Af5m1tY',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '80961396-ae68-4067-9a4a-7fbae4271b0f',
    '5hTwH3b',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '80e9a2b2-5717-4a42-afad-d6b472d94782',
    'bE2XGK5',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '8389dca3-8ea4-4002-8b97-62619f8276ea',
    'AtZbxUH',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '84d7361a-92ac-427f-a76d-8f67efde2c50',
    'IZLZmvX',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '86c431e3-dc20-4902-80cb-521a22def995',
    'IBXYAyl',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '872f0447-b535-4a64-815a-8fc5efd55361',
    'ff2Pxul',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '885f8ecf-a9bf-491c-80a3-bccffa0bcf2f',
    'B_qCZdp',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '8c1c51df-ce38-4832-bc4f-6e8fbc15c2f7',
    '8_3m4i_',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '8f4c88fd-0b74-49b2-98ba-620e26e94e6d',
    '4JV3VON',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '90d0d949-3f7f-4abb-b906-66c95b13471f',
    'Djn2Z3A',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '94f93cd4-adf0-4a41-a65a-020c942e7d7b',
    '9Lcq4HW',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '951af4ed-c45f-425d-bb33-8db5c0fa60eb',
    'Ignhep5',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9527b3a5-34dc-4432-9ed5-8c7da1ef1a52',
    'QX2FFWp',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '96ac12fb-cd95-40d3-b472-38ae161bc218',
    'ZuXIXYL',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9709f04d-c73e-4d34-960d-ef54f0abfcdb',
    'K2FSd5x',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '970ea127-8d21-42f3-84bb-126a945b3be7',
    'LJsNhfD',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '979859c6-2cd0-4376-862b-c62e26395150',
    'XgX0SLT',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '98a35374-6dc9-4123-a37b-449647ee22d9',
    'tsCo2WO',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '98c15eeb-c18b-4114-be31-162e47c855cc',
    'aHTVW43',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '992f545a-2f46-458b-9c22-6fceab0bca40',
    '3Uyzn-m',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9955f673-4474-43db-b00f-57ca8cd3b538',
    'EDs5MIG',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9a216c15-ca0b-4fe3-ab33-b32c0b9f25d7',
    'oMI6jUe',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9ae7e932-fea3-4a77-83ec-2aa55938d711',
    'rG-DPr8',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9c18ebf9-70ad-4d65-86f7-972e271fa00e',
    'cVcMJec',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9e3ad2f2-b2cc-4d26-adcd-c18c9b016db6',
    'Mn65hyE',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9e949e26-ca59-4ba8-996c-05ede2a4f514',
    'noVaVtu',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    '9f488ebe-89c5-4158-9e94-2a81f101d939',
    'oauk4T1',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a01e752a-b803-44c4-afbc-9b575e0513da',
    '_wEwy2t',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a10b9a2f-79dd-4a47-9b45-beba18451d51',
    '6W-onAA',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a27e3d44-df3c-4a7d-9681-c91132808654',
    '-JQwcha',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a29611d0-2993-496a-842a-2b923e2efb16',
    'f2_0WSF',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a3de9758-abd6-4097-bfee-5fa6e63b72bb',
    'AD1UOtz',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a4a4866b-9a69-43b4-823c-29fbb9064167',
    'XEC8eTx',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a5ea1225-7e8b-4a84-a166-58331dd91849',
    'AW054iX',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'a9ed3ac6-cf59-48a3-a00b-f0dd6f4a6997',
    'KX0TwZY',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'ac9f55dd-5231-487b-b412-15b8cc2819ac',
    '95jbmaw',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'aef9ed2e-63db-45dc-b4d1-2c7b6f742b9e',
    'Jt_Q90a',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'b0cb4144-d4fa-4d29-893c-8843f7b13d84',
    'SOAcmZ4',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'b1b15205-9148-4dd5-a9ba-5350bfd2c3f4',
    'i-mc2Jp',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'b636d85d-d42f-4fd9-9003-11db82bf2730',
    'R_Husjl',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'b66552e4-826b-4d9a-afc5-e92ae1163440',
    'Pq50y91',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'b7822294-ef63-42b6-bbc8-bb2afcb27dc4',
    'WKsvCkr',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'b79a6857-257f-4e24-9ee6-927e5ac9f36f',
    'xIpbvV5',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'b82b5c23-e7c1-495b-bb43-3998eed94d89',
    'pgZy6yw',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'ba976e13-b646-40e2-b76d-2f3689373f55',
    'NDkLpKR',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'bbd68063-b989-4c1c-a461-a14479d005f8',
    'rvPPvPC',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'bc615972-b92e-4007-aa9d-279da285df65',
    'Vi-OKCL',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'bc8c8a09-10f3-421e-98b3-79e85def3cb5',
    'IDTpiSG',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'bd73c633-10da-41c2-a1a4-fc33ba8f0b30',
    'Dc_zxkz',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'be4a11b5-386e-4ae2-abee-88ae82a15ffb',
    'pBVJwu8',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'bffe7db7-ea32-4162-87f7-b8f0f3631587',
    'UZP7Ncn',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'c0293aa4-1586-4040-809a-7eb996e8e813',
    'SlBf-AI',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'c5125eef-d3bd-4303-95b6-2097b83d7fa1',
    'Ywk2cwU',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'c5bd5102-1155-460f-ba16-d8db439d7d9c',
    'LYJMecJ',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'c622f136-1f86-4e14-b16a-b13721b445e8',
    'APlIC-X',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'cd577782-30c9-4d83-ab50-87957e2b60a3',
    'POIf-pI',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'cdec6646-1424-420c-942f-21fd2e13b2f3',
    '1ezAINA',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'cebb6476-cd3d-4e90-9656-dbe0be00872f',
    '_kSz0S-',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'd33d5f2c-21b9-435d-ac57-43ce0f304d58',
    'U-NDL-v',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'd744cb4a-f4f3-4acd-baac-07f92351a70f',
    '0QgVX_N',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'd9bd2b31-bdae-45a7-ba4d-e6395fb567d1',
    'zqQgQhz',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'dc661268-2f7d-4cd2-a606-5bd1c786235c',
    'YPwiiEU',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'dce60da1-45bf-4c39-be6f-8a33971cbc68',
    'MZrHMGR',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'dd771e3b-09e6-4240-8117-97ebc49b7257',
    '0eDmbaO',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e0090ec5-6089-491d-95d2-eac48bc93008',
    'UQTKUlN',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e039e132-ddae-49ce-888d-b5715ae42663',
    'Eksm-85',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e144b0a9-6993-426e-89c8-60207f89aded',
    'OqJp15B',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e8283729-a6cb-4f54-9a85-ffc5df547d48',
    'YGuvyyD',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e89b8048-155b-4323-8ad4-44e842edaa52',
    '6YG9To2',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'e8e320dc-aed5-48de-870f-4c8ddd352569',
    '1WzzQ1M',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'ea95de36-ae24-44fa-ba18-1d7bcc36fe8d',
    'M4GiywA',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'ed1468e8-ef80-48fb-8f6b-1134ee939fb0',
    'aoyLERW',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'f06dbdb3-30d5-4e65-8016-24febb045092',
    'Rb_ZJuX',
    '2_fPzDw',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'f0fb487f-63d2-4444-ad1e-0ce96853d73b',
    'G3akcBs',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'f838f34a-5fbf-475a-8d92-34352a4d4614',
    '9xOxJou',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'f913eed6-17c8-42be-a74b-4ebb151c3bbc',
    'bZ_O1wu',
    '1HN7a2S',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'f92c1e41-fff9-47fe-9d70-73d7287248fb',
    'xMrocLE',
    'OMVKFac',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'f9a2b4c6-4d84-4983-8bad-ec3b2ab5bde0',
    'SMbOytY',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'facd797b-f3da-4a07-a017-37cbc685afc8',
    'V5FMjD2',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'fbf9fcd5-643b-4c61-818e-917e7e55dc49',
    'GsIWqNL',
    'Ifq45cL',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'fd1936e6-ea35-4941-8cba-3dcbb7eafff8',
    '3_GATxc',
    'T9Bo3Ne',
    '2024/2025'
  );
INSERT INTO
  `classhistory` (`id`, `student_id`, `class_id`, `session`)
VALUES
  (
    'ff91ce5d-3cea-4d38-8af6-034a6069bed2',
    'kYUuCpo',
    'T9Bo3Ne',
    '2024/2025'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: demotions
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: disengagedstudent
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: disengagemnets
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: examresults
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fcaresults
# ------------------------------------------------------------


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


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: promotions
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: scaresults
# ------------------------------------------------------------


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
    '_2-r5MV',
    'AJ/23/222',
    'Hamza',
    'Usman',
    NULL,
    '',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    '_kSz0S-',
    'AJ/21/193',
    'Ahmed',
    'Ismail',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.673',
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
    '_wEwy2t',
    'AJ/24/307',
    'Aishat',
    'Issah',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    '-2mqYIs',
    'AJ/23/239',
    'Naja\'atu Kidebe',
    'Ibrahim',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.380',
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
    '-JQwcha',
    'AJ/22/211',
    'Marwan',
    'Bashir',
    NULL,
    '',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    '0eDmbaO',
    'AS/23/067',
    'Kidebe',
    'Yusuf Habibah',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.772',
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
    '0lO3mFy',
    'AJ/21/185',
    'Hamza S/fawa',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.671',
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
    '0QgVX_N',
    'AJ/23/236',
    'Abdul-Semiu',
    'Issah',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.380',
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
    '0RiufTC',
    'AJ/21/152',
    'Salim',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.763',
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
    '0tA7Xmw',
    'AJ/23/219',
    'Hassan Garba',
    'Issah',
    NULL,
    'Male',
    '',
    '',
    'JSS',
    '',
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    '1ezAINA',
    'AJ/23/238',
    'Maryam',
    'Abdulrasheed',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.380',
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
    '1WzzQ1M',
    'AJ/24/289',
    'Sagir',
    'Muhammed',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    '3_GATxc',
    'AJ/24/278',
    'Fatimah',
    'Muhammed Awwal',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.118',
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
    '3Uyzn-m',
    'AJ/23/255',
    'Muhammad',
    'Muhammad-Bello',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    '4c1wUN0',
    'AS/23/064',
    'Maryam',
    'Aliyu',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.769',
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
    '4JV3VON',
    'AS/23/063',
    'Mubarak',
    'Adamu',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.765',
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
    '4vF7HEJ',
    'AJ/23/230',
    'Mustapha',
    'Lukman',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.378',
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
    '5hTwH3b',
    'AJ/24/301',
    'Rukaiyyat',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    '62EmXiv',
    'AS/25/090',
    'Nurudeen',
    'Aminu',
    NULL,
    'Male',
    '',
    '',
    'SSS',
    '',
    'Islam',
    '2025-01-06 00:00:00.000',
    '2024/2025',
    '2nd term',
    NULL,
    1,
    '',
    '',
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 11:28:55.004',
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
    '6W-onAA',
    'AJ/21/196',
    'Aishat',
    'Ibrahim',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.674',
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
    '6YG9To2',
    'AJ/25/306',
    'Husna',
    'Abdul Kareem',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    '7Iv7ITI',
    'AS/24/073',
    'Gadafi',
    'Mohmmed',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.765',
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
    '8_3m4i_',
    'AJ/23/270',
    'Rahimat',
    'Umar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.116',
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
    '8Y2R6k8',
    'AJ/24/298',
    'Rahmat',
    'Aliyu Muhammed',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    '95jbmaw',
    'AJ/23/227',
    'Bashir S/Fawa',
    'Bashir',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.375',
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
    '96FpJJy',
    'AJ/23/244',
    'Sherifat',
    'Ibrahim',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    '9Lcq4HW',
    'AS/24/081',
    'Hauwa',
    'Lawal',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.676',
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
    '9SqurkF',
    'AJ/21/155',
    'Nazir Tanko',
    'Umar',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.762',
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
    '9xOxJou',
    'AS/24/086',
    'Maryam',
    'Ahmed',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.678',
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
    'AD1UOtz',
    'AJ/24/296',
    'Abubakar',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'Af5m1tY',
    'AJ/23/252',
    'Yerima Dihiyat',
    'Shehu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    'aHTVW43',
    'AJ/25/317',
    'Paul',
    'Sule',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'aoyLERW',
    'AJ/21/195',
    'Sumaiyyah',
    'Habib',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'APlIC-X',
    'AJ/21/144',
    'Serah',
    'Bamidele',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.766',
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
    'AtZbxUH',
    'AS/24/078',
    'Sherif',
    'Ibrahim Moh\'d',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.673',
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
    'AW054iX',
    'AJ/24/291',
    'Abdulrahaman',
    'Zakari',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'B_qCZdp',
    'AJ/21/190',
    'Zainab Ayoka',
    'Mustapha',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.676',
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
    'BcsW68Z',
    'AJ/24/297',
    'Nabila',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.381',
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
    'BdgSX6c',
    'AJ/24/279',
    'Barnabas',
    'Nuhu Lafia',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.121',
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
    'bE2XGK5',
    'AJ/24/305',
    'Suraiya',
    'Salihu Gonna',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'blQ3H8f',
    'AJ/23/254',
    'Muhammad Abba',
    'Ayuba',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    'BWt4nH0',
    'AJ/25/331',
    'Nasir',
    'Aliyu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'bZ_O1wu',
    'AJ/23/210',
    'Mercy',
    'Yahaya',
    NULL,
    '',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'CBDSKk5',
    'AJ/23/237',
    'Faith',
    'Bamidele',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.380',
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
    'CdlKQfx',
    'AJ/23/240',
    'Kikwashi Maryam',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.380',
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
    'COqnp45',
    'AJ/22/208',
    'Joy',
    'Onah',
    NULL,
    'Female',
    '',
    '',
    'SSS',
    '',
    'Christianity',
    '2023-09-04 11:06:32.330',
    '2024/2025',
    '2nd term',
    NULL,
    1,
    '',
    '',
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 11:28:55.004',
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
    'CU8rlb4',
    'AJ/24/299',
    'Zainab',
    'Ismail',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'cVcMJec',
    'AJ/24/309',
    'Jessica',
    'Okpube Daniel',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'Dc_zxkz',
    'AJ/23/243',
    'Aishat Humairat',
    'Attahiru',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    'DE8vnQe',
    'AJ/23/264',
    'Silas Isreal',
    'Ayuba',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.114',
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
    'Djn2Z3A',
    'AS/24/082',
    'Mardiyat',
    'Sanusi',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.676',
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
    'EDs5MIG',
    'AJ/23/263',
    'Hassanat',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.114',
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
    'eGzyzQg',
    'AJ/24/287',
    'Yusuf',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'Eksm-85',
    'AJ/21/153',
    'Fatima',
    'Salihu',
    '2009-07-02 00:00:00.000',
    'Female',
    '',
    '',
    'SSS',
    '',
    'Islam',
    '2023-09-04 11:06:32.330',
    '2024/2025',
    '2nd term',
    'SSS 1',
    1,
    '',
    '',
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 11:14:00.885',
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
    'eTPMVJZ',
    'AJ/25/320',
    'Victor',
    'Ishaya',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'f1kac6R',
    'AJ/21/149',
    'Jabir',
    'Bashir',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.764',
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
    'f2_0WSF',
    'AJ/23/268',
    'Aminat',
    'Abdulrasaq',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.116',
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
    'f7mrWyk',
    'AJ/23/218',
    'Husseini Lashi',
    'Issah',
    NULL,
    'Male',
    '',
    '',
    'JSS',
    '',
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'ff2Pxul',
    'AJ/21/187',
    'Abdul Jelil',
    'Mohammed Nasir',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.673',
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
    'G3akcBs',
    'AJ/23/248',
    'Asihat',
    'Muhammad-Jamiu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    'Gb4Rb4V',
    'AJ/24/290',
    'Abdulsalam',
    'Haliru',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'Gf0AASl',
    'AJ/24/295',
    'Ibrahim',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'GsIWqNL',
    'AS/24/085',
    'Balkisu',
    'Aliyu B.',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'H7N8FSO',
    'AJ/23/249',
    'Hassanat',
    'Salihu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    'HtphcSz',
    'AJ/23/267',
    'Mohammed',
    'Usman',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.115',
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
    'hXGMGZw',
    'AJ/25/326',
    'Rahab',
    'Ishaku',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.384',
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
    'hze8AHg',
    'AJ/23/229',
    'Sadikat Morenikeji',
    'Folorunsho',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.378',
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
    'i-mc2Jp',
    'AJ/25/308',
    'Ummul Salma',
    'Umar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'IBXYAyl',
    'AS/23/066',
    'Galadima',
    'Alhassan Unaisah',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.771',
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
    'IDTpiSG',
    'AS/24/079',
    'Abdulrahman',
    'Musa',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.673',
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
    'Ignhep5',
    'AJ/24/300',
    'Nana Aishat',
    'Yusuf',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'iHjHZ6B',
    'AJ/24/293',
    'Abdulsamad',
    'Yusuf',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'IQWvOv7',
    'AJ/24/288',
    'Ishaya',
    'Solomon',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'ixm8OxF',
    'AJ/24/280',
    'Precious',
    'Yisa Sunday',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.121',
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
    'IZLZmvX',
    'AJ/21/182',
    'Saratu',
    'Aliyu',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'J4IyWc9',
    'AJ/23/232',
    'Maimunat',
    'Ibrahim',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.379',
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
    'J7O_TgC',
    'AJ/25/328',
    'Zainab',
    'Musa',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'JAK4Ph7',
    'AJ/23/233',
    'Joy',
    'Abiodun',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.379',
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
    'JbwaLn2',
    'AJ/25/319',
    'Yushau',
    'Abdulrahman',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'jgti7uM',
    'AJ/23/260',
    'Mahmud',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.112',
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
    'JMPukvS',
    'AJ/25/321',
    'Henry',
    'Yohannah',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'JOQG0hx',
    'AJ/23/242',
    'Abubakar',
    'Ahmadu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.380',
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
    'Jt_Q90a',
    'AJ/24/284',
    'Hauwa',
    'Mohammed',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.122',
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
    'jYAfwdy',
    'AJ/23/258',
    'Ummi-Aishat',
    'Umar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    'K2FSd5x',
    'AJ/21/194',
    'Hauwa',
    'Mshelia Danladi',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'KX0TwZY',
    'AJ/21/150',
    'Blessing',
    'Yakubu Luka',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.770',
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
    'kYUuCpo',
    'AJ/23/257',
    'Yusuf',
    'Umar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    'L0jNDG4',
    'AJ/23/262',
    'Hussainat',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.113',
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
    'L3A7LAe',
    'AJ/23/228',
    'Hauwa\'u',
    'Abass Adamu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.378',
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
    'LF4VphQ',
    'AJ/21/136',
    'Ahmed',
    'Muhammad',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.763',
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
    'lgyn_68',
    'AJ/23/251',
    'Yerima Faisal',
    'Shehu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    'LJsNhfD',
    'AJ/21/191',
    'Munirat',
    'Usman',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'LK7nyUB',
    'AS/24/077',
    'Abdulgafar',
    'Habib',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.673',
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
    'LYJMecJ',
    'AJ/21/156',
    'Nana Hauwa',
    'Yusuf',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.771',
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
    'M4GiywA',
    'AJ/21/134',
    'Muhammad Jamiu',
    'Folorunsho',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.761',
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
    'micHP4u',
    'AJ/21/184',
    'Sagirat',
    'Usman',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'MLv8o22',
    'AJ/22/200',
    'Balirat',
    'Issah',
    NULL,
    'Female',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'Mn65hyE',
    'AJ/25/332',
    'Favour Chisom',
    'Igwe',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.380',
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
    'MZrHMGR',
    'AJ/23/245',
    'Abdullah Sadoroki',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    'N4hOJra',
    'AJ/21/148',
    'Mufidah',
    'Alhassan',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.770',
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
    'NDkLpKR',
    'AJ/23/253',
    'Abubakar',
    'Hamidu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    'NeO9xAc',
    'AJ/22/206',
    'Usman',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.672',
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
    'NMmACV8',
    'AJ/24/303',
    'Hafsat',
    'Usman',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'NNemuPa',
    'AJ/21/141',
    'Habibu',
    'Zakari Baba',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.764',
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
    'noVaVtu',
    'AJ/24/313',
    'Faridat',
    'Musa',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'ns_z6MX',
    'AJ/24/283',
    'Angela',
    'Tsado',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.121',
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
    'nZu2qpp',
    'AJ/25/323',
    'Samson',
    'Timothy',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.384',
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
    'O15ns2-',
    'AJ/23/259',
    'Isah',
    'Mohammed Buhari',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.111',
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
    'o881JSI',
    'AJ/23/272',
    'Abdulmalik',
    'Issah',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.116',
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
    'oauk4T1',
    'AS/24/088',
    'Sadiyat Halimat',
    'Ahmed',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.678',
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
    'ofFg_L7',
    'AJ/24/310',
    'Fatimah',
    'Aliyu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'OFtSqMv',
    'AJ/25/318',
    'Ahmed',
    'Abdullahi',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'oMI6jUe',
    'AJ/23/221',
    'Faith',
    'Godwin',
    NULL,
    '',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'OOGQwL-',
    'AJ/21/162',
    'Bagado',
    'Umar Yakubu',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.764',
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
    'OqJp15B',
    'AJ/22/212',
    'Salim',
    'Yusuf',
    NULL,
    '',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'P6qBoAh',
    'AJ/23/261',
    'Garba',
    'Suleiman Muhammed',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.113',
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
    'pBVJwu8',
    'AJ/21/163',
    'Danladi',
    'Yunusa',
    NULL,
    'Male',
    '',
    '',
    'SSS',
    '',
    'Islam',
    '2021-09-06 00:00:00.000',
    '2024/2025',
    '1st term',
    NULL,
    1,
    '',
    '',
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 11:28:55.004',
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
    'pgZy6yw',
    'AJ/21/138',
    'Hauwa',
    'Dauda',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.767',
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
    'POIf-pI',
    'AJ/23/246',
    'Mohammed',
    'Umar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    'Pq50y91',
    'AJ/25/322',
    'Zephaniah',
    'Andrew',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.384',
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
    'PQxjmvI',
    'AJ/21/143',
    'Sagir',
    'Zakari',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.765',
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
    'psaw364',
    'AJ/22/207',
    'Hauwa',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.772',
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
    'q4Opj0v',
    'AJ/25/327',
    'Cecilia',
    'Nuhu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.384',
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
    'QoWg4yT',
    'AJ/24/302',
    'Halimat',
    'Salihu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'qR6Ub0E',
    'AJ/24/281',
    'Enock',
    'Samaila',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.122',
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
    'QX2FFWp',
    'AJ/21/175',
    'Aishat',
    'Abdullateef',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.674',
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
    'R_Husjl',
    'AJ/24/277',
    'Grace',
    'Ibrahim',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.118',
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
    'Rb_ZJuX',
    'AJ/21/151',
    'Jibril',
    'Haruna',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.764',
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
    'RcvAZak',
    'AS/23/069',
    'Zaid Dio',
    'Salish',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.764',
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
    'rG-DPr8',
    'AJ/21/192',
    'Sharhabila',
    'Salihu',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.676',
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
    'rGTOqTH',
    'AJ/25/315',
    'Dogara',
    'Thomas',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'rvPPvPC',
    'AS/23/070',
    'Zainab',
    'Abass',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.770',
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
    's7OprJI',
    'AS/24/084',
    'Rahmat',
    'Mohammed',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'SdzqVdO',
    'AJ/23/223',
    'Christopher',
    'Samuel',
    NULL,
    '',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'SELc4Mi',
    'AJ/23/265',
    'Abubakar',
    'Saheed',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.115',
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
    'SJj5gNt',
    'AJ/22/201',
    'Aishat',
    'Bashir',
    NULL,
    'Female',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'SlBf-AI',
    'AJ/23/231',
    'Nana Suhairat',
    'Haliru',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.379',
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
    'SMbOytY',
    'AS/24/083',
    'Maria',
    'Musa',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.677',
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
    'smFeBzU',
    'AJ/24/292',
    'Abdulbasit',
    'Abdulwaliyu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'SOAcmZ4',
    'AJ/22/209',
    'Blessing',
    'N Somto',
    NULL,
    'Female',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'stDnP0q',
    'AJ/24/286',
    'Khalifa',
    'Dauda Moh\'d',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'T9n-LDr',
    'AJ/23/271',
    'Kamaldeen',
    'Iliyasu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.116',
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
    'TkO95R9',
    'AS/24/076',
    'Sale',
    'Musa',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.766',
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
    'tsCo2WO',
    'AJ/23/250',
    'Hussainat',
    'Salihu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.381',
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
    'TSoX_nt',
    'AJ/25/329',
    'Nancy',
    'Lemy',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'tuEBdwJ',
    'AJ/25/330',
    'Abdullahi Dabo',
    'Usman',
    NULL,
    '',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:53:29.557',
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
    'tzvCUP_',
    'AJ/24/285',
    'Julius',
    'Yakubu Luka',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.385',
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
    'U-NDL-v',
    'AJ/23/234',
    'Shafiu Babangida',
    'Aliyu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.379',
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
    'U74z55T',
    'AS/24/089',
    'Blessing',
    'John',
    NULL,
    'Female',
    '',
    '',
    'SSS',
    '',
    'Christianity',
    '2023-09-04 11:06:32.330',
    '2024/2025',
    '2nd term',
    NULL,
    1,
    '',
    '',
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 11:31:51.957',
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
    'uca0qjU',
    'AJ/25/324',
    'Joshua',
    'Michael',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.384',
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
    'uMVDUg7',
    'AJ/21/154',
    'Dallau',
    'Musa Ruqayat',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.770',
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
    'UQTKUlN',
    'AS/24/075',
    'Abdul Rahaman',
    'Ahmad Ibn',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.766',
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
    'UZP7Ncn',
    'AJ/21/139',
    'Abdulrauf',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.763',
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
    'V_h15eL',
    'AS/24/087',
    'Nana Alshat',
    'Issa',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.678',
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
    'V5FMjD2',
    'AJ/23/247',
    'Muhammed',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    'Vi-OKCL',
    'AJ/23/266',
    'Abubakar',
    'Usman',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.115',
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
    'Vtyfh9s',
    'AJ/24/312',
    'Fatimah',
    'Umar Tanko',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'w9LRsUe',
    'AJ/21/164',
    'Anas',
    'Umar',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.762',
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
    'wgK4IPv',
    'AS/24/080',
    'Hashimu',
    'Garba',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.674',
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
    'WKsvCkr',
    'AJ/24/275',
    'Meshack',
    'Yohannah',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.117',
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
    'WtLwgSo',
    'AS/23/065',
    'Galadima',
    'Alhassan Anisah',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.771',
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
    'XEC8eTx',
    'AJ/25/316',
    'John',
    'Sule',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'XgX0SLT',
    'AJ/23/256',
    'Mohammed Sadisu',
    'Ahmed',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.382',
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
    'xIpbvV5',
    'AJ/24/314',
    'Aishat',
    'Zakari',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.383',
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
    'xIXqRvq',
    'AJ/22/214',
    'Maryam',
    'Bashir',
    NULL,
    'Female',
    '',
    '',
    'JSS',
    '',
    '',
    '2025-02-25 00:00:00.000',
    '2024/2025',
    '1st term',
    '',
    1,
    '',
    '',
    '1HN7a2S',
    '8uIPHRQ',
    '2025-02-25 10:54:09.848',
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
    'xMrocLE',
    'AJ/25/325',
    'Zainab',
    'Abdullahi .A.',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.384',
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
    'XPOJQ9K',
    'AJ/24/311',
    'Halimat Sadiat',
    'Yusuf',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'XsSuiaH',
    'AJ/21/135',
    'Esther',
    'Siyabola',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.772',
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
    'y0lWnRZ',
    'AJ/24/276',
    'Godwin',
    'Silas',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.117',
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
    'YGuvyyD',
    'AS/23/068',
    'Precious Nnenna',
    'Ifeanyi',
    '2009-06-26 00:00:00.000',
    'Female',
    '',
    '',
    'SSS',
    '',
    'Christianity',
    '2023-09-04 11:06:32.330',
    '2024/2025',
    '1st term',
    'SSS 1',
    1,
    '',
    '',
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 11:11:46.564',
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
    'YPwiiEU',
    'AJ/24/282',
    'Maryam',
    'Adamu',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 12:39:12.122',
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
    'Ywk2cwU',
    'AS/24/074',
    'Favour',
    'Aderinre',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.766',
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
    'zqQgQhz',
    'AJ/23/235',
    'Samson',
    'Samuel E.',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'T9Bo3Ne',
    '8uIPHRQ',
    '2025-02-25 10:55:44.379',
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
    'ZuXIXYL',
    'AJ/24/304',
    'Zainab',
    'Abubakar',
    NULL,
    '',
    NULL,
    NULL,
    'JSS',
    NULL,
    NULL,
    '2025-02-27 00:00:00.000',
    '2024/2025',
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'OMVKFac',
    '8uIPHRQ',
    '2025-02-27 17:52:43.382',
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
    'ZyXUMwr',
    'AJ/21/165',
    'Stephen',
    'James',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    '2_fPzDw',
    '8uIPHRQ',
    '2025-02-25 13:33:29.765',
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
    'zZszPtu',
    'AJ/21/174',
    'Khalilat Ayomide',
    'Murtala',
    NULL,
    '',
    NULL,
    NULL,
    'SSS',
    NULL,
    NULL,
    '2025-02-25 00:00:00.000',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    NULL,
    'Ifq45cL',
    '8uIPHRQ',
    '2025-02-25 13:03:42.676',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: studentsdemotions
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: studentspromotions
# ------------------------------------------------------------


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


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: transactions
# ------------------------------------------------------------


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
