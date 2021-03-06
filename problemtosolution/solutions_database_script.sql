/* solutions_database_script.sql
Created: 06/10/2019
ChangeLog: 
	07/02/2019 - Backup commentary added
Author: Buck Woody, Microsoft
Purpose: Creates a database for storing problems and solutions.
Requires: SQL Server 2017 or higher, any edition/platform

License: https://opensource.org/licenses/MS-PL - use at your own risk. The author and Microsoft assumes no responsibility for use in production.
*/


USE master;
GO 

CREATE DATABASE solutions;
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

USE solutions;
GO

CREATE TABLE [dbo].[Problem] ([ProblemID] [int] IDENTITY(1, 1) NOT NULL, [ProblemName] [nvarchar](150) NULL, [ProblemDescription] [nvarchar](max) NULL, PRIMARY KEY CLUSTERED ([ProblemID] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Solution] ([SolutionID] [int] IDENTITY(1, 1) NOT NULL, [SolutionName] [nvarchar](150) NULL, [SolutionDescription] [nvarchar](max) NULL, PRIMARY KEY CLUSTERED ([SolutionID] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[SolutionReferences] ([SolutionReferenceID] [int] IDENTITY(1, 1) NOT NULL, [SolutionReferenceType] [nvarchar](100) NULL, [SolutionReferenceName] [nvarchar](150) NULL, [SolutionReferenceDescription] [nvarchar](max) NULL, [SolutionID] [int] NULL, [SolutionReferencesLocation] [varchar](255) NULL, PRIMARY KEY CLUSTERED ([SolutionReferenceID] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[ProblemToSolution] ([ProblemToSolutionID] [int] IDENTITY(1, 1) NOT NULL, [ProblemID] [int] NULL, [SolutionID] [int] NULL, [Strength] [nvarchar](50) NULL, PRIMARY KEY CLUSTERED ([ProblemToSolutionID] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY]
GO

CREATE VIEW [dbo].[ProblemsToSolutions]
AS
SELECT dbo.Problem.ProblemName, dbo.Problem.ProblemDescription, dbo.Solution.SolutionName, dbo.Solution.SolutionDescription, dbo.ProblemToSolution.Strength, dbo.SolutionReferences.SolutionReferenceType, dbo.SolutionReferences.SolutionReferenceName, dbo.SolutionReferences.SolutionReferenceDescription, dbo.SolutionReferences.SolutionReferencesLocation
FROM dbo.Problem
INNER JOIN dbo.ProblemToSolution ON dbo.Problem.ProblemID = dbo.ProblemToSolution.ProblemID
INNER JOIN dbo.Solution ON dbo.ProblemToSolution.SolutionID = dbo.Solution.SolutionID
LEFT JOIN dbo.SolutionReferences ON dbo.Solution.SolutionID = dbo.SolutionReferences.SolutionID
GO

CREATE TABLE [dbo].[AzureService] ([AzureServiceID] [int] IDENTITY(1, 1) NOT NULL, [ServiceName] [nvarchar](150) NULL, [ServiceDescription] [nvarchar](max) NULL, PRIMARY KEY CLUSTERED ([AzureServiceID] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[ServiceReferences] ([ServiceReferenceID] [int] IDENTITY(1, 1) NOT NULL, [ServiceReferenceName] [nvarchar](150) NULL, [ServiceReferenceType] [nvarchar](50) NULL, [ServiceReferenceLocation] [nvarchar](150) NULL, [ServiceReferenceDescription] [nvarchar](max) NULL, [AzureServiceID] [int] NULL, PRIMARY KEY CLUSTERED ([ServiceReferenceID] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[SolutionToService] ([SolutionToServiceID] [int] IDENTITY(1, 1) NOT NULL, [SolutionID] [int] NULL, [AzureServiceID] [int] NULL, [Complexity] [nvarchar](50) NULL, [MonthlyEstimatedCost] [nvarchar](50) NULL, PRIMARY KEY CLUSTERED ([SolutionToServiceID] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY]
GO

CREATE VIEW [dbo].[SolutionsToServices]
AS
SELECT dbo.Solution.SolutionName, dbo.AzureService.ServiceName, dbo.AzureService.ServiceDescription, dbo.ServiceReferences.ServiceReferenceName, dbo.ServiceReferences.ServiceReferenceType, dbo.ServiceReferences.ServiceReferenceLocation
FROM dbo.Solution
INNER JOIN dbo.SolutionToService ON dbo.Solution.SolutionID = dbo.SolutionToService.SolutionID
INNER JOIN dbo.AzureService ON dbo.SolutionToService.AzureServiceID = dbo.AzureService.AzureServiceID
LEFT JOIN dbo.ServiceReferences ON dbo.AzureService.AzureServiceID = dbo.ServiceReferences.AzureServiceID
GO

CREATE TABLE [dbo].[sysdiagrams] ([name] [sysname] NOT NULL, [principal_id] [int] NOT NULL, [diagram_id] [int] IDENTITY(1, 1) NOT NULL, [version] [int] NULL, [definition] [varbinary](max) NULL, PRIMARY KEY CLUSTERED ([diagram_id] ASC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[AzureService] ON

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (1, N'Virtual Machines', N'Windows or Linux Virtual Machine')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (2, N'Azure Blob Storage', N'Cloud-based Storage')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (3, N'Azure Kubernetes Service', N'Kubernetes clusters as a service')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (4, N'Azure Key Vault', N'Secure offsite location for privacy and authentication keys')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (5, N'Azure Active Directory', N'ADLS')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (6, N'IoT Hub', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (7, N'IoT Edge', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (8, N'IoT Central', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (9, N'Azure Sphere', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (10, N'Cognitive Services', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (11, N'Azure Bot Service', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (12, N'Azure SQL Data Warehouse', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (13, N'Azure Data Factory', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (14, N'Event Hubs', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (15, N'Azure SSAS', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (16, N'Azure Data Catalog', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (17, N'Azure Stream Analytics', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (18, N'HDInsight', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (19, N'Azure Data Lake Storage', N'HDFS Tiering')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (20, N'Power BI', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (21, N'Azure Blockchain', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (22, N'Azure Logic Apps', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (23, N'Azure Cosmos DB', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (24, N'Service Fabric', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (25, N'SAP HANA', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (26, N'Virtual Machine Scale Sets', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (27, N'Azure Mobile Apps', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (28, N'VMWare', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (29, N'Azure App Service', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (30, N'Azure Container Registry', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (31, N'Azure Red Hat OpenShift', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (32, N'SQL Server Stretch Database', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (33, N'Azure SQL Database Edge', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (34, N'Azure SQL Database', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (35, N'Azure DevOps', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (36, N'Azure Pipelines', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (37, N'Azure Active Directory Domain Services', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (38, N'Azure Service Bus', N'A fully managed enterprise integration message broker. Service Bus is most commonly used to decouple applications and services from each other, and is a reliable and secure platform for asynchronous data and state transfer.')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (39, N'Azure Backup', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (40, N'Azure Site Recovery', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (41, N'Azure Stack', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (42, N'Azure Data Migration Service', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (43, N'Azure Data Box', N'Storage appliance with caching, Hierarchical Storage Management, and security')

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (44, N'Azure VPN', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (45, N'Azure NetApp Files', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (46, N'Azure SQL Data Sync', NULL)

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription])
VALUES (47, N'Azure DevTest Labs', NULL)

SET IDENTITY_INSERT [dbo].[AzureService] OFF
SET IDENTITY_INSERT [dbo].[Problem] ON

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (1, N'Copy Data Automatically', N'We want to copy certain data elements to an external location for use by others, securely.')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (2, N'Database Backups', N'We want to store our database backups in another location with full redundancy.')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (3, N'Offiste High Availability', N'We want additional safety on our data systems, with the ability to use them globally or as a secondary read service.')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (4, N'SQL Server 2008 EOS', N'SQL Server 2008 has reached end of service, and we don''t want to pay for extended support. We do have applications that required SQL Server 2008 as the back-end.')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (5, N'Lift and Shift', N'We have a SQL Server installation on premises and we want to duplicate or move it to Azure')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (6, N'Big Data Analytics', N'We have a lot of data that we need to analyze in a single environment. We''d also like to use Spark.')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (7, N'Data Hub', N'We have Oracle, Terradata, HDFS and other data sources we want to query using one system, without having to install and manage lots of connectors or learn to use multiple query languages. ')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (8, N'Performance Improvements', N'We have the need to improve our current performance, but we can''t always alter the code.')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (9, N'Security Improvements', N'We need to be able to use secure security enclaves, and have encryption end-to-end within the server without decoding at the client. ')

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription])
VALUES (10, N'SOA Architecture', N'We want to create a Service Oriented Architecture and use our SQL Server Data.')

SET IDENTITY_INSERT [dbo].[Problem] OFF
SET IDENTITY_INSERT [dbo].[ProblemToSolution] ON

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (1, 1, 1, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (2, 2, 1, N'Low')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (3, 2, 2, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (4, 2, 6, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (5, 3, 4, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (6, 4, 9, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (7, 5, 3, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (8, 6, 5, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (9, 7, 8, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (10, 7, 5, N'Medium')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (11, 8, 8, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (12, 9, 8, N'High')

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength])
VALUES (13, 10, 10, N'High')

SET IDENTITY_INSERT [dbo].[ProblemToSolution] OFF
SET IDENTITY_INSERT [dbo].[ServiceReferences] ON

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (1, N'Windows Virtual Machines Documentation', N'Official Documentation', N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/', N'Official Documentation for Windows Virtual Machines', 1)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (2, N'Linux Virtual Machines Documentation', N'Official Documentation', N'https://docs.microsoft.com/en-us/azure/virtual-machines/linux/', N'Official Documentation for Linux Virtual Machines', 1)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (3, N'SQL Server Replication to Azure', N'Official Documentation', N'https://docs.microsoft.com/en-us/sql/relational-databases/replication/sql-server-replication?view=sql-server-2017', N'Official Documentation for SQL Server Replication', 1)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (4, N'Introduction to Azure managed disks', N'Concepts', N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/managed-disks-overview', N'Official Documentation', 2)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (5, N'N/A', NULL, NULL, NULL, 3)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (6, NULL, NULL, NULL, NULL, 4)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (7, NULL, NULL, NULL, NULL, 5)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (8, NULL, NULL, NULL, NULL, 6)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (9, NULL, NULL, NULL, NULL, 7)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (10, NULL, NULL, NULL, NULL, 8)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (11, NULL, NULL, NULL, NULL, 9)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (12, NULL, NULL, NULL, NULL, 10)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (13, NULL, NULL, NULL, NULL, 11)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (14, NULL, NULL, NULL, NULL, 12)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (15, NULL, NULL, NULL, NULL, 13)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (16, NULL, NULL, NULL, NULL, 14)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (17, NULL, NULL, NULL, NULL, 15)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (18, NULL, NULL, NULL, NULL, 16)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (19, NULL, NULL, NULL, NULL, 17)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (20, NULL, NULL, NULL, NULL, 18)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (21, NULL, NULL, NULL, NULL, 19)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (22, NULL, NULL, NULL, NULL, 20)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (23, NULL, NULL, NULL, NULL, 21)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (24, NULL, NULL, NULL, NULL, 22)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (25, NULL, NULL, NULL, NULL, 23)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (26, NULL, NULL, NULL, NULL, 24)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (27, NULL, NULL, NULL, NULL, 25)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (28, NULL, NULL, NULL, NULL, 26)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (29, NULL, NULL, NULL, NULL, 27)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (30, NULL, NULL, NULL, NULL, 28)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (31, NULL, NULL, NULL, NULL, 28)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (32, NULL, NULL, NULL, NULL, 30)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (33, NULL, NULL, NULL, NULL, 29)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (34, NULL, NULL, NULL, NULL, 31)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (35, NULL, NULL, NULL, NULL, 32)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (36, NULL, NULL, NULL, NULL, 33)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (37, NULL, NULL, NULL, NULL, 34)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (38, NULL, NULL, NULL, NULL, 35)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (39, NULL, NULL, NULL, NULL, 36)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (40, NULL, NULL, NULL, NULL, 37)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (41, N'Azure Service Bus Messaging Documentation', N'Official Documentation', N'https://docs.microsoft.com/en-us/azure/service-bus-messaging/', N'Learn how to use Azure Service Bus messaging services to send and receive messages to and from queues, and publish and subscribe for messages using topics and subscriptions.', 38)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (42, NULL, NULL, NULL, NULL, 39)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (43, NULL, NULL, NULL, NULL, 40)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (44, NULL, NULL, NULL, NULL, 41)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (45, NULL, NULL, NULL, NULL, 42)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (46, NULL, NULL, NULL, NULL, 43)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (47, NULL, NULL, NULL, NULL, 44)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (48, NULL, NULL, NULL, NULL, 45)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (49, NULL, NULL, NULL, NULL, 46)

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID])
VALUES (50, NULL, NULL, NULL, NULL, 47)

SET IDENTITY_INSERT [dbo].[ServiceReferences] OFF
SET IDENTITY_INSERT [dbo].[Solution] ON

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (1, N'SQL Replication to Azure VM', N'Use SQL Server Replication to copy data to an Azure Virtual Machine.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (2, N'Backup to Azure', N'Backup using standard T-SQL statements to Azure Storage. Has the ability to be triple-redundancy, and have global copies, or keep in a single Region. Or Backup using Azure Backup.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (3, N'Azure Site Recovery', NULL)

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (4, N'Availability Group Replica', N'Synchronize data between SQL on Windows to Azure Managed Instance  through a vnet. Allows clusterless async replica between Linux and Azure MI.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (5, N'SQL Server 2019 Big Data Clusters', N'Allows large-scale MPP data and Spark processing.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (6, N'Storage appliance', N'A full Hiearchical Storage Management (HMS) solution. Provides multiple automatic benefits.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (7, N'Copy data using a gateway', N'The Azure Data Factory has the ability to establish a gateway with SQL Server and move data to any number of "sinks", or destinations.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (8, N'SQL Server 2019', N'SQL Server 2019 has the ability to run on Windows, linux, in Containers and Kubernetes, and can act as a Data Hub using PolyBase. It also contains numerous security and performance enhancements, some with no code-change.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (9, N'SQL Server Virtual Machines', N'SQL Server VM''s are a full Instance of SQL Server running in Azure. You can bring your own license or rent one, and there are multiple sizes.')

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription])
VALUES (10, N'Azure Service Bus', N'Use the SQL Server Service Broker, along with the Azure Service Bus to create a full re-active messaging system')

SET IDENTITY_INSERT [dbo].[Solution] OFF
SET IDENTITY_INSERT [dbo].[SolutionReferences] ON

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (1, N'Tutorial', N'Using a VPN with Replication', N'', 1, N'https://docs.microsoft.com/en-us/sql/relational-databases/replication/publish-data-over-the-internet-using-vpn?view=sql-server-2017')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (5, N'Official Documentation', N'SQL Server Backup and Restore with Microsoft Azure Blob Storage Service', N'', 2, N'https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-microsoft-azure-blob-storage-service?view=sql-server-2017')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (6, N'Official Documentation', N'Site Recovery General Information', N'', 3, N'https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-overview')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (7, N'Tutorials and Guidelines', N'SQL Server Always On availability groups on Azure virtual machines', N'', 4, N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-availability-group-overview')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (8, N'Official Documentation', N'Using Azure AKS for SQL Server 2019 BDC', N'', 5, N'https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-on-aks?view=sqlallproducts-allversions')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (9, N'Official Documentation', N'Azure Data Box Overview', N'', 6, N'https://docs.microsoft.com/en-us/azure/databox/data-box-overview')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (10, N'Tutorial', N'Copy data to and from SQL Server using Azure Data Factory', N'', 7, N'https://docs.microsoft.com/en-us/azure/data-factory/connector-sql-server')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (11, N'Overview', N'What''s new in SQL Server 2019', N'', 8, N'https://docs.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-ver15?view=sqlallproducts-allversions')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (12, N'Qucikstart', N'Create a SQL Server 2017 Windows virtual machine in the Azure portal', N'', 9, N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/quickstart-sql-vm-create-portal')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (13, N'Workshop', N'SQL Server 2019 big data clusters workshop', N'', 5, N'https://aka.ms/sqlworkshops')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (14, N'Cost Estimate', N'Cost Estimate', N'Shows a general cost estimate of a basic version of this solution; can be customized', 6, N'https://azure.com/e/dfed0eefb9774aa681478cf2061d4f27')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (15, N'Concepts', N'When to use Service Broker in SQL Server', NULL, 10, N'https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-service-broker?view=sql-server-2017')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (16, N'Whitepaper', N'Designing a Modern Service Architecture for the Cloud', N'Whitepaper of various options for A SOA', 10, N'https://www.microsoft.com/en-us/itshowcase/designing-a-modern-service-architecture-for-the-cloud')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (17, N'Whitepaper', N'Service Oriented Database Architecture', N'Older whitepaper on using Service Broker, but concepts and code are still valid.', 10, N'https://www.microsoft.com/en-us/research/wp-content/uploads/2005/09/tr-2005-129.pdf ')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (18, N'Blog', N'Data Integration Design Patterns With Microservices', N'SOA is related to Microservices in many ways - this official blog entry shows more detail on that design.', 10, N'https://blogs.technet.microsoft.com/cansql/2016/12/05/data-integration-design-patterns-with-microservices/')

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation])
VALUES (19, N'Official Documentation', N'Choose between Azure messaging services - Event Grid, Event Hubs, and Service Bus', N'This article describes the differences between these services, and helps you understand which one to choose for your application. In many cases, the messaging services are complementary and can be used together.', 10, N'https://docs.microsoft.com/en-us/azure/event-grid/compare-messaging-services?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fservice-bus-messaging%2FTOC.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json')

SET IDENTITY_INSERT [dbo].[SolutionReferences] OFF
SET IDENTITY_INSERT [dbo].[SolutionToService] ON

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (1, 1, 1, N'Low', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (2, 1, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (3, 2, 2, N'Low', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (4, 2, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (5, 3, 40, N'Medium', N'Medium')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (6, 3, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (7, 4, 1, N'Low', N'Medium')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (8, 4, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (9, 5, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (10, 5, 2, N'Low', N'Medium')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (11, 5, 3, N'Medium', N'High')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (12, 5, 5, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (13, 5, 19, N'Low', N'Medium')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (14, 6, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (15, 6, 43, N'Low', N'High')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (16, 6, 2, N'Low', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (17, 7, 13, N'Medium', N'Medium')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (18, 8, 1, N'Low', N'Medium')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (19, 8, 5, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (20, 8, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (21, 9, 44, N'Medium', N'Low')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (22, 9, 1, N'Medium', N'High')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (23, 9, 2, N'Low', N'Medium')

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost])
VALUES (24, 10, 38, N'High', N'Low')

SET IDENTITY_INSERT [dbo].[SolutionToService] OFF
SET ANSI_PADDING ON
GO

ALTER TABLE [dbo].[sysdiagrams] ADD CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED ([principal_id] ASC, [name] ASC)
	WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProblemToSolution]
	WITH NOCHECK ADD CONSTRAINT [FK_ProblemToSolution_Problem] FOREIGN KEY ([SolutionID]) REFERENCES [dbo].[Problem]([ProblemID])
GO

ALTER TABLE [dbo].[ProblemToSolution] CHECK CONSTRAINT [FK_ProblemToSolution_Problem]
GO

ALTER TABLE [dbo].[ProblemToSolution]
	WITH CHECK ADD CONSTRAINT [FK_ProblemToSolution_Solution] FOREIGN KEY ([ProblemID]) REFERENCES [dbo].[Solution]([SolutionID])
GO

ALTER TABLE [dbo].[ProblemToSolution] CHECK CONSTRAINT [FK_ProblemToSolution_Solution]
GO

ALTER TABLE [dbo].[ServiceReferences]
	WITH CHECK ADD CONSTRAINT [FK_ServiceReferences_AzureService] FOREIGN KEY ([AzureServiceID]) REFERENCES [dbo].[AzureService]([AzureServiceID])
GO

ALTER TABLE [dbo].[ServiceReferences] CHECK CONSTRAINT [FK_ServiceReferences_AzureService]
GO

ALTER TABLE [dbo].[SolutionReferences]
	WITH CHECK ADD CONSTRAINT [FK_SolutionReferences_Solution1] FOREIGN KEY ([SolutionID]) REFERENCES [dbo].[Solution]([SolutionID])
GO

ALTER TABLE [dbo].[SolutionReferences] CHECK CONSTRAINT [FK_SolutionReferences_Solution1]
GO

ALTER TABLE [dbo].[SolutionToService]
	WITH CHECK ADD CONSTRAINT [FK_SolutionToService_AzureService] FOREIGN KEY ([AzureServiceID]) REFERENCES [dbo].[AzureService]([AzureServiceID])
GO

ALTER TABLE [dbo].[SolutionToService] CHECK CONSTRAINT [FK_SolutionToService_AzureService]
GO

ALTER TABLE [dbo].[SolutionToService]
	WITH CHECK ADD CONSTRAINT [FK_SolutionToService_Solution] FOREIGN KEY ([SolutionID]) REFERENCES [dbo].[Solution]([SolutionID])
GO

ALTER TABLE [dbo].[SolutionToService] CHECK CONSTRAINT [FK_SolutionToService_Solution]
GO

ALTER DATABASE [solutions]

SET READ_WRITE
GO

/* Optional: Backup to Azure */
USE master;
GO

/* https://www.sqlnethub.com/blog/how-to-backup-sql-server-database-from-on-premises-to-azure-storage/

CREATE CREDENTIAL AzureBlob
	WITH IDENTITY = 'yoursaaccountname', SECRET = 'SuperSecretKey';
GO

BACKUP DATABASE [solutions] TO URL = 'https://yoursaaccountname.blob.core.windows.net/sqlserver/solutions.bak'
WITH CREDENTIAL = 'AzureBlob', FORMAT;
GO

RESTORE DATABASE solutions
FROM URL = 'https://bwsa.blob.core.windows.net/sqlserver/solutions.bak' WITH CREDENTIAL = 'AzureBlob'
	--, MOVE 'solutions' TO 'c:\temp\solutions.mdf'
	--, MOVE 'solutions_log' TO 'c:\temp\solutions.ldf'
	, REPLACE;
GO
*/

-- EOF: solutions_database_script.sql