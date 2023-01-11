# docker-pg-dump
Postgres utility container to dump a database and push to S3 :) Lovely


### Usage example
In Kubernetes you can setup backups with:

```yaml
  jobTemplate:
    spec:
      backoffLimit: 0 # pod will not attempt retry on failure
      activeDeadlineSeconds: 3300 # 55min once a Job reaches activeDeadlineSeconds, all of its running Pods are terminated
      template:
        spec:
          serviceAccountName: pg-dumper
          containers:
          - name: pg-dumper
            image: osodevops/docker-pg-dumper:v1.0.3
            command: ["/bin/sh", "-c"]
            args:
            - |
              DATABASE_PREFIX=$(date +"%y_%m_%d");
              cd /root && PGPASSWORD=$DB_PASSWORD pg_dump -F plain -v -O -o -U $DB_USERNAME -h $DB_HOST -d ${DATABASE_NAME} -f ${DATABASE_PREFIX}_${DATABASE_NAME}.sql;
              gzip ${DATABASE_PREFIX}_${DATABASE_NAME}.sql;
              aws s3 cp /root/${DATABASE_PREFIX}_${DATABASE_NAME}.sql.gz s3://${AWS_ACCOUNT}-rds-data-backups/;
            imagePullPolicy: IfNotPresent # | IfNotPresent | Always
```