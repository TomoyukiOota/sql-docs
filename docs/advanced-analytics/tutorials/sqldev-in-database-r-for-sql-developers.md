# SQL開発者のための In-Database R 分析（チュートリアル）

このチュートリアルの目的は、SQLプログラマーにSQL Serverで機械学習ソリューションを構築する実践的な体験を提供することです。このチュートリアルでは、ストアドプロシージャにRコードを追加することで、RをアプリケーションあるいはBIソリューションに組み込む方法を学習します。

> [!NOTE]
> 同様のチュートリアルのPython版は[こちら](../tutorials/sqldev-in-database-python-for-sql-developers.md)。Python版はSQL Server 2017で動作します。

## 出典
[In-database R analytics for SQL developers (tutorial)](https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/sqldev-in-database-r-for-sql-developers)

## 概要
機械学習開発のライフサイクルは一般的に、データの取得とクレンジング、データの探索と特徴エンジニアリング、モデルのトレーニングとチューニング、そして最終的には本番環境へのモデル展開で構成されます。実際のコーディング、デバッグ、テストは、R用の統合開発環境（例えば、RStudioやR Tools for Visual Studio）を使用するのが最適です。

Rでソリューションを作成してテストした後、RコードをTransact-SQLストアドプロシージャとしてSQL Serverに展開します。このチュートリアルでは、必要なすべてのRコードを提供します。

- [Lesson 1: サンプルデータのダウンロード](../tutorials/sqldev-download-the-sample-data.md)

    サンプルデータセットとすべてのスクリプトファイルをローカルコンピュータにダウンロードします。

- [Lesson 2: PowerShellを使用したSQL Serverへのデータインポート](../r/sqldev-import-data-to-sql-server-using-powershell.md)

    指定したインスタンス上にデータベースとテーブルを作成し、サンプルデータをテーブルにロードするPowerShellスクリプトを実行します。

- [Lesson 3: データの探索と可視化](../tutorials/sqldev-explore-and-visualize-the-data.md)

    Transact-SQLストアドプロシージャからRを実行し、基本的なデータの探索と可視化を実行します。

- [Lesson 4: T-SQLを使用したデータの特徴抽出](../tutorials/sqldev-create-data-features-using-t-sql.md)

    ユーザ定義関数を活用しデータの特徴抽出を行います。
  
- [Lesson 5: T-SQLを使用したモデルのトレーニングと保存](../r/sqldev-train-and-save-a-model-using-t-sql.md)

    ストアドプロシージャ化したRコードにより機械学習モデルを構築して保存します。
  
- [Lesson 6: モデルの利用](../tutorials/sqldev-operationalize-the-model.md)

    モデルをデータベースに保存した後、Transact-SQLを使用して予測のためにモデルを呼び出します。

> [!NOTE]
> ストアドプロシージャに埋め込まれたコードに問題がある場合、ストアドプロシージャから返される情報は通常、エラーの原因を理解するには不十分であるため、RコードのテストはR用の統合開発環境（IDE）を使用することをお勧めします。

## シナリオ

このチュートリアルでは、よく知られているNYC Taxiデータセットを使用します。このチュートリアルをすばやく簡単にするために、データはサンプリングして利用します。このデータセットの、時刻、距離、ピックアップ場所などの列に基づき、特定の乗車においてチップが得られるかどうかを予測するバイナリ分類モデルを作成します。

## 要件

このチュートリアルは、データベースやテーブルの作成、テーブルへのデータのインポート、SQLクエリの作成など、基本的なデータベース操作に慣れているユーザーを対象としています。

チュートリアルを開始する前に、次の準備を完了する必要があります。:

- SQL Server 2017のDatabase Engine ServicesおよびMachine Learning Services（In-Database）をインストールしてください。
- SQL Server 2017 内でR（およびPython）実行するにはsp_configureでexternal scripts enabledの設定変更が必要です。またexternal scripts enabledパラメータは設定変更の反映にSQL Server 2017の再起動が必要です。

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

[Lesson 1: サンプルデータのダウンロード](../tutorials/sqldev-download-the-sample-data.md)

## 関連項目

[Machine Learning Services with R](https://docs.microsoft.com/en-us/sql/advanced-analytics/r/sql-server-r-services)

<--
---
title: "In-database R analytics for SQL developers (tutorial)| Microsoft Docs"
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
ms.assetid: c18cb249-2146-41b7-8821-3a20c5d7a690
caps.latest.revision: 15
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# In-database R analytics for SQL developers (tutorial)

The goal of this tutorial is to provide SQL programmers with hands-on experience building a machine learning solution in SQL Server. In this tutorial, you'll learn how to incorporate R into an application or BI solution by wrapping R code in stored procedures.

> [!NOTE]
> 
> The same solution is available in Python. SQL Server 2017 is required. See [In-database analytics for Python developers](../tutorials/sqldev-in-database-python-for-sql-developers.md)

## Overview

The process of building an end to end solution typically consists of obtaining and cleaning data, data exploration and feature engineering, model training and tuning, and finally deployment of the model in production. Development and testing of the actual code is best performed using a dedicated development environment. For R, that might mean RStudio or [!INCLUDE[rtvs-short](../../includes/rtvs-short-md.md)].

However, after the solution has been created, you can easily deploy it to [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] using [!INCLUDE[tsql](../../includes/tsql-md.md)] stored procedures in the familiar environment of [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)].

In this tutorial, we assume that you have been given all the R code needed for the solution, and focus on building and deploying the solution using SQL Server.

- [Lesson 1: Download the sample data](../tutorials/sqldev-download-the-sample-data.md)

    Download the sample dataset and the sample SQL script files to a local computer.

- [Lesson 2: Import data to SQL Server using PowerShell](../r/sqldev-import-data-to-sql-server-using-powershell.md)

    Execute a PowerShell script that creates a database and a table on the [!INCLUDE[ssCurrent](../../includes/sscurrent-md.md)] instance and loads the sample data to the table.

- [Lesson 3: Explore and visualize the data](../tutorials/sqldev-explore-and-visualize-the-data.md)

    Perform basic data exploration and visualization, by calling R packages and functions from [!INCLUDE[tsql](../../includes/tsql-md.md)] stored procedures.

- [Lesson 4: Create data features using T-SQL](../tutorials/sqldev-create-data-features-using-t-sql.md)

    Create new data features using custom SQL functions.
  
-   [Lesson 5: Train and save an R model using T-SQL](../r/sqldev-train-and-save-a-model-using-t-sql.md)

    Build a machine learning model using R in stored procedures. Save the model to a SQL Server table.
  
-   [Lesson 6: Operationalize the model](../tutorials/sqldev-operationalize-the-model.md)

    After the model has been saved to the database, call the model for prediction from [!INCLUDE[tsql](../../includes/tsql-md.md)] by using stored procedures.

### Scenario

This tutorial uses a well-known public dataset, based on trips in New York city taxis. To make the sample code run quicker, we created a representative 1% sampling of the data. You'll use this data to build a binary classification model that predicts whether a particular trip is likely to get a tip or not, based on columns such as the time of day, distance, and pick-up location.

### Requirements

This tutorial is intended for users who are already familiar with fundamental database operations, such as creating databases and tables, importing data into tables, and creating SQL queries. All R code is provided, so no R development environment is required. An experienced SQL programmer should be able to complete this example by using [!INCLUDE[tsql](../../includes/tsql-md.md)] in [!INCLUDE[ssManStudioFull](../../includes/ssmanstudiofull-md.md)], and by running the provided PowerShell scripts.

However, before starting the tutorial, you must complete these preparations:

- Connect to an instance of SQL Server 2016 with R Services, or SQL Server 2017 with Machine Learning Services and R enabled.
- The login that you use for this tutorial must have permissions to create databases and other objects, to upload data, select data, and run stored procedures.

> [!NOTE]
> We recommend that you do **not** use [!INCLUDE[ssManStudioFull](../../includes/ssmanstudiofull-md.md)] to write or test R code. If the code that you embed in a stored procedure has any problems, the information that is returned from the stored procedure is usually inadequate to understand the cause of the error.
> 
> For debugging, we recommend you use a tool such as [!INCLUDE[rtvs-short](../../includes/rtvs-short-md.md)], or RStudio. The R scripts provided in this tutorial have already been developed and debugged using traditional R tools.

## Next lesson

[Lesson 1: Download the sample data](../tutorials/sqldev-download-the-sample-data.md)


-->
