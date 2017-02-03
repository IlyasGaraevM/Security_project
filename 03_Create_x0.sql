Use Client


if OBJECT_ID (N'dbo.create_x0', N'FN') IS NOT NULL  
    drop function create_x0; 


go

create function create_x0(@p bigint, @q bigint, @i bigint)
returns bigint

as
begin
	declare @n bigint
	declare @final bigint
	set @final = 0
	set @n = @p * @q
	while @i < @n - 1
		begin
			if dbo.gcd(@i,@n) = 1
				begin
					set @final = @i
					break
				end
			if @i = @n - 1
				begin
					return 1
				end
			set @i = @i + 1
		end
	return @final
end