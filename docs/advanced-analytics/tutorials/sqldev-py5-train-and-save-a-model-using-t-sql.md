# Step 5: T-SQL���g�p�������f���̃g���[�j���O�ƕۑ�

���̃X�e�b�v�ł́APython�p�b�P�[�W�ł���scikit-learn��revoscalepy���g�p���āA�@�B�w�K���f�����g���[�j���O������@���w�K���܂��B������Python�p�b�P�[�W�͊���SQL Server Machine Learning Services�Ƌ��ɃC���X�g�[������Ă��邽�߁A���W���[�������[�h���ăX�g�A�h�v���V�[�W��������K�v�Ȋ֐����Ăяo�����Ƃ��ł��܂��B�쐬�����f�[�^�������g�p���ă��f�����g���[�j���O���A�P�����ꂽ���f����SQL Server�̃e�[�u���ɕۑ����܂��B

## �T���v���f�[�^���g���[�j���O�Z�b�g�ƃe�X�g�Z�b�g�ɕ�������

1.  �X�g�A�h�v���V�[�W��`TrainTestSplit`��[Step 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](sqldev-py2-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

    Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�X�g�A�h�v���V�[�W��]�̏��ɓW�J���܂��B`TrainTestSplit`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B

    `TrainTestSplit`��nyctaxi_sample�e�[�u���̃f�[�^��nyctaxi_sample_training��nyctaxi_sample_testing��2�̃e�[�u���ɕ������܂��B

    ```SQL:TrainTestSplit
    CREATE PROCEDURE [dbo].[TrainTestSplit] (@pct int)
    AS
    
    DROP TABLE IF EXISTS dbo.nyctaxi_sample_training
    SELECT * into nyctaxi_sample_training FROM nyctaxi_sample WHERE (ABS(CAST(BINARY_CHECKSUM(medallion,hack_license)  as int)) % 100) < @pct
    
    DROP TABLE IF EXISTS dbo.nyctaxi_sample_testing
    SELECT * into nyctaxi_sample_testing FROM nyctaxi_sample
    WHERE (ABS(CAST(BINARY_CHECKSUM(medallion,hack_license)  as int)) % 100) > @pct
    GO
    ```

2. �X�g�A�h�v���V�[�W�������s���A�g���[�j���O�Z�b�g�Ɋ��蓖�Ă銄����\����������͂��܂��B���Ƃ��΁A���̕��́A�g���[�j���O�Z�b�g�Ƀf�[�^��60�������蓖�Ă܂��B�g���[�j���O�ƃe�X�g�̃f�[�^�́A2�̕ʁX�̃e�[�u���Ɋi�[����܂��B

    ```SQLT-SQL
    EXEC TrainTestSplit 60
    GO
    ```
    
    ![result5-1](media/sqldev-python-step5-1-gho9o9.png "result5-1")

## scikit-learn���g���ă��W�X�e�B�b�N��A���f�����\�z����

���̃Z�N�V�����ł́A�쐬�����g���[�j���O�f�[�^���g�p���ă��f�����g���[�j���O����X�g�A�h�v���V�[�W�����쐬���܂��B���̃X�g�A�h�v���V�[�W���͓��̓f�[�^���`���A���W�X�e�B�b�N��A���f�����g���[�j���O���邽�߂�scikit-learn�֐����g�p���܂��B����̓V�X�e���X�g�A�h�v���V�[�W��sp_execute_external_script���g�p���āASQL Server�ƂƂ��ɃC���X�g�[�����ꂽPython�����^�C�����Ăяo�����ƂŎ������Ă��܂��B

�V�����g���[�j���O�f�[�^���p�����[�^�Ƃ��Ē�`���V�X�e���X�g�A�h�v���V�[�W��sp_execute_exernal_script�̌Ăяo�������b�v����X�g�A�h�v���V�[�W�����쐬���邱�ƂŁA���f���̍ăg���[�j���O��e�Ղɂ��Ă��܂��B

1.  �X�g�A�h�v���V�[�W��`TrainTipPredictionModelSciKitPy`��[Step 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](sqldev-py2-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

    Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�X�g�A�h�v���V�[�W��]�̏��ɓW�J���܂��B`TrainTipPredictionModelSciKitPy`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B

```SQL:TrainTipPredictionModelSciKitPy
DROP PROCEDURE IF EXISTS TrainTipPredictionModelSciKitPy;
GO

CREATE PROCEDURE [dbo].[TrainTipPredictionModelSciKitPy] (@trained_model varbinary(max) OUTPUT)
AS
BEGIN
  EXEC sp_execute_external_script
  @language = N'Python',
  @script = N'
import numpy
import pickle
# import pandas
from sklearn.linear_model import LogisticRegression

##Create SciKit-Learn logistic regression model
X = InputDataSet[["passenger_count", "trip_distance", "trip_time_in_secs", "direct_distance"]]
y = numpy.ravel(InputDataSet[["tipped"]])

SKLalgo = LogisticRegression()
logitObj = SKLalgo.fit(X, y)

##Serialize model
trained_model = pickle.dumps(logitObj)
  ',
  @input_data_1 = N'
  select tipped, fare_amount, passenger_count, trip_time_in_secs, trip_distance, 
  dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance
  from nyctaxi_sample_training
  ',
  @input_data_1_name = N'InputDataSet',
  @params = N'@trained_model varbinary(max) OUTPUT',
  @trained_model = @trained_model OUTPUT;
  ;
END;
GO
```

2. ����SQL�������s���āA�g���[�j���O���ꂽ���f����nyc_taxi_models�e�[�u���ɓo�^���܂��B

    ```SQL:T-SQL
    DECLARE @model VARBINARY(MAX);
    EXEC TrainTipPredictionModelSciKitPy @model OUTPUT;
    INSERT INTO nyc_taxi_models (name, model) VALUES('SciKit_model', @model);
    ```

    �f�[�^�����ƃ��f���̃t�B�b�e�B���O�ɂ͐���������܂��BPython��stdout�X�g���[���Ƀp�C�v����郁�b�Z�[�W�́AManagement Studio�̃��b�Z�[�W�E�B���h�E�ɕ\������܂��B
    
    ![result5-2](media/sqldev-python-step5-2-gho9o9.png "result5-2")
    
    ![result5-2_error](media/sqldev-python-step5-2_error-gho9o9.png "result5-2_error")

3. nyc_taxi_models�e�[�u���ɐV�������R�[�h��1�ǉ�����A�V���A���C�Y���ꂽ���f�����o�^����Ă��邱�Ƃ��m�F���܂��B

    ![result5-3](media/sqldev-python-step5-3-gho9o9.png "result5-3")

## revoscalepy�p�b�P�[�W���g�p���ă��W�X�e�B�b�N���f�����\�z����

���ɁA�V���������[�X�ƂȂ�RevoScalePy�p�b�P�[�W���g�p�����X�g�A�h�v���V�[�W���ɂ���ă��W�X�e�B�b�N��A���f�����g���[�j���O���܂��BPython ��RevoScalePy�p�b�P�[�W�ɂ́AR��RevoScaleR�p�b�P�[�W�Œ񋟂������̂Ɠ��l�̃I�u�W�F�N�g��`��f�[�^���H�����A�@�B�w�K�̂��߂̃A���S���Y�����܂܂�Ă��܂��B���̃��C�u�����ɂ���āA���W�X�e�B�b�N����`��A�A�f�V�W�����c���[�Ȃǂ̈�ʓI�ȃA���S���Y�����g�p�����\�����f���̃g���[�j���O��A�v�Z�R���e�L�X�g�̍쐬�A�v�Z�R���e�L�X�g�Ԃ̃f�[�^�ړ��A�f�[�^���H�������ł��܂��BRevoScalePy�̏ڍׂ�[Introducing RevoScalePy](https://docs.microsoft.com/ja-jp/sql/advanced-analytics/python/what-is-revoscalepy)���m�F���Ă��������B

1.  �X�g�A�h�v���V�[�W��`TrainTipPredictionModelRxPy`��[Step 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](sqldev-py2-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

    Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�X�g�A�h�v���V�[�W��]�̏��ɓW�J���܂��B`TrainTipPredictionModelRxPy`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B

```SQL:TrainTipPredictionModelRxPy
DROP PROCEDURE IF EXISTS TrainTipPredictionModelRxPy;
GO

CREATE PROCEDURE [dbo].[TrainTipPredictionModelRxPy] (@trained_model varbinary(max) OUTPUT)
AS
BEGIN
EXEC sp_execute_external_script 
  @language = N'Python',
  @script = N'
import numpy
import pickle
# import pandas
from revoscalepy.functions.RxLogit import rx_logit

## Create a logistic regression model using rx_logit function from revoscalepy package
logitObj = rx_logit("tipped ~ passenger_count + trip_distance + trip_time_in_secs + direct_distance", data = InputDataSet);

## Serialize model
trained_model = pickle.dumps(logitObj)
',
@input_data_1 = N'
select tipped, fare_amount, passenger_count, trip_time_in_secs, trip_distance, 
dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance
from nyctaxi_sample_training
',
@input_data_1_name = N'InputDataSet',
@params = N'@trained_model varbinary(max) OUTPUT',
@trained_model = @trained_model OUTPUT;
;
END;
GO
```
    
- nyctaxi_sample_training�f�[�^��revoscalepy�p�b�P�[�W���g�p���ă��W�X�e�B�b�N��A���f�����g���[�j���O���܂��B
- SELECT�N�G���̓J�X�^���X�J���֐�fnCalculateDistance���g�p���āA��Ԉʒu�ƍ~�Ԉʒu�̊Ԃ̒��ڋ������v�Z���܂��B�N�G���̌��ʂ̓f�t�H���g��Python���͕ϐ�`InputDataset`�Ɋi�[����܂��B
- Python�X�N���v�g�́AMachine Learning Services�Ɋ܂܂�Ă���revoscalepy��LogisticRegression�֐����Ăяo���āA���W�X�e�B�b�N��A���f�����쐬���܂��B
- tipped��ړI�ϐ��ɁApassenger_count�Atrip_distance�Atrip_time_in_secs�A�����direct_distance������ϐ��Ƃ��ă��f�����쐬���܂��B    - Python�ϐ�`logitObj`�Ŏ������P���ς݃��f���̓V���A���C�Y����o�̓p�����[�^�Ƃ��ĕԂ�܂��B���̏o�͂�nyc_taxi_models�e�[�u���ɓo�^���邱�ƂŁA�����̗\���ɌJ��Ԃ��g�p���邱�Ƃ��ł��܂��B

2. ����SQL�������s���āA�g���[�j���O���ꂽ���f����nyc_taxi_models�e�[�u���ɓo�^���܂��B

    ```SQL:T-SQL
    DECLARE @model VARBINARY(MAX);
    EXEC TrainTipPredictionModelRxPy @model OUTPUT;
    INSERT INTO nyc_taxi_models (name, model) VALUES('revoscalepy_model', @model);
    ```

    �f�[�^�����ƃ��f���̃t�B�b�e�B���O�ɂ͐���������܂��BPython��stdout�X�g���[���Ƀp�C�v����郁�b�Z�[�W�́AManagement Studio�̃��b�Z�[�W�E�B���h�E�ɕ\������܂��B

    ![result5-4](media/sqldev-python-step5-4-gho9o9.png "result5-4")
    
3. nyc_taxi_models�e�[�u���ɐV�������R�[�h��1�ǉ�����A�V���A���C�Y���ꂽ���f�����o�^����Ă��邱�Ƃ��m�F���܂��B

    ![result5-5](media/sqldev-python-step5-5-gho9o9.png "result5-5")
    
���̃X�e�b�v�ł́A�P�����ꂽ���f�����g�p���ė\�����쐬���܂��B

## ���̃X�e�b�v

[Step 6: ���f���̗��p](sqldev-py6-operationalize-the-model.md)

## �O�̃X�e�b�v

[Step 4: T-SQL���g�p�����f�[�^�̓������o](sqldev-py4-create-data-features-using-t-sql.md)

## �͂��߂���

[SQL�J���҂̂��߂� In-Database Python ����](sqldev-in-database-python-for-sql-developers.md)

## �֘A����

[Machine Learning Services with Python](https://docs.microsoft.com/en-us/sql/advanced-analytics/python/sql-server-python-services)

<!--
---
title: "Step 5: Train and Save a Model using T-SQL | Microsoft Docs"
ms.custom: ""
ms.date: "07/26/2017"
ms.prod: "sql-server-2017"
ms.reviewer: ""
ms.suite: ""
ms.technology: 
  - "python-services"
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
# Step 5: Train and save a model using T-SQL

In this step, you learn how to train a machine learning model using the Python packages **scikit-learn** and **revoscalepy**. These Python libraries are already installed with SQL Server Machine Learning Services, so you can load the modules and call the necessary functions from within a stored procedure. You'll train the model using the data features you just created, and then save the trained model in a [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] table.

## Split the sample data into training and testing sets

1. Run the following T-SQL commands to create a stored procedure that divides the data in the nyctaxi\_sample table into two parts: nyctaxi\_sample\_training and nyctaxi\_sample\_testing.

    ```SQL
    CREATE PROCEDURE [dbo].[TrainTestSplit] (@pct int)
    AS
    
    DROP TABLE IF EXISTS dbo.nyctaxi_sample_training
    SELECT * into nyctaxi_sample_training FROM nyctaxi_sample WHERE (ABS(CAST(BINARY_CHECKSUM(medallion,hack_license)  as int)) % 100) < @pct
    
    DROP TABLE IF EXISTS dbo.nyctaxi_sample_testing
    SELECT * into nyctaxi_sample_testing FROM nyctaxi_sample
    WHERE (ABS(CAST(BINARY_CHECKSUM(medallion,hack_license)  as int)) % 100) > @pct
    GO
    ```

2. Run the stored procedure, and type an integer that represents the percentage of data allocated to the training set. For example, the following statement would allocate 60% of data to the training set. Training and testing data are stored in two separate tables.

    ```SQL
    EXEC TrainTestSplit 60
    GO
    ```

## Build a logistic regression model using scikit-learn

In this section, you create a stored procedure that can be used to train a model using the training data you just prepared. This stored procedure defines the input data and uses a **scikit-learn** function to train a logistic regression model. You call the Python runtime that is installed with SQL Server by using the system stored procedure, [sp_execute_external_script](../../relational-databases/system-stored-procedures/sp-execute-external-script-transact-sql.md).

To make it easier to retrain the model, you can wrap the call to sp_execute_exernal_script in another stored procedure, and pass in the new training data as a parameter. This section will walk you through that process.

1.  In [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)], open a new **Query** window and run the following statement to create the stored procedure _TrainTipPredictionModelSciKitPy_.  Note that the stored procedure contains a definition of the input data, so you don't need to provide an input query.

    ```SQL
    DROP PROCEDURE IF EXISTS TrainTipPredictionModelSciKitPy;
    GO

    CREATE PROCEDURE [dbo].[TrainTipPredictionModelSciKitPy] (@trained_model varbinary(max) OUTPUT)
    AS
    BEGIN
      EXEC sp_execute_external_script
      @language = N'Python',
      @script = N'
      import numpy
      import pickle
      import pandas
      from sklearn.linear_model import LogisticRegression
      
      ##Create SciKit-Learn logistic regression model
      X = InputDataSet[["passenger_count", "trip_distance", "trip_time_in_secs", "direct_distance"]]
      y = numpy.ravel(InputDataSet[["tipped"]])
      
      SKLalgo = LogisticRegression()
      logitObj = SKLalgo.fit(X, y)
      
      ##Serialize model
      trained_model = pickle.dumps(logitObj)
      ',
      @input_data_1 = N'
      select tipped, fare_amount, passenger_count, trip_time_in_secs, trip_distance, 
      dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance
      from nyctaxi_sample_training
      ',
      @input_data_1_name = N'InputDataSet',
      @params = N'@trained_model varbinary(max) OUTPUT',
      @trained_model = @trained_model OUTPUT;
      ;
    END;
    GO
    ```

2. Run the following SQL statements to insert the trained model into table nyc\_taxi_models.

    ```SQL
    DECLARE @model VARBINARY(MAX);
    EXEC TrainTipPredictionModelSciKitPy @model OUTPUT;
    INSERT INTO nyc_taxi_models (name, model) VALUES('SciKit_model', @model);
    ```

    Processing of the data and fitting the model might take a couple of mins. Messages that would be piped to Python's **stdout** stream are displayed in the **Messages** window of [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)]. For example:

    *STDOUT message(s) from external script:*
  *C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\PYTHON_SERVICES\lib\site-packages\revoscalepy*

3. Open the table *nyc\_taxi_models*. You can see that one new row has been added, which contains the serialized model in the column _model_.

    *linear_model*
    *0x800363736B6C6561726E2E6C696E6561....*

## Build a logistic model using the _revoscalepy_ package

Now, create a different stored procedure that uses the new **revoscalepy** package to train a logistic regression model. The **revoscalepy** package for Python contains objects, transformation, and algorithms similar to those provided for the R language's **RevoScaleR** package. With this library, you can create a compute context, move data between compute contexts, transform data, and train predictive models using popular algorithms such as logistic and linear regression, decision trees, and more. For more information, see [what is revoscalepy?](../python/what-is-revoscalepy.md)

1. In [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)], open a new **Query** window and run the following statement to create the stored procedure _TrainTipPredictionModelRxPy_.  This model also uses the training data you just prepared. Because the stored procedure already includes a definition of the input data, you don't need to provide an input query.

    ```SQL
    DROP PROCEDURE IF EXISTS TrainTipPredictionModelRxPy;
    GO

    CREATE PROCEDURE [dbo].[TrainTipPredictionModelRxPy] (@trained_model varbinary(max) OUTPUT)
    AS
    BEGIN
    EXEC sp_execute_external_script 
      @language = N'Python',
      @script = N'
    import numpy
    import pickle
    import pandas
    from revoscalepy.functions.RxLogit import rx_logit_ex
    
    ## Create a logistic regression model using rx_logit_ex function from revoscalepy package
    logitObj = rx_logit_ex("tipped ~ passenger_count + trip_distance + trip_time_in_secs + direct_distance", data = InputDataSet);
    
    ## Serialize model
    trained_model = pickle.dumps(logitObj)
    ',
    @input_data_1 = N'
    select tipped, fare_amount, passenger_count, trip_time_in_secs, trip_distance, 
    dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) as direct_distance
    from nyctaxi_sample_training
    ',
    @input_data_1_name = N'InputDataSet',
    @params = N'@trained_model varbinary(max) OUTPUT',
    @trained_model = @trained_model OUTPUT;
    ;
    END;
    GO
    ```

    This stored procedure performs the following steps as part of model training:

    - Train a logistic regression model using revoscalepy package on nyctaxi\_sample\_training data.
    - The SELECT query uses the custom scalar function _fnCalculateDistance_ to calculate the direct distance between the pick-up and drop-off locations. The results of the query are stored in the default Python input variable, `InputDataset`.
    - The Python script calls the revoscalepy's LogisticRegression function, which is included with [!INCLUDE[rsql_productname](../../includes/rsql-productname-md.md)], to create the logistic regression model.
    - The binary variable _tipped_ is used as the *label* or outcome column,  and the model is fit using these feature columns:  _passenger_count_, _trip_distance_, _trip_time_in_secs_, and _direct_distance_.
    - The trained model, contained in the Python variable `logitObj`, is serialized and put as an output parameter [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)]. That output is inserted into the database table _nyc_taxi_models_, along with its name, as a new row, so that you can retrieve and use it for future predictions.

2. Run the stored procedure as follows to insert the trained **revoscalepy** model into the table _nyc\_taxi\_models.

    ```SQL
    DECLARE @model VARBINARY(MAX);
    EXEC TrainTipPredictionModelRxPy @model OUTPUT;
    
    INSERT INTO nyc_taxi_models (name, model) VALUES('revoscalepy_model', @model);
    ```

    Processing of the data and fitting the model might take a while. Messages that would be piped to Python's **stdout** stream are displayed in the **Messages** window of [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)]. For example:

    *STDOUT message(s) from external script:*
  *C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\PYTHON_SERVICES\lib\site-packages\revoscalepy*

3. Open the table *nyc_taxi_models*. You can see that one new row has been added, which contains the serialized model in the column _model_.

    *rx_model*
    *0x8003637265766F7363616c....*

In the next step, you use the trained models to create predictions.

## Next step

[Step 6: Operationalize the model](sqldev-py6-operationalize-the-model.md)

## Previous step

[Step 4: Create data features using T-SQL](sqldev-py5-train-and-save-a-model-using-t-sql.md)

-->