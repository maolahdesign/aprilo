USE iris_dataset
GO
DROP TABLE IF EXISTS iris_models;
GO
CREATE TABLE iris_models (
model_name VARCHAR(50) NOT NULL DEFAULT('default model') PRIMARY KEY,
model VARBINARY(MAX) NOT NULL
);
GO
