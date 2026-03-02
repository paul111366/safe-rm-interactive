# Safe-RM Interactive 🛡️

A "mechanical safety" for the Linux command line. 

As a Journeyman Plumber and writer, I know that once you cut a pipe or delete a draft, there’s usually no going back. Traditional `rm` is destructive by design. **Safe-RM** changes that by wrapping the delete command in a safety net.

## 🚀 How it Works
Instead of permanently unlinking your files, this tool:
1. **Archives:** Wraps your files/folders in a compressed `.tar.gz` with a high-resolution timestamp.
2. **Preserves Path:** Stores the absolute path so you can restore a file exactly where it came from.
3. **Automates Cleanup:** A simple cron job acts as your "garbage collector," purging archives older than 30 days.
4. **Interactive Recovery:** The `undel` command lets you choose between versions and even "peek" at the file content before restoring.

## 🛠 Installation

### 1. Fast Install
Clone the repo and run the installer:
$git clone https://github.com/paul111366/safe-rm-interactive.git$ cd safe-rm-interactive
$chmod +x install.sh$ ./install.sh

### 2. Manual Setup
If you prefer to do it yourself:
1. Move `safe_rm.sh` and `undel.sh` to your `~/.local/bin/`.
2. Add `alias rm='safe_rm'` to your `.bashrc`, `.zshrc`, or `/etc/profile.d/safe-rm.sh`.
3. Set up your crontab (`crontab -e`) to clean the archive:
   `0 0 * * * find ~/.rm_archive -type f -mtime +30 -delete`

## 📖 Usage

### Deleting Files
Use `rm` as you normally would. If you run `rm` with no arguments, it will provide a help summary.
$ rm my_story.txt
# Output: Archived: my_story.txt (Restore with 'undel my_story.txt')

### Restoring Files
Run `undel` followed by the filename.
$ undel my_story.txt

If multiple versions exist, you will see a numbered list:
- Type the **number** to restore (e.g., 1).
- Type the **number + p** to peek at the first 10 lines (e.g., 1p).

### Bypassing the Safety
If you need to delete a massive file permanently without archiving:
$ \rm heavy_file.iso

## 🛠 Troubleshooting & Edge Cases

### Handling sudo rm
Aliases are usually not inherited by `sudo`. To ensure root deletions are also safe, you can:
- Install the script via the Global Method (/etc/profile.d/).
- Add `alias sudo='sudo '` to your .bashrc.

### Special Characters
This script uses absolute paths and quoted variables to safely handle filenames containing spaces, semicolons, or leading dashes.

### Permissions
If you are restoring a file to a system directory (like /etc/), you may need to run the restore with sudo:
$ sudo undel config.conf

---
**Author:** Paul Rogers (u/JohnPaulRogers)  
**License:** MIT
