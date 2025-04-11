USE iris_dataset
GO
CREATE PROCEDURE load_iris_dataset
AS
BEGIN
EXEC sp_execute_external_script @language = N'Python', 
@script = N'
from sklearn import datasets
iris = datasets.load_iris()
iris_data = pandas.DataFrame(iris.data)
iris_data["Species"] = pandas.Categorical.from_codes(iris.target, iris.target_names)
iris_data["SpeciesId"] = iris.target
', 
@input_data_1 = N'', 
@output_data_1_name = N'iris_data'
WITH RESULT SETS ((Sepal_Length float not null, Sepal_Width float not null,
       Petal_Length float not null, Petal_Width float not null, 
	   Species varchar(100) not null, SpeciesId int not null));
END;
GO