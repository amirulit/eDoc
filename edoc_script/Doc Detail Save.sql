CREATE TABLE dbo.SecurityInfo
(
    EntryId BIGINT IDENTITY(1,1) PRIMARY KEY,
    ParentId BIGINT NOT NULL,
    KeyNo INT NOT NULL,

    Header01 NVARCHAR(500) NULL,
    Header02 NVARCHAR(500) NULL,
    Header03 NVARCHAR(500) NULL,
    Header04 NVARCHAR(500) NULL,

    CreatedBy NVARCHAR(100) NULL,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE INDEX IX_SecurityInfo_Parent_Key
ON dbo.SecurityInfo(ParentId, KeyNo);


CREATE TABLE dbo.SecurityInfoLookup
(
    LookupId INT IDENTITY(1,1) PRIMARY KEY,
    GroupName VARCHAR(50) NOT NULL,
    ValueText NVARCHAR(200) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE INDEX IX_SecurityInfoLookup_Group
ON dbo.SecurityInfoLookup(GroupName, IsActive);



INSERT INTO dbo.SecurityInfoLookup(GroupName, ValueText)
VALUES
('DocumentType', 'Original'),
('DocumentType', 'Certified'),
('DocumentCopyType', 'Original'),
('DocumentCopyType', 'Certified'),
('DocumentCopyType', 'Photocopy');