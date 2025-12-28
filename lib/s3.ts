import { S3Client } from "@aws-sdk/client-s3";

export const s3 = new S3Client({
    region: process.env.AWS_REGION ?? "garage",
    endpoint: process.env.AWS_ENDPOINT ?? "http://localhost:3900",
    forcePathStyle: true,
    credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID!,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY!,
    }
})