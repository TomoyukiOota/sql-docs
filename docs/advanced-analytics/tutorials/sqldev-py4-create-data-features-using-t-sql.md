# Step 4: T-SQL���g�p�����f�[�^�̓������o

�f�[�^�̒T����A�f�[�^���炢�����̓��@�����W�������G���W�j�A�����O�Ɉڂ�܂��B���f�[�^����������o���s���v���Z�X�́A���x�ȕ��̓��f�����O�̏d�v�ȃX�e�b�v�ł��B

���̃X�e�b�v�ł́ATransact-SQL�֐����g�p���Đ��f�[�^����������o���s�����@���w�K���܂��B���̌�A�X�g�A�h�v���V�[�W�����炻�̊֐����Ăяo���āA�����l���܂ރe�[�u�����쐬���܂��B

## �֐��̒�`

���f�[�^�ɋL�^���ꂽ���[�^�[�����l�͒n���I�����܂��͈ړ�������\�����̂ɂȂ��Ă��Ȃ��ꍇ�����邽�߁A���̃f�[�^�Z�b�g�ŗ��p�\�ȍ��W���g�p���ď�Ԉʒu�ƍ~�Ԉʒu�̊Ԃ̒��ڋ������v�Z���܂��B������s�����߂ɃJ�X�^��Transact-SQL�֐���[Haversine��](https://en.wikipedia.org/wiki/Haversine_formula)���g�p���܂��B

T-SQL�֐�`fnCalculateDistance`��Haversine�����g�p���ċ������v�Z���AT-SQL�֐�`fnEngineerFeatures`�͂��ׂĂ̓������܂ރe�[�u�����쐬���܂��B

### fnCalculateDistance���g�p���Ĉړ��������v�Z����

1.  T-SQL�֐�`fnCalculateDistance`��[Step 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](sqldev-py2-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

    Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�֐�]�A[�X�J���[�l�֐�]�̏��ɓW�J���܂��B`fnCalculateDistance`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B
  
    ```SQL:fnCalculateDistance
    CREATE FUNCTION [dbo].[fnCalculateDistance] (@Lat1 float, @Long1 float, @Lat2 float, @Long2 float)
    -- User-defined function that calculates the direct distance between two geographical coordinates
    RETURNS float
    AS
    BEGIN
      DECLARE @distance decimal(28, 10)
      -- Convert to radians
      SET @Lat1 = @Lat1 / 57.2958
      SET @Long1 = @Long1 / 57.2958
      SET @Lat2 = @Lat2 / 57.2958
      SET @Long2 = @Long2 / 57.2958
      -- Calculate distance
      SET @distance = (SIN(@Lat1) * SIN(@Lat2)) + (COS(@Lat1) * COS(@Lat2) * COS(@Long2 - @Long1))
      --Convert to miles
      IF @distance <> 0
      BEGIN
        SET @distance = 3958.75 * ATAN(SQRT(1 - POWER(@distance, 2)) / @distance);
      END
      RETURN @distance
    END
    GO
    ```
**Notes:**

- ���̊֐��̓X�J���[�l�֐��ł���A���O��`���ꂽ�^�̒P��̃f�[�^�l��Ԃ��܂��B
- ��Ԉʒu�ƍ~�Ԉʒu�̏ꏊ���瓾��ꂽ�ܓx�ƌo�x�̒l�����͂Ƃ��Ďg�p����܂��BHaversine���́A�ʒu�����W�A���ɕϊ����A�����̒l���g�p���āA2�̏ꏊ�̊Ԃ̒��ڋ������v�Z���܂��B

### fnEngineerFeatures���g�p���ē����l��ۑ�����

1.  T-SQL�֐�`fnEngineerFeatures`��[Step 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](sqldev-py2-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

    Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�֐�]�A[�e�[�u���l�֐�]�̏��ɓW�J���܂��B`fnCalculateDistance`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B
    
    `fnEngineerFeatures`�͕����̗����͂Ƃ��Ďg�p�������̓����l���Ԃ��e�[�u���l�֐��ł��B`fnEngineerFeatures`�̖ړI�́A���f���\�z�Ɏg�p��������l�Z�b�g���쐬���邱�Ƃł��B`fnEngineerFeatures`�͏�Ԉʒu�ƍ~�Ԉʒu�̊Ԃ̒��������𓾂邽�߂�`fnCalculateDistance`���Ăяo���܂��B
  
    ```
    CREATE FUNCTION [dbo].[fnEngineerFeatures] (
    @passenger_count int = 0,
    @trip_distance float = 0,
    @trip_time_in_secs int = 0,
    @pickup_latitude float = 0,
    @pickup_longitude float = 0,
    @dropoff_latitude float = 0,
    @dropoff_longitude float = 0)
    RETURNS TABLE
    AS
      RETURN
      (
      -- Add the SELECT statement with parameter references here
      SELECT
        @passenger_count AS passenger_count,
        @trip_distance AS trip_distance,
        @trip_time_in_secs AS trip_time_in_secs,
        [dbo].[fnCalculateDistance](@pickup_latitude, @pickup_longitude, @dropoff_latitude, @dropoff_longitude) AS direct_distance
      )
    GO
    ```

2. ���ꂪ�@�\���邱�Ƃ��m�F���邽�߂ɁA��Ԉʒu�ƍ~�Ԉʒu�̏ꏊ���قȂ�^�]�ɂ�������炸���[�^�[�����l��0�ɐݒ肳�ꂽ�L�^�ɑ΂��Ēn���I�������v�Z���Ă݂܂��B

    ```SQL:T-SQL
        SELECT tipped, fare_amount, passenger_count,(trip_time_in_secs/60) as TripMinutes,
        trip_distance, pickup_datetime, dropoff_datetime,
        dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) AS direct_distance
        FROM nyctaxi_sample
        WHERE pickup_longitude != dropoff_longitude and pickup_latitude != dropoff_latitude and trip_distance = 0
        ORDER BY trip_time_in_secs DESC
    ```
    
    ![result4-1](media/sqldev-python-step4-1-gho9o9.png "result4-1")
    
    ���̒ʂ胁�[�^�[�ɂ���ĕ񍐂��ꂽ�����́A�K�������n���I�������������̂Ƃ��ċL�^����Ă���Ƃ͌���܂���B���������O�����������G���W�j�A�����O���d�v�ȗ��R�ł��B
    
���̃X�e�b�v�ł́A�����̋@�\���g�p���āAPython���g�p���ċ@�B�w�K���f�����쐬���A�g���[�j���O������@���w�K���܂��B

## Next Step

[Step 5: T-SQL���g�p�������f���̃g���[�j���O�ƕۑ�](sqldev-py5-train-and-save-a-model-using-t-sql.md)

## Previous Step

[Step 3: �f�[�^�̒T���Ɖ���](sqldev-py3-explore-and-visualize-the-data.md)

## See Also

[Machine Learning Services with Python](https://docs.microsoft.com/en-us/sql/advanced-analytics/python/sql-server-python-services)

<!--
---
title: "Step 4: Create Data Features using T-SQL  | Microsoft Docs"
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
# Step 4: Create Data Features using T-SQL

After data exploration, you have collected some insights from the data, and are ready to move on to *feature engineering*. This process of creating features from the raw data can be a critical step in advanced analytics modeling.

In this step, you'll learn how to create features from raw data by using a [!INCLUDE[tsql](../../includes/tsql-md.md)] function. You'll then call that function from a stored procedure to create a table that contains the feature values.

## Define the Function

The distance values reported in the original data are based on the reported meter distance, and don't necessarily represent geographical distance or distance traveled. Therefore, you'll need to calculate the direct distance between the pick-up and drop-off points, by using the coordinates available in the source NYC Taxi dataset. You can do this by using the [Haversine formula](https://en.wikipedia.org/wiki/Haversine_formula) in a custom [!INCLUDE[tsql](../../includes/tsql-md.md)] function.

You'll use one custom T-SQL function, _fnCalculateDistance_, to compute the distance using the Haversine formula, and use a second custom T-SQL function, _fnEngineerFeatures_, to create a table containing all the features.

### Calculate trip distance using fnCalculateDistance

1.  The function _fnCalculateDistance_ should have been downloaded and registered with [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] as part of the preparation for this walkthrough. Take a minute to review the code.
  
    In [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)], expand **Programmability**, expand **Functions** and then **Scalar-valued functions**.
    Right-click _fnCalculateDistance_, and select **Modify** to open the [!INCLUDE[tsql](../../includes/tsql-md.md)] script in a new query window.
  
    ```SQL
    CREATE FUNCTION [dbo].[fnCalculateDistance] (@Lat1 float, @Long1 float, @Lat2 float, @Long2 float)
    -- User-defined function that calculates the direct distance between two geographical coordinates
    RETURNS float
    AS
    BEGIN
      DECLARE @distance decimal(28, 10)
      -- Convert to radians
      SET @Lat1 = @Lat1 / 57.2958
      SET @Long1 = @Long1 / 57.2958
      SET @Lat2 = @Lat2 / 57.2958
      SET @Long2 = @Long2 / 57.2958
      -- Calculate distance
      SET @distance = (SIN(@Lat1) * SIN(@Lat2)) + (COS(@Lat1) * COS(@Lat2) * COS(@Long2 - @Long1))
      --Convert to miles
      IF @distance <> 0
      BEGIN
        SET @distance = 3958.75 * ATAN(SQRT(1 - POWER(@distance, 2)) / @distance);
      END
      RETURN @distance
    END
    GO
    ```
**Notes:**

- The function is a scalar-valued function, returning a single data value of a predefined type.
- It takes latitude and longitude values as inputs, obtained from trip pick-up and drop-off locations. The Haversine formula converts locations to radians and uses those values to compute the direct distance in miles between those two locations.

To add the computed value to a table that can be used for training the model, you'll use another function, _fnEngineerFeatures_.

### Save the features using _fnEngineerFeatures_

1.  Take a minute to review the code for the custom T-SQL function, _fnEngineerFeatures_, which should have been created for you as part of the preparation for this walkthrough.
  
    This function is a table-valued function that takes multiple columns as inputs, and outputs a table with multiple feature columns.  The purpose of this function is to create a feature set for use in building a model. The function _fnEngineerFeatures_ calls the previously created T-SQL function, _fnCalculateDistance_, to get the direct distance between pickup and dropoff locations.
  
    ```
    CREATE FUNCTION [dbo].[fnEngineerFeatures] (
    @passenger_count int = 0,
    @trip_distance float = 0,
    @trip_time_in_secs int = 0,
    @pickup_latitude float = 0,
    @pickup_longitude float = 0,
    @dropoff_latitude float = 0,
    @dropoff_longitude float = 0)
    RETURNS TABLE
    AS
      RETURN
      (
      -- Add the SELECT statement with parameter references here
      SELECT
        @passenger_count AS passenger_count,
        @trip_distance AS trip_distance,
        @trip_time_in_secs AS trip_time_in_secs,
        [dbo].[fnCalculateDistance](@pickup_latitude, @pickup_longitude, @dropoff_latitude, @dropoff_longitude) AS direct_distance
      )
    GO
    ```
  
2. To verify that this function works, you can use it to calculate the geographical distance for those trips where the metered distance was 0 but the pick-up and drop-off locations were different.
  
    ```
        SELECT tipped, fare_amount, passenger_count,(trip_time_in_secs/60) as TripMinutes,
        trip_distance, pickup_datetime, dropoff_datetime,
        dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) AS direct_distance
        FROM nyctaxi_sample
        WHERE pickup_longitude != dropoff_longitude and pickup_latitude != dropoff_latitude and trip_distance = 0
        ORDER BY trip_time_in_secs DESC
    ```
  
    As you can see, the distance reported by the meter doesn't always correspond to geographical distance. This is why feature engineering is important.

In the next step, you'll learn how to use these data features to create and train a machine learning model using Python.

## Next Step

[Step 5: Train and Save a Model using T-SQL](sqldev-py5-train-and-save-a-model-using-t-sql.md)

## Previous Step

[Step 3: Explore and Visualize the Data](sqldev-py3-explore-and-visualize-the-data.md)

## See Also

[Machine Learning Services with Python](../python/sql-server-python-services.md)

-->