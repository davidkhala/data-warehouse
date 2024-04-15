# [.export in BTEQ](https://docs.teradata.com/r/Basic-Teradata-Query-Reference-17.20/BTEQ-Commands/BTEQ-Command-Descriptions/EXPORT)

The EXPORT command provides the client system destination and file format specifications for the export data retrieved from Teradata Database

![image](https://user-images.githubusercontent.com/7227589/236853702-2a53d770-1653-4844-96c9-c8040d0d88a3.png)


# Sample
In Record Mode, to send the results of a SELECT statement to the data set allocated to the file ${path2file}
```
.EXPORT DATA FILE=${path2file}
```

