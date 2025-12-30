/*
  Warnings:

  - You are about to drop the column `createdBy` on the `FileRevision` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `Node` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[currentRevisionId]` on the table `Node` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[workspaceId,parentId,name]` on the table `Node` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `sizeBytes` to the `Blob` table without a default value. This is not possible if the table is not empty.
  - Added the required column `createdById` to the `FileRevision` table without a default value. This is not possible if the table is not empty.
  - Added the required column `createdById` to the `Node` table without a default value. This is not possible if the table is not empty.
  - Added the required column `currentRevisionId` to the `Node` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Node_parentId_name_key";

-- AlterTable
ALTER TABLE "Blob" ADD COLUMN     "contentType" TEXT,
ADD COLUMN     "sha256" TEXT,
ADD COLUMN     "sizeBytes" BIGINT NOT NULL,
ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "FileRevision" DROP COLUMN "createdBy",
ADD COLUMN     "createdById" TEXT NOT NULL,
ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Node" DROP COLUMN "createdBy",
ADD COLUMN     "createdById" TEXT NOT NULL,
ADD COLUMN     "currentRevisionId" TEXT NOT NULL,
ALTER COLUMN "parentId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "WorkspaceMember" ADD COLUMN     "role" "WorkspaceRole" NOT NULL DEFAULT 'MEMBER';

-- CreateIndex
CREATE UNIQUE INDEX "Node_currentRevisionId_key" ON "Node"("currentRevisionId");

-- CreateIndex
CREATE INDEX "Node_workspaceId_idx" ON "Node"("workspaceId");

-- CreateIndex
CREATE INDEX "Node_parentId_idx" ON "Node"("parentId");

-- CreateIndex
CREATE UNIQUE INDEX "Node_workspaceId_parentId_name_key" ON "Node"("workspaceId", "parentId", "name");

-- CreateIndex
CREATE INDEX "NodeClosure_ancestorId_idx" ON "NodeClosure"("ancestorId");

-- CreateIndex
CREATE INDEX "NodeClosure_descendantId_depth_idx" ON "NodeClosure"("descendantId", "depth");

-- AddForeignKey
ALTER TABLE "Node" ADD CONSTRAINT "Node_currentRevisionId_fkey" FOREIGN KEY ("currentRevisionId") REFERENCES "FileRevision"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Node" ADD CONSTRAINT "Node_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Node" ADD CONSTRAINT "Node_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Node"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FileRevision" ADD CONSTRAINT "FileRevision_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
