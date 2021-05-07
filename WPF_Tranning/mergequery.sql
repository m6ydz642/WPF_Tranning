USE [BaseBallGameWinform_DB]
GO

SELECT [Score_id]
      ,[Score_sub]
  FROM [dbo].[SubScoreTable]

GO


--insert into SubScoreTable values (1, 'test')
update SubScoreTable set score_id = 3 where score_id = 2;
update ScoreTable set score_id = 2 where score_id = 2; 




select * from ScoreTable
select * from SubScoreTable

SELECT *
  FROM (
         SELECT Score, Score_id
           FROM ScoreTable
       ) AS result
 PIVOT ( 
       sum(Score_id) for Score IN ([1], [2], [3], [4],[5],[10]) 
       ) AS pivot_result



	


	---------------------------------���ǿ� �´� ��� ������ ���α�
	MERGE INTO SubScoreTable --INSERT/UPDATE �� ���̺�
 USING (SELECT 1AS DUM) X
      ON (score_id= 111 and score_sub = 'test')--����2��
--   WHEN MATCHED THEN --�� ���ǿ� �´� �����Ͱ� ������ UPDATE
          
WHEN NOT MATCHED THEN --�� ���ǿ� ��1�� �����Ͱ� ������ INSERT
     UPDATE SET
            score_id=3
            ,score_sub='BBB';


---------------------------------------------
			-- ���ν��� ����

			USE [BaseBallGameWinform_DB]
GO

create procedure Score_Modify
@Score_id int,
@Score varchar(300)

as Begin
MERGE INTO SubScoreTable --INSERT/UPDATE �� ���̺�
 USING (SELECT 1AS DUM) X
      ON (score_id= 111 and score_sub = 'test')--����2��
    WHEN MATCHED THEN --�� ���ǿ� �´� �����Ͱ� ������ UPDATE
            UPDATE SET
            score_id=3
            ,score_sub='BBB'
			    WHEN NOT MATCHED THEN --�� ���ǿ� ��1�� �����Ͱ� ������ INSERT
            INSERT (score_id, score_sub)
            VALUES(
                20
                ,'���ǹ̴�1');
end
--------------------------------------------------
exec dbo.Score_Modify 1,'test'
exec Score_Modify;


SET IDENTITY_INSERT (ScoreTable) OFF


------------------------------------------------- select ���� ���ν���
USE [BaseBallGameWinform_DB]
GO



create procedure Score_Select
@Score_id int

as Begin

   SELECT convert(bit,0) as 'üũ�ڽ�', [Score_id]
      ,[Score]
  FROM [dbo].[ScoreTable] where Score_Id = @Score_id;

end

------------------------------------------------



select * from information_schema.table_constraints where table_name = 'dbo.TB_AuthUser' -- ���̺� ���� �ܷ�Ű ��ȸ

-----------------------------------------------------------
drop procedure Save_Score
drop type TYPE_SaveScore
exec Save_Score
select * from ScoreTable
-----------------------------------------------------------
USE [BaseBallGameWinform_DB]
GO
create procedure Save_Score 
@Get_SaveScore TYPE_SaveScore READONLY

as Begin
MERGE INTO ScoreTable as A --INSERT/UPDATE �� ���̺�
 USING @Get_SaveScore as B
      ON (A.Score_id = B.Score_id)--����

			when Matched then 
			     UPDATE SET  A.Score = B.Score , A.modify=getdate() -- ���뺯�游 �����ϰ� ����

			WHEN NOT MATCHED THEN --�� ���ǿ� ��1�� �����Ͱ� ������ INSERT
            INSERT (score,createdt)
            VALUES(
              
                B.Score, B.createdt);
end


-----------------------------------------------
-- 0501 2021 AM 02:06 ���� ���ν��� ������ (������¥, �߰���¥ ����)
USE [BaseBallGameWinform_DB]
GO
/****** Object:  StoredProcedure [dbo].[Save_Score]    Script Date: 2021-05-01 ���� 1:16:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Save_Score] 
@Get_SaveScore TYPE_SaveScore READONLY

as Begin
MERGE INTO ScoreTable as A --INSERT/UPDATE �� ���̺�
 USING @Get_SaveScore as B
      ON (A.Score_id = B.Score_id )--����

			when Matched  and A.Score != B.Score then 
					   UPDATE SET  A.Score = B.Score , A.modify=getdate();-- ���뺯�游 �����ϰ� ����

			--WHEN not MATCHED and B.Score_id != B.Score_id THEN --B.Score_id != B.Score_id ��ü�� ���� �ȵǴ� �����̶� insert�� �ȵ�
		 -- 			          INSERT (score,createdt) VALUES(B.Score, getdate());

MERGE INTO ScoreTable as A --INSERT/UPDATE �� ���̺�
 USING @Get_SaveScore as B
      ON (A.Score_id = B.Score_id )--����

			--when Matched  and A.Score != B.Score then 
			--		   UPDATE SET  A.Score = B.Score , A.modify=getdate()-- ���뺯�游 �����ϰ� ����

			WHEN not MATCHED THEN 
		  			          INSERT (score,createdt) VALUES(B.Score, getdate());
end

-----------------------------------------------
USE [BaseBallGameWinform_DB]
GO
CREATE TYPE TYPE_SaveScore AS TABLE(
-- ����� ���� ���̺� (����, ������)
    checkbox bit,
	Score_id int,

	Score varchar(max),
	 modify datetime,
	 createdt datetime

)

GO


------------------------------------------------- ���ھ� �˻� ���ν���
USE [BaseBallGameWinform_DB]
GO



create procedure Score_Search
@Score_id int

as Begin

   SELECT  convert(bit,0) as 'üũ�ڽ�', [Score_id]
      ,[Score] 
   from ScoreTable 
   where Score_Id = @Score_id;

end

---------------------------------------------------------------------------
USE [BaseBallGameWinform_DB]
GO
/****** Object:  StoredProcedure [dbo].[Save_Score]    Script Date: 2021-05-08 ���� 3:36:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Save_Score] 
@Get_SaveScore TYPE_SaveScore READONLY

as Begin
MERGE INTO ScoreTable as A --INSERT/UPDATE �� ���̺�
 USING @Get_SaveScore as B
      ON (A.Score_id = B.Score_id )--����

			when Matched  and A.Score != B.Score then 
					   UPDATE SET  A.Score = B.Score , A.modify=getdate();-- ���뺯�游 �����ϰ� ����

			--WHEN not MATCHED and B.Score_id != B.Score_id THEN --B.Score_id != B.Score_id ��ü�� ���� �ȵǴ� �����̶� insert�� �ȵ�
		 -- 			          INSERT (score,createdt) VALUES(B.Score, getdate());

MERGE INTO ScoreTable as A --INSERT/UPDATE �� ���̺�
 USING @Get_SaveScore as B
      ON (A.Score_id = B.Score_id )--����

			--when Matched  and A.Score != B.Score then 
			--		   UPDATE SET  A.Score = B.Score , A.modify=getdate()-- ���뺯�游 �����ϰ� ����

			WHEN not MATCHED THEN 
		  			          INSERT (score,createdt) VALUES(B.Score, getdate());
end


---------------------------------------------- ���ν��� ���ھ� ���� ��������








