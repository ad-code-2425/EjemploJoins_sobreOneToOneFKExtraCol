USE [instituto]
GO
/****** Object:  Table [dbo].[comunidadAutonoma]    Script Date: 24/01/2023 16:17:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'dbo.comunidadAutonoma', N'U') IS  NULL
BEGIN
	CREATE TABLE [dbo].[comunidadAutonoma](
		[idCA] [int] NOT NULL,
		[nombre] [varchar](100) NOT NULL,
	 CONSTRAINT [PK_comunidadAutonoma] PRIMARY KEY CLUSTERED 
	(
		[idCA] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[provincia]    Script Date: 24/01/2023 16:17:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'dbo.provincia', N'U') IS  NULL
BEGIN
	CREATE TABLE [dbo].[provincia](
		[idProvincia] [int] NOT NULL,
		[nombre] [varchar](100) NOT NULL,
		[idCA] [int] NOT NULL,
	 CONSTRAINT [PK__municipi__FD10E40056191BA5] PRIMARY KEY CLUSTERED 
	(
		[idProvincia] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	
	ALTER TABLE [dbo].[provincia] ADD  CONSTRAINT [DF__municipio__codPr__6FE99F9F]  DEFAULT (NULL) FOR [nombre]
	
	ALTER TABLE [dbo].[provincia] ADD  CONSTRAINT [DF__municipio__codMu__70DDC3D8]  DEFAULT (NULL) FOR [idCA]
	
	ALTER TABLE [dbo].[provincia]  WITH CHECK ADD  CONSTRAINT [FK_provincia_CA] FOREIGN KEY([idCA])
	REFERENCES [dbo].[comunidadAutonoma] ([idCA])
	
	ALTER TABLE [dbo].[provincia] CHECK CONSTRAINT [FK_provincia_CA]
	
END
GO

/****** Object:  Table [dbo].[direccion]    Script Date: 24/01/2023 16:17:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'dbo.direccion', N'U') IS  NULL
BEGIN
	CREATE TABLE [dbo].[direccion](
		[id] [int] IDENTITY(1,1) NOT NULL,
		[calle] [varchar](255) NULL,
		[numero] [int] NULL,
		[poblacion] [varchar](255) NULL,
		[idProvincia] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	ALTER TABLE [dbo].[direccion] ADD  DEFAULT (NULL) FOR [calle]
	
	ALTER TABLE [dbo].[direccion] ADD  DEFAULT (NULL) FOR [numero]
	
	ALTER TABLE [dbo].[direccion] ADD  DEFAULT (NULL) FOR [poblacion]
	

	
END

IF (OBJECT_ID('dbo.FK_direccion_provincia', 'F') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[direccion] DROP CONSTRAINT [FK_direccion_provincia]
END
ELSE
BEGIN
	ALTER TABLE [dbo].[direccion]  WITH CHECK ADD  CONSTRAINT [FK_direccion_provincia] FOREIGN KEY([idProvincia])
	REFERENCES [dbo].[provincia] ([idProvincia])
END

GO
/****** Object:  Table [dbo].[modulo]    Script Date: 24/01/2023 16:17:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'dbo.modulo', N'U') IS  NULL
BEGIN
	CREATE TABLE [dbo].[modulo](
		[idModulo] [int] IDENTITY(1,1) NOT NULL,
		[nombre] [varchar](255) NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[idModulo] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[profesormodulo]    Script Date: 24/01/2023 16:17:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'dbo.profesormodulo', N'U') IS  NULL
BEGIN
	CREATE TABLE [dbo].[profesormodulo](
		[idProfesor] [int] NOT NULL,
		[idModulo] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[idModulo] ASC,
		[idProfesor] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	
	ALTER TABLE [dbo].[profesormodulo]  WITH CHECK ADD  CONSTRAINT [FK_profesormodulo_modulo] FOREIGN KEY([idModulo])
	REFERENCES [dbo].[modulo] ([idModulo])
	
	ALTER TABLE [dbo].[profesormodulo] CHECK CONSTRAINT [FK_profesormodulo_modulo]
	
	ALTER TABLE [dbo].[profesormodulo]  WITH CHECK ADD  CONSTRAINT [FK_profesormodulo_profesor] FOREIGN KEY([idProfesor])
	REFERENCES [dbo].[profesor] ([Id])
	
	ALTER TABLE [dbo].[profesormodulo] CHECK CONSTRAINT [FK_profesormodulo_profesor]
	
END
GO
