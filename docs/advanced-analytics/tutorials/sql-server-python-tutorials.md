<!--
---
title: "SQL Server Python Tutorials | Microsoft Docs"
ms.custom: 
  - "SQL2016_New_Updated"
ms.date: "06/28/2017"
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
caps.latest.revision: 1
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
-->

# SQL Server + Python チュートリアル

この記事はPythonをSQL Server 2017で使用するためのチュートリアルとサンプルを提供します。これによって次のことを学びます。

+ T-SQLからPythonを実行する方法
+ リモートおよびローカルの計算コンテキストの理解、およびSQL Serverを使用してPythonコードを実行する方法
+ Pythonコードをストアドプロシージャとして定義する方法
+ 本番環境用のPythonコードの最適化
+ アプリケーションに機械学習を組み込むための現実に即したシナリオ

要件とセットアップの詳細については、[前提条件](#bkmk_Prerequisites)を参照してください。

## <a name="bkmk_pythontutorials"></a>Python チュートリアル

+ [T-SQLからPythonを実行する方法](run-python-using-t-sql.md)

  SQL Server 2016から導入された拡張機構を使ってT-SQLからPythonを実行するための基礎を学びます。

+ [revoscalepyを使ってPythonで機械学習モデルを作成する](use-python-revoscalepy-to-create-model.md)

  新しい **revoscalepy** ライブラリの **rxLinMod** を使用してモデルを作成します。コードはリモートのPythonターミナルから起動されますが、モデリングはSQL Serverのコンテキストで処理されます。

+ [Pythonで予測モデル構築する](https://github.com/gho9o9/sql-server-samples/tree/master/samples/features/machine-learning-services/python/getting-started/rental-prediction)

  ストアドプロシージャを使用してスキーレンタル事業の日々の需要予測を行うモデルを作成します。

+ [SQL開発者のための In-Database Python 分析](sqldev-in-database-python-for-sql-developers.md)

  T-SQLストアドプロシージャを使用して完全なPythonソリューションを構築します。

+ [Pythonモデルの展開と利用](....\python\publish-consume-python-code.md)

  Microsoft Machine Learning Serverの最新バージョンを使用してPythonモデルを導入する方法を学びます。

<!--
## Pythonサンプル

These samples and demos provided by the SQL Server development team highlight ways that you can use embedded analytics in real-world applications.

+ [Build a predictive model using Python and SQL Server](https://microsoft.github.io/sql-ml-tutorials/python/rentalprediction/)

  Learn how a ski rental business might use machine learning to predict future rentals, which helps the business plan and staff to meet future demand.
-->

## <a name="bkmk_Prerequisites"></a>前提条件

これらのチュートリアルを使用するには、SQL Server 2017 Machine Learning Services (In-Database)がインストールされている必要があります。Machine Learning ServicesはRまたはPythonをサポートしています。ただし、Pythonを利用する際にはインストールする言語にPythonを選択する必要があります。なおRとPythonの両方を同じコンピュータにインストールすることが可能です。

<!--
> [!NOTE]
>
> Support for Python is a new feature in SQL Server 2017 (CTP 2.0). Although the feature is in pre-release and not supported for production environments, we invite you to try it out and send feedback.
**SQL Server 2017**
-->

SQL Serverのインストール完了後に、以下のステップが必要です。

+ 外部スクリプト実行機能を有効化します。 `sp_configure 'external scripts enabled', 1`
+ SQL Serverを再起動します。
+ 外部ランタイムのコールに必要な権限がサービスアカウントに付与されていることを確認します。
+ サーバーへの接続、データの読み取り、およびサンプルに必要なデータベースオブジェクトの作成に必要なアクセス許可がSQLログインまたはWindowsユーザーアカウントに付与されていることを確認します。

トラブルに遭遇した場合は、次の一般的な問題についての記事を参考にしてください。[SQL Server R Servicesのインストールとアップグレード](../../advanced-analytics/r-services/upgrade-and-installation-faq-sql-server-r-services.md)

## 関連項目

[R チュートリアル](sql-server-r-tutorials.md)


<!--
---
title: "SQL Server Python Tutorials | Microsoft Docs"
ms.custom: 
  - "SQL2016_New_Updated"
ms.date: "06/28/2017"
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
caps.latest.revision: 1
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# SQL Server Python Tutorials

This article provides a list of tutorials and samples that demonstrate the use of Python with SQL Server 2017. Through these samples and demos, you will learn:

+ How to run Python from T-SQL
+ What are remote and local compute contexts, and how you can execute Python code using the SQL Server computer
+ How to wrap Python code in a stored procedure
+ Optimizing Python code for a SQL production environment
+ Real-world scenarios for embedding machine learning in applications

For information about requirements and setup, see [Prerequisites](#bkmk_Prerequisites).

## <a name="bkmk_pythontutorials"></a>Python Tutorials

+ [Running Python in T-SQL](run-python-using-t-sql.md)

   Learn the basics of how to call Python in T-SQL, using the extensibility mechanism pioneered in SQL Server 2016.

+ [Create a Machine Learning Model in Python using revoscalepy](use-python-revoscalepy-to-create-model.md)

   You'll create a model using **rxLinMod**, from the new **revoscalepy** library. You'll launch the code from a remote Python terminal but the modeling will take place in the SQL Server compute context.

+ [Build a predictive model with Python (GitHub)](https://github.com/Microsoft/sql-server-samples/tree/master/samples/features/machine-learning-services/python/getting-started/rental-prediction)

  Create a machine learning model to predict demand for a ski rental business, and operationalize that model for day-to-day demand prediction using stored procedures. All code and data is provided.

+ [In-Database Python Analytics for SQL Developers](sqldev-in-database-python-for-sql-developers.md)

  NEW! Build a complete Python solution using T-SQL stored procedures. All Python code is included.

+ [Deploy and Consume a Python Model](..\python\publish-consume-python-code.md)

  Learn how to deploy a Python model using the latest version of Microsoft Machine Learning Server.

## Python Samples

These samples and demos provided by the SQL Server development team highlight ways that you can use embedded analytics in real-world applications.

+ [Build a predictive model using Python and SQL Server](https://microsoft.github.io/sql-ml-tutorials/python/rentalprediction/)

  Learn how a ski rental business might use machine learning to predict future rentals, which helps the business plan and staff to meet future demand.

## <a name="bkmk_Prerequisites"></a>Prerequisites

To use these tutorials, you must have installed SQL Server 2017 Machine Learning Services (In-Database). SQL Server 2017 supports either R or Python. However, you must install the extensibility framework that supports machine learning, and select Python as the language to install. You can install both R and Python on the same computer.

> [!NOTE]
>
> Support for Python is a new feature in SQL Server 2017 (CTP 2.0). Although the feature is in pre-release and not supported for production environments, we invite you to try it out and send feedback.
**SQL Server 2017**

After running SQL Server setup, don't forget these important steps:

+ Enable the external script execution feature by running `sp_configure 'enable external script', 1`
+ Restart the server
+ Ensure that the service that calls the external runtime has necessary permissions
+ Ensure that your SQL login or Windows user account has necessary permissions to connect to the server, to read data, and to create any database objects required by the sample

If you run into trouble, see this article for some common issues: [Upgrade and Installation of SQL Server R Services](../../advanced-analytics/r-services/upgrade-and-installation-faq-sql-server-r-services.md)

## See Also

[R Tutorials](sql-server-r-tutorials.md)
-->
