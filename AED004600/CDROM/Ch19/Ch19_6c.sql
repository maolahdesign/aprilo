USE iris_dataset
GO
CREATE PROCEDURE predict_species
   @model_name VARCHAR(100)
AS
BEGIN
DECLARE @predict_model VARBINARY(max) = (
        SELECT model FROM iris_models
        WHERE model_name = @model_name);

EXEC sp_execute_external_script
@language = N'Python',
@script = N'
import pickle

irismodel = pickle.loads(predict_model)
pred = irismodel.predict(iris_data[["Sepal_Length", "Sepal_Width", 
                                    "Petal_Length", "Petal_Width"]])
iris_data["PredictedSpecies"] = pred
out = iris_data.query("PredictedSpecies != SpeciesId")
OutputDataSet = out[["id","SpeciesId","PredictedSpecies"]]
',
@input_data_1_name = N'iris_data',
@input_data_1 = N'SELECT id, Sepal_Length, Sepal_Width, 
           Petal_Length, Petal_Width, SpeciesId FROM iris_data',
@params = N'@predict_model varbinary(max)',
@predict_model = @predict_model
WITH RESULT SETS(("id" INT, "SpeciesId" INT, "SpeciesId_Predicted" INT));
END;
GO