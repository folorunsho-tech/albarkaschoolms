/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

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
  `school_section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `payment_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teller_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` int DEFAULT NULL,
  `paid` int DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) DEFAULT NULL,
  `updatedById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `section` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `Payments_student_id_fkey` (`student_id`),
  KEY `Payments_createdById_fkey` (`createdById`),
  CONSTRAINT `Payments_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Payments_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
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
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `demotedOn` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `StudentsDemotions_student_id_fkey` (`student_id`),
  KEY `StudentsDemotions_to_id_fkey` (`to_id`),
  KEY `StudentsDemotions_createdById_fkey` (`createdById`),
  CONSTRAINT `StudentsDemotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `StudentsDemotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `StudentsDemotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `classes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: studentspromotions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `studentspromotions`;
CREATE TABLE `studentspromotions` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `promotedOn` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `StudentsPromotions_student_id_fkey` (`student_id`),
  KEY `StudentsPromotions_to_id_fkey` (`to_id`),
  KEY `StudentsPromotions_createdById_fkey` (`createdById`),
  CONSTRAINT `StudentsPromotions_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `StudentsPromotions_student_id_fkey` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `StudentsPromotions_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `classes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
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
    'e48007b2-2354-4bc7-b1b6-f8e816ed70e0',
    '617cf1fcb3496fae5c068d2af0ebf11a9f924ae1aecfdca6817dd367bcac4b66',
    '2024-12-03 20:02:54.718',
    '20241203200254_classhistory',
    NULL,
    NULL,
    '2024-12-03 20:02:54.299',
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
  ('EMP0001', '18mZBlZ');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', '18mZBlZ');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', '1oHZ6vY');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', '3c9EWTV');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'aVninf3');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'bDliUQN');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'bDliUQN');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'Bo69IyB');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'Bo69IyB');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'bT759gG');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'bT759gG');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'CfPv-dn');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'DvclqC0');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0000', 'E7JETdx');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'E7JETdx');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'E7JETdx');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'eIi5HQm');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'eIi5HQm');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'ElqqBT7');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'FnMLAER');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'FnMLAER');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'g9NIUEF');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'g9NIUEF');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'GQjbl0E');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'GQjbl0E');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'IC1gVq9');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'IC1gVq9');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'JFhxsq5');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'JFhxsq5');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'l95dKX8');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'l95dKX8');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'lqUtsDB');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'lRKKmoa');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'lRKKmoa');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'M5Vv1pi');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'M5Vv1pi');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'MjrnCzB');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'nGFxkVf');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'nGFxkVf');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'nMFpFkZ');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'nMFpFkZ');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'nmkGlgl');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'nTKfuNC');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'o9bUcgF');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'pFZPf3T');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'pFZPf3T');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'PyejTsh');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'qnPwjEd');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'TFlldgc');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'TJSQ_-v');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'TJSQ_-v');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'uis6FkF');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0000', 'Vx7JKMR');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'Vx7JKMR');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'Vx7JKMR');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'x9oVrQ9');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'x9oVrQ9');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP0001', 'YOb8XbD');
INSERT INTO
  `_staffstosubjects` (`A`, `B`)
VALUES
  ('EMP2', 'YOb8XbD');

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
    `active`
  )
VALUES
  (
    '8uIPHRQ',
    'Ibrahim Folorunsho',
    'tacheyon',
    '00a49fa200fb624f879f26b296fa89f0f3676f1f2ba10de2b5f39b800b34fcb4',
    'EMP0000',
    '{\"backup\": false, \"staffs\": {\"edit\": false, \"view\": false, \"create\": false}, \"classes\": {\"edit\": false, \"view\": false}, \"results\": {\"edit\": true, \"view\": true, \"create\": true}, \"accounts\": false, \"payments\": {\"edit\": false, \"view\": false, \"create\": false}, \"settings\": false, \"students\": {\"edit\": false, \"view\": false, \"create\": false}, \"statement\": true, \"staffPromotions\": false, \"studentPromotions\": false}',
    '2024-11-29 11:11:24.098',
    '2024-12-06 01:03:26.281',
    '8uIPHRQ',
    1
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
    `active`
  )
VALUES
  (
    'f4RocSh',
    'Alexander Ehichioya Samuel',
    'Alexander',
    'e8a00edfff2862bfdef5f90ac0ac9db32d17060f1e0f388874127bf8fa03785f',
    'EMP2',
    '{\"backup\": true, \"staffs\": {\"edit\": true, \"view\": true, \"create\": true}, \"classes\": {\"edit\": true, \"view\": true}, \"results\": {\"edit\": true, \"view\": true, \"create\": true}, \"accounts\": true, \"payments\": {\"edit\": false, \"view\": false, \"create\": false}, \"settings\": true, \"students\": {\"edit\": true, \"view\": true, \"create\": true}, \"statement\": true, \"staffPromotions\": false, \"studentPromotions\": true}',
    '2024-12-08 11:32:18.959',
    '2024-12-20 12:49:08.097',
    NULL,
    1
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
    `active`
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
    '2024-12-03 16:39:19.345',
    'pS2M79v',
    1
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
INSERT INTO
  `appointments` (`id`, `name`, `school_section`)
VALUES
  ('zD0CVKz', 'Developer', 'All');

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
    'cm4yneboe0001sucehoo08v7i',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 20:44:48.922',
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
    'cm4ynf0v4000112k7rwsnr8yd',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 20:45:21.566',
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
    'cm4ynfxb50001vfjft5zw2e3b',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 20:46:03.616',
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
    'cm4ynkt0j0003vfjf34y6ga5w',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 20:49:51.329',
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
    'cm4ynnlwp0005vfjfvk3wbps5',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 20:52:02.088',
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
    'cm4yno8ec0007vfjfm7k7rqvx',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 20:52:31.235',
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
    'cm4yntbko00019ujrcjjvzakw',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 20:56:28.622',
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
    'cm4ypbhio0001rp0smubi359k',
    'f4RocSh',
    'Logged-in',
    '2024-12-21 21:38:35.755',
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
    'cm4zqmuzi00011uvp125m8bgw',
    'f4RocSh',
    'Logged-in',
    '2024-12-22 15:03:12.219',
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
    'cm4zxs7xa0001i1jy6jzmgnqa',
    'pS2M79v',
    'Logged-in',
    '2024-12-22 18:23:19.572',
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
    'cm500gb3h0001e19nop4j7day',
    'f4RocSh',
    'Logged-in',
    '2024-12-22 19:38:02.665',
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
    'cm50br60c0003e19n9fuhoh5s',
    'f4RocSh',
    'Logged-in',
    '2024-12-23 00:54:25.064',
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
    '457bdfc7-428f-4596-920f-032509c122b7',
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
    'e6a8658d-e1b5-4ba4-bf29-1d0ebd05395d',
    'AJ3njGo',
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
    'cm4amdrke0001e3y7d6meyubs',
    'RAN1AcR',
    '2024/2025',
    '1st term',
    '2024-12-05 01:09:55.023',
    'Relocation',
    NULL,
    '',
    'pS2M79v'
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
    'cm4amg6020001f7yi7k7ojbuq',
    'RAN1AcR',
    '2024/2025',
    '1st term',
    '2024-12-05 01:11:47.042',
    'Relocation',
    NULL,
    '',
    'pS2M79v'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: disengagemnets
# ------------------------------------------------------------


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
    5,
    '2023/2024',
    '1st term',
    'pS2M79v',
    '2024-12-08 16:27:34.702',
    '2024-12-08 16:40:05.444',
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
  `feesgroup` (`id`, `name`, `amount`, `school_section`)
VALUES
  ('huZHxXf', 'testing', '111', 'All');
INSERT INTO
  `feesgroup` (`id`, `name`, `amount`, `school_section`)
VALUES
  ('xMpB2xj', 'School fee', '12000', 'SSS');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: payments
# ------------------------------------------------------------

INSERT INTO
  `payments` (
    `payment_id`,
    `student_id`,
    `term`,
    `session`,
    `payment_method`,
    `teller_no`,
    `total`,
    `paid`,
    `status`,
    `createdById`,
    `createdAt`,
    `updatedAt`,
    `updatedById`,
    `item`,
    `section`,
    `class`
  )
VALUES
  (
    'PM87207',
    'FWpZizc',
    '1st term',
    '2024/2025',
    'Cash',
    '',
    12000,
    12000,
    'Cancelled',
    'pS2M79v',
    '2024-12-04 16:30:20.384',
    '2024-12-04 16:31:19.501',
    NULL,
    'School fee',
    'SSS',
    'SSS 1'
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
    'SSS',
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
    '2024-12-03 03:24:53.504',
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
    '2024-12-09 20:08:42.973',
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
    'Ifq45cL',
    '8uIPHRQ',
    '2024-12-05 01:36:54.011',
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
    '2024-12-05 01:36:54.019',
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
    'eBMCLPq',
    'AJ3njGo',
    'SSS 2',
    '1st term',
    '2024/2025',
    'Ifq45cL',
    'pS2M79v',
    '2024-12-05 01:36:53.992'
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
    'oTeTPjA',
    'FWpZizc',
    'SSS 2',
    '1st term',
    '2024/2025',
    'Ifq45cL',
    'pS2M79v',
    '2024-12-05 01:36:53.993'
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
    'o-_AEdN',
    'AJ3njGo',
    'SSS 1',
    '1st term',
    '2024/2025',
    '2_fPzDw',
    'pS2M79v',
    '2024-12-05 01:33:08.002'
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
    'U8jbxjI',
    'FWpZizc',
    'SSS 1',
    '1st term',
    '2024/2025',
    '2_fPzDw',
    'pS2M79v',
    '2024-12-05 01:33:08.008'
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

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
