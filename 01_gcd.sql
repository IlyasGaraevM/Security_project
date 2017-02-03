Use Client


if OBJECT_ID (N'dbo.gcd', N'FN') IS NOT NULL  
    drop function gcd;  


go

create function gcd(@a bigint, @b bigint)
returns bigint

as
begin
	declare @c bigint
	set @c = 0
	while @b <> 0
		begin
			set @c = @a % @b
			set @a = @b
			set @b = @c
		end
	if @a < 0
		begin
			return -@a
		end
	return @a
end