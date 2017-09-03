# Lesson 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g

���̋L���́ASQL�J���҂̂��߂� In-Database R ���́i�`���[�g���A���j �̈ꕔ�ł��B

���̃X�e�b�v�ł́A�_�E�����[�h�����X�N���v�g��1�����s���āA�`���[�g���A���ɕK�v�ȃf�[�^�x�[�X�I�u�W�F�N�g���쐬���܂��B���̃X�N���v�g�́A�g�p����X�g�A�h�v���V�[�W���̂قƂ�ǂ��쐬���A�w�肵���f�[�^�x�[�X�̃e�[�u���ɃT���v���f�[�^�����[�h���܂��B

## �o�T
[Lesson 2: Import data to SQL Server using PowerShell](https://docs.microsoft.com/en-us/sql/advanced-analytics/r/sqldev-import-data-to-sql-server-using-powershell)

## �I�u�W�F�N�g�쐬

�_�E�����[�h�����t�@�C���Q�̒���PowerShell�X�N���v�g`RunSQL_SQL_Walkthrough.ps1`�����s���A�`���[�g���A�������������܂��B���̃X�N���v�g�͎��̃A�N�V���������s���܂��F

- SQL Native Client�����SQL�R�}���h���C�����[�e�B���e�B���C���X�g�[������Ă��Ȃ��ꍇ�̓C���X�g�[�����܂��B�����́Abcp���g�p���ăf�[�^���o���N���[�h���邽�߂ɕK�v�ł��B

- SQL Server�C���X�^���X�Ƀf�[�^�x�[�X�ƃe�[�u�����쐬���A�����փf�[�^���o���N���[�h���܂��B

- ����ɕ����̊֐��ƃX�g�A�h�v���V�[�W�����쐬���܂��B

## �X�N���v�g�̎��s

1.  �Ǘ��҂Ƃ���PowerShell�R�}���h�v�����v�g���J���A���̃R�}���h�����s���܂��B
  
    ```PowerShell:PowerShell
    .\RunSQL_SQL_Walkthrough.ps1
    ```
  
    ���̏�����͂���悤���߂��܂��B
  
    - SQL Server 2017 R Service���C���X�g�[������Ă���T�[�o���܂��̓A�h���X�B
    - �쐬����f�[�^�x�[�X�̖��O
    - �Ώۂ�SQL Server�̃��[�U�[���ƃp�X���[�h�B���̃��[�U�́A�f�[�^�x�[�X�A�e�[�u���A�X�g�A�h�v���V�[�W���A�֐��̍쐬�����A����уe�[�u���ւ̃f�[�^���[�h�������K�v�ł��B���[�U�[���ƃp�X���[�h���ȗ������ꍇ�͌��݂�Windows���[�U�ɂ���ă��O�C�����܂��B
    - �_�E�����[�h�����t�@�C���Q�̒��̃T���v���f�[�^�t�@�C��`nyctaxi1pct.csv`�̃p�X�B�Ⴆ�΁A`C:\tempRSQL\nyctaxi1pct.csv`�ł��B
    
    ���X�N�V����
    �@2_�f�[�^�C���|�[�gSTART�iPWS�j
    �@3_�f�[�^�C���|�[�gEND�iPWS�j
    ���X�N�V����

2.  ��L�菇�̈�Ŏw�肵���f�[�^�x�[�X���ƃ��[�U�[�����v���[�X�z���_�ɒu��������悤�ɁA���ׂĂ�T-SQL�X�N���v�g���ύX����Ă��܂��B

    T-SQL�X�N���v�g�ɂ���č쐬�����X�g�A�h�v���V�[�W���Ɗ֐����f�[�^�x�[�X���ɍ쐬����Ă��邱�Ƃ��m�F���܂��B
    
    �����_��
    �@�X�g�A�h�v���V�[�W��PersistModel���쐬����Ă��Ȃ�
    �@�X�g�A�h�v���V�[�W��PredictBatchMode���쐬����Ă��Ȃ�
    �����_��

    |**T-SQL�X�N���v�g�t�@�C��**|**�X�g�A�h�v���V�[�W���^�֐�**|
    |-|-|
    |create-db-tb-upload-data.sql|�f�[�^�x�[�X��2�̃e�[�u�����쐬���܂��B<br /><br />�e�[�u��`nyctaxi_sample`: ���C���ƂȂ�NYC Taxi�f�[�^�Z�b�g���o�^����܂��B���[�h�����f�[�^��NYC Taxi�f�[�^�Z�b�g��1���̃T���v���ł��B�N���X�^���J�����X�g�A�C���f�b�N�X�̒�`�ɂ���ăX�g���[�W�����ƃN�G���p�t�H�[�}���X�����コ���Ă��܂��B<br /><br />�e�[�u��`nyc_taxi_models`: �P�����ꂽ���x�ȕ��̓��f�����o�^����܂��B|
    |fnCalculateDistance.sql|��Ԉʒu�ƍ~�Ԉʒu�̊Ԃ̒��ڋ������v�Z����X�J���[�l�֐�`fnCalculateDistance`���쐬���܂��B|
    |fnEngineerFeatures.sql|���f���g���[�j���O�p�̐V�����������o���쐬����e�[�u���l�֐�`fnEngineerFeatures`���쐬���܂��B|
    |PersistModel.sql|���f����ۑ����邽�߂ɌĂяo�����Ƃ��ł���X�g�A�h�v���V�[�W��`PersistModel`���쐬���܂��B �X�g�A�h�v���V�[�W���́Avarbinary�f�[�^�^�ŃV���A�������ꂽ���f�����擾���A�w�肳�ꂽ�e�[�u���ɏ������݂܂��B|
    |PredictTipBatchMode.sql|���f�����g�p�����\���̂��߂ɁA�P�����ꂽ���f�����Ăяo���X�g�A�h�v���V�[�W��`PredictTipBatchMode`���쐬���܂��B�X�g�A�h�v���V�[�W���́A���̓p�����[�^�Ƃ��Ė⍇�����󂯓���A���͍s�̃X�R�A���܂ސ��l�̗��߂��܂��B|
    |PredictTipSingleMode.sql|���f�����g�p�����\���̂��߂ɁA�P�����ꂽ���f�����Ăяo���X�g�A�h�v���V�[�W��`PredictTipSingleMode`���쐬���܂��B���̃X�g�A�h�v���V�[�W���͐V�����ϑ��l����͂Ƃ��āA�X�̓����l�̓C�����C���p�����[�^�Ƃ��Ď󂯎��A�V�����ϑ��l�ɑ΂���\���l��Ԃ��܂��B|
    |PlotHistogram.sql|�f�[�^�T���p�̃X�g�A�h�v���V�[�W��`PlotHistogram`���쐬���܂��B ���̃X�g�A�h�v���V�[�W���́AR�֐����Ăяo���ĕϐ��̃q�X�g�O�������v���b�g���A�v���b�g���o�C�i���I�u�W�F�N�g�Ƃ��ĕԂ��܂��B|
    |PlotInOutputFiles.sql|�f�[�^�T���p�̃X�g�A�h�v���V�[�W��`PlotInOutputFiles`���쐬���܂��B ���̃X�g�A�h�v���V�[�W���́AR�֐����g�p���ăO���t�B�b�N���쐬���A���[�J��PDF�t�@�C���Ƃ��ĕۑ����܂��B|
    |TrainTipPredictionModel.sql|R�p�b�P�[�W���Ăяo�����Ƃɂ���ă��W�X�e�B�b�N��A���f�����P������X�g�A�h�v���V�[�W��`TrainTipPredictionModel`���쐬���܂��B ���̃��f���́A�]�|������̒l��\�����A�����_���ɑI�����ꂽ70���̃f�[�^���g�p���ČP������܂��B �X�g�A�h�v���V�[�W���̏o�͂͌P�����ꂽ���f���ł���A�e�[�u��nyc_taxi_models�ɕۑ�����܂��B|

3.  SQL Server Management Studio���g�p����SQL Server�փ��O�C�����A�쐬���ꂽ�f�[�^�x�[�X�A�e�[�u���A�֐��A����уX�g�A�h�v���V�[�W�����m�F���܂��B

    ���X�N�V����
    �@4_�f�[�^�C���|�[�g��̃I�u�W�F�N�g�G�N�X�v���[���[�iSSMS�j
    ���X�N�V����
  
    > [!NOTE]
    > T-SQL�X�N���v�g�̓f�[�^�x�[�X�I�u�W�F�N�g���č쐬���Ȃ����߁A���łɑ��݂���ꍇ�ɂ̓f�[�^���d�����ēo�^����܂��B���̂��߁A�X�N���v�g���Ď��s����ꍇ�͎��O�Ɋ����I�u�W�F�N�g���폜���Ă��������B

## ���̃X�e�b�v

[Lesson 3: �f�[�^�̒T���Ɖ���](../tutorials/sqldev-explore-and-visualize-the-data.md)

## �O�̃X�e�b�v

[Lesson 1: �T���v���f�[�^�̃_�E�����[�h](../tutorials/sqldev-download-the-sample-data.md)

## �͂��߂���

[Lesson 1: �T���v���f�[�^�̃_�E�����[�h](../tutorials/sqldev-download-the-sample-data.md)

## �֘A����

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
