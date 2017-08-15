<!--
---
title: "Run Python using T-SQL | Microsoft Docs"
ms.custom: ""
ms.date: "07/31/2017"
ms.prod: "sql-server-2016"
ms.reviewer: ""
ms.suite: ""
ms.technology: 
  - "r-services"
ms.tgt_pltfrm: ""
ms.topic: "article"
applies_to: 
  - "SQL Server 2016"
dev_langs: 
  - "Python"
caps.latest.revision: 2
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
-->

# T-SQL���g�p����Python�����s����

���̗�ł́A�X�g�A�h�v���V�[�W��[sp_execute_external_script](https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-execute-external-script-transact-sql)���g�p���āASQL Server�ŒP����Python�X�N���v�g�����s������@�������܂��B

## Step 1. �e�X�g�e�[�u�����쐬����

�܂��A�j���̖��O���\�[�X�f�[�^�Ƀ}�b�s���O����Ƃ��Ɏg�p����ǉ��̃f�[�^���쐬���܂��B����T-SQL�X�e�[�g�����g�����s���āA�e�[�u�����쐬���܂��B

```SQL
CREATE TABLE PythonTest (
    [DayOfWeek] varchar(10) NOT NULL,
    [Amount] float NOT NULL
    )
GO

INSERT INTO PythonTest VALUES
('Sunday', 10.0),
('Monday', 11.1),
('Tuesday', 12.2),
('Wednesday', 13.3),
('Thursday', 14.4),
('Friday', 15.5),
('Saturday', 16.6),
('Friday', 17.7),
('Monday', 18.8),
('Sunday', 19.9)
GO
```

## Step 2. "Hello World" �X�N���v�g�����s����

���̃R�[�h�́APython�����^�C���ɓ��̓f�[�^��n���A���̓f�[�^�̊e�s�ɑ΂��āA�j���̃C���f�b�N�X��\�����l�Ńe�[�u���̗j�������X�V���܂��B

SQL Server����Python�����^�C���ɓn�����s�����w�肵�Ă���*@RowsPerRead*�ɒ��ڂ��Ă��������B

**pandas**�Ƃ́A�f�[�^��͂��x������@�\��񋟂���Python���C�u�����ŁAMachine Learning Services�Ƀf�t�H���g�Ŋ܂܂�Ă��܂��B

```sql
DECLARE @ParamINT INT = 1234567
DECLARE @ParamCharN VARCHAR(6) = 'INPUT '

print '------------------------------------------------------------------------'
print 'Output parameters (before):'
print FORMATMESSAGE('ParamINT=%d', @ParamINT)
print FORMATMESSAGE('ParamCharN=%s', @ParamCharN)

print 'Dataset (before):'
SELECT * FROM PythonTest

print '------------------------------------------------------------------------'
print 'Dataset (after):'
DECLARE @RowsPerRead INT = 5

execute sp_execute_external_script 
@language = N'Python',
@script = N'
import sys
import os
print("*******************************")
print(sys.version)
print("Hello World")
print(os.getcwd())
print("*******************************")
if ParamINT == 1234567:
       ParamINT = 1
else:
       ParamINT += 1

ParamCharN="OUTPUT"
OutputDataSet = InputDataSet

global daysMap

daysMap = {
       "Monday" : 1,
       "Tuesday" : 2,
       "Wednesday" : 3,
       "Thursday" : 4,
       "Friday" : 5,
       "Saturday" : 6,
       "Sunday" : 7
       }

OutputDataSet["DayOfWeek"] = pandas.Series([daysMap[i] for i in OutputDataSet["DayOfWeek"]], index = OutputDataSet.index, dtype = "int32")
', 
@input_data_1 = N'SELECT * FROM PythonTest',
@input_data_1_name = 'InputDataSet'
@output_data_1_name = 'OutputDataSet'
@params = N'@r_rowsPerRead INT, @ParamINT INT OUTPUT, @ParamCharN CHAR(6) OUTPUT',
@r_rowsPerRead = @RowsPerRead,
@paramINT = @ParamINT OUTPUT,
@paramCharN = @ParamCharN OUTPUT
with result sets (("DayOfWeek" int null, "Amount" float null))

print 'Output parameters (after):'
print FORMATMESSAGE('ParamINT=%d', @ParamINT)
print FORMATMESSAGE('ParamCharN=%s', @ParamCharN)
GO
```

> [!TIP]
> �X�g�A�h�v���V�[�W���̃p�����[�^�̏ڍׂ�[sp_execute_external_script](https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-execute-external-script-transact-sql)���m�F���Ă��������B

## Step 3. ���s���ʂ̊m�F

�X�g�A�h�v���V�[�W���̓I���W�i���̃f�[�^�ƍX�V��̃f�[�^��Management Studio�i�������͂ق���SQL�N�G���c�[���j�̌��ʃy�C���ɕ\�����܂��B

*���ʁi�I���W�i���j*
|DayOfWeek| Amount|
|-----|-----|
|Sunday|10.0|
|Monday|11.1|
|Tuesday|12.2|
|Wednesday|13.3|
|Thursday|14.4|
|Friday|15.5|
|Saturday|16.6|
|Friday|17.7|
|Monday|18.8|
|Sunday|19.9|

*���ʁi�X�V��j*
|DayOfWeek| Amount|
|-----|-----|
|7|10.0|
|1|11.1|
|2|12.2|
|3|13.3|
|4|14.4|
|5|15.5|
|6|16.6|
|5|17.7|
|1|18.8|
|7|19.9|

Python�R���\�[���ɕԂ��ꂽ�X�e�[�^�X��G���[�Ɋւ�����̓��b�Z�[�W�y�C���ɕ\�����܂��B

*���b�Z�[�W*
```
------------------------------------------------------------------------
Output parameters (before):
ParamINT=1234567
ParamCharN=INPUT 
Dataset (before):

(10 �s��������܂���)
------------------------------------------------------------------------
Dataset (after):
STDOUT message(s) from external script: 
*******************************
3.5.2 |Continuum Analytics, Inc.| (default, Jul  5 2016, 11:41:13) [MSC v.1900 64 bit (AMD64)]
Hello World
C:\PROGRA~1\MICROS~1\MSSQL1~1.MSS\MSSQL\EXTENS~1\MSSQLSERVER01\C9C1E33C-8646-4FDA-9F0F-FAA72A142B9A
*******************************
*******************************
3.5.2 |Continuum Analytics, Inc.| (default, Jul  5 2016, 11:41:13) [MSC v.1900 64 bit (AMD64)]
Hello World
C:\PROGRA~1\MICROS~1\MSSQL1~1.MSS\MSSQL\EXTENS~1\MSSQLSERVER01\C9C1E33C-8646-4FDA-9F0F-FAA72A142B9A
*******************************


(10 �s��������܂���)
Output parameters (after):
ParamINT=2
ParamCharN=OUTPUT
```

+ ���b�Z�[�W�o�͂ɂ́A�X�N���v�g���s�Ɏg�p������ƃf�B���N�g�����܂܂�܂��B���̗�ł́AMSSQLSERVER01��SQL Server�ɂ���Ċ��蓖�Ă�ꂽ���[�J�[�A�J�E���g���Q�Ƃ��ăW���u���Ǘ����܂��BGUID�́A�f�[�^����уX�N���v�g���ʕ����i�[����X�N���v�g�̎��s���ɍ쐬�����ꎞ�I�ȃt�H���_�̖��O�ł��B�����̈ꎞ�t�H���_��SQL Server�ɂ���ĕی삳��A�X�N���v�g�̏I�����Windows�W���u�I�u�W�F�N�g�ɂ���ăN���[���A�b�v����܂��B

+ ���b�Z�[�W�uHello World�v���܂ރZ�N�V������2��\������܂��B�����10�s�̃e�[�u���ɑ΂���*@RowsPerRead*�̒l��5�ɐݒ肳��Ă��邽�߁A�e�[�u�����̂��ׂĂ̍s�̏�����Python��2��Ăяo����Ă��邽�߂ł��B

    �{�ԉғ������Ɋe�o�b�`�œn���s�̍ő吔���`���[�j���O���邱�Ƃ������߂��܂��B�œK�ȍs���̓f�[�^�Ɉˑ����f�[�^�Z�b�g�̗񐔂Ɠn���f�[�^�̎�ނ̗����ɂ���ĉe�����󂯂܂��B

## ���\�[�X

���x�ȃq���g�ƃG���h�c�[�G���h�̃f���ɂ��ẮA������Python�̃T���v���ƃ`���[�g���A�����Q�Ƃ��Ă��������B

+ [revoscalepy���g���ă��f�����쐬����](use-python-revoscalepy-to-create-model.md)
+ [SQL�J���҂̂��߂� In-Database Python ����](sqldev-in-database-python-for-sql-developers.md)
+ [Python��SQL Server���g�p���ė\�����f�����\�z����](https://github.com/gho9o9/sql-server-samples/tree/master/samples/features/machine-learning-services/python/getting-started/rental-prediction)

## �g���u���V���[�e�B���O

`sp_execute_external_script`�̎��s���G���[�ƂȂ�ꍇ�͊O���X�N���v�g���s�@�\���L��������Ă��Ȃ��\��������܂��B���̍ۂ�`sp_configure`���g�p���ĊO���X�N���v�g���s�@�\��L����������A�C���X�^���X���ċN�����Ă��������B���ڍׂɂ��Ă�[Machine Learning Services�iPython�j�̃Z�b�g�A�b�v](../python/setup-python-machine-learning-services.md)���m�F���Ă��������B

<!--
---
title: "Run Python using T-SQL | Microsoft Docs"
ms.custom: ""
ms.date: "07/31/2017"
ms.prod: "sql-server-2016"
ms.reviewer: ""
ms.suite: ""
ms.technology: 
  - "r-services"
ms.tgt_pltfrm: ""
ms.topic: "article"
applies_to: 
  - "SQL Server 2016"
dev_langs: 
  - "Python"
caps.latest.revision: 2
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# Run Python using T-SQL

This example shows how you can run a simple Python script in SQL Server, by using the stored procedure [sp_execute_external_script](../../relational-databases/system-stored-procedures/sp-execute-external-script-transact-sql.md)

## Step 1. Create the test data table

First, you'll create some extra data, to use when mapping the names of the days of the week to the source data. Run the following T-SQL statement to create the table.

```SQL
CREATE TABLE PythonTest (
    [DayOfWeek] varchar(10) NOT NULL,
    [Amount] float NOT NULL
    )
GO

INSERT INTO PythonTest VALUES
('Sunday', 10.0),
('Monday', 11.1),
('Tuesday', 12.2),
('Wednesday', 13.3),
('Thursday', 14.4),
('Friday', 15.5),
('Saturday', 16.6),
('Friday', 17.7),
('Monday', 18.8),
('Sunday', 19.9)
GO
```

## Step 2. Run the "Hello World" script

The following code loads the Python executable, passes the input data, and for each row of input data, updates the day name in the table with a number representing the day-of-week index.

Take a note of the parameter *@RowsPerRead*. This parameter specifies the number of rows that are passed to the Python runtime from SQL Server.

The Python Data Analysis Library, known as **pandas**, is required for passing data to SQL Server, and is included by default with Machine Learning Services.

```sql
DECLARE @ParamINT INT = 1234567
DECLARE @ParamCharN VARCHAR(6) = 'INPUT '

print '------------------------------------------------------------------------'
print 'Output parameters (before):'
print FORMATMESSAGE('ParamINT=%d', @ParamINT)
print FORMATMESSAGE('ParamCharN=%s', @ParamCharN)

print 'Dataset (before):'
SELECT * FROM PythonTest

print '------------------------------------------------------------------------'
print 'Dataset (after):'
DECLARE @RowsPerRead INT = 5

execute sp_execute_external_script 
@language = N'Python',
@script = N'
import sys
import os
print("*******************************")
print(sys.version)
print("Hello World")
print(os.getcwd())
print("*******************************")
if ParamINT == 1234567:
       ParamINT = 1
else:
       ParamINT += 1

ParamCharN="OUTPUT"
OutputDataSet = InputDataSet

global daysMap

daysMap = {
       "Monday" : 1,
       "Tuesday" : 2,
       "Wednesday" : 3,
       "Thursday" : 4,
       "Friday" : 5,
       "Saturday" : 6,
       "Sunday" : 7
       }

OutputDataSet["DayOfWeek"] = pandas.Series([daysMap[i] for i in OutputDataSet["DayOfWeek"]], index = OutputDataSet.index, dtype = "int32")
', 
@input_data_1 = N'SELECT * FROM PythonTest', 
@params = N'@r_rowsPerRead INT, @ParamINT INT OUTPUT, @ParamCharN CHAR(6) OUTPUT',
@r_rowsPerRead = @RowsPerRead,
@paramINT = @ParamINT OUTPUT,
@paramCharN = @ParamCharN OUTPUT
with result sets (("DayOfWeek" int null, "Amount" float null))

print 'Output parameters (after):'
print FORMATMESSAGE('ParamINT=%d', @ParamINT)
print FORMATMESSAGE('ParamCharN=%s', @ParamCharN)
GO
```

> [!TIP]
> The parameters for this stored procedure are described in more detail in this quickstart: [Using R code in T-SQL](rtsql-using-r-code-in-transact-sql-quickstart.md).

## Step 3. View the results

The stored procedure returns the original data, applies the script, and then returns the modified data in the **Results** pane of Management Studio or other SQL query tool.


|DayOfWeek (before)| Amount|DayOfWeek (after) |
|-----|-----|-----|
|Sunday|10|7|
|Monday|11.1|1|
|Tuesday|12.2|2|
|Wednesday|13.3|3|
|Thursday|14.4|4|
|Friday|15.5|5|
|Saturday|16.6|6|
|Friday|17.7|5|
|Monday|18.8|1|
|Sunday|19.9|7|

Status messages or errors returned to the Python console are returned as messages in the **Query** window. Here's an excerpt of the output you might see:

*Sample results*

```
Output parameters (before):
ParamINT=1234567
ParamCharN=INPUT 
Dataset (before):

(10 rows affected)

Dataset (after):
STDOUT message(s) from external script: 
C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\PYTHON_SERVICES\lib\site-packages\revoscalepy

3.5.2 |Anaconda 4.2.0 (64-bit)| (default, Jul  5 2016, 11:41:13) [MSC v.1900 64 bit (AMD64)]
Hello World
C:\PROGRA~1\MICROS~2\MSSQL1~1.MSS\MSSQL\EXTENS~1\MSSQLSERVER01\7A70B3FB-FBA2-4C52-96D6-8634DB843229

3.5.2 |Anaconda 4.2.0 (64-bit)| (default, Jul  5 2016, 11:41:13) [MSC v.1900 64 bit (AMD64)]
Hello World
C:\PROGRA~1\MICROS~2\MSSQL1~1.MSS\MSSQL\EXTENS~1\MSSQLSERVER01\7A70B3FB-FBA2-4C52-96D6-8634DB843229

(10 rows affected)
Output parameters (after):
ParamINT=2
ParamCharN=OUTPUT
```

+ The Message output includes the working directory used for script execution. In this example,  MSSQLSERVER01 refers to the worker account allocated by SQL Server to manage the job. The GUID is the name of a temporary folder that is created during script execution to store data and script artifacts. These temporary folders are secured by SQL Server, and are cleaned up by the Windows job object after script has terminated.

+ The section containing the message "Hello World" prints two times. This happens because the value of *@RowsPerRead* was set to 5 and there are 10 rows in the table; therefore, two calls to Python are required to process all the rows in the table.

    In your production runs, we recommend that you experiment with different values to determine the maximum number of rows that should be passed in each batch. The optimum number of rows is data-dependent, and is affected by both the number of columns in the dataset and the type of data that you are passing.

## Resources

See these additional Python samples and tutorials for advanced tips and end-to-end demos.

+ [Use Python revoscalepy to create a model](use-python-revoscalepy-to-create-model.md)
+ [In-Database Python for SQL Developers](sqldev-in-database-python-for-sql-developers.md)
+ [Build a predictive model using Python and SQL Server](https://microsoft.github.io/sql-ml-tutorials/python/rentalprediction/)

## Troubleshooting

If you can't find the stored procedure, `sp_execute_external_script`, it means you probably haven't finished configuring the instance to support external runtimes. After running SQL Server 2017 setup and selecting Python as the machine learning language, you must also explicitly enable the feature using `sp_configure`, and then restart the instance. For details, see [Setup Machine Learning Services with Python](../python/setup-python-machine-learning-services.md).
-->