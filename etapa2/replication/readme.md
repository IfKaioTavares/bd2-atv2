# 📘 Replicação Simplificada no PostgreSQL

Este guia descreve o processo de configuração de **replicação streaming** no PostgreSQL de forma simples, entre um servidor **primário** e um **servidor réplica**.

---

## 🔧 Requisitos
- PostgreSQL instalado nos dois servidores (mesma versão)
- Acesso SSH entre os servidores
- IP fixo ou nome acessível de ambos os lados

---

## 🧱 1. No Servidor Primário

### 1.1 Editar `postgresql.conf`
Localize e edite o arquivo (ex: `/etc/postgresql/15/main/postgresql.conf`):

```conf
wal_level = replica
max_wal_senders = 5
wal_keep_size = 64MB
```

### 1.2 Editar `pg_hba.conf`
Adicione permissão para o IP da réplica:

```conf
host replication replicador 192.168.0.100/32 md5
```

> Substitua `192.168.0.100` pelo IP da réplica.

### 1.3 Criar usuário replicador
Acesse o `psql` e execute:

```sql
CREATE USER replicador REPLICATION LOGIN ENCRYPTED PASSWORD 'senha123';
```

### 1.4 Reinicie o PostgreSQL
```bash
sudo systemctl restart postgresql
```

---

## ⬇️ 2. No Servidor Réplica

### 2.1 Parar o PostgreSQL
```bash
sudo systemctl stop postgresql
```

### 2.2 Fazer o clone inicial com `pg_basebackup`
```bash
pg_basebackup -h 192.168.0.10 -D /var/lib/postgresql/15/main -U replicador -P -R
```

- `-h`: IP do primário
- `-D`: diretório de dados da réplica (confira o caminho correto)
- `-U`: usuário de replicação
- `-P`: exibe progresso
- `-R`: cria `standby.signal` e configura `primary_conninfo`

### 2.3 Iniciar o PostgreSQL na réplica
```bash
sudo systemctl start postgresql
```

---

## ✅ 3. Verificações

### No Primário
```sql
SELECT * FROM pg_stat_replication;
```
Você verá a réplica conectada.

### Na Réplica
```sql
SELECT pg_is_in_recovery();
-- Retorna: true
```
