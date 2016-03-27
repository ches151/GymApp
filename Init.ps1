#
# DB_Maintenance.ps1
#

function Recreate-Db-From-Model
{
	Update-Database -TargetMigration $InitialDatabase -Verbose
	Add-Migration -Name "Initial" -Force
	Update-Database -Verbose
}

