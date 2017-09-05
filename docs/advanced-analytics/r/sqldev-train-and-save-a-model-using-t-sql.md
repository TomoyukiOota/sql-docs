# Lesson 5: T-SQL���g�p�������f���̃g���[�j���O�ƕۑ�

���̃��b�X���ł́AR���g�p���ċ@�B�w�K���f�����g���[�j���O������@���w�K���܂��B�쐬�����f�[�^�������g�p���ă��f�����g���[�j���O���A�P�����ꂽ���f����SQL Server�̃e�[�u���ɕۑ����܂��B

## ���f���̃g���[�j���O�̂��߂̃X�g�A�h�v���V�[�W�����쐬����

T-SQL����R���Ăяo���Ƃ��́A�V�X�e���X�g�A�h�v���V�[�W��sp_execute_external_script���g�p���܂��B�����ł̓��f���g���[�j���O���J��Ԃ����Ƃ�O���ɁAsp_execute_exernal_script���J�v�Z���������ʂ̃X�g�A�h�E�v���V�[�W��`TrainTipPredictionModel`���쐬���܂��B

�X�g�A�h�v���V�[�W��`TrainTipPredictionModel`��[Lesson 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](../r/sqldev-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

1. Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�X�g�A�h�v���V�[�W��]�̏��ɓW�J���܂��B

2. `TrainTipPredictionModel`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B

    ```SQL:T-SQL
    CREATE PROCEDURE [dbo].[TrainTipPredictionModel]
    
    AS
    BEGIN
      DECLARE @inquery nvarchar(max) = N'
        select tipped, fare_amount, passenger_count,trip_time_in_secs,trip_distance,
        pickup_datetime, dropoff_datetime,
        dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance
        from nyctaxi_sample
        --tablesample (70 percent) repeatable (98052)
    '
      -- Insert the trained model into a database table
      INSERT INTO nyc_taxi_models
      EXEC sp_execute_external_script @language = N'R',
                                      @script = N'
    
    ## Create model
    logitObj <- rxLogit(tipped ~ passenger_count + trip_distance + trip_time_in_secs + direct_distance, data = InputDataSet)
    summary(logitObj)
    
    ## Serialize model and put it in data frame
    trained_model <- data.frame(model=as.raw(serialize(logitObj, NULL)));
    ',
      @input_data_1 = @inquery,
      @output_data_1_name = N'trained_model'
      ;
    
    END
    GO
    ```

- SELECT�N�G���̓J�X�^���X�J���֐�`fnCalculateDistance`���g�p���āA��Ԉʒu�ƍ~�Ԉʒu�̊Ԃ̒��ڋ������v�Z���܂��B�N�G���̌��ʂ̓f�t�H���g��R���͕ϐ�`InputDataset`�Ɋi�[����܂��B
- R�X�N���v�g�́AR Services (In-Database)�Ɋ܂܂��RevoScaleR���C�u������rxLogit�֐����Ăяo���āA���W�X�e�B�b�N��A���f�����쐬���܂��Btipped�����x���i�ړI�ϐ��j�ɁApassenger_count�Atrip_distance�Atrip_time_in_secs�A�����direct_distance������l��i�����ϐ��j�Ƃ��ă��f�����쐬���܂��B
- R�ϐ�`logitObj`�Ŏ������P���ς݃��f���̓V���A���C�Y����o�̓p�����[�^�Ƃ��ĕԂ�܂��B���̏o�͂�nyc_taxi_models�e�[�u���ɓo�^���邱�ƂŁA�����̗\���ɌJ��Ԃ��g�p���邱�Ƃ��ł��܂��B

## �X�g�A�h�v���V�[�W��`TrainTipPredictionModel`���g�p����R���f���𐶐�����

1. �X�g�A�h�v���V�[�W��`TrainTipPredictionModel`���Ăяo���܂��B

    ```SQL
    EXEC [dbo].[TrainTipPredictionModel]
    ```
    
    ![result](../tutorials/media/sqldev-r-step5-1-gho9o9.png "result")

2. Management Studio �̃��b�Z�[�W�E�B���h�E��R�̕W���o�̓��b�Z�[�W���m�F���Ă��������B

    "STDOUT message(s) from external script: Rows Read: 1703957, Total Rows Processed: 1703957, Total Chunk Time: 0.049 seconds "

    �X�̊֐��ɌŗL�̃��b�Z�[�W `rxLogit`���\������A���f���쐬�̈ꕔ�Ƃ��Đ������ꂽ�ϐ��ƃe�X�g���g���b�N���\������܂��B

3. �X�e�[�g�����g������������Anyc_taxi_models�e�[�u�����J���܂��B

    �e�[�u���ɐV�������R�[�h��1�ǉ�����A�V���A���C�Y���ꂽ���f�����o�^����Ă��邱�Ƃ��m�F���܂��B

    ![result](../tutorials/media/sqldev-r-step5-2-gho9o9.png "result")

���̃X�e�b�v�ł́A�P�����ꂽ���f�����g�p���ė\�����쐬���܂��B

## ���̃X�e�b�v

[Lesson 6: ���f���̗��p](../tutorials/sqldev-operationalize-the-model.md)

## �O�̃X�e�b�v

[Lesson 4: T-SQL���g�p�����f�[�^�̓������o](../tutorials/sqldev-create-data-features-using-t-sql.md)

## �͂��߂���

[SQL�J���҂̂��߂� In-Database R ����](../tutorials/sqldev-in-database-r-for-sql-developers.md)

## �֘A����

[Machine Learning Services with R](https://docs.microsoft.com/en-us/sql/advanced-analytics/r/sql-server-r-services)


<!--
---
title: "Lesson 5: Train and save a model using T-SQL | Microsoft Docs"
ms.custom: ""
ms.date: "07/26/2016"
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
ms.assetid: 3282e8ed-b515-4ed5-8543-fcef68629a92
caps.latest.revision: 10
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# Lesson 5: Train and save a model using T-SQL

This article is part of a tutorial for SQL developers on how to use R in SQL Server.

In this lesson, you'll learn how to train a machine learning model by using R. You'll train the model using the data features you just created, and then save the trained model in a [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] table. In this case, the R packages are already installed with [!INCLUDE[rsql_productname](../../includes/rsql-productname-md.md)], so everything can be done from SQL.

## Create the stored procedure

When calling R from T-SQL, you use the system stored procedure, [sp_execute_external_script](../../relational-databases/system-stored-procedures/sp-execute-external-script-transact-sql.md). However, for processes that you repeat often, such as retraining a model, it is easier to encapsulate the call to  `sp_execute_exernal_script` in another stored procedure.

1.  First, create a stored procedure that contains the R code to build the tip prediction model. In [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)], open a new **Query** window and run the following statement to create the stored procedure _TrainTipPredictionModel_. This stored procedure defines the input data and uses an R package to create a logistic regression model.

    ```SQL
    CREATE PROCEDURE [dbo].[TrainTipPredictionModel]
    
    AS
    BEGIN
      DECLARE @inquery nvarchar(max) = N'
        select tipped, fare_amount, passenger_count,trip_time_in_secs,trip_distance,
        pickup_datetime, dropoff_datetime,
        dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance
        from nyctaxi_sample
        tablesample (70 percent) repeatable (98052)
    '
      -- Insert the trained model into a database table
      INSERT INTO nyc_taxi_models
      EXEC sp_execute_external_script @language = N'R',
                                      @script = N'
    
    ## Create model
    logitObj <- rxLogit(tipped ~ passenger_count + trip_distance + trip_time_in_secs + direct_distance, data = InputDataSet)
    summary(logitObj)
    
    ## Serialize model and put it in data frame
    trained_model <- data.frame(model=as.raw(serialize(logitObj, NULL)));
    ',
      @input_data_1 = @inquery,
      @output_data_1_name = N'trained_model'
      ;
    
    END
    GO
    ```

    - However, to ensure that some data is left over to test the model, 70% of the data are randomly selected from the taxi data table.
    
    - The SELECT query uses the custom scalar function _fnCalculateDistance_ to calculate the direct distance between the pick-up and drop-off locations.  the results of the query are stored in the default R input variable, `InputDataset`.
  
    - The R script calls the `rxLogit` function, which is one of the enhanced R functions included with [!INCLUDE[rsql_productname](../../includes/rsql-productname-md.md)], to create the logistic regression model.
  
        The binary variable _tipped_ is used as the *label* or outcome column,  and the model is fit using these feature columns:  _passenger_count_, _trip_distance_, _trip_time_in_secs_, and _direct_distance_.
  
    -   The trained model, saved in the R variable `logitObj`, is serialized and put in a data frame for output to [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)]. That output is inserted into the database table _nyc_taxi_models_, so that you can use it for future predictions.
  
2.  Run the statement to create the stored procedure, if it doesn't already exist.

## Generate the R model using the stored procedure

Because the stored procedure already includes a definition of the input data, you don't need to provide an input query.

1. To generate the R model, call the stored procedure without any other parameters:

    ```SQL
    EXEC TrainTipPredictionModel
    ```

2. Watch the **Messages** window of [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)] for messages that would be piped to R's **stdout** stream, like this messaage: 

    "STDOUT message(s) from external script: Rows Read: 1193025, Total Rows Processed: 1193025, Total Chunk Time: 0.093 seconds"

    You might also see messages specific to the individual function, `rxLogit`, displaying the variables and test metrics generated as part of model creation.

3.  When the statement has completed, open the table *nyc_taxi_models*. Processing of the data and fitting the model might take a while.

    You can see that one new row has been added, which contains the serialized model in the column _model_.

    ```
    model
    ------
    0x580A00000002000302020....
    ```

In the next step you'll use the trained model to create predictions.

## Next lesson

[Lesson 6: Operationalize the model](../tutorials/sqldev-operationalize-the-model.md)

## Previous lesson

[Lesson 4: Create data features using T-SQL](..//tutorials/sqldev-create-data-features-using-t-sql.md)

-->