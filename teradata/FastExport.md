
# FastExport
FastExport utility is used to export large volume data from Teradata tables into flat files.
- Flat file cannot be read and understood using a regular text editor
- FastExport exports the data in 64K blocks

Usecases
- ELT

## Syntax
Learning
- https://www.tutorialspoint.com/teradata/teradata_fastexport.htm

Session syntax
```
.begin export
    sessions ${session_name};

.export ...
...

.end export;
```

## Deprecate
Teradata® Parallel Transporter(TPT) is the new replacement of FastExport
- FastExport will process the blocks in order.
- TPT Export can have multiple processes