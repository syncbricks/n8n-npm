# 🔄 Auto-Update n8n with Cron and npm on Ubuntu

This repository contains a simple yet effective automation setup to **keep your globally installed n8n instance up-to-date** on an Ubuntu server using `cron` jobs and a custom shell script.

---

## 📌 Overview

If you're running `n8n` installed via `npm`, you'll need to manually update it to get the latest features and fixes. This repository provides:

- An automatic **weekly update** of your Ubuntu system.
- An automatic **restart of the server** to apply updates.
- A reliable **n8n update script** that:
  - Stops the n8n service
  - Updates n8n via `npm`
  - Restarts the n8n service

---

## 🧰 Components

### 1. Crontab Entries

These cron jobs are set to run every **Friday** at specific times:

```cron
# System update and upgrade every Friday at 1 AM
0 1 * * 5 sudo apt-get update -y && sudo apt-get dist-upgrade -y

# Reboot server every Friday at 2 AM
0 2 * * 5 sudo reboot

# Update n8n every Friday at 5 AM (after reboot and system readiness)
0 5 * * 5 sudo bash /home/ubuntu/update-n8n.sh
```

### 2. Shell Script – `update-n8n.sh`

This is the core update script. Make sure it is **executable**:

```bash
chmod +x /home/ubuntu/update-n8n.sh
```

#### Script Contents:

```bash
#!/bin/bash

# Stop the n8n service
echo "Stopping n8n service..."
sudo systemctl stop n8n

# Wait for 5 seconds to ensure the service is fully stopped
sleep 5

# Update n8n globally via npm
echo "Updating n8n via npm..."
sudo npm update -g n8n

# Start the n8n service
echo "Starting n8n service..."
sudo systemctl start n8n

echo "n8n update process completed."
```

---

## ⚙️ Setup Guide

### Step 1: Ensure n8n is installed via npm

```bash
sudo npm install -g n8n
```

### Step 2: Enable and configure n8n as a systemd service

Example `n8n.service` file for `/etc/systemd/system/n8n.service`:

```ini
[Unit]
Description=n8n workflow automation tool
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/n8n
Restart=always
User=ubuntu
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory=/home/ubuntu

[Install]
WantedBy=multi-user.target
```

Enable the service:

```bash
sudo systemctl daemon-reexec
sudo systemctl enable n8n
sudo systemctl start n8n
```

### Step 3: Add the Cron Jobs

Edit the crontab:

```bash
sudo crontab -e
```

Add the entries from above to automate weekly maintenance and updates.

---

## 🔒 Security Considerations

- **Root Access:** These cron jobs run as root (`sudo`) to perform system updates and manage services.
- **Limit Exposure:** Ensure your server is protected via a firewall and not publicly exposing ports unnecessarily.
- **Backup:** It's wise to back up your workflows before any update.

---

## 🧪 Testing the Script

You can run the update script manually to test it:

```bash
sudo bash /home/ubuntu/update-n8n.sh
```

Then check if n8n has updated:

```bash
n8n --version
```

## 📚 Learn More & Resources

- 🎓 **Master the Full Potential of n8n**  
  [Udemy Course – Mastering n8n: AI Agents, API Automation, Webhooks, No Code](https://www.udemy.com/course/mastering-n8n-ai-agents-api-automation-webhooks-no-code/?referralCode=0309FD70BE2D72630C09)

- 📖 **Get the Companion Book**  
  [n8n Automation Mastery – Full Guidebook](https://lms.syncbricks.com/books/n8n)

- ☁️ **Try n8n Cloud Hosting**  
  [Sign Up for n8n Cloud via SyncBricks](https://n8n.syncbricks.com)

- 📺 **Watch Tutorials and Demos**  
  [Subscribe to SyncBricks YouTube Channel](https://www.youtube.com/channel/UC1ORA3oNGYuQ8yQHrC7MzBg?sub_confirmation=1)

---

## 📬 Contributing

If you have ideas to improve this auto-update system or want to support more install methods (like Docker), feel free to fork and submit a pull request.

---

## 📄 License

This project is licensed under the MIT License. See `LICENSE` for more information.

---
