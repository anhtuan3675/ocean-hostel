USE OCEAN_HOSTEL
GO


CREATE PROC	PROC__HOPDONG__INSERT
@MAHOPDONG	VARCHAR(10),
@MAPHONG	VARCHAR(10),
@THOIHAN	INT,
@TIENCOC	INT
AS
BEGIN
	INSERT INTO HOPDONG(MAHOPDONG, MAPHG, THOIHAN, TIENCOC)
	VALUES (@MAHOPDONG, @MAPHONG, @THOIHAN, @TIENCOC)
END
GO

-------------------------------------------------------------
CREATE PROC	PROC__HOPDONG__DELETE
@MAHOPDONG	VARCHAR(10)
AS
BEGIN
	SELECT khd.MAKHACH, khd.MAHOPDONG
	INTO #TEMP
	FROM HOPDONG hd, KHACH_HOPDONG khd
	WHERE hd.MAHOPDONG = khd.MAHOPDONG
		AND hd.MAHOPDONG = @MAHOPDONG
	
	
	DECLARE @MAPHG VARCHAR(10)
	SELECT @MAPHG = MAPHG
	FROM HOPDONG
	WHERE MAHOPDONG = @MAHOPDONG
	
	
	DELETE FROM KHACH_HOPDONG
	WHERE MAHOPDONG = @MAHOPDONG
	
	
	WHILE (SELECT COUNT(*) FROM #TEMP) > 0
	BEGIN
		DECLARE @MAKH VARCHAR(10)
		SELECT TOP 1 @MAKH = MAKHACH
		FROM #TEMP
		
		DECLARE @MAHD VARCHAR(10)
		SELECT TOP 1 @MAHD = MAHOPDONG
		FROM #TEMP
		
		
		DELETE FROM KHACH_VIPHAM
		WHERE MAKHACH = @MAKH
		
		DELETE FROM #TEMP
		WHERE MAHOPDONG = @MAHD
		
		DELETE FROM KHACH
		WHERE MAKHACH = @MAKH
		
		UPDATE	PHONG
		SET SOLG_DANGO = SOLG_DANGO - 1
		WHERE MAPHG = @MAPHG
	END
	
	
		
	DELETE FROM HOPDONG
	WHERE MAHOPDONG = @MAHOPDONG
END
GO


-------------------------------------------------
CREATE	PROC	PROC__HOPDONG__GetList
AS
BEGIN
	SELECT hd.*, ph.TENPHG
	FROM HOPDONG hd, PHONG ph
	WHERE ph.MAPHG = hd.MAPHG
END
GO


-------------------------------------------------
CREATE	PROC	PROC__HOPDONG__TRACOC
@MAHOPDONG	VARCHAR(10)
AS
BEGIN
	UPDATE	HOPDONG
	SET DATRACOC = 'True'
	WHERE MAHOPDONG = @MAHOPDONG
END
GO


-------------------------------------------------
CREATE PROC	PROC__HOPDONG__HETHAN
@MAHOPDONG	VARCHAR(10)
AS
BEGIN
	DECLARE @MAPHG	VARCHAR(10)
	SELECT @MAPHG = MAPHG
	FROM HOPDONG
	
	WHILE (SELECT COUNT(*) FROM KHACH_HOPDONG) > 0
	BEGIN
		DECLARE @MAKHACH VARCHAR(10)
		SELECT TOP 1 @MAKHACH = MAKHACH
		FROM KHACH_HOPDONG
		
		DECLARE @MAHD VARCHAR(10)
		SELECT TOP 1 @MAHD = MAHOPDONG
		FROM KHACH_HOPDONG
		
		UPDATE KHACH
		SET TRANGTHAI = N'Hết hợp đồng'
		WHERE MAKHACH = @MAKHACH
		
		UPDATE PHONG
		SET SOLG_DANGO = SOLG_DANGO - 1
		WHERE MAPHG = @MAPHG
		
		DELETE FROM KHACH_HOPDONG
		WHERE MAHOPDONG = @MAHD
			AND MAKHACH = @MAKHACH
	END
	
	DELETE FROM HOPDONG
	WHERE MAHOPDONG = @MAHD
END
GO
