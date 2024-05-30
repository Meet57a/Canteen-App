const { S3Client } = require("@aws-sdk/client-s3");

const S3 = new S3Client({
    region: "auto",
    endpoint: "",
    credentials: {
        accessKeyId: "",
        secretAccessKey:
            "",
    },
});

module.exports = S3;
