# SQL開発者のための In-Database Python 分析

このチュートリアルの目的は、SQLプログラマーにSQL Serverで機械学習ソリューションを構築する実践的な体験を提供することです。 このチュートリアルでは、ストアドプロシージャにPythonコードを追加することで、Pythonをアプリケーションに組み込む方法を学習します。

> [!NOTE]
> 同様のチュートリアルのR版は[こちら](sqldev-in-database-r-for-sql-developers.md)。R版はSQL Server 2017とSQL Server 2016の両方で動作します。

## 出典
[In-Database Python Analytics for SQL Developers](https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/sqldev-in-database-python-for-sql-developers)

## 概要

エンドツーエンドソリューションを構築するプロセスは通常、データの取得とクレンジング、データの探索と特徴エンジニアリング、モデルのトレーニングとチューニング、そして最終的には本番環境へのモデル展開で構成されます。実際のコーディング、デバッグ、テストは、以下のようなPython用の統合開発環境（IDE）を使用するのが最適です。

+ PyCharm：人気のあるIDEです。
+ Spyder：[Visual Studio 2017](https://blogs.msdn.microsoft.com/visualstudio/2017/05/12/a-lap-around-python-in-visual-studio-2017/)に含まれ[Data Science workload](https://blogs.msdn.microsoft.com/visualstudio/2016/11/18/data-science-workloads-in-visual-studio-2017-rc/)によりインストールされます。
+ Python Tools for Visual Studio：[Visual Studio用のPython Extensions](https://docs.microsoft.com/visualstudio/python/python-in-visual-studio).

Python IDEでソリューションを作成してテストした後、PythonコードをTransact-SQLストアドプロシージャとしてSQL Serverに展開します。このチュートリアルでは、必要なすべてのPythonコードを提供します。

- [Step 1: サンプルデータのダウンロード](sqldev-py1-download-the-sample-data.md)

  サンプルデータセットとすべてのスクリプトファイルをローカルコンピュータにダウンロードします。

- [Step 2: PowerShellを使用したSQL Serverへのデータインポート](sqldev-py2-import-data-to-sql-server-using-powershell.md)

  指定したインスタンス上にデータベースとテーブルを作成し、サンプルデータをテーブルにロードするPowerShellスクリプトを実行します。

- [Step 3: データの探索と可視化](sqldev-py3-explore-and-visualize-the-data.md)

  Transact-SQLストアドプロシージャからPythonを実行し、基本的なデータの探索と可視化を実行します。

- [Step 4: T-SQLを使用したデータの特徴抽出](sqldev-py4-create-data-features-using-t-sql.md)

  ユーザ定義関数を活用しデータの特徴抽出を行います。

- [Step 5: T-SQLを使用したモデルのトレーニングと保存](sqldev-py5-train-and-save-a-model-using-t-sql.md)

  ストアドプロシージャ化したPythonコードにより機械学習モデルを構築して保存します。
  
-  [Step 6: モデルの利用](sqldev-py6-operationalize-the-model.md)

  モデルをデータベースに保存した後、Transact-SQLを使用して予測のためにモデルを呼び出します。

> [!NOTE]
> ストアドプロシージャに埋め込まれたコードに問題がある場合、ストアドプロシージャから返される情報は通常、エラーの原因を理解するには不十分であるため、PythonコードのテストはPython用の統合開発環境（IDE）を使用することをお勧めします。


## シナリオ

このチュートリアルでは、よく知られているNYC Taxiデータセットを使用します。このチュートリアルをすばやく簡単にするために、データはサンプリングして利用します。このデータセットの、時刻、距離、ピックアップ場所などの列に基づき、特定の乗車においてチップが得られるかどうかを予測するバイナリ分類モデルを作成します。

## 要件

このチュートリアルは、データベースやテーブルの作成、テーブルへのデータのインポート、SQLクエリの作成など、基本的なデータベース操作に慣れているユーザーを対象としています。

チュートリアルを開始する前に、次の準備を完了する必要があります。:

- SQL Server 2017のDatabase Engine ServicesおよびMachine Learning Services（In-Database）をインストールしてください。

- SQL Server 2017 内でPython（およびR）実行するにはsp_configureでexternal scripts enabledの設定変更が必要です。またexternal scripts enabledパラメータは設定変更の反映にSQL Server 2017の再起動が必要です。

    1. 外部スクリプト実行機能の有効化

        ```SQL:T-SQL
        EXEC sp_configure 'external scripts enabled', 1;
        ```

    2. SQL Server 2017の再起動

        ```cmd:cmd
        net stop "SQL Server Launchpad (MSSQLSERVER)"
        net stop "SQL Server (MSSQLSERVER)"
        net start "SQL Server (MSSQLSERVER)"
        net start "SQL Server Launchpad (MSSQLSERVER)"
        ```

        netコマンドに渡すインスタンス名は環境に応じて変更してください。またSQL Server AgentサービスなどSQL Serverサービスに依存するサービスがある場合には明示的に再開してください。

- このチュートリアルで使用するSQL Serverログインには、データベースやその他のオブジェクトの作成、データの更新、データの参照、ストアドプロシージャの実行の権限を付与してください。

## 次のステップ

  [Step 1: サンプルデータのダウンロード](sqldev-py1-download-the-sample-data.md)

## 関連項目

[Machine Learning Services with Python](https://docs.microsoft.com/en-us/sql/advanced-analytics/python/sql-server-python-services)

<!--
---
title: "In-Database Python Analytics for SQL Developers | Microsoft Docs"
ms.custom: ""
ms.date: "05/25/2017"
ms.prod: "sql-server-2017"
ms.reviewer: ""
ms.suite: ""
ms.technology: 
  - "r-services"
ms.tgt_pltfrm: ""
ms.topic: "article"
applies_to: 
  - "SQL Server 2017"
dev_langs: 
  - "Python"
  - "TSQL"
ms.assetid: 
caps.latest.revision: 2
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# In-Database Python Analytics for SQL Developers

The goal of this walkthrough is to provide SQL programmers with hands-on experience building a machine learning solution in SQL Server. In this walkthrough, you'll learn how to incorporate Python into an application by adding Python code to stored procedures.

> [!NOTE]
> Prefer R? See [this tutorial](sqldev-in-database-r-for-sql-developers.md), which provides a similar solution but uses R, and can eb run in either SQL Server 2016 or SQL Server 2017.

## Overview

The process of building an end to end solution typically consists of obtaining and cleaning data, data exploration and feature engineering, model training and tuning, and finally deployment of the model in production. Development and testing of the actual code is best performed using a dedicated development environment, such as these Python tools:

+ PyCharm, a popular IDE
+ Spyder, which is included with [Visual Studio 2017](https://blogs.msdn.microsoft.com/visualstudio/2017/05/12/a-lap-around-python-in-visual-studio-2017/) if you install the [Data Science workload](https://blogs.msdn.microsoft.com/visualstudio/2016/11/18/data-science-workloads-in-visual-studio-2017-rc/)
+ [Python Extensions for Visual Studio](https://docs.microsoft.com/visualstudio/python/python-in-visual-studio).

After you have created and tested the solution in the IDE, you can deploy the Python code to [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] using [!INCLUDE[tsql](../../includes/tsql-md.md)] stored procedures in the familiar environment of [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)].

In this walkthrough, we'll assume that you have been given all the Python code needed for the solution, and you'll focus on building and deploying the solution using SQL Server.

- [Step 1: Download the Sample Data](sqldev-py1-download-the-sample-data.md)

  Download the sample dataset and all script files to a local computer.

- [Step 2: Import Data to SQL Server using PowerShell](sqldev-py2-import-data-to-sql-server-using-powershell.md)

  Execute a PowerShell script that creates a database and a table on the specified instance, and loads the sample data to the table.

- [Step 3: Explore and Visualize the Data](sqldev-py3-explore-and-visualize-the-data.md)

  Perform basic data exploration and visualization, by calling Python from [!INCLUDE[tsql](../../includes/tsql-md.md)] stored procedures.

- [Step 4: Create Data Features using T-SQL](sqldev-py5-train-and-save-a-model-using-t-sql.md)

  Create new data features using custom SQL functions.
  
- [Step 5: Train and Save a Model using T-SQL](sqldev-py5-train-and-save-a-model-using-t-sql.md)

   Build and save the machine learning model, using Python in stored procedures.
  
-  [Step 6: Operationalize the Model](sqldev-py6-operationalize-the-model.md)

  After the model has been saved to the database, call the model for prediction using [!INCLUDE[tsql](../../includes/tsql-md.md)].

> [!NOTE]
> We recommend that you do not use [!INCLUDE[ssManStudioFull](../../includes/ssmanstudiofull-md.md)] to write or test Python code. If the code that you embed in a stored procedure has any problems, the information that is returned from the stored procedure is usually inadequate to understand the cause of the error.


### Scenario

This walkthrough uses the well-known NYC Taxi data set. To make this walkthrough quick and easy, the data is sampled. Using this data, you'll create a binary classification model that predicts whether a particular trip is likely to get a tip or not, based on columns such as the time of day, distance, and pick-up location.

### Requirements

This walkthrough is intended for users who are already familiar with fundamental database operations, such as creating databases and tables, importing data into tables, and creating SQL queries.

All Python code is provided. An experienced SQL programmer should be able to complete this walkthrough by using [!INCLUDE[tsql](../../includes/tsql-md.md)] in [!INCLUDE[ssManStudioFull](../../includes/ssmanstudiofull-md.md)] or by running the provided PowerShell scripts.

Before starting the walkthrough, you must complete these preparations:

- Install an instance of SQL Server 2017 with Machine Learning Services and Python enabled (requires CTP 2.0 or later).
- The login that you use for this walkthrough must have permissions to create databases and other objects, to upload data, select data, and run stored procedures.

## Next Step

  [Step 1: Download the Sample Data](sqldev-py1-download-the-sample-data.md)

## See Also

[Machine Learning Services with Python](../python/sql-server-python-services.md)



-->