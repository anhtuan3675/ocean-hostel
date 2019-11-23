USE OCEAN_HOSTEL
GO




---------------------------------
CREATE	PROC	PROC__TANG__DETELE
@MATANG		VARCHAR(15)
AS
BEGIN
	DELETE FROM TANG
	WHERE MATANG = @MATANG
END
GO


---------------------------------
CREATE	PROC	PROC__TANG__UPDATE
@MATANG		VARCHAR(10),
@TENTANG	VARCHAR(15)
AS
BEGIN
	UPDATE	TANG
	SET TENTANG = @TENTANG
	WHERE MATANG = @MATANG
END
GO