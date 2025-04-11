USE iris_dataset
GO
DROP TABLE IF EXISTS iris_data;
GO
CREATE TABLE iris_data (
id           INT NOT NULL IDENTITY PRIMARY KEY,
Sepal_Length FLOAT NOT NULL,
Sepal_Width  FLOAT NOT NULL,
Petal_Length FLOAT NOT NULL,
Petal_Width  FLOAT NOT NULL,
Species      VARCHAR(100) NOT NULL,
SpeciesId    INT   NOT NULL
);
GO