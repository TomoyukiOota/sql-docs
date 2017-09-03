# Lesson 2: PowerShellを使用したSQL Serverへのデータインポート

この記事は、SQL開発者のための In-Database R 分析（チュートリアル） の一部です。

このステップでは、ダウンロードしたスクリプトの1つを実行して、チュートリアルに必要なデータベースオブジェクトを作成します。このスクリプトは、使用するストアドプロシージャのほとんどを作成し、指定したデータベースのテーブルにサンプルデータをロードします。

## 出典
[Lesson 2: Import data to SQL Server using PowerShell](https://docs.microsoft.com/en-us/sql/advanced-analytics/r/sqldev-import-data-to-sql-server-using-powershell)

## オブジェクト作成

ダウンロードしたファイル群の中のPowerShellスクリプト`RunSQL_SQL_Walkthrough.ps1`を実行し、チュートリアル環境を準備します。このスクリプトは次のアクションを実行します：

- SQL Native ClientおよびSQLコマンドラインユーティリティがインストールされていない場合はインストールします。これらは、bcpを使用してデータをバルクロードするために必要です。

- SQL Serverインスタンスにデータベースとテーブルを作成し、そこへデータをバルクロードします。

- さらに複数の関数とストアドプロシージャを作成します。

## スクリプトの実行

1.  管理者としてPowerShellコマンドプロンプトを開き、次のコマンドを実行します。
  
    ```PowerShell:PowerShell
    .\RunSQL_SQL_Walkthrough.ps1
    ```
  
    次の情報を入力するよう求められます。
  
    - SQL Server 2017 R Serviceがインストールされているサーバ名またはアドレス。
    - 作成するデータベースの名前
    - 対象のSQL Serverのユーザー名とパスワード。このユーザは、データベース、テーブル、ストアドプロシージャ、関数の作成権限、およびテーブルへのデータロード権限が必要です。ユーザー名とパスワードを省略した場合は現在のWindowsユーザによってログインします。
    - ダウンロードしたファイル群の中のサンプルデータファイル`nyctaxi1pct.csv`のパス。例えば、`C:\tempRSQL\nyctaxi1pct.csv`です。
    
    ★スクショ★
    　2_データインポートSTART（PWS）
    　3_データインポートEND（PWS）
    ★スクショ★

2.  上記手順の一環で指定したデータベース名とユーザー名をプレースホルダに置き換えるように、すべてのT-SQLスクリプトが変更されています。

    T-SQLスクリプトによって作成されるストアドプロシージャと関数がデータベース内に作成されていることを確認します。
    
    ★問題点★
    　ストアドプロシージャPersistModelが作成されていない
    　ストアドプロシージャPredictBatchModeが作成されていない
    ★問題点★

    |**T-SQLスクリプトファイル**|**ストアドプロシージャ／関数**|
    |-|-|
    |create-db-tb-upload-data.sql|データベースと2つのテーブルを作成します。<br /><br />テーブル`nyctaxi_sample`: メインとなるNYC Taxiデータセットが登録されます。ロードされるデータはNYC Taxiデータセットの1％のサンプルです。クラスタ化カラムストアインデックスの定義によってストレージ効率とクエリパフォーマンスを向上させています。<br /><br />テーブル`nyc_taxi_models`: 訓練された高度な分析モデルが登録されます。|
    |fnCalculateDistance.sql|乗車位置と降車位置の間の直接距離を計算するスカラー値関数`fnCalculateDistance`を作成します。|
    |fnEngineerFeatures.sql|モデルトレーニング用の新しい特徴抽出を作成するテーブル値関数`fnEngineerFeatures`を作成します。|
    |PersistModel.sql|モデルを保存するために呼び出すことができるストアドプロシージャ`PersistModel`を作成します。 ストアドプロシージャは、varbinaryデータ型でシリアル化されたモデルを取得し、指定されたテーブルに書き込みます。|
    |PredictTipBatchMode.sql|モデルを使用した予測のために、訓練されたモデルを呼び出すストアドプロシージャ`PredictTipBatchMode`を作成します。ストアドプロシージャは、入力パラメータとして問合せを受け入れ、入力行のスコアを含む数値の列を戻します。|
    |PredictTipSingleMode.sql|モデルを使用した予測のために、訓練されたモデルを呼び出すストアドプロシージャ`PredictTipSingleMode`を作成します。このストアドプロシージャは新しい観測値を入力として、個々の特徴値はインラインパラメータとして受け取り、新しい観測値に対する予測値を返します。|
    |PlotHistogram.sql|データ探索用のストアドプロシージャ`PlotHistogram`を作成します。 このストアドプロシージャは、R関数を呼び出して変数のヒストグラムをプロットし、プロットをバイナリオブジェクトとして返します。|
    |PlotInOutputFiles.sql|データ探索用のストアドプロシージャ`PlotInOutputFiles`を作成します。 このストアドプロシージャは、R関数を使用してグラフィックを作成し、ローカルPDFファイルとして保存します。|
    |TrainTipPredictionModel.sql|Rパッケージを呼び出すことによってロジスティック回帰モデルを訓練するストアドプロシージャ`TrainTipPredictionModel`を作成します。 このモデルは、転倒した列の値を予測し、ランダムに選択された70％のデータを使用して訓練されます。 ストアドプロシージャの出力は訓練されたモデルであり、テーブルnyc_taxi_modelsに保存されます。|

3.  SQL Server Management Studioを使用してSQL Serverへログインし、作成されたデータベース、テーブル、関数、およびストアドプロシージャを確認します。

    ★スクショ★
    　4_データインポート後のオブジェクトエクスプローラー（SSMS）
    ★スクショ★
  
    > [!NOTE]
    > T-SQLスクリプトはデータベースオブジェクトを再作成しないため、すでに存在する場合にはデータが重複して登録されます。そのため、スクリプトを再実行する場合は事前に既存オブジェクトを削除してください。

## 次のステップ

[Lesson 3: データの探索と可視化](../tutorials/sqldev-explore-and-visualize-the-data.md)

## 前のステップ

[Lesson 1: サンプルデータのダウンロード](../tutorials/sqldev-download-the-sample-data.md)

## はじめから

[Lesson 1: サンプルデータのダウンロード](../tutorials/sqldev-download-the-sample-data.md)

## 関連項目

[In-database R analytics for SQL developers (tutorial)](https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/sqldev-in-database-r-for-sql-developers)


<!--
---
title: "Lesson 2: Import data to SQL Server using PowerShell | Microsoft Docs"
ms.custom: ""
ms.date: "07/26/2017"
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
  - "R"
  - "TSQL"
ms.assetid: 3c5b5145-fa57-455a-b153-0400fc062dc0
caps.latest.revision: 11
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# Lesson 2: Import data to SQL Server using PowerShell

This article is part of a tutorial for SQL developers on how to use R in SQL Server.

In this step, you'll run one of the downloaded scripts, to create the database objects required for the walkthrough. The script also creates most of the stored procedures you'll use, and uploads the sample data to a table in the database you specified.

## Run the scripts to create SQL objects

Among the downloaded files, you should see a PowerShell script that you can run to prepare the environment for the walkthrough. Actions performed by the script include:

- Installing the SQL Native Client and SQL command-line utilities, if not already installed. These utilities are required for bulk-loading the data to the database using **bcp**.

- Creating a database and a table on the [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] instance, and bulk-inserting data into the table.

- Creating multiple SQL functions and stored procedures.

### Run the script

1.  Open a PowerShell command prompt as administrator and run the following command.
  
    ```ps
    .\RunSQL_SQL_Walkthrough.ps1
    ```
  
    You will be prompted to input the following information:
  
    - The name or address of a [!INCLUDE[ssCurrent](../../includes/sscurrent-md.md)] instance where [!INCLUDE[rsql_productname](../../includes/rsql-productname-md.md)] has been installed
  
    - The user name and password for an account on the instance. The account must have permissions to create databases, create tables and stored procedures, and upload data to tables. If you do not provide the user name and password, your Windows identity is used to sign in to SQL Server.
  
    - The path and file name of the sample data file that you just downloaded. For example:
  
        `C:\tempRSQL\nyctaxi1pct.csv`
  
2.  As part of this step, all the [!INCLUDE[tsql](../../includes/tsql-md.md)] scripts are also modified to replace placeholders with the database name and user name that you provide as script inputs.
  
    Take a minute to review the stored procedures and functions created by the script.
  
    |**SQL script file name**|**Function**|
    |-|-|
    |create-db-tb-upload-data.sql|Creates a database and two tables:<br /><br />nyctaxi_sample: Contains the main NYC Taxi dataset. A clustered columnstore index is added to the table to improve storage and query performance. The 1% sample of the NYC Taxi dataset will be inserted into this table.<br /><br />nyc_taxi_models: Used to persist the trained advanced analytics model.|
    |fnCalculateDistance.sql|Creates a scalar-valued function that calculates the direct distance between pickup and dropoff locations|
    |fnEngineerFeatures.sql|Creates a table-valued function that creates new data features for model training|
    |PersistModel.sql|Creates a stored procedure that can be called to save a model. The stored procedure takes a model that has been serialized in a varbinary data type, and writes it to the specified table.|
    |PredictTipBatchMode.sql|Creates a stored procedure that calls the trained model to create predictions using the model. The stored procedure accepts a query as its input parameter and returns a column of numeric values containing the scores for the input rows.|
    |PredictTipSingleMode.sql|Creates a stored procedure that calls the trained model to create predictions using the model. This stored procedure accepts a new observation as input, with individual feature values passed as in-line parameters, and returns a value that predicts the outcome for the new observation.|
  
    You'll create some additional stored procedures in the latter part of this walkthrough:
  
    |**SQL script file name**|**Function**|
    |------|------|
    |PlotHistogram.sql|Creates a stored procedure for data exploration. This stored procedure calls an R function to plot the histogram of a variable and then returns the plot as a binary object.|
    |PlotInOutputFiles.sql|Creates a stored procedure for data exploration. This stored procedure creates a graphic using an R function and then saves the output as a local PDF file.|
    |TrainTipPredictionModel.sql|Creates a stored procedure that trains a logistic regression model by calling an R package. The model predicts the value of the  tipped column, and is trained using a randomly selected 70% of the data. The output of the stored procedure is the trained model, which is saved in the table nyc_taxi_models.|
  
3.  Log in to the [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] instance using [!INCLUDE[ssManStudioFull](../../includes/ssmanstudiofull-md.md)] and the login you specified, to verify that you can see the database, tables, functions, and stored procedures that were created.
  
    ![rsql_devtut_BrowseTables](media/rsql-devtut-browsetables.png "rsql_devtut_BrowseTables")
  
    > [!NOTE]
    > If the database objects already exist, they cannot be created again.
    >   
    > If the table already exists, the data will be appended, not overwritten. Therefore, be sure to drop any existing objects before running the script.

## Next lesson

[Lesson 3: Explore and visualize the data](../tutorials/sqldev-explore-and-visualize-the-data.md)

## Previous lesson

[Lesson 1: Download the sample data](../tutorials/sqldev-download-the-sample-data.md)


-->
