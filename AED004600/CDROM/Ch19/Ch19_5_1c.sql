USE iris_dataset
GO
INSERT INTO iris_data (Sepal_Length, Sepal_Width,
     Petal_Length, Petal_Width, Species, SpeciesId)
EXEC dbo.load_iris_dataset;
GO