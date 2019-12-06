USE OCEAN_HOSTEL
GO


CREATE PROC	PROC__LOAIPHONG__THONGKE
AS
BEGIN
	SELECT lp.TENLOAIPHG, COUNT(ph.MAPHG) AS SOLG
	FROM LOAIPHONG lp, PHONG ph
	WHERE ph.MALOAIPHG = lp.MALOAIPHG
		AND ph.SOLG_DANGO > 0
	GROUP BY lp.TENLOAIPHG
END
GO



CREATE	PROC	PROC__LOAIPHONG__INSERT
@TENLOAIPHG		NVARCHAR(15),
@GIAPHG			INT
AS
BEGIN
	DECLARE @MALOAIPHG VARCHAR(15)
	SELECT @MALOAIPHG = dbo.FUNC__LOAIPHONG__GetNextID()
	
	INSERT INTO LOAIPHONG(MALOAIPHG, TENLOAIPHG, GIAPHG)
	VALUES (@MALOAIPHG, @TENLOAIPHG, @GIAPHG)
END
GO


--------------------------------------------------------
CREATE	PROC	PROC__LOAIPHONG__DELETE
@MALOAIPHG	VARCHAR(15)
AS
BEGIN
	DELETE FROM LOAIPHONG
	WHERE MALOAIPHG = @MALOAIPHG
END
GO


--------------------------------------------------------
CREATE	PROC	PROC__LOAIPHONG__UPDATE
@MALOAIPHG	VARCHAR(15),
@TENLOAIPHG	NVARCHAR(15),
@GIAPHG		INT
AS
BEGIN
	UPDATE LOAIPHONG
	SET TENLOAIPHG = @TENLOAIPHG,
		GIAPHG = @GIAPHG
	WHERE MALOAIPHG = @MALOAIPHG
END