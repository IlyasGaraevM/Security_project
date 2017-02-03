Use Client


if OBJECT_ID (N'dbo.find_simple', N'FN') IS NOT NULL  
    drop function find_simple; 


go

create function find_simple(@q bigint, @rand bigint)
returns bigint

as
begin
	declare @i bigint
	declare @shet int
	declare @p bigint
	declare @test bigint
	declare @bool int

	set @bool = 1
	set @p = 0
	set @shet = 0
	set @rand = @rand - (@rand % 4) + 3

	while (@p = 0 or @q = @p) and @shet < 100000 
	begin
		set @i = 2
		set @test = 0
		set @bool = 1
		while @i < sqrt(@rand) and @bool = 1
		begin
			if (@rand % @i = 0)
			begin
				set @bool = 0
			end
			else
				if (@rand % 4 = 3)
					set @test = @rand
			set @i = @i + 1
		end
		if @bool = 1 and @test <> 0
		begin
			set @p = @test
			return @p
		end
		set @rand = @rand + 4
		set @shet = @shet + 1
	end
	return 0
end;
