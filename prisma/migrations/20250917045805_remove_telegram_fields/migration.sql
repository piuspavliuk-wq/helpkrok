/*
  Warnings:

  - You are about to drop the column `authDate` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `hash` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `photoUrl` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `telegramId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `User` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT,
    "email" TEXT,
    "password" TEXT,
    "emailVerified" DATETIME,
    "image" TEXT,
    "firstName" TEXT,
    "lastName" TEXT,
    "faculty" TEXT,
    "university" TEXT,
    "yearOfStudy" INTEGER,
    "phone" TEXT,
    "dateOfBirth" DATETIME,
    "bio" TEXT,
    "preferences" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_User" ("bio", "createdAt", "dateOfBirth", "email", "emailVerified", "faculty", "firstName", "id", "image", "lastName", "name", "password", "phone", "preferences", "university", "updatedAt", "yearOfStudy") SELECT "bio", "createdAt", "dateOfBirth", "email", "emailVerified", "faculty", "firstName", "id", "image", "lastName", "name", "password", "phone", "preferences", "university", "updatedAt", "yearOfStudy" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
