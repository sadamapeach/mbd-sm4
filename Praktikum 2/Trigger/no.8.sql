USE [Klinik]
GO
/****** Object:  Trigger [dbo].[update_stock_obat]    Script Date: 19/05/2023 00:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =====================================================================================
-- Author	  : Oktaviana Sadama Nur Azizah		
-- Create date: 2023-05-15
-- Description:	Mengupdate jumlah stok obat pada tabel stok obat ketika seorang pasien
--				membeli resep (dicatatkan pada tabel resep)
-- =====================================================================================
CREATE TRIGGER [dbo].[update_stock_obat] 
   ON  [dbo].[resep] 
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @number INT
	SELECT @number = CAST(jumlah_stock AS INT) FROM stock_obat
	WHERE kodesto_ang = (SELECT TOP 1 id_resep FROM inserted ORDER BY id_resep DESC)
	SET @number = @number - 1

	UPDATE stock_obat SET jumlah_stock = CAST(@number AS NCHAR(10))
	WHERE kodesto_ang = (SELECT TOP 1 id_resep FROM inserted ORDER BY id_resep DESC)

END
