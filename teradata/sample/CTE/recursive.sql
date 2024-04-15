CREATE TABLE t1(a1 INT, b1 INT);

INS t1(1,2);
INS t1(1,4);
INS t1(2,3);
INS t1(3,4);

WITH
RECURSIVE s3 (MinVersion)  AS (SELECT a1 FROM t1 WHERE a1 > 1
                               UNION ALL
                              SELECT MinVersion FROM s3 WHERE MinVersion > 3),
RECURSIVE s4(MinVersion)  AS (SELECT a1 FROM t1 WHERE a1 = 2
                              UNION ALL
                              SELECT MinVersion FROM s4 WHERE MinVersion > 2)
SELECT * FROM s3,s4;
