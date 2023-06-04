﻿use [F1daTuga]
go

CREATE STATISTICS [_dta_stat_1061578820_2_8] ON [dbo].[Estatisticas]([id_corrida], [tipo_stat])
WITH AUTO_DROP = OFF
go

CREATE STATISTICS [_dta_stat_1061578820_9_2] ON [dbo].[Estatisticas]([valor], [id_corrida])
WITH AUTO_DROP = OFF
go

CREATE STATISTICS [_dta_stat_1061578820_9_8_2] ON [dbo].[Estatisticas]([valor], [tipo_stat], [id_corrida])
WITH AUTO_DROP = OFF
go
