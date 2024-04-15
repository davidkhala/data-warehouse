
# [.quit, .exit]([https://docs.teradata.com/r/AqtT8IJdAuhShWsvC9N9Og/hZWUydMW7uu_t5gnOV7dsw](https://docs.teradata.com/r/Basic-Teradata-Query-Reference-17.20/BTEQ-Commands/BTEQ-Command-Descriptions/EXIT-or-QUIT)https://docs.teradata.com/r/Basic-Teradata-Query-Reference-17.20/BTEQ-Commands/BTEQ-Command-Descriptions/EXIT-or-QUIT)
Log off all database sessions and then exits BTEQ.
- `.quit` or `.exit` without specifying errorcode: The highest severity value encountered during BTEQ's execution will by default be used as BTEQ's return code value
- `.quit <return-code>`: return code is a decimal number.
  - To avoid existing codes confusion, do not use numbers 1 through 10.

# [return code](https://docs.teradata.com/r/Basic-Teradata-Query-Reference-17.20/Using-BTEQ/Error-Handling/BTEQ-Return-Codes)
- `00`:	Job completed with no errors
- `02`:	BTEQ had to produce a warning to alert that an SQL request instruction was given without any sessions being logged on.
- `04`:	Warning error
- `08`:	User error
- `12`:	Severe internal error
