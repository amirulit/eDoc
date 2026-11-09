CREATE TABLE dbo.PK_Details
(
    RecordId BIGINT IDENTITY(1,1) PRIMARY KEY,
    PKNo INT NOT NULL,
    Value01 NVARCHAR(500) NULL,
    Value02 NVARCHAR(500) NULL,
    Value03 NVARCHAR(500) NULL,
    Value04 NVARCHAR(500) NULL,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE()
);
GO

SELECT * FROM PK_Details

CREATE TABLE dbo.PK_Lookup
(
    LookupId INT IDENTITY(1,1) PRIMARY KEY,
    LookupType VARCHAR(50) NOT NULL,
    LookupValue NVARCHAR(250) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

CREATE INDEX IX_PK_Details_PKNo
ON dbo.PK_Details(PKNo);


INSERT INTO dbo.PK_Lookup (LookupType, LookupValue)
VALUES
('APPROVAL', 'Board'),
('APPROVAL', 'Managing Director'),
('APPROVAL', 'Head Office'),

('ORIGINAL_TYPE', 'Original'),
('ORIGINAL_TYPE', 'Certified'),
('ORIGINAL_TYPE', 'Photocopy');

