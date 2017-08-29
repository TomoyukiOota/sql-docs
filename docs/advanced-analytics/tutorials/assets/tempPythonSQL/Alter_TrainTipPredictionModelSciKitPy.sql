/****** Object:  StoredProcedure [dbo].[TrainTipPredictionModelSciKitPy]    Script Date: 2017/08/29 22:22:00 ******/
DROP PROCEDURE [dbo].[TrainTipPredictionModelSciKitPy]
GO

/****** Object:  StoredProcedure [dbo].[TrainTipPredictionModelSciKitPy]    Script Date: 2017/08/29 22:22:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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

