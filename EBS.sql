IF OBJECT_ID('tempdb..#xml') IS NOT NULL DROP TABLE #xml
CREATE TABLE #xml ( yourXML XML )
GO

declare @YourXML XML
Declare @Object as Int;
Declare @ResponseText as Varchar(max);
Declare @Body as varchar(max);
DECLARE @EBSURL VARCHAR(8000)
DECLARE @EBSResult int

select @EBSURL = 'https://xml.nobelyayin.com/'


Exec @EBSResult =  sp_OACreate 'MSXML2.ServerXMLHTTP', @Object OUT;
Exec @EBSResult =  sp_OAMethod @Object, 'open', NULL, 'get',@EBSURL, 'false'
Exec @EBSResult =  sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'application/x-www-form-urlencoded'
Exec @EBSResult =  sp_OAMethod @Object, 'send', null, @body

DECLARE @responseTextTable table(responseText nvarchar(max));

insert into @responseTextTable (responseText)
Exec @EBSResult =  sp_OAMethod @Object, 'responseText'

declare @asd nvarchar(max)
set @asd = (select *  from @responseTextTable)
set @asd +='<Aciklama/> <Urun/>  <Urunler/>'


SET @asd = REPLACE(@asd,'UTF-8', 'UTF-16')

set @YourXML = @asd

DECLARE @idoc int;



--Declare @EBSCount int


--set @EBSCount = (SELECT @YourXML.value('count(/Urunler/Urun/KitapAdi)[1]','VARCHAR(MAX)')  from #xml)
