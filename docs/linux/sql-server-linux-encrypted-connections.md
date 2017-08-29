---
title: Encrypting Connections to SQL Server on Linux | Microsoft Docs
description: This topic describes Encrypting Connections to SQL Server on Linux.
author: tmullaney 
ms.date: 06/14/2017
ms.author: thmullan;rickbyh 
manager: jhubbard
ms.topic: article
ms.prod: sql-linux
ms.technology: database-engine
ms.assetid: 
helpviewer_keywords: 
  - "Linux, encrypted connections"
---
# Encrypting Connections to SQL Server on Linux

[!INCLUDE[tsql-appliesto-sslinux-only](../includes/tsql-appliesto-sslinux-only.md)]

[!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] on Linux can use Transport Layer Security (TLS) to encrypt data that is transmitted across a network between a client application and an instance of [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)]. [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] supports the same TLS protocols on both Windows and Linux: TLS 1.2, 1.1, and 1.0. However, the steps to configure TLS are specific to the operating system on which [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] is running.  
 
## Typical Scenario 
TLS is used to encrypt connections from a client application to [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)]. When configured correctly, TLS provides both privacy and data integrity for communications between the client and the server.  
The following steps describe a typical scenario:  

1. Database administrator generates a private key and a certificate signing request (CSR). The CSR's Common Name should match the server name that clients specify in their SQL Server connection string. This Common Name is usually the fully qualified domain name of the [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] host. To use the same certificate for multiple servers, you can use a wildcard in the Common Name (for example, `"*.contoso.com"` instead of `"node1.contoso.com"`).   
2. The CSR is sent to a certificate authority (CA) for signing. The CA should be trusted by all client machines that connect to [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)]. The CA returns a signed certificate to the database administrator.   
3. Database administrator configures [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] to use the private key and the signed certificate for TLS connections.   
4. Clients specify `"Encrypt=True"` and `"TrustServerCertificate=False"` in their connection strings. (The specific parameter names may be different depending on which driver is being used). Clients now attempt encrypt connections to SQL Server and check the validity of SQL Server's certificate to prevent man-in-the-middle attacks.  
 
## Configuring TLS on Linux  

Use `mssql-conf` to configure TLS for an instance of [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] running on Linux. The following options are supported:  

|Option |Description |
|--- |--- |
|`network.forceencryption` |If 1, then [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] forces all connections to be encrypted. By default, this option is 0. |  
|`network.tlscert` |The absolute path to the certificate file that [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] uses for TLS. Example:   `/etc/ssl/certs/mssql.pem`  The certificate file must be accessible by the mssql account. Microsoft recommends restricting access to the file using `chown mssql:mssql <file>; chmod 400 <file>`. |  
|`network.tlskey` |The absolute path to the private key file that [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] uses for TLS. Example:  `/etc/ssl/private/mssql.key`  The certificate file must be accessible by the mssql account. Microsoft recommends restricting access to the file using `chown mssql:mssql <file>; chmod 400 <file>`. | 
|`network.tlsprotocols` |A comma-separated list of which TLS protocols are allowed by SQL Server. [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] always attempts to negotiate the strongest allowed protocol. If a client does not support any allowed protocol, [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] rejects the connection attempt.  For compatibility, all supported protocols are allowed by default (1.2, 1.1, 1.0).  If your clients support TLS 1.2, Microsoft recommends allowing only TLS 1.2. |  
|`network.tlsciphers` |Specifies which ciphers are allowed by [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] for TLS. This string must be formatted per [OpenSSL's cipher list format](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html). In general, you should not need to change this option. <br /> By default, the following ciphers are allowed: <br /> `ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA` |   
| | |
 
## Example 
This example uses a self-signed certificate. In normal production scenarios, the certificate would be signed by a CA that is trusted by all clients.  
 
### Step 1: Generate private key and certificate 
Open a command terminal on the Linux machine where [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] is running. Run the following commands:  

- Generate a self-signed certificate. Make sure the /CN matches your SQL Server host fully-qualified domain name. You may optionally use wildcards, for example `'/CN=*.contoso.com'`.    
   ```  
   openssl req -x509 -nodes -newkey rsa:2048 -subj '/CN=mssql.contoso.com' -keyout mssql.key -out mssql.pem -days 365 
   ```  

- Restrict access to `mssql`  
   ```  
   sudo chown mssql:mssql mssql.pem mssql.key 
   sudo chmod 400 mssql.pem mssql.key 
   ```  
 
- Move to system SSL directories (optional)  
   ```  
   sudo mv mssql.pem /etc/ssl/certs/ 
   sudo mv mssql.key /etc/ssl/private/ 
   ```  
 
### Step 2: Configure  [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)]  
Use `mssql-conf` to configure [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] to use the certificate and key for TLS. For increased security, you can also set TLS 1.2 as the only allowed protocol and force all clients to use encrypted connections.  

```  
sudo /opt/mssql/bin/mssql-conf set network.tlscert /etc/ssl/certs/mssql.pem 
sudo /opt/mssql/bin/mssql-conf set network.tlskey /etc/ssl/private/mssql.key 
sudo /opt/mssql/bin/mssql-conf set network.tlsprotocols 1.2 
sudo /opt/mssql/bin/mssql-conf set network.forceencryption 1 
```
 
### Step 3: Restart [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] 
[!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] must be restarted for these changes to take effect.  
`sudo systemctl restart mssql-server`  
 
### Step 4: Copy self-signed certificate to client machines 
Because this example uses a certificate self-signed by the [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] host, the certificate (not the private key) must be copied and installed as a trusted root certificate on all client machines that connect to [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)]. If the certificate is signed by a CA that is already trusted by all clients, this step is not necessary. 
 
### Step 5: Connect from clients using TLS 
Connect to [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] from a client with encryption enabled and `TrustServerCertificate` set to `False` in the connection string. Here are a few examples of how to specify these parameters using different tools and drivers. 

sqlcmd  
`sqlcmd -N -C -S mssql.contoso.com -U sa -P '<YourPassword>'`  

[!INCLUDE[ssmanstudiofull-md](../includes/ssmanstudiofull-md.md)]   
  ![SSMS connection dialog](media/sql-server-linux-encrypted-connections/ssms-encrypt-connection.png "SSMS connection dialog")  
  
ADO.NET  
`"Encrypt=true; TrustServerCertificate=true;"`  

ODBC   
`"Encrypt=yes; TrustServerCertificate=no;"`  

JDBC  
`"encrypt=true; trustServerCertificate=false;" `

 
## Common connection errors  

|Error message |Fix |
|--- |--- |
|The certificate chain was issued by an authority that is not trusted.  |This error occurs when clients are unable to verify the signature on the certificate presented by SQL Server during the TLS handshake. Make sure the client trusts either the [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] certificate directly, or the CA which signed the SQL Server certificate. |
|The target principal name is incorrect.  |Make sure that Common Name field on SQL Server's certificate matches the server name specified in the client's connection string. |  
|An existing connection was forcibly closed by the remote host. |This error can occur when the client doesn't support the TLS protocol version required by SQL Server. For example, if [!INCLUDE[ssNoVersion](../includes/ssnoversion-md.md)] is configured to require TLS 1.2, make sure your clients also support the TLS 1.2 protocol. |
| | |   

