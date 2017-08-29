# Step 4: T-SQLを使用したデータの特徴抽出

データの探索後、データからいくつかの洞察を収集し特徴エンジニアリングに移ります。生データから特徴抽出を行うプロセスは、高度な分析モデリングの重要なステップです。

このステップでは、Transact-SQL関数を使用して生データから特徴抽出を行う方法を学習します。その後、ストアドプロシージャからその関数を呼び出して、特徴値を含むテーブルを作成します。

## 関数の定義

元データに記録されたメーター距離値は地理的距離または移動距離を表すものになっていない場合があるため、このデータセットで利用可能な座標を使用して乗車位置と降車位置の間の直接距離を計算します。これを行うためにカスタムTransact-SQL関数で[Haversine式](https://en.wikipedia.org/wiki/Haversine_formula)を使用します。

T-SQL関数`fnCalculateDistance`はHaversine式を使用して距離を計算し、T-SQL関数`fnEngineerFeatures`はすべての特徴を含むテーブルを作成します。

### fnCalculateDistanceを使用して移動距離を計算する

1.  T-SQL関数`fnCalculateDistance`は[Step 2: PowerShellを使用したSQL Serverへのデータインポート](sqldev-py2-import-data-to-sql-server-using-powershell.md)を通じてSQL Serverに定義されています。

    Management Studioのオブジェクトエクスプローラで、[プログラミング]、[関数]、[スカラー値関数]の順に展開します。`fnCalculateDistance`を右クリックし、[変更] を選択して新しいクエリウィンドウでTransact-SQLスクリプトを開きます。
  
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

- この関数はスカラー値関数であり、事前定義された型の単一のデータ値を返します。
- 乗車位置と降車位置の場所から得られた緯度と経度の値が入力として使用されます。Haversine式は、位置をラジアンに変換し、これらの値を使用して、2つの場所の間の直接距離を計算します。

### fnEngineerFeaturesを使用して特徴値を保存する

1.  T-SQL関数`fnEngineerFeatures`は[Step 2: PowerShellを使用したSQL Serverへのデータインポート](sqldev-py2-import-data-to-sql-server-using-powershell.md)を通じてSQL Serverに定義されています。

    Management Studioのオブジェクトエクスプローラで、[プログラミング]、[関数]、[テーブル値関数]の順に展開します。`fnCalculateDistance`を右クリックし、[変更] を選択して新しいクエリウィンドウでTransact-SQLスクリプトを開きます。
    
    `fnEngineerFeatures`は複数の列を入力として使用し複数の特徴値列を返すテーブル値関数です。`fnEngineerFeatures`の目的は、モデル構築に使用する特徴値セットを作成することです。`fnEngineerFeatures`は乗車位置と降車位置の間の直線距離を得るために`fnCalculateDistance`を呼び出します。
  
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

2. これが機能することを確認するために、乗車位置と降車位置の場所が異なる運転にもかかわらずメーター距離値が0に設定された記録に対して地理的距離を計算してみます。

    ```SQL:T-SQL
        SELECT tipped, fare_amount, passenger_count,(trip_time_in_secs/60) as TripMinutes,
        trip_distance, pickup_datetime, dropoff_datetime,
        dbo.fnCalculateDistance(pickup_latitude, pickup_longitude,  dropoff_latitude, dropoff_longitude) AS direct_distance
        FROM nyctaxi_sample
        WHERE pickup_longitude != dropoff_longitude and pickup_latitude != dropoff_latitude and trip_distance = 0
        ORDER BY trip_time_in_secs DESC
    ```
    
    ![result4-1](media/sqldev-python-step4-1-gho9o9.png "result4-1")
    
    この通りメーターによって報告された距離は、必ずしも地理的距離を示すものとして記録されているとは限りません。こうした前処理が特徴エンジニアリングが重要な理由です。
    
次のステップでは、これらの機能を使用して、Pythonを使用して機械学習モデルを作成し、トレーニングする方法を学習します。

## Next Step

[Step 5: T-SQLを使用したモデルのトレーニングと保存](sqldev-py5-train-and-save-a-model-using-t-sql.md)

## Previous Step

[Step 3: データの探索と可視化](sqldev-py3-explore-and-visualize-the-data.md)

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