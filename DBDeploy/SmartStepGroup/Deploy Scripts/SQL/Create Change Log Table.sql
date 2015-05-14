IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[db_chg_log]') AND type in (N'U'))
BEGIN

	CREATE TABLE dbo.db_chg_log (
		chg_seq_nbr varchar(100) NOT NULL,
		chg_agnt_nm varchar(100) NOT NULL CONSTRAINT df_db_chg_log_agnt_nm DEFAULT SYSTEM_USER,
		chg_aply_dtm datetime NOT NULL CONSTRAINT df_db_chg_log_aply_dtm DEFAULT GETUTCDATE()
	)

	ALTER TABLE db_chg_log ADD CONSTRAINT xdb_chg_log01 PRIMARY KEY (chg_seq_nbr)

END