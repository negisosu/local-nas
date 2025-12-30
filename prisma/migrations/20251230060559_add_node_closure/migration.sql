-- CreateTable
CREATE TABLE "NodeClosure" (
    "ancestorId" TEXT NOT NULL,
    "descendantId" TEXT NOT NULL,
    "depth" INTEGER NOT NULL,

    CONSTRAINT "NodeClosure_pkey" PRIMARY KEY ("ancestorId","descendantId")
);

-- AddForeignKey
ALTER TABLE "NodeClosure" ADD CONSTRAINT "NodeClosure_ancestorId_fkey" FOREIGN KEY ("ancestorId") REFERENCES "Node"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NodeClosure" ADD CONSTRAINT "NodeClosure_descendantId_fkey" FOREIGN KEY ("descendantId") REFERENCES "Node"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
