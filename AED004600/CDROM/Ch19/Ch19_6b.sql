USE iris_dataset
GO
DECLARE @model varbinary(max);
DECLARE @new_model_name varchar(50)
SET @new_model_name = 'Naive Bayes'
EXEC dbo.generate_iris_model @model OUTPUT;
DELETE iris_models WHERE model_name = @new_model_name;
INSERT INTO iris_models (model_name, model)
       VALUES(@new_model_name, @model);
GO
SELECT * FROM dbo.iris_models
GO