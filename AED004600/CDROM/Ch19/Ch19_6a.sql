USE iris_dataset
GO
CREATE PROCEDURE generate_iris_model 
  @trained_model VARBINARY(max) OUTPUT
AS
BEGIN
EXEC sp_execute_external_script
@language = N'Python',
@script = N'
import pickle
from sklearn.naive_bayes import GaussianNB
GNB = GaussianNB()
model = GNB.fit(iris_data[["Sepal_Length", "Sepal_Width", 
                           "Petal_Length", "Petal_Width"]],
                iris_data[["SpeciesId"]].values.ravel())
trained_model = pickle.dumps(model)
',
@input_data_1_name = N'iris_data',
@input_data_1 = N'SELECT Sepal_Length, Sepal_Width, 
             Petal_Length, Petal_Width, SpeciesId FROM iris_data',
@params = N'@trained_model varbinary(max) OUTPUT',
@trained_model = @trained_model OUTPUT;
END;
GO