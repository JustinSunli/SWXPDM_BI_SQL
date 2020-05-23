

RESTORE DATABASE Blount_vault
FROM DISK = '/home/justin/Downloads/2020_05_15_BlountVault.bak'
WITH MOVE 'Blount_Vault' TO '/var/opt/mssql/data/Blount_Vault.mdf',
MOVE 'Blount_Vault_Log' TO '/var/opt/mssql/data/YourDB_Log.ldf'
GO