# Wazuh 4.14 + Suricata Server Setup

This repository provides a **production-ready Bash installation script** to deploy **Wazuh 4.14 (server components)** integrated with **Suricata IDS** on **Ubuntu 22.04 / 24.04**.

The solution is designed for **SOC labs, SIEM practice, Blue Team training, and enterprise-style server deployments**, with a strong focus on **automation, stability, and clean log integration**.

<img width="901" height="592" alt="image" src="https://github.com/user-attachments/assets/c78a3c8c-9cf1-4e41-895c-93129332d3bd" />




---

## 🔐 Components Installed

- ✅ **Wazuh Manager 4.14**
- ✅ **Wazuh Indexer**
- ✅ **Wazuh Dashboard**
- ✅ **Suricata IDS** (AF-PACKET mode)
- ✅ **Suricata rule auto-update** (`suricata-update`)
- ✅ **Wazuh ↔ Suricata integration** using EVE JSON logs
- ❌ **Wazuh Agent NOT installed** (server-side setup only)

---

## 🖥️ System Requirements

| Requirement | Minimum |
|------------|--------|
| OS | Ubuntu 22.04 / 24.04 |
| CPU | 2 vCPU |
| RAM | 4 GB (8 GB recommended) |
| Disk | 40 GB |
| Network | Internet access |

> ⚠️ **Fresh server installation is strongly recommended** to avoid conflicts.

---

## 🚀 Installation Steps

### 1️⃣ Clone the repository
git clone https://github.com/83uzzal/Wazuh-4.14-Suricata-server-setup.git

### 2️⃣ Navigate to the repository directory
cd Wazuh-4.14-Suricata-server-setup

### 3️⃣ Make the installation script executable
chmod +x wazuh_suricata_install.sh

### 4️⃣ Run the installation script
sudo ./wazuh_suricata_install.sh

### 5️⃣ Follow the on-screen prompts

The script will automatically install and configure Wazuh Manager, Indexer, Dashboard, and Suricata IDS

After completion, it will display the Dashboard URL, Username, and Auto-generated password

---

### 🔑 Dashboard Access
- After installation, the script will display:

- 🌐 Dashboard URL
- 👤 Username: admin
- 🔐 Auto-generated Password

    https://<server-ip>
    Username: admin
    Password: ********

<img width="359" height="157" alt="image" src="https://github.com/user-attachments/assets/e64d1638-5d0d-4ea5-bb50-0c5a1c5bd889" />

---

### 🧠 What the Script Does Internally
- Adds official Wazuh repositories
- Installs:
    - Wazuh Manager
    - Wazuh Indexer
    - Wazuh Dashboard
- Enables and validates required systemd services
- Installs Suricata IDS from Ubuntu repositories
- Runs suricata-update to download and update rules
- Configures Suricata EVE JSON logging
- Integrates Suricata logs with Wazuh Manager
- Performs health checks and service validation

<img width="1349" height="637" alt="image" src="https://github.com/user-attachments/assets/010c6942-99cb-4dfd-9650-e4773b949e6b" />


⚠️ Important Notes
- ❌ Do NOT install Wazuh Agent on the same server
- ✅ Ensure the correct network interface name (default: ens33)

<img width="1366" height="637" alt="image" src="https://github.com/user-attachments/assets/4c6a7fc0-3827-4721-a9fa-99f0e76bf72b" />

 
### 📌 Use Cases
- SOC Lab Environment
- SIEM Practice & Learning
- IDS + SIEM Correlation
- Blue Team Training
- Cybersecurity Interview Demonstration Project
  

### 📜 License :
This project is licensed under the MIT License.




## 👨💻 Author  
## Md. Alamgir Hasan
Cybersecurity | SOC | SIEM | Blue Team

