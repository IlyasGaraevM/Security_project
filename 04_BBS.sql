Use Client


if OBJECT_ID (N'dbo.BBS', N'FN') IS NOT NULL  
    drop function BBS; 


go

create function BBS(@Number bigint)
returns bigint

as
begin
	declare @rand bigint
	declare @p bigint
	declare @q bigint
	declare @x0 bigint
	declare @n bigint
	
	--Create new p, q and x0--
/*	set @q = 0
	set @rand =  cast(crypt_gen_random(2, 0x73103685F7E966CAE0CB) as bigint)
	set @p = dbo.find_simple(@q, @rand)
	set @rand =  cast(crypt_gen_random(2, 0x73103685F7E966CAE0CB) as bigint)
	set @q = dbo.find_simple(@p, @rand)
	set @rand =  cast(crypt_gen_random(2, 0x73103685F7E966CAE0CB) as bigint)
	set @x0 = dbo.create_x0(@p, @q, @rand)*/
	set @q = 49747
	set @p = 18731
	set @x0 = 33759
	set @Number = 400
	set @n = @p*@q

	while @Number > 0
	begin
		set @x0 = (@x0 * @x0) % @n
		set @Number = @Number - 1
	end	
	return @x0
end