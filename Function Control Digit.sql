IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Validation]') AND TYPE IN (N'FN', N'IF', N'TF', N'FS', N'FT')) 
	DROP FUNCTION [dbo].[Validation] 
GO 
CREATE FUNCTION [dbo].[Validation](@Str VARCHAR(10)) 
	RETURNS BIT
AS 
BEGIN
	DECLARE @ValidControlDigit INT,
			@Counter INT,
			@IsValid BIT,
			@ControlDigit INT,
			@Mod INT
	SET @IsValid = 0
	SET @Counter = 2
	SET @ValidControlDigit = 0
	SET @ControlDigit = CONVERT(INT, RIGHT(@Str, 1))
	SET @Str = SUBSTRING(@Str, 1, LEN(@Str) - 1) -- رقم کنترل حذف میشود

	WHILE @Counter <= 10
	BEGIN
		SET @ValidControlDigit = @ValidControlDigit + (CONVERT(INT, RIGHT(@Str, 1)) * @Counter)
		SET @Str = SUBSTRING(@Str, 1, LEN(@Str) - 1) -- یک رقم از سمت راست می اندازیم
		SET @Counter = @Counter + 1
	END

	SET @Mod = @ValidControlDigit % 11

	IF @Mod <= 2
	BEGIN
		SET @ValidControlDigit = @Mod
	END
	ELSE
	BEGIN
		SET @ValidControlDigit = 11 - @Mod
	END

	IF @ValidControlDigit = @ControlDigit
		SET @IsValid = 1

	RETURN @IsValid
END