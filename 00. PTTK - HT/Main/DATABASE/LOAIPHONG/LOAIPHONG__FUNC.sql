USE OCEAN_HOSTEL
GO


CREATE	FUNCTION	FUNC__LOAIPHONG__GetNextID()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @MAXID INT

	SELECT @MAXID = CONVERT(INT, MAX(SUBSTRING(MALOAIPHG, 8, LEN(MALOAIPHG) - 7)))
	FROM LOAIPHONG
	
	---------------------------------
	IF (@MAXID IS NULL)
		SET @MAXID = '0'
	
	
	DECLARE @DISTANCE INT
	IF (LEN(@MAXID + 1) > LEN(@MAXID))	--	Trường hợp chữ số cuối cùng của đơn vị
		SET @DISTANCE = 3 - (LEN(@MAXID) + 1)
	ELSE
		SET @DISTANCE = 3 - LEN(@MAXID)
	
	---------------------------------
	DECLARE @RESULT VARCHAR(10)
	SET @RESULT = 'LOAIPHG' + REPLICATE('0', @DISTANCE) + CONVERT(VARCHAR, @MAXID + 1)
	
	RETURN @RESULT + CONVERT(VARCHAR, @MAXID + 1)
END

