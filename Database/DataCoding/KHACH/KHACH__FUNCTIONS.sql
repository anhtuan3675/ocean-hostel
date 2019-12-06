USE OCEAN_HOSTEL
GO


------------------------------------------
CREATE	FUNCTION	FUNC__KHACH__GetNextID()
RETURNS	VARCHAR(10)
AS
BEGIN
	DECLARE @MAXID INT

	SELECT @MAXID = CONVERT(INT, MAX(SUBSTRING(MAKHACH, 6, LEN(MAKHACH) - 5)))
	FROM KHACH
	
	---------------------------------
	IF (@MAXID IS NULL)
		SET @MAXID = '0'
	
	
	DECLARE @DISTANCE INT
	IF (LEN(@MAXID + 1) > LEN(@MAXID))	--	Trường hợp chữ số cuối cùng của đơn vị
		SET @DISTANCE = 5 - (LEN(@MAXID) + 1)
	ELSE
		SET @DISTANCE = 5 - LEN(@MAXID)
	
	---------------------------------
	DECLARE @RESULT VARCHAR(10)
	SET @RESULT = 'KHACH' + REPLICATE('0', @DISTANCE) + CONVERT(VARCHAR, @MAXID + 1)
	
	RETURN @RESULT + CONVERT(VARCHAR, @MAXID + 1)
END
GO