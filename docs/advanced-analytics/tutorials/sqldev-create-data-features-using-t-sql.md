# Lesson 4: T-SQL���g�p�����f�[�^�̓������o

���̋L���́ASQL�J���҂̂��߂� In-Database R ���́i�`���[�g���A���j �̈ꕔ�ł��B

���̃X�e�b�v�ł́ATransact-SQL�֐����g�p���Đ��f�[�^����������o���s�����@���w�K���܂��B���̌�A�X�g�A�h�v���V�[�W�����炻�̊֐����Ăяo���āA�����l���܂ރe�[�u�����쐬���܂��B

## �������o�ɂ���

�f�[�^�̒T����A�f�[�^���炢�����̓��@�����W�������G���W�j�A�����O�Ɉڂ�܂��B���f�[�^����������o���s���v���Z�X�́A���x�ȕ��̓��f�����O�̏d�v�ȃX�e�b�v�ł��B

���f�[�^�ɋL�^���ꂽ���[�^�[�����l�͒n���I�����܂��͈ړ�������\�����̂ɂȂ��Ă��Ȃ��ꍇ�����邽�߁A���̃f�[�^�Z�b�g�ŗ��p�\�ȍ��W���g�p���ď�Ԉʒu�ƍ~�Ԉʒu�̊Ԃ̒��ڋ������v�Z���܂��B������s�����߂ɃJ�X�^��Transact-SQL�֐���[Haversine��](https://en.wikipedia.org/wiki/Haversine_formula)���g�p���܂��B

T-SQL�֐�`fnCalculateDistance`��Haversine�����g�p���ċ������v�Z���AT-SQL�֐�`fnEngineerFeatures`�͂��ׂĂ̓������܂ރe�[�u�����쐬���܂��B

�S�̗̂���͎��̂Ƃ���ł��B

- �v�Z�����s����T-SQL�֐����쐬����

- �����l�𐶐�����֐����Ăяo��

- �����l���e�[�u���ɕۑ�����

## �֐�fnCalculateDistance���g�p���Ĉړ��������v�Z����

T-SQL�֐�`fnCalculateDistance`��[Lesson 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](../r/sqldev-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

1. Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�֐�]�A[�X�J���[�l�֐�]�̏��ɓW�J���܂��B

2. `fnCalculateDistance`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B

    ```SQL:T-SQL
    CREATE FUNCTION [dbo].[fnCalculateDistance] (@Lat1 float, @Long1 float, @Lat2 float, @Long2 float)  
    -- User-defined function that calculates the direct distance between two geographical coordinates.  
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

    - ���̊֐��̓X�J���[�l�֐��ł���A���O��`���ꂽ�^�̒P��̃f�[�^�l��Ԃ��܂��B
    - ��Ԉʒu�ƍ~�Ԉʒu�̏ꏊ���瓾��ꂽ�ܓx�ƌo�x�̒l�����͂Ƃ��Ďg�p����܂��BHaversine���́A�ʒu�����W�A���ɕϊ����A�����̒l���g�p���āA2�̏ꏊ�̊Ԃ̒��ڋ������v�Z���܂��B


## �֐�fnEngineerFeatures���g�p���ē����l��ۑ�����

T-SQL�֐�`fnEngineerFeatures`��[Lesson 2: PowerShell���g�p����SQL Server�ւ̃f�[�^�C���|�[�g](../r/sqldev-import-data-to-sql-server-using-powershell.md)��ʂ���SQL Server�ɒ�`����Ă��܂��B

`fnEngineerFeatures`�͕����̗����͂Ƃ��Ďg�p�������̓����l���Ԃ��e�[�u���l�֐��ł��B`fnEngineerFeatures`�̖ړI�́A���f���\�z�Ɏg�p��������l�Z�b�g���쐬���邱�Ƃł��B`fnEngineerFeatures`�͏�Ԉʒu�ƍ~�Ԉʒu�̊Ԃ̒��������𓾂邽�߂�`fnCalculateDistance`���Ăяo���܂��B

1. Management Studio�̃I�u�W�F�N�g�G�N�X�v���[���ŁA[�v���O���~���O]�A[�֐�]�A[�X�J���[�l�֐�]�̏��ɓW�J���A`fnEngineerFeatures`���E�N���b�N���A[�ύX] ��I�����ĐV�����N�G���E�B���h�E��Transact-SQL�X�N���v�g���J���܂��B

    ```SQL:T-SQL
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

    + ���̃e�[�u���l�֐��́A�����̗����͂��A�����̓����l�̗���܂ރe�[�u�����o�͂���B
    + ���̊֐��̖ړI�́A���f�����\�z���邽�߂̐V���������l���쐬���邱�Ƃł��B

2.  ���ꂪ�@�\���邱�Ƃ��m�F���邽�߂ɁA��Ԉʒu�ƍ~�Ԉʒu�̏ꏊ���قȂ�^�]�ɂ�������炸���[�^�[�����l��0�ɐݒ肳�ꂽ�L�^�ɑ΂��Ēn���I�������v�Z���Ă݂܂��B

    ```SQL:T-SQL
    SELECT tipped, fare_amount, passenger_count,(trip_time_in_secs/60) as TripMinutes,
    trip_distance, pickup_datetime, dropoff_datetime,
    dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) AS direct_distance
    FROM nyctaxi_sample
    WHERE pickup_longitude != dropoff_longitude and pickup_latitude != dropoff_latitude and trip_distance = 0
    ORDER BY trip_time_in_secs DESC
    ```
    
    ![result](media/sqldev-r-step4-1-gho9o9.png "result")
    
    ���̒ʂ胁�[�^�[�ɂ���ĕ񍐂��ꂽ�����́A�K�������n���I�������������̂Ƃ��ċL�^����Ă���Ƃ͌���܂���B���������O�����������G���W�j�A�����O���d�v�ȗ��R�ł��B

���̃X�e�b�v�ł́A�����̋@�\���g�p���āAR���g�p���ċ@�B�w�K���f�����쐬���A�g���[�j���O������@���w�K���܂��B

## ���̃X�e�b�v

[Lesson 5: T-SQL���g�p�������f���̃g���[�j���O�ƕۑ�](../r/sqldev-train-and-save-a-model-using-t-sql.md)

## �O�̃X�e�b�v

[Lesson 3: �f�[�^�̒T���Ɖ���](../tutorials/sqldev-explore-and-visualize-the-data.md)

## �͂��߂���

[SQL�J���҂̂��߂� In-Database R ����](../tutorials/sqldev-in-database-r-for-sql-developers.md)

## �֘A����

[Machine Learning Services with R](https://docs.microsoft.com/en-us/sql/advanced-analytics/r/sql-server-r-services)


<!--
---
title: "Lesson 4: Create data features using T-SQL  | Microsoft Docs"
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
ms.assetid: 5b2f4c44-6192-40df-abf1-fc983844f1d0
caps.latest.revision: 10
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# Lesson 4: Create data features using T-SQL

This article is part of a tutorial for SQL developers on how to use R in SQL Server.

In this step, you'll learn how to create features from raw data by using a [!INCLUDE[tsql](../../includes/tsql-md.md)] function. You'll then call that function from a stored procedure to create a table that contains the feature values.

## About feature engineering

After several rounds of data exploration, you have collected some insights from the data, and are ready to move on to *feature engineering*. This process of creating meaningful features from the raw data is a critical step in creating analytical models.

In this dataset, the distance values are based on the reported meter distance, and don't necessarily represent geographical distance or the actual distance traveled. Therefore, you'll need to calculate the direct distance between the pick-up and drop-off points, by using the coordinates available in the source NYC Taxi dataset. You can do this by using the [Haversine formula](https://en.wikipedia.org/wiki/Haversine_formula) in a custom [!INCLUDE[tsql](../../includes/tsql-md.md)] function.

You'll use one custom T-SQL function, _fnCalculateDistance_, to compute the distance using the Haversine formula, and use a second custom T-SQL function, _fnEngineerFeatures_, to create a table containing all the features.

The overall process is as follows:

- Create the T-SQL function that performs the calculations

- Call the function to generate the feature data

- Save the feature data to a table

## Calculate trip distance using fnCalculateDistance

The function _fnCalculateDistance_ should have been downloaded and registered with [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] as part of the preparation for this tutorial. Take a minute to review the code.
  
1. In [!INCLUDE[ssManStudio](../../includes/ssmanstudio-md.md)], expand **Programmability**, expand **Functions** and then **Scalar-valued functions**.   

2. Right-click _fnCalculateDistance_, and select **Modify** to open the [!INCLUDE[tsql](../../includes/tsql-md.md)] script in a new query window.
  
    ```SQL
    CREATE FUNCTION [dbo].[fnCalculateDistance] (@Lat1 float, @Long1 float, @Lat2 float, @Long2 float)  
    -- User-defined function that calculates the direct distance between two geographical coordinates.  
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
  
    - The function is a scalar-valued function, returning a single data value of a predefined type.
  
    - It takes latitude and longitude values as inputs, obtained from trip pick-up and drop-off locations. The Haversine formula converts locations to radians and uses those values to compute the direct distance in miles between those two locations.

## Generate the features using _fnEngineerFeatures_

To add the computed values to a table that can be used for training the model, you'll use another function, _fnEngineerFeatures_. The new function calls the previously created T-SQL function, _fnCalculateDistance_, to get the direct distance between pick-up and drop-off locations. 

1. Take a minute to review the code for the custom T-SQL function, _fnEngineerFeatures_, which should have been created for you as part of the preparation for this walkthrough.
  
    ```SQL
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

    + This table-valued function that takes multiple columns as inputs, and outputs a table with multiple feature columns.

    + The purpose of this function is to create new features for use in building a model.

2.  To verify that this function works, use it to calculate the geographical distance for those trips where the metered distance was 0 but the pick-up and drop-off locations were different.
  
    ```SQL
        SELECT tipped, fare_amount, passenger_count,(trip_time_in_secs/60) as TripMinutes,
        trip_distance, pickup_datetime, dropoff_datetime,
        dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) AS direct_distance
        FROM nyctaxi_sample
        WHERE pickup_longitude != dropoff_longitude and pickup_latitude != dropoff_latitude and trip_distance = 0
        ORDER BY trip_time_in_secs DESC
    ```
  
    As you can see, the distance reported by the meter doesn't always correspond to geographical distance. This is why feature engineering is so important. You can use these improved data features to train a machine learning model using R.

## Next lesson

[Lesson 5: Train and save a model using T-SQL](../r/sqldev-train-and-save-a-model-using-t-sql.md)

## Previous lesson

[Lesson 3: Explore and visualize the data](../tutorials/sqldev-explore-and-visualize-the-data.md)
-->