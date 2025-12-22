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

<img width="501" height="216" alt="image" src="https://github.com/user-attachments/assets/a19f4fe7-321c-4c3f-84a6-a1e539359ad0" />

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

# 🛡️ Custom Suricata Local Rule Test (Windows → Wazuh)

This guide explains how to create and test a **custom Suricata local rule** and verify alerts from a **Windows agent machine** in **Wazuh + Suricata**.

---

## ✅ Step 1: Create a Custom Local Rule

On your **Ubuntu Suricata/Wazuh server**, open the local rules file:

```bash
sudo mousepad /var/lib/suricata/rules/local.rules
```

Add the following rule:

```text
alert http any any -> any any (msg:"SURICATA TEST - WINDOWS HTTP REQUEST"; flow:to_server,established; content:"/testsuri"; http_uri; nocase; sid:10000001; rev:2;)
```

### 🔎 Rule Explanation

* **alert http** → Inspect HTTP traffic
* **flow:to_server,established** → Only client → server traffic
* **content:"/testsuri"; http_uri** → Match URI path
* **sid:10000001** → Custom rule SID (use ≥ 1,000,000)

---

## ✅ Step 2: Reload Suricata Rules

Apply and validate the rule:

```bash
sudo suricata-update
sudo systemctl restart suricata
sudo suricata -T -c /etc/suricata/suricata.yaml
```

Expected output:

```text
Configuration provided was successfully loaded. Exiting.
```

---

## ✅ Step 3: Create a Local Web Endpoint (Important)

Suricata needs **real HTTP traffic** to trigger alerts.

Install Apache:

```bash
sudo apt install apache2 -y
```

Create a test endpoint:

```bash
echo "Suricata test OK" | sudo tee /var/www/html/testsuri
```

### 🌐 Test URL

```
http://192.168.68.76/testsuri
```

(Replace IP with your Suricata server IP)

---

## ✅ Step 4: Trigger Alert from Windows Agent

### 🔹 From PowerShell / CMD

```powershell
curl http://192.168.68.76/testsuri
```

### 🔹 From Browser

Open in any browser:

```
http://192.168.68.76/testsuri
```

---

## ✅ Step 5: Verify Suricata Log (Server)

```bash
sudo jq 'select(.alert.signature=="SURICATA TEST - WINDOWS HTTP REQUEST")' /var/log/suricata/eve.json
```

---

## ✅ Step 6: Verify in Wazuh Dashboard

Navigate to:

```
Security Events → IDS → Suricata
```

Or search:

```
data.alert.signature:"SURICATA TEST - WINDOWS HTTP REQUEST"
```

---

## 🧠 Important Notes

* Browser cache does **NOT** affect Suricata
* Same TCP session may not trigger repeated alerts
* Use different query strings for multiple tests:

```powershell
curl http://192.168.68.76/testsuri?test=1
curl http://192.168.68.76/testsuri?test=2
```

---

## ✅ Result

You have successfully:

* Created a custom Suricata rule
* Generated Windows-based HTTP traffic
* Detected traffic in Suricata
* Visualized alerts in Wazuh

🎯 **This setup is ideal for SOC labs, IDS testing, and interviews.**


<img width="1366" height="635" alt="image" src="https://github.com/user-attachments/assets/e8d2858c-9e22-40cc-bac1-1846938883ff" />

 
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

