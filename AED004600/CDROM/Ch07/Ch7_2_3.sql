USE 毙叭╰参 
GO
CREATE TABLE ︳基虫 (
   ︳基虫絪腹  int    NOT NULL IDENTITY PRIMARY KEY, 
   玻珇絪腹    char(4)  NOT NULL,
   羆基        decimal(5, 1) NOT NULL,
   计秖        int       NOT NULL DEFAULT 1,
   キА虫基    AS  羆基 / 计秖
)


