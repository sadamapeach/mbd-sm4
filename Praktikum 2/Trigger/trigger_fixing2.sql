USE [Klinik]
GO
/****** Object:  Trigger [dbo].[auto_incrememt_kodepas_ang]    Script Date: 19/05/2023 00:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================================
-- Author	  : Oktaviana Sadama Nur Azizah		
-- Create date: 2023-05-15
-- Description:	Trigger auto increment pada tabel catatan kesehatan
--				untuk field id_kesehatan
-- ==================================================================
CREATE TRIGGER [dbo].[auto_incrememt_id_kesehatan] 
   ON  [dbo].[catatan_kesehatan] 
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @number INT
	IF (SELECT COUNT(*) FROM catatan_kesehatan) <= 1
		SET @number = 1
	ELSE
		SELECT TOP 2 @number = id_kesehatan FROM catatan_kesehatan ORDER BY id_kesehatan DESC
		IF (SELECT TOP 1 id_kesehatan FROM inserted ORDER BY id_kesehatan DESC) > @number
			SET @number = @number + 1
		ELSE
			SET @number = @number + 2
		
	UPDATE catatan_kesehatan SET id_kesehatan = @number
	WHERE id_kesehatan = (SELECT TOP 1 id_kesehatan FROM inserted ORDER BY id_kesehatan DESC)
	AND catatan_kesehatan = (SELECT TOP 1 catatan_kesehatan FROM inserted ORDER BY catatan_kesehatan DESC)

END
GO
