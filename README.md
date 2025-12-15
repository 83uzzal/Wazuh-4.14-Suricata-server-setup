# Wazuh 4.14 + Suricata Server Setup

This repository provides a **production-ready Bash installation script** to deploy **Wazuh 4.14 (server components)** integrated with **Suricata IDS** on **Ubuntu 22.04 / 24.04**.

The solution is designed for **SOC labs, SIEM practice, Blue Team training, and enterprise-style server deployments**, with a strong focus on **automation, stability, and clean log integration**.

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
```bash
git clone https://github.com/83uzzal/Wazuh-4.14-Suricata-server-setup.git
cd Wazuh-4.14-Suricata-server-setup

