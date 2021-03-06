USE [master]
GO
/****** Object:  Database [GymApp]    Script Date: 4/25/2016 3:04:17 PM ******/
CREATE DATABASE [GymApp]
GO
ALTER DATABASE [GymApp] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GymApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GymApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GymApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GymApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GymApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GymApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [GymApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GymApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GymApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GymApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GymApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GymApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GymApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GymApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GymApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GymApp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GymApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GymApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GymApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GymApp] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [GymApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GymApp] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [GymApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GymApp] SET RECOVERY FULL 
GO
ALTER DATABASE [GymApp] SET  MULTI_USER 
GO
ALTER DATABASE [GymApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GymApp] SET DB_CHAINING OFF 
GO
USE [GymApp]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 4/25/2016 3:04:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Exercises]    Script Date: 4/25/2016 3:04:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exercises](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_dbo.Exercises] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ExerciseSets]    Script Date: 4/25/2016 3:04:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExerciseSets](
	[Id] [uniqueidentifier] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[ExerciseId] [uniqueidentifier] NOT NULL,
	[WorkoutId] [uniqueidentifier] NOT NULL,
	[WorkoutSessionId] [uniqueidentifier] NOT NULL,
	[Weight] [float] NULL,
	[Unit] [int] NOT NULL,
	[SerialNumber] [int] NULL,
	[NumberOfRepetitions] [int] NULL,
 CONSTRAINT [PK_dbo.ExerciseSets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[WorkoutExercises]    Script Date: 4/25/2016 3:04:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkoutExercises](
	[Workout_Id] [uniqueidentifier] NOT NULL,
	[Exercise_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dbo.WorkoutExercises] PRIMARY KEY CLUSTERED 
(
	[Workout_Id] ASC,
	[Exercise_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Workouts]    Script Date: 4/25/2016 3:04:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Workouts](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_dbo.Workouts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[WorkoutSessions]    Script Date: 4/25/2016 3:04:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkoutSessions](
	[Id] [uniqueidentifier] NOT NULL,
	[DateStart] [datetime2](7) NOT NULL,
	[DateEnd] [datetime2](7) NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_dbo.WorkoutSessions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'b475f58c-7671-f740-8b4e-01a6e18f5f13', N'Have a lunch', CAST(N'2016-03-29 10:28:23.3482245' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'Back 1', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'45aa9981-4e98-7f8b-e559-05548131ea85', N'Lunges', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'1c98a752-8d7c-2f8e-e6f0-08627ed2a1ba', N'play  mortal kombat', CAST(N'2016-03-30 10:17:42.1977203' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'f7c85d9a-9857-5922-c285-0babfafe5059', N'Side leg press', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'9c7d5692-7d94-f61d-3875-0ec4cce9852f', N'eat', CAST(N'2016-03-30 10:17:42.1977203' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'4e6466c8-a4d7-a920-99d1-1428df760d17', N'Watch Flash', CAST(N'2016-03-28 07:52:07.7550845' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'4efde001-d741-e195-0db9-1e24b7fcd72d', N'Bench Press On a Sofa', CAST(N'2016-03-28 07:48:41.7874628' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'Good morning', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'43d295b0-8448-b01e-0548-25646a6c4cb1', N'Back 4', CAST(N'2016-04-23 08:59:13.2275925' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'f5ef2a47-691b-c04a-e9bf-26dd13cdf531', N'Drink coffee', CAST(N'2016-03-28 08:36:13.4731022' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'27f2be72-0d24-71ce-422a-2c3abf5112c6', N'Eat', CAST(N'2016-03-30 09:40:47.7930664' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'69bb2158-d6f0-6818-3d8b-2f1f5570b8ed', N'🙆', CAST(N'2016-03-28 07:30:50.4463478' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'4ddedb77-9809-0951-8933-2fea6d89518d', N'💀💩', CAST(N'2016-03-28 07:30:50.4463478' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'e1460956-c4ee-b4d5-27b3-32aa4bf88280', N'Squats', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'Hypertension', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'fcaa8c99-ee5b-8f97-8ed2-3a7d3d162343', N'Go home🚗🏡', CAST(N'2016-03-28 09:18:12.2584588' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'DB incline bench press', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'72dc5bb0-984d-25c4-95c6-3e0f686339ff', N'test', CAST(N'2016-03-28 21:39:51.0991735' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'07e81ade-bc5c-47f7-bcf9-428304e8edcb', N'Жим лежа', CAST(N'2016-04-01 08:23:34.9090448' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'214be655-3fae-3022-0c21-496c17be3bd7', N'Abductor up', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'0ddab7e3-8841-c080-4be4-5a70827ac453', N'Жим лёжа на боку', CAST(N'2016-03-28 06:25:30.7862446' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'46b0c025-c158-58ac-5719-5b23d300c312', N'Leg press', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'0e438fb5-04ab-be16-ed30-6376f8041bc9', N'work', CAST(N'2016-03-30 10:17:42.1977203' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'Do some work', CAST(N'2016-03-28 08:36:13.4574552' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'92b1fe2e-5663-9586-137d-6874e51a194b', N'🙇', CAST(N'2016-03-28 07:30:50.4463478' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'b1588044-e602-8425-252d-6bb1b6482090', N'Back 3', CAST(N'2016-04-18 03:37:29.7552945' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'cdb0fb40-6fb0-1ee8-154a-78b479130ac5', N'Do some work', CAST(N'2016-03-29 10:28:23.3482245' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'cb72b385-1b2c-2f72-75a5-7dae635e6056', N'go home', CAST(N'2016-03-30 10:17:42.1977203' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'bac1dce4-8c9c-9a4f-8ab2-7ee930ce7170', N'Жим лёжа на правом боку', CAST(N'2016-03-28 06:25:30.7862446' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'a0103534-4061-3e51-fe84-85dcf28deb69', N'DB front hammer lift', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'86ea0502-d7fa-2acc-6713-87f0257be240', N'Leg extension', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'3549b786-96a0-6a19-50ce-8834417dea63', N'Гантели', CAST(N'2016-04-01 08:23:34.9090448' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'024adda4-9dd3-06df-c34b-8e06bc5a8e02', N'Take a Breakfast', CAST(N'2016-03-28 07:52:07.7550845' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'Triceps dips', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'a886f5b9-dad1-b155-2b80-9a6900936de0', N'Go home', CAST(N'2016-03-28 08:36:13.4731022' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'0a9b8793-e356-3794-8484-a92a42a50901', N'🙅', CAST(N'2016-03-28 07:30:50.4463478' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'667d84f5-8a53-8dab-3192-ab8f8d0e386e', N'Жим лёжа', CAST(N'2016-03-28 06:25:30.7862446' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'd6e02221-5ac7-b8dd-e93e-b0ff70001d1a', N'💪', CAST(N'2016-03-28 07:30:50.4463478' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'DB bent over rear delt raise', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'8c6a9eea-e44c-1ba8-56d9-b6aa9c6893dd', N'Take some coffee', CAST(N'2016-03-29 10:28:23.3482245' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'5d61c9c4-4e31-9fff-8af8-ba79600bc779', N'Smoke hookah', CAST(N'2016-03-29 10:28:23.3482245' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'DB lateral raise', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'83e6872a-7f9c-2971-af3a-beb40c62b1ce', N'Bench Press On a Couch', CAST(N'2016-03-28 07:48:41.7874628' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'684722a1-84de-4fab-9abc-ceb86253d37c', N'Watch Good Wife', CAST(N'2016-03-28 07:52:07.7550845' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'5d727a7d-68f0-47f0-bc36-dd0cab5cc483', N'Work', CAST(N'2016-03-30 09:40:47.7930664' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'330502be-4119-6e0d-dfd1-de17bb26962a', N'Watch Big Bang Theory', CAST(N'2016-03-28 07:52:07.7550845' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'27e62cbb-6554-8e66-2fb4-de850845a8de', N'Dead lift', CAST(N'2016-04-09 05:08:14.1711367' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'940b7c61-207e-8653-135f-ec1e463327e9', N'Go home', CAST(N'2016-03-30 09:40:47.7930664' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'e875a929-0490-2173-215c-ed57a396c2cb', N'Bench Press On a Bed', CAST(N'2016-03-28 07:48:41.7874628' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'a60f1582-f1c7-53cc-c078-ed5afbed0c80', N'Drink coffee☕', CAST(N'2016-03-28 09:18:12.2584588' AS DateTime2))
INSERT [dbo].[Exercises] ([Id], [Name], [DateCreated]) VALUES (N'0aa607a9-838c-d043-f2fa-fcb7e37a5ff2', N'Back 2', CAST(N'2016-04-07 18:37:48.5276932' AS DateTime2))
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e79efac8-b1a8-8b2e-92a4-00c287b4878d', CAST(N'2016-04-12 02:38:30.5700000' AS DateTime2), N'e1460956-c4ee-b4d5-27b3-32aa4bf88280', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 40, 0, 2, 7)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'fbe35051-ee1a-8144-64b9-010e63bab636', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 100, 0, 3, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'62bc2db8-9539-7f1a-9dc3-032aa1597458', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'5757f43c-1c41-46b4-1ed6-ac159d3226d2', 1456852, 0, 1, 2)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'031a75eb-edd4-4988-09de-059fe709bd69', CAST(N'2016-04-10 09:27:11.4190000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 20, 0, 1, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'5b08555f-c1dd-d272-ce51-06b30bad542e', CAST(N'2016-04-12 02:51:18.2890000' AS DateTime2), N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 30, 0, 1, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'380f6e94-0b04-f224-e67f-072f2f9c1f02', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 20, 0, 3, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'5f2d65d0-b98f-f174-aae4-0865686adbdb', CAST(N'2016-04-23 09:04:07.1160000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 2, 0, 2, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'630cd8bc-a407-a0a2-7ebc-08f913dcb300', CAST(N'2016-04-24 09:17:27.6160000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 90, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'9ef425e4-cbb3-8356-2afe-11469be87270', CAST(N'2016-04-09 07:27:49.5520000' AS DateTime2), N'46b0c025-c158-58ac-5719-5b23d300c312', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 85, 0, 1, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e525c99e-14ee-49bc-1c8a-13952fe0d7a3', CAST(N'2016-04-10 10:07:16.5060000' AS DateTime2), N'0aa607a9-838c-d043-f2fa-fcb7e37a5ff2', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'e857ab12-ada7-76d2-aa02-b98c30ed06e2', 25, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'96f627b3-2a72-73e8-495d-13d9f16d904b', CAST(N'2016-04-23 08:59:20.5540000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 3, 0, 5, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e702dffa-d8f9-8e9c-2ab9-18ba87ada123', CAST(N'2016-04-18 02:57:30.8150000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'6b44f55d-f978-4510-5182-a4dc14f4e633', 20, 0, 1, 7)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'33f0f9af-317b-298b-e957-18cf8324384b', CAST(N'2016-04-18 03:36:55.5880000' AS DateTime2), N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 10, 0, 0, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'7a9efeac-97a3-001a-50e4-19fffbd3edd0', CAST(N'2016-04-23 08:26:37.5170000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 1, 0, 1, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'a429f57b-4a03-e2d3-3d06-1afb4aa4f1e4', CAST(N'2016-04-24 09:52:25.7150000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 30, 0, 2, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'b2dec2db-cd4f-078d-0512-1bd0d4c5524c', CAST(N'2016-04-12 02:36:49.7420000' AS DateTime2), N'e1460956-c4ee-b4d5-27b3-32aa4bf88280', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 20, 0, 3, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'54a74b2f-3f7c-43f7-cf99-1c70113d1e09', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 1, 0, 2, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'787b7deb-7e1f-cdf6-e666-1c7dab196294', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 3, 0, 2, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'd64e7900-38f5-9890-fd8b-1db2b43d2861', CAST(N'2016-04-18 03:38:12.1780000' AS DateTime2), N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 12.5, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'b9578b20-babd-117c-9ea8-20ff13389b24', CAST(N'2016-04-24 09:46:53.8350000' AS DateTime2), N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 20, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'572b782c-c2e3-f099-6d5b-214bee504f88', CAST(N'2016-04-23 08:37:27.8710000' AS DateTime2), N'0aa607a9-838c-d043-f2fa-fcb7e37a5ff2', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 20, 0, 7, 14)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'6e321636-6d85-7342-b07d-236baa88802e', CAST(N'2016-04-10 10:09:43.4890000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'e857ab12-ada7-76d2-aa02-b98c30ed06e2', 3, 0, 5, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e1ad85aa-2922-1d62-776d-26eb1bd53e3b', CAST(N'2016-04-18 02:57:27.7980000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'6b44f55d-f978-4510-5182-a4dc14f4e633', 20, 0, 2, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'ac899a01-a1e5-58c4-e8c2-27c7c18b36ab', CAST(N'2016-04-24 09:50:07.5830000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 30, 0, 6, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'ebf569cd-c500-c31b-6dcc-2b55fabbea45', CAST(N'2016-04-23 08:18:59.7020000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 3, 0, 3, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'84f66c0d-202a-6bc6-7bed-2b7cb960f336', CAST(N'2016-04-24 10:34:36.2300000' AS DateTime2), N'214be655-3fae-3022-0c21-496c17be3bd7', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 50, 0, 2, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'07756be4-b605-b1d4-932b-2f666a51e1d8', CAST(N'2016-04-23 08:08:26.4270000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 20, 0, 2, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'cdaf76d7-12f8-1742-0f94-2ffe176dec0a', CAST(N'2016-04-12 03:06:49.3380000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 30, 0, 6, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'3c3e30b2-ae9c-bd78-5528-32a56cc6eb02', CAST(N'2016-04-10 19:45:36.5510000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'8f069918-33bb-ff9e-241b-b03c88509b41', N'de92864a-417c-8fb2-d84c-e5194d351d60', 1, 0, 0, 2)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'1b0ff2af-1975-6bed-4126-345549c81531', CAST(N'2016-04-10 21:07:12.1420000' AS DateTime2), N'4e6466c8-a4d7-a920-99d1-1428df760d17', N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'6996ad3e-2aef-fa61-cf1b-0fc4cc0847c4', 5, 0, 5, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'56429d90-935f-87ea-aded-359857e3edf0', CAST(N'2016-04-10 21:07:04.5930000' AS DateTime2), N'330502be-4119-6e0d-dfd1-de17bb26962a', N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'6996ad3e-2aef-fa61-cf1b-0fc4cc0847c4', 5, 0, 3, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f5335432-1cf1-6cb8-0f06-367d9bd815cd', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 15, 0, 2, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'b8aadbbe-9271-0f02-2726-3a75270bd8cf', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 9, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'629c0f4b-2f5b-3f4f-daf9-3e687ceed36f', CAST(N'2016-04-23 08:31:21.4700000' AS DateTime2), N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 5, 0, 1, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'96b7d025-b75c-2acb-17ac-3faef747bc06', CAST(N'2016-04-18 03:08:47.0520000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 1, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'a0c0bc2a-8245-0b6a-0763-41aececcb5b9', CAST(N'2016-04-18 03:08:44.6660000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 3, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'3664da77-7818-666a-1e96-44a18b989e31', CAST(N'2016-04-24 09:31:42.5510000' AS DateTime2), N'27e62cbb-6554-8e66-2fb4-de850845a8de', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 40, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'c2fa3a94-d93c-cfe5-2e29-44d07e137118', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 35, 0, 2, 11)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'd6aef607-dc11-78fd-6741-4537e40acb56', CAST(N'2016-04-10 10:12:04.3220000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'e857ab12-ada7-76d2-aa02-b98c30ed06e2', 3, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'ef0665f2-3bbe-bbb0-d60f-4814ab7cab1c', CAST(N'2016-04-12 09:01:51.6800000' AS DateTime2), N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'a6f06d81-815b-953a-1e82-d0eac8f03099', 1, 0, 0, 1)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'a19219cf-e9db-71be-26cb-48b96c30abbf', CAST(N'2016-04-12 08:56:38.8780000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'4fc29a8f-207d-7716-bec1-bac1266c630d', 6, 0, 1, 5)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e4331736-fbfc-34aa-625f-4d4fed027820', CAST(N'2016-04-09 07:25:47.0860000' AS DateTime2), N'46b0c025-c158-58ac-5719-5b23d300c312', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 70, 0, 5, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'1397be1b-16fd-4303-a39d-4de54369c28c', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 3, 0, 2, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'3da090aa-93d2-076d-c484-4f40837babee', CAST(N'2016-04-10 21:06:21.5250000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'b3099d27-6ee7-ee22-a324-9a697ae85447', 5, 0, 0, 6)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'a684d010-f4af-366f-0103-5044157f0ca7', CAST(N'2016-04-10 09:37:07.9000000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 3, 0, 3, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'11440e54-24d8-e8c1-d310-50e86dc10530', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 12.5, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'99ef8863-d6e3-8d0f-f190-52ae5d39bb3d', CAST(N'2016-04-24 10:00:08.8570000' AS DateTime2), N'214be655-3fae-3022-0c21-496c17be3bd7', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 45, 0, 4, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'd3a0d784-ecf0-aa6a-76bb-553c2872a46f', CAST(N'2016-04-23 08:22:03.2110000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 3, 0, 1, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'19b752ed-9002-6eaf-9d2d-56d2188c5b5b', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'dc83f8c3-f209-3eaf-0d4d-65d0f85ce3e5', 9, 0, 2, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'ea0cfd6a-1fef-586a-0255-56d9a7e20700', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 30, 0, 2, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f265c776-3b63-cd6a-4fe2-579f364c34c3', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 2, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'337413e9-5246-838e-71a6-5d85ac6a2b46', CAST(N'2016-04-12 02:51:57.3390000' AS DateTime2), N'27e62cbb-6554-8e66-2fb4-de850845a8de', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 40, 0, 1, 7)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f2b3706f-ec77-4410-dfee-5efd3c512af0', CAST(N'2016-04-10 09:43:59.7320000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 1, 0, 4, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'33d1a541-d62f-0fa8-e51d-64c42340c139', CAST(N'2016-04-09 07:44:50.4230000' AS DateTime2), N'f7c85d9a-9857-5922-c285-0babfafe5059', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 12.5, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'58ad9c72-7d61-90b8-a18e-66d4538abd96', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 20, 0, 2, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'ce92b0a0-dd94-de2f-8f27-69e2727ec345', CAST(N'2016-04-10 10:01:44.4340000' AS DateTime2), N'0aa607a9-838c-d043-f2fa-fcb7e37a5ff2', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'e857ab12-ada7-76d2-aa02-b98c30ed06e2', 20, 0, 7, 14)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'b29b5454-653b-b88d-f66f-707720ee5935', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 2, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'2ebd0426-3930-b3c4-e5f3-71dee0a75115', CAST(N'2016-04-12 03:08:25.8540000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 30, 0, 1, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'13891e7b-c03a-7d4e-6066-724d459b6a0c', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 5, 0, 1, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'43645584-e942-5de2-6348-72c40388d403', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'43d295b0-8448-b01e-0548-25646a6c4cb1', N'7755999f-9d26-1497-4e1e-ca8ef281b127', N'0b7934bb-cd82-e85d-7e7f-547f2b5fb411', 15, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'265221ad-d0e1-4ff1-7905-7424e0c305bd', CAST(N'2016-04-24 09:14:02.4660000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 70, 0, 0, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'8ba0a54e-8212-bbfa-0279-7af07d31e634', CAST(N'2016-04-12 08:56:41.7350000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'4fc29a8f-207d-7716-bec1-bac1266c630d', 3, 0, 2, 3)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'44e574f1-3882-f408-1afb-7cfdea2208fe', CAST(N'2016-04-10 09:48:20.7760000' AS DateTime2), N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 5, 0, 1, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'bcbafca4-9a63-ae0b-f533-7dcbd2af83cd', CAST(N'2016-04-09 07:51:44.0340000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 30, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'5c80018c-0b9b-5f07-c233-7e0e3371233c', CAST(N'2016-04-24 09:54:18.7600000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 30, 0, 3, 11)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'cc4d12ca-8701-4d99-52e2-7e756b1356f4', CAST(N'2016-04-18 03:44:23.0670000' AS DateTime2), N'b1588044-e602-8425-252d-6bb1b6482090', N'90068f89-4a7d-5733-7e68-d8ad8b1ca9a4', N'e2bd49e1-830f-7ec5-7ab4-143821d2f9cc', 10, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'74b9cc88-328c-386d-1abe-812a0367c3cb', CAST(N'2016-04-24 09:50:10.5870000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 30, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'b3c0e806-8807-9cd7-53ce-81aa4a1a16d8', CAST(N'2016-04-23 08:56:33.2290000' AS DateTime2), N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 15, 0, 1, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'86c1d79c-721a-5e7d-e71a-832a17a00ad6', CAST(N'2016-04-24 09:47:04.4060000' AS DateTime2), N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 30, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'2663a385-abb5-72c2-8a99-835072819d8e', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 4, 0, 2, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'1faca763-0740-cb8d-0694-83981d1f2186', CAST(N'2016-04-10 09:37:10.5060000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 3, 0, 1, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e462201a-2601-a343-833e-858e5b1fc610', CAST(N'2016-04-18 03:08:56.3300000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 6, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'4f8e0cb6-5017-b761-67b6-86a7a24a1cd7', CAST(N'2016-04-12 02:51:13.8980000' AS DateTime2), N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 20, 0, 2, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'54f2e118-5fae-eeb1-1060-8aebf77b1f11', CAST(N'2016-04-23 09:05:57.6690000' AS DateTime2), N'43d295b0-8448-b01e-0548-25646a6c4cb1', N'7755999f-9d26-1497-4e1e-ca8ef281b127', N'0b7934bb-cd82-e85d-7e7f-547f2b5fb411', 15, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'9e120e50-31dd-dee6-b88b-8b0c39edd817', CAST(N'2016-04-09 07:44:44.2650000' AS DateTime2), N'f7c85d9a-9857-5922-c285-0babfafe5059', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 10, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'918e617d-39c1-b1c0-f063-8d70a8427f45', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 5, 0, 2, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'af2b37d3-dedb-b375-5795-91652f7e0424', CAST(N'2016-04-24 09:47:13.4400000' AS DateTime2), N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 40, 0, 3, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'3bdbcd9d-57ed-ce67-f272-91c47ceb1714', CAST(N'2016-04-24 10:03:28.1430000' AS DateTime2), N'214be655-3fae-3022-0c21-496c17be3bd7', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 50, 0, 1, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'53f541db-4533-c008-c679-92d2b8d61858', CAST(N'2016-04-12 03:05:11.3240000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 9, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'ef7659f2-13dd-0fb5-433d-9688f0ef0a1b', CAST(N'2016-04-24 09:19:49.6610000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 100, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'26f5ffff-c449-93cb-393a-9b95a7c4d905', CAST(N'2016-04-18 03:44:00.8610000' AS DateTime2), N'b1588044-e602-8425-252d-6bb1b6482090', N'90068f89-4a7d-5733-7e68-d8ad8b1ca9a4', N'e2bd49e1-830f-7ec5-7ab4-143821d2f9cc', 10, 0, 0, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'd3c08a30-bae1-f8b2-bbe5-9ed1977ffe43', CAST(N'2016-04-10 09:44:07.8640000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 1, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'02aabc2b-9d35-3e8a-c68c-a95c2427615a', CAST(N'2016-04-23 08:23:40.8660000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 1, 0, 4, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'69b8ed4b-954f-033a-6800-b0e3302644fe', CAST(N'2016-04-10 09:36:52.5450000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 3, 0, 1, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'6438c8f8-ee97-2c8a-7fb7-b1c1e697597d', CAST(N'2016-04-12 08:56:35.5650000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'4fc29a8f-207d-7716-bec1-bac1266c630d', 6, 0, 0, 6)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'21b0d191-bb92-be63-1424-b3d9a2c8d36a', CAST(N'2016-04-10 10:16:41.4690000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'e857ab12-ada7-76d2-aa02-b98c30ed06e2', 3, 0, 2, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'47355219-3055-191c-7f54-b500e9073ccd', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'0aa607a9-838c-d043-f2fa-fcb7e37a5ff2', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'e857ab12-ada7-76d2-aa02-b98c30ed06e2', 25, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'a630bdc8-69a8-8a66-78e5-b6799f401fb3', CAST(N'2016-04-09 07:46:36.1330000' AS DateTime2), N'86ea0502-d7fa-2acc-6713-87f0257be240', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 25, 0, 6, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f7045b33-65df-d8e9-0624-b725d19644d6', CAST(N'2016-04-09 07:30:08.8390000' AS DateTime2), N'46b0c025-c158-58ac-5719-5b23d300c312', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 100, 0, 2, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'4e8548b4-8af2-f3fc-e481-b88d19739430', CAST(N'2016-04-23 08:19:17.9990000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 3, 0, 6, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e3524ad5-a410-f376-0dd6-b8efd48081e0', CAST(N'2016-04-18 03:31:59.2300000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'bc77cb15-34df-e9b1-de99-bc0838addc11', CAST(N'2016-04-10 09:48:18.0660000' AS DateTime2), N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 5, 0, 1, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f0ab2a4c-96b6-de39-31cc-bca974ff37ae', CAST(N'2016-04-10 11:16:56.7400000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'60f99982-2c9d-094b-991c-966d47186fb7', 5, 0, 0, 6)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'916f0bda-dbaf-4274-8248-bd38c1e7af50', CAST(N'2016-04-10 09:36:48.5480000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 3, 0, 6, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'cca0ed33-1635-4a08-058c-be86831aa596', CAST(N'2016-04-23 08:22:11.6530000' AS DateTime2), N'a0103534-4061-3e51-fe84-85dcf28deb69', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 3, 0, 1, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'327468d3-ca8b-2690-2999-c05a4e1db361', CAST(N'2016-04-24 09:47:07.1710000' AS DateTime2), N'c1cf1f30-bbf2-f690-8594-216d4f963fa6', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 35, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'bd21851d-547e-e6c3-9108-c0ec954eb097', CAST(N'2016-04-12 03:05:07.9840000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 7, 0, 0, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'5f3163b2-9cac-7555-d3a0-cf07193aebe1', CAST(N'2016-04-12 02:36:57.6050000' AS DateTime2), N'e1460956-c4ee-b4d5-27b3-32aa4bf88280', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 30, 0, 1, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'dbd5cc10-4b5a-34d0-a61b-d021a1e00782', CAST(N'2016-04-18 03:08:59.1070000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 1, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'06892e92-37fe-583a-92ba-d04359cfe9a6', CAST(N'2016-04-10 21:05:49.6610000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'dc83f8c3-f209-3eaf-0d4d-65d0f85ce3e5', 6, 0, 1, 6)
GO
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'5610950b-2467-f743-9acd-d61cd29eeecb', CAST(N'2016-04-23 08:34:34.5780000' AS DateTime2), N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 5, 0, 1, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'bf376657-f7fd-d8dd-e12f-d7dbe00d0ef8', CAST(N'2016-04-18 03:15:19.9290000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 1, 0, 2, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'b8c7e634-552d-26ab-76e9-d8c109a4381a', CAST(N'2016-04-23 08:08:20.9840000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 20, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'324dc302-64b2-2622-ca50-d8ddd49ecb8d', CAST(N'2016-04-18 03:44:29.9640000' AS DateTime2), N'b1588044-e602-8425-252d-6bb1b6482090', N'90068f89-4a7d-5733-7e68-d8ad8b1ca9a4', N'e2bd49e1-830f-7ec5-7ab4-143821d2f9cc', 10, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'c4a5c498-3f69-2b34-d9ca-dcaea2aeb77a', CAST(N'2016-04-23 09:01:06.0290000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 2, 0, 1, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f45d9a4a-cb06-0b06-986f-dcbadddb72d3', CAST(N'2016-04-18 02:58:45.3220000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'6b44f55d-f978-4510-5182-a4dc14f4e633', 20, 0, 2, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'0cba6270-efa0-d1d4-6304-dd726e392f6a', CAST(N'2016-04-18 03:10:18.1590000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 1, 0, 4, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'0cd21b79-e785-e0b4-0509-ddb0630253d9', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'4c184ae8-b49f-2aed-7187-bdd1d5093416', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 3, 0, 2, 13)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'23b8b4e0-0213-47ed-b668-e479742c31c3', CAST(N'2016-04-10 09:44:03.6470000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 1, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'7c349a76-c4df-bc50-0089-e4ad907bf5c3', CAST(N'2016-04-18 03:18:17.2470000' AS DateTime2), N'0765cbfb-49e2-c33a-d33f-34c751a0e145', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 5, 0, 1, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'113c0152-01fa-35c9-12e9-e4ea5dbfc10c', CAST(N'2016-04-23 09:05:55.9890000' AS DateTime2), N'43d295b0-8448-b01e-0548-25646a6c4cb1', N'7755999f-9d26-1497-4e1e-ca8ef281b127', N'0b7934bb-cd82-e85d-7e7f-547f2b5fb411', 15, 0, 0, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'5a5f022b-c957-4dfa-14d0-e6d42cd1a74f', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'45aa9981-4e98-7f8b-e559-05548131ea85', N'd3396a00-c61c-e531-178e-32127637e368', N'e7c9c90c-eaec-b0b7-3943-1d682271baa5', 1, 0, 0, 1)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'4e0031c8-bff8-7c15-48ac-e8eabaa37b8d', CAST(N'2016-04-10 21:06:50.6630000' AS DateTime2), N'4efde001-d741-e195-0db9-1e24b7fcd72d', N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'6996ad3e-2aef-fa61-cf1b-0fc4cc0847c4', 6, 0, 0, 6)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'ec4efab0-18a2-2694-125f-e96facbfb44a', CAST(N'2016-04-18 03:31:56.0420000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 5, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'39d39a19-1ca6-ddb9-e35f-e9d1dc5bd16d', CAST(N'2016-04-23 08:08:23.8480000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 20, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'519d1266-e248-efff-17d2-ea4301579dd5', CAST(N'2016-04-09 07:37:08.9660000' AS DateTime2), N'46b0c025-c158-58ac-5719-5b23d300c312', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 100, 0, 3, 9)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'b1d96f62-c167-eb7c-c445-eb7e3aa34286', CAST(N'2016-04-10 11:17:00.4080000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'60f99982-2c9d-094b-991c-966d47186fb7', 6, 0, 1, 6)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'9e00f9e1-1025-52a5-a557-ec1ed6609e35', CAST(N'2016-04-23 08:50:34.2360000' AS DateTime2), N'c01ae525-c8bf-bb1c-4542-01d661023b5d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'129cd93b-7e78-6353-8275-2799fda25280', 10, 0, 0, 12)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f59d8905-81b8-32c2-ff0c-ed1e5d0e1140', CAST(N'2016-04-10 09:27:06.9460000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', 20, 0, 2, 8)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'2aa3162b-5435-b2df-ecfc-ed7d7ae88106', CAST(N'2016-04-24 09:29:08.4420000' AS DateTime2), N'27e62cbb-6554-8e66-2fb4-de850845a8de', N'd3396a00-c61c-e531-178e-32127637e368', N'8060755b-726b-8c43-b644-0fce50a9e2f7', 20, 0, 7, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'0fe45764-e957-256c-dc9a-f07719d2c664', CAST(N'2016-04-09 07:37:40.0670000' AS DateTime2), N'f7c85d9a-9857-5922-c285-0babfafe5059', N'd3396a00-c61c-e531-178e-32127637e368', N'47355556-428b-b134-6ea6-20145f0954b1', 5, 0, 1, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'f1eb5a44-a3c6-9be9-e12c-f3ccc79a233e', CAST(N'2016-04-12 02:50:57.5740000' AS DateTime2), N'e1460956-c4ee-b4d5-27b3-32aa4bf88280', N'd3396a00-c61c-e531-178e-32127637e368', N'052aba58-233b-789e-1195-6d356f9cbb13', 40, 0, 3, 6)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'fc5a8d26-a158-7c68-00c5-f65152d3d606', CAST(N'2016-04-10 11:17:04.6970000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'60f99982-2c9d-094b-991c-966d47186fb7', 4, 0, 2, 6)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'48b625ef-bab3-3559-759b-f947a6dc1f1c', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 3, 0, 2, 10)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'93f1ae0b-f36d-96b7-0f9a-f9a3da540cc5', CAST(N'2016-04-18 03:03:31.5730000' AS DateTime2), N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 1, 0, 2, 1)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'79df64dd-e67d-5375-19af-fa287440b852', CAST(N'2016-04-18 03:12:25.2210000' AS DateTime2), N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d', N'a49176b3-2030-1548-ddcb-d514439cefa7', N'45b30481-489b-95d7-405b-b253635e9773', 1, 0, 1, 15)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'dc89feca-eb61-08cd-7ed7-fca16748cde0', CAST(N'2016-04-10 21:05:46.5920000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'dc83f8c3-f209-3eaf-0d4d-65d0f85ce3e5', 2, 0, 0, 3)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'e83fc484-66c6-6f34-8049-fdd43f319902', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'83e6872a-7f9c-2971-af3a-beb40c62b1ce', N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'6996ad3e-2aef-fa61-cf1b-0fc4cc0847c4', 5, 0, 1, 3)
INSERT [dbo].[ExerciseSets] ([Id], [Date], [ExerciseId], [WorkoutId], [WorkoutSessionId], [Weight], [Unit], [SerialNumber], [NumberOfRepetitions]) VALUES (N'dbb250cc-ae48-8d38-2562-ffaebd5d45de', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), N'a50ccfc2-bed8-59aa-5366-641eccb8b356', N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'60f99982-2c9d-094b-991c-966d47186fb7', 22, 0, 3, 6698)
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'45aa9981-4e98-7f8b-e559-05548131ea85')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'f7c85d9a-9857-5922-c285-0babfafe5059')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'c1cf1f30-bbf2-f690-8594-216d4f963fa6')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'e1460956-c4ee-b4d5-27b3-32aa4bf88280')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'214be655-3fae-3022-0c21-496c17be3bd7')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'46b0c025-c158-58ac-5719-5b23d300c312')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'86ea0502-d7fa-2acc-6713-87f0257be240')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'27e62cbb-6554-8e66-2fb4-de850845a8de')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'4e6466c8-a4d7-a920-99d1-1428df760d17')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'4efde001-d741-e195-0db9-1e24b7fcd72d')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'024adda4-9dd3-06df-c34b-8e06bc5a8e02')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'83e6872a-7f9c-2971-af3a-beb40c62b1ce')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'684722a1-84de-4fab-9abc-ceb86253d37c')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'330502be-4119-6e0d-dfd1-de17bb26962a')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'4d27a94c-abfb-6ee0-2e7f-87f9f7b3da3d', N'07e81ade-bc5c-47f7-bcf9-428304e8edcb')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'4d27a94c-abfb-6ee0-2e7f-87f9f7b3da3d', N'3549b786-96a0-6a19-50ce-8834417dea63')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'fcaa8c99-ee5b-8f97-8ed2-3a7d3d162343')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'a50ccfc2-bed8-59aa-5366-641eccb8b356')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'a60f1582-f1c7-53cc-c078-ed5afbed0c80')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'f0411250-66ea-485c-0687-9ac4a2251c86', N'4efde001-d741-e195-0db9-1e24b7fcd72d')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'f0411250-66ea-485c-0687-9ac4a2251c86', N'83e6872a-7f9c-2971-af3a-beb40c62b1ce')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'f0411250-66ea-485c-0687-9ac4a2251c86', N'e875a929-0490-2173-215c-ed57a396c2cb')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'8f069918-33bb-ff9e-241b-b03c88509b41', N'b475f58c-7671-f740-8b4e-01a6e18f5f13')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'8f069918-33bb-ff9e-241b-b03c88509b41', N'a50ccfc2-bed8-59aa-5366-641eccb8b356')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'8f069918-33bb-ff9e-241b-b03c88509b41', N'cdb0fb40-6fb0-1ee8-154a-78b479130ac5')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'8f069918-33bb-ff9e-241b-b03c88509b41', N'8c6a9eea-e44c-1ba8-56d9-b6aa9c6893dd')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'8f069918-33bb-ff9e-241b-b03c88509b41', N'5d61c9c4-4e31-9fff-8af8-ba79600bc779')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'7755999f-9d26-1497-4e1e-ca8ef281b127', N'43d295b0-8448-b01e-0548-25646a6c4cb1')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'c01ae525-c8bf-bb1c-4542-01d661023b5d')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'0765cbfb-49e2-c33a-d33f-34c751a0e145')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'8eb1b91c-5949-864b-4eca-3bbeb5511f3d')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'a0103534-4061-3e51-fe84-85dcf28deb69')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'4ae49f30-9b3a-bab7-6f56-8e52b1dd021d')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'1fd8ff94-525a-44fc-a2f0-b61a87ff5bab')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'4c184ae8-b49f-2aed-7187-bdd1d5093416')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'0aa607a9-838c-d043-f2fa-fcb7e37a5ff2')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'90068f89-4a7d-5733-7e68-d8ad8b1ca9a4', N'b1588044-e602-8425-252d-6bb1b6482090')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'2ac78da8-c34b-b692-613c-ffca59b9f340', N'1c98a752-8d7c-2f8e-e6f0-08627ed2a1ba')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'2ac78da8-c34b-b692-613c-ffca59b9f340', N'9c7d5692-7d94-f61d-3875-0ec4cce9852f')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'2ac78da8-c34b-b692-613c-ffca59b9f340', N'0e438fb5-04ab-be16-ed30-6376f8041bc9')
INSERT [dbo].[WorkoutExercises] ([Workout_Id], [Exercise_Id]) VALUES (N'2ac78da8-c34b-b692-613c-ffca59b9f340', N'cb72b385-1b2c-2f72-75a5-7dae635e6056')
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'd3396a00-c61c-e531-178e-32127637e368', N'Legs', CAST(N'2016-04-09 05:08:14.1867622' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'51188fb7-a515-8c50-b51c-661a79c8f9ce', N'Sunday', CAST(N'2016-03-28 07:52:07.7707140' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'4d27a94c-abfb-6ee0-2e7f-87f9f7b3da3d', N'Пятница', CAST(N'2016-04-01 08:23:34.9247056' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'6bce09ae-5bd4-03d4-8ba3-99796b0c430f', N'Monday', CAST(N'2016-03-28 09:18:12.2740860' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'f0411250-66ea-485c-0687-9ac4a2251c86', N'Saturday', CAST(N'2016-03-28 07:48:41.8030942' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'8f069918-33bb-ff9e-241b-b03c88509b41', N'Tuesday', CAST(N'2016-03-29 10:28:23.3638209' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'7755999f-9d26-1497-4e1e-ca8ef281b127', N'Back 4', CAST(N'2016-04-23 08:59:13.2275925' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'a49176b3-2030-1548-ddcb-d514439cefa7', N'Chest + Back', CAST(N'2016-04-07 18:37:48.7464450' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'90068f89-4a7d-5733-7e68-d8ad8b1ca9a4', N'Back 3', CAST(N'2016-04-18 03:37:29.7616565' AS DateTime2))
INSERT [dbo].[Workouts] ([Id], [Name], [DateCreated]) VALUES (N'2ac78da8-c34b-b692-613c-ffca59b9f340', N'Wednesday IMPROVED', CAST(N'2016-03-30 10:17:42.2026784' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'3603ee4b-58be-8678-4ed6-01d1b0ffc4bd', CAST(N'2016-03-28 07:55:16.9300000' AS DateTime2), CAST(N'2016-03-28 07:55:18.9060000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'ec42caaf-3231-2ed1-519d-0c572dd63959', CAST(N'2016-04-24 09:08:33.4970000' AS DateTime2), CAST(N'2016-04-24 09:13:19.4960000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'6996ad3e-2aef-fa61-cf1b-0fc4cc0847c4', CAST(N'2016-04-10 21:06:45.7490000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'8060755b-726b-8c43-b644-0fce50a9e2f7', CAST(N'2016-04-24 09:13:56.5260000' AS DateTime2), CAST(N'2016-04-24 10:34:39.2710000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'e2bd49e1-830f-7ec5-7ab4-143821d2f9cc', CAST(N'2016-04-18 03:43:56.4950000' AS DateTime2), CAST(N'2016-04-18 03:44:35.8480000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'a8c2cb10-09d8-56dc-519d-15a6687d8982', CAST(N'2016-04-01 08:50:01.2460000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'5ac64bd7-94e1-e359-4e88-1994ea9ce472', CAST(N'2016-03-28 06:26:53.1790000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'c8c3c540-78bb-389e-a91b-1b2d29dc2c02', CAST(N'2016-04-24 09:13:33.4810000' AS DateTime2), CAST(N'2016-04-24 09:13:50.8560000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'e7c9c90c-eaec-b0b7-3943-1d682271baa5', CAST(N'2016-04-12 09:01:05.3370000' AS DateTime2), CAST(N'2016-04-12 09:01:20.5250000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'47355556-428b-b134-6ea6-20145f0954b1', CAST(N'2016-04-09 07:25:30.9370000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'481bdd6e-1eca-4728-5508-278550decf75', CAST(N'2016-03-30 09:40:58.1660000' AS DateTime2), CAST(N'2016-03-30 09:40:59.5580000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'129cd93b-7e78-6353-8275-2799fda25280', CAST(N'2016-04-23 07:56:06.0680000' AS DateTime2), CAST(N'2016-04-23 09:04:28.5480000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'7c35227f-aebe-1321-6e41-2b311363726c', CAST(N'2016-03-28 07:38:20.2560000' AS DateTime2), CAST(N'2016-03-28 07:38:22.3910000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'7f223cd8-ee03-91bc-8a80-2cc565e330f6', CAST(N'2016-03-28 06:30:51.0720000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'ed1eb35b-4f6d-fb59-0494-2e9d0adf78fa', CAST(N'2016-03-29 10:31:08.2800000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'78d41e98-d68e-0d6e-144b-3dec28fddbbf', CAST(N'2016-04-18 03:43:14.0560000' AS DateTime2), CAST(N'2016-04-18 03:43:19.4270000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'2cdef934-2101-3ba5-0cc4-4ddeb1961264', CAST(N'2016-03-28 06:30:54.0570000' AS DateTime2), CAST(N'2016-03-28 06:30:54.8850000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'0b7934bb-cd82-e85d-7e7f-547f2b5fb411', CAST(N'2016-04-23 09:05:52.2850000' AS DateTime2), CAST(N'2016-04-23 09:06:04.2030000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'2e261bce-061c-b011-b5dd-548b70ba30db', CAST(N'2016-04-06 13:09:17.1960000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'e2ee94cc-8616-405c-c080-57373a156a20', CAST(N'2016-04-10 21:04:23.8810000' AS DateTime2), CAST(N'2016-04-10 21:04:43.8390000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'609f3935-2d5b-6ed7-76dc-59060547c700', CAST(N'2016-04-18 02:56:19.8060000' AS DateTime2), CAST(N'2016-04-18 02:56:54.0240000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'24e3fd2e-67e9-a1c5-7d3c-64492fd213d3', CAST(N'2016-04-23 09:05:24.5090000' AS DateTime2), CAST(N'2016-04-23 09:05:26.0540000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'dc83f8c3-f209-3eaf-0d4d-65d0f85ce3e5', CAST(N'2016-04-10 21:05:35.8190000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'955e2d1d-70ef-f00c-b902-6d1ca682f602', CAST(N'2016-04-06 13:09:27.3370000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'052aba58-233b-789e-1195-6d356f9cbb13', CAST(N'2016-04-12 02:29:23.4460000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'e7ca27a2-20c7-83a9-6724-8178eea40324', CAST(N'2016-03-28 06:30:24.2460000' AS DateTime2), CAST(N'2016-03-28 06:30:29.7390000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'9f6532e2-a8e3-1991-2747-8960bea36782', CAST(N'2016-03-28 07:44:21.7610000' AS DateTime2), CAST(N'2016-03-28 07:44:24.7220000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'0cae91cf-1f2a-f1e6-55f5-8d08e2e71eaa', CAST(N'2016-04-01 08:24:21.3570000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'60f99982-2c9d-094b-991c-966d47186fb7', CAST(N'2016-04-10 11:16:51.4520000' AS DateTime2), CAST(N'2016-04-10 11:17:32.2210000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'6b6b96de-a4f1-ef0f-ffd2-9a007261d60c', CAST(N'2016-04-18 02:50:23.5900000' AS DateTime2), CAST(N'2016-04-18 02:56:17.1360000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'b3099d27-6ee7-ee22-a324-9a697ae85447', CAST(N'2016-04-10 21:06:16.5400000' AS DateTime2), CAST(N'2016-04-10 21:06:38.2630000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'3af43c0b-def2-0880-e456-a34aa49dd662', CAST(N'2016-04-10 09:59:02.9780000' AS DateTime2), CAST(N'2016-04-10 09:59:06.8050000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'6b44f55d-f978-4510-5182-a4dc14f4e633', CAST(N'2016-04-18 02:57:18.2460000' AS DateTime2), CAST(N'2016-04-18 02:59:19.4760000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'e25bfb5e-9ddf-a279-fe1f-a4f0c4ae49a9', CAST(N'2016-03-29 10:30:36.0650000' AS DateTime2), CAST(N'2016-03-29 10:30:51.4800000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'5757f43c-1c41-46b4-1ed6-ac159d3226d2', CAST(N'2016-03-29 10:29:49.5360000' AS DateTime2), CAST(N'2016-03-29 10:30:30.4170000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'00545642-1c73-c325-ffb9-ad2dfdb05144', CAST(N'2016-04-10 10:20:05.7840000' AS DateTime2), CAST(N'2016-04-10 10:20:10.5130000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'88f054b1-e28b-172b-11e7-af4735acfefc', CAST(N'2016-03-28 06:25:39.7610000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'45b30481-489b-95d7-405b-b253635e9773', CAST(N'2016-04-18 02:59:23.1660000' AS DateTime2), CAST(N'2016-04-18 03:42:16.7220000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'2cf29d37-a3ff-5cd2-7b5a-b635eab589e6', CAST(N'2016-04-10 09:15:20.6060000' AS DateTime2), CAST(N'2016-04-10 09:15:23.4100000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'e857ab12-ada7-76d2-aa02-b98c30ed06e2', CAST(N'2016-04-10 09:59:16.8260000' AS DateTime2), CAST(N'2016-04-10 10:19:56.6380000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'4fc29a8f-207d-7716-bec1-bac1266c630d', CAST(N'2016-04-12 08:56:26.7360000' AS DateTime2), CAST(N'2016-04-12 08:56:47.2110000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'65669bc4-a21d-c150-1cf9-be2d0d4e3fd6', CAST(N'2016-04-10 09:15:28.4610000' AS DateTime2), CAST(N'2016-04-10 09:58:58.9840000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'3170fbb5-a99d-4e44-2e57-c31a4fc5fa97', CAST(N'2016-03-30 10:09:45.3870000' AS DateTime2), CAST(N'2016-03-30 10:09:47.9990000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'26e30b24-ac2b-bf8a-38a9-c350dbf6fd6f', CAST(N'2016-03-28 07:37:50.6210000' AS DateTime2), CAST(N'2016-03-28 07:38:14.9350000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'9cf552d1-8ee1-c4f4-514e-c6bb528f71f0', CAST(N'2016-03-28 07:44:13.8150000' AS DateTime2), CAST(N'2016-03-28 07:44:19.9280000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'71c8910c-838e-3bec-d000-ca9137fa33d8', CAST(N'2016-04-10 21:04:54.4830000' AS DateTime2), CAST(N'2016-04-10 21:05:30.9490000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'1765e661-8a1d-85d7-7261-d080b6772a7e', CAST(N'2016-04-10 09:59:09.0430000' AS DateTime2), CAST(N'2016-04-10 09:59:14.5820000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'a6f06d81-815b-953a-1e82-d0eac8f03099', CAST(N'2016-04-12 09:01:39.0140000' AS DateTime2), CAST(N'2016-04-12 09:02:38.3980000' AS DateTime2))
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'ac51f9e3-bab8-d9a9-62ae-d796dfd90c99', CAST(N'2016-04-06 13:09:23.6380000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'de92864a-417c-8fb2-d84c-e5194d351d60', CAST(N'2016-04-10 19:45:31.6590000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'36d56c89-4089-14ab-32fd-e6299963dc0b', CAST(N'2016-04-01 16:27:05.3590000' AS DateTime2), NULL)
INSERT [dbo].[WorkoutSessions] ([Id], [DateStart], [DateEnd]) VALUES (N'56c1da06-37ca-16bf-44ea-f135bab08c9b', CAST(N'2016-04-12 08:56:52.4290000' AS DateTime2), CAST(N'2016-04-12 08:57:12.9550000' AS DateTime2))
/****** Object:  Index [IX_ExerciseId]    Script Date: 4/25/2016 3:04:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_ExerciseId] ON [dbo].[ExerciseSets]
(
	[ExerciseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_WorkoutId]    Script Date: 4/25/2016 3:04:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_WorkoutId] ON [dbo].[ExerciseSets]
(
	[WorkoutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_WorkoutSessionId]    Script Date: 4/25/2016 3:04:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_WorkoutSessionId] ON [dbo].[ExerciseSets]
(
	[WorkoutSessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Exercise_Id]    Script Date: 4/25/2016 3:04:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_Exercise_Id] ON [dbo].[WorkoutExercises]
(
	[Exercise_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Workout_Id]    Script Date: 4/25/2016 3:04:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_Workout_Id] ON [dbo].[WorkoutExercises]
(
	[Workout_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[ExerciseSets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ExerciseSets_dbo.Exercises_ExerciseId] FOREIGN KEY([ExerciseId])
REFERENCES [dbo].[Exercises] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExerciseSets] CHECK CONSTRAINT [FK_dbo.ExerciseSets_dbo.Exercises_ExerciseId]
GO
ALTER TABLE [dbo].[ExerciseSets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ExerciseSets_dbo.Workouts_WorkoutId] FOREIGN KEY([WorkoutId])
REFERENCES [dbo].[Workouts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExerciseSets] CHECK CONSTRAINT [FK_dbo.ExerciseSets_dbo.Workouts_WorkoutId]
GO
ALTER TABLE [dbo].[ExerciseSets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ExerciseSets_dbo.WorkoutSessions_WorkoutSessionId] FOREIGN KEY([WorkoutSessionId])
REFERENCES [dbo].[WorkoutSessions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExerciseSets] CHECK CONSTRAINT [FK_dbo.ExerciseSets_dbo.WorkoutSessions_WorkoutSessionId]
GO
ALTER TABLE [dbo].[WorkoutExercises]  WITH CHECK ADD  CONSTRAINT [FK_dbo.WorkoutExercises_dbo.Exercises_Exercise_Id] FOREIGN KEY([Exercise_Id])
REFERENCES [dbo].[Exercises] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WorkoutExercises] CHECK CONSTRAINT [FK_dbo.WorkoutExercises_dbo.Exercises_Exercise_Id]
GO
ALTER TABLE [dbo].[WorkoutExercises]  WITH CHECK ADD  CONSTRAINT [FK_dbo.WorkoutExercises_dbo.Workouts_Workout_Id] FOREIGN KEY([Workout_Id])
REFERENCES [dbo].[Workouts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WorkoutExercises] CHECK CONSTRAINT [FK_dbo.WorkoutExercises_dbo.Workouts_Workout_Id]
GO
USE [master]
GO
ALTER DATABASE [GymApp] SET  READ_WRITE 
GO
