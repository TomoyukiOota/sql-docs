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

# T-SQLを使用してPythonを実行する

この例では、ストアドプロシージャ[sp_execute_external_script](https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-execute-external-script-transact-sql)を使用して、SQL Serverで単純なPythonスクリプトを実行する方法を示します。

## Step 1. テストテーブルを作成する

まず、曜日の名前をソースデータにマッピングするときに使用する追加のデータを作成します。次のT-SQLステートメントを実行して、テーブルを作成します。

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

## Step 2. "Hello World" スクリプトを実行する

次のコードは、Pythonランタイムに入力データを渡し、入力データの各行に対して、曜日のインデックスを表す数値でテーブルの曜日名を更新します。

SQL ServerからPythonランタイムに渡される行数を指定している*@RowsPerRead*に注目してください。

**pandas**とは、データ解析を支援する機能を提供するPythonライブラリで、Machine Learning Servicesにデフォルトで含まれています。

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
> ストアドプロシージャのパラメータの詳細は[sp_execute_external_script](https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-execute-external-script-transact-sql)を確認してください。

## Step 3. 実行結果の確認

ストアドプロシージャはオリジナルのデータと更新後のデータをManagement Studio（もしくはほかのSQLクエリツール）の結果ペインに表示します。

*結果（オリジナル）*
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

*結果（更新後）*
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

Pythonコンソールに返されたステータスやエラーに関する情報はメッセージペインに表示します。

*メッセージ*
```
------------------------------------------------------------------------
Output parameters (before):
ParamINT=1234567
ParamCharN=INPUT 
Dataset (before):

(10 行処理されました)
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


(10 行処理されました)
Output parameters (after):
ParamINT=2
ParamCharN=OUTPUT
```

+ メッセージ出力には、スクリプト実行に使用される作業ディレクトリが含まれます。この例では、MSSQLSERVER01はSQL Serverによって割り当てられたワーカーアカウントを参照してジョブを管理します。GUIDは、データおよびスクリプト成果物を格納するスクリプトの実行中に作成される一時的なフォルダの名前です。これらの一時フォルダはSQL Serverによって保護され、スクリプトの終了後にWindowsジョブオブジェクトによってクリーンアップされます。

+ メッセージ「Hello World」を含むセクションが2回表示されます。これは10行のテーブルに対して*@RowsPerRead*の値が5に設定されているため、テーブル内のすべての行の処理にPythonが2回呼び出されているためです。

    本番稼動向けに各バッチで渡す行の最大数をチューニングすることをお勧めします。最適な行数はデータに依存しデータセットの列数と渡すデータの種類の両方によって影響を受けます。

## リソース

高度なヒントとエンドツーエンドのデモについては、これらのPythonのサンプルとチュートリアルを参照してください。

+ [revoscalepyを使ってモデルを作成する](use-python-revoscalepy-to-create-model.md)
+ [SQL開発者のための In-Database Python 分析](sqldev-in-database-python-for-sql-developers.md)
+ [PythonとSQL Serverを使用して予測モデルを構築する](https://github.com/gho9o9/sql-server-samples/tree/master/samples/features/machine-learning-services/python/getting-started/rental-prediction)

## トラブルシューティング

`sp_execute_external_script`の実行がエラーとなる場合は外部スクリプト実行機能が有効化されていない可能性があります。その際は`sp_configure`を使用して外部スクリプト実行機能を有効化した後、インスタンスを再起動してください。より詳細については[Machine Learning Services（Python）のセットアップ](../python/setup-python-machine-learning-services.md)を確認してください。

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