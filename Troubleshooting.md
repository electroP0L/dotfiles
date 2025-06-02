# Troubleshooting

## Problem #1

ZSH is not properly set as the default shell by `chsh -s $(which zsh)`, and the command `getent passwd <username>` returns an outdated shell (e.g., `/bin/bash`).

### Cause

The `/etc/nsswitch.conf` file might have been configured to use SSSD (System Security Services Daemon), which queries external sources (LDAP, AD, etc.) before consulting local files.

### Solution

1. Edit the source priority in `/etc/nsswitch.conf`:

   ```bash
   sudo nano /etc/nsswitch.conf
   ```

2. Locate the following line:

   ```bash
   passwd: sss files systemd
   ```

3. Change it to prioritize local files:

   ```bash
   passwd: files sss systemd
   ```

4. Restart the SSSD service to clear its cache:

   ```bash
   sudo systemctl restart sssd
   ```

5. Verify the change:

   ```bash
   getent passwd <username>
   ```

## Problem #2

When trying to broadcast with terminator, signs appear twice in the broadcasted terminals.

### Solution

Remove the ibus library:

```bash
sudo apt-get remove ibus
```

Make sure that no important packages depending on ibus will be uninstalled. If this is the case, cancel the uninstallation and leave the package installed.

**Note**: This solution can probably be made less drastic by following some ideas from [this forum](https://github.com/gnome-terminator/terminator/issues/596).