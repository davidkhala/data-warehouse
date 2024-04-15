[Teradata has Common-Table-Expressions(CTE) support]([https://forgetcode.com/Teradata/1298-Common-Table-Expressions-CTE](https://docs.teradata.com/r/Teradata-VantageTM-SQL-Data-Manipulation-Language/March-2019/Select-Statements/WITH-Modifier/Examples/Example-Common-Table-Expression))

```
WITH CTE_name(column list) AS
(
SELECT column list FROM table [(WHERE condition)]
)
SELECT * FROM CTE_name;
```
