Use Client

declare @user_pass varchar(max)
declare @generate_key varchar(max)

set @user_pass = 'pasw0Rd'

set @generate_key = crypt_gen_random(1000,convert([varbinary](8000),@user_pass))

exec('
	create symmetric key MySymmetricKey_1
		with algorithm = AES_256
		encryption by password = '''+@generate_key+'''
		
	open symmetric key MySymmetricKey_1
		decryption by password = '''+@generate_key+'''
	')

create symmetric key MySymmetricKey
	with algorithm = AES_256
	encryption by symmetric key MySymmetricKey_1
go
	
open symmetric key MySymmetricKey
	decryption by symmetric key MySymmetricKey_1

declare @EncryptTable varchar(max)
declare @BaseTable varchar(max)
declare @table_id varchar(max)
declare @id int
declare @i int
declare @table_name varchar(max)

set @EncryptTable = '[dbo].[EncryptTable]'
set @BaseTable = 'Salary'
set @table_id = (select c.name
				 from sys.indexes as i
				 inner join sys.index_columns as ic 
				 on i.object_id = ic.object_id and i.index_id = ic.index_id
				 inner join sys.columns as c 
				 on ic.object_id = c.object_id and c.column_id = ic.column_id
				 where i.is_primary_key = 1 
				 and i.object_id = object_id(@BaseTable)
				 )

exec('exec sp_rename '''+@EncryptTable+'.id'', '''+@table_id+''', ''COLUMN'';
	')

exec('declare cursor_1 cursor for
	  select '+@table_id+' from '+@BaseTable
	  )

open cursor_1 

fetch next from cursor_1 into @id

while @@FETCH_STATUS = 0
	begin
		set @i = 2
		
		while col_name(object_id(@BaseTable), @i) <> 'NULL'
			begin
				set @table_name = col_name(object_id(@BaseTable), @i)
				exec('
					if col_name(Object_id('''+@EncryptTable+'''), '+@i+') is NULL
						alter table '+@EncryptTable+' add '+@table_name+' nvarchar(max) NULL;
					')
				exec('
					declare @buf_value nvarchar(max)
					declare @test nvarchar(max)

					set @buf_value = EncryptByKey(KEY_GUID(''MySymmetricKey''), 
												 (select cast('+@table_name+' as nvarchar) 
												  from '+@BaseTable+' 
												  where '+@table_id+' = '+@id+')
												 )
					
					set @test = (select '+@table_name+' 
								from '+@EncryptTable+' 
								where '+@table_id+' = '+@id+')
					if (@test is NULL)
						insert into '+@EncryptTable+' ( '+@table_id+', '+@table_name+')
					  						   values ('+@id+', @buf_value);
					update '+@EncryptTable+'
						set '+@table_name+' = @buf_value
						where '+@table_id+' = '+@id+';
					')
				set @i = @i + 1
		
			end

		fetch next from cursor_1 into @id
	end 

close cursor_1
deallocate cursor_1

close symmetric key MySymmetricKey_1
close symmetric key MySymmetricKey;
