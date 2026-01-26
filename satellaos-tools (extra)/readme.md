# SatellaOS Config Backup & Restore Tools

This package contains two simple scripts:

- **config-backup.sh**  
  Backs up LightDM and XFCE configurations.

- **config-restore.sh**  
  Restores a previously saved backup.

## Important Note
Backup files **must** be located at:  

$HOME/satellaos-installer/configuration/


Otherwise, `config-restore.sh` will not be able to find the backups and the restore process will fail.

---

# SatellaOS Program Installer Tool

- **satellaos-program-installer-tool-5.1.5.sh**  
  Provides an easy option to install 26 different programs.