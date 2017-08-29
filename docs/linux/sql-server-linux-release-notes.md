---
title: Release notes for SQL Server 2017 on Linux | Microsoft Docs
description: This topic contains the release notes and supported features for SQL Server 2017 running on Linux. Release notes are included for RC2 and prior versions.
author: rothja 
ms.author: jroth 
manager: jhubbard
ms.date: 08/07/2017
ms.topic: article
ms.prod: sql-linux
ms.technology: database-engine
ms.assetid: 1314744f-fcaf-46db-800e-2918fa7e1b6c
---
# Release notes for SQL Server 2017 on Linux

The following release notes apply to SQL Server 2017 running on Linux. This release supports many of the SQL Server database engine features for Linux. The topic below is broken into sections for each release, beginning with the most recent release, RC2. See the information in each section for supported platforms, tools, features, and known issues.

The following table lists the releases of SQL Server 2017 covered in this topic.

| Release | Version | Release date |
|-----|-----|-----|
| [RC2](#RC2) | 14.0.900.75 | 8-2017 |
| [RC1](#RC1) | 14.0.800.90 | 7-2017 |
| [CTP 2.1](#ctp21) | 14.0.600.250 | 5-2017 |
| [CTP 2.0](#ctp20) | 14.0.500.272 | 4-2017 |
| [CTP 1.4](#ctp14) | 14.0.405.198 | 3-2017 |
| [CTP 1.3](#ctp13) | 14.0.304.138 | 2-2017 |
| [CTP 1.2](#ctp12) | 14.0.200.24 | 1-2017 |
| [CTP 1.1](#ctp11) | 14.0.100.187 | 12-2016 |
| [CTP 1.0](#ctp10) | 14.0.1.246 | 11-2016 |

## <a id="RC2"></a> RC2 (August 2017)

The SQL Server engine version for this release is 14.0.900.75.

### Supported platforms

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.3 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| SUSE Enterprise Linux Server v12 SP2 | EXT4 | [Installation guide](quickstart-install-connect-suse.md) |
| Ubuntu 16.04LTS | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE]
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has been tested up to 1.5 TB of memory at this time.

### Package details

Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](sql-server-linux-setup.md)
- [Install Full-text Search package](sql-server-linux-setup-full-text-search.md)
- [Install SQL Server Agent package](sql-server-linux-setup-sql-agent.md)

| Package | Package version | Downloads |
|-----|-----|-----|
| Red Hat RPM package | 14.0.900.75-1 | [Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.900.75-1.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.900.75-1.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-fts-14.0.900.75-1.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.900.75-1.x86_64.rpm) | 
| SLES RPM package | 14.0.900.75-1 | [mssql-server Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-14.0.900.75-1.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-ha-14.0.900.75-1.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-fts-14.0.900.75-1.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.900.75-1.x86_64.rpm) | 
| Ubuntu 16.04 Debian package | 14.0.900.75-1 | [Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.900.75-1_amd64.deb)</br>[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.900.75-1_amd64.deb)</br>[Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.900.75-1_amd64.deb)</br>[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.900.75-1_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows](https://go.microsoft.com/fwlink/?linkid=847722) | 17.0 |
| [SQL Server Data Tools for Visual Studio](https://go.microsoft.com/fwlink/?linkid=846626) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest |

### Unsupported features and services

The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Transactional replication |
| &nbsp; | Merge replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed query with 3rd-party connections |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| &nbsp; | Buffer Pool Extension |
| **SQL Server Agent** |  Subsystems: CmdExec, PowerShell, Queue Reader, SSIS, SSAS, SSRS |
| &nbsp; | Alerts |
| &nbsp; | Log Reader Agent |
| &nbsp; | Change Data Capture |
| &nbsp; | Managed Backup |
| **High Availability** | Database mirroring  |
| **Security** | Extensible Key Management |
| **Services** | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues

The following sections describe known issues with this release of SQL Server 2017 RC2 on Linux.

#### General

- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- The default language of the **sa** login is English.

    - **Resolution**: Change the language of the **sa** login with the **ALTER LOGIN** statement.

#### Databases

- The master database cannot be moved with the mssql-conf utility. Other system databases can be moved with mssql-conf.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

- Certain algorithms (cipher suites) for Transport Layer Security (TLS) do not work properly with SQL Server on Linux. This results in connection failures when attempting to connect to SQL Server, as well as problems establishing connections between replicas in high availability groups.

   - **Resolution**: Modify the **mssql.conf** configuration script for SQL Server on Linux to disable problematic cipher suites, by doing the following:

      1. Add the following to /var/opt/mssql/mssql.conf.

      ```
      [network]
      tlsciphers=ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:!ECDHE-ECDSA-AES256-GCM-SHA384:!ECDHE-ECDSA-AES128-GCM-SHA256:!ECDHE-ECDSA-AES256-SHA384:!ECDHE-ECDSA-AES128-SHA256:!ECDHE-ECDSA-AES256-SHA:!ECDHE-ECDSA-AES128-SHA:!ECDHE-RSA-AES256-SHA384:!ECDHE-RSA-AES128-SHA256:!ECDHE-RSA-AES256-SHA:!ECDHE-RSA-AES128-SHA:!DHE-RSA-AES256-GCM-SHA384:!DHE-RSA-AES128-GCM-SHA256:!DHE-RSA-AES256-SHA:!DHE-RSA-AES128-SHA:!DHE-DSS-AES256-SHA256:!DHE-DSS-AES128-SHA256:!DHE-DSS-AES256-SHA:!DHE-DSS-AES128-SHA:!DHE-DSS-DES-CBC3-SHA:!NULL-SHA256:!NULL-SHA
      ```

      1. Restart SQL Server with the following command.
   
      ```
      sudo systemctl restart mssql-server
      ```

- SQL Server 2014 databases on Windows that use In-memory OLTP cannot be restored on SQL Server 2017 on Linux. To restore a SQL Server 2014 database that uses in-memory OLTP, first upgrade the databases to SQL Server 2016 or SQL Server 2017 on Windows before moving them to SQL Server on Linux via backup/restore or detach/attach.

#### Remote database files

- Hosting database files on a NFS server is not supported in this release. This includes using NFS for shared disk failover clustering as well as databases on non-clustered instances. We are working on enabling NFS server support in the upcoming releases.

#### Localization

- If your locale is not English (en_us) during setup, you must use UTF-8 encoding in your bash session/terminal. If you use ASCII encoding, you might see an error similar to the following:

   ```
   UnicodeEncodeError: 'ascii' codec can't encode character u'\xf1' in position 8: ordinal not in range(128)
   ```

   If you cannot use UTF-8 encoding, run setup using the MSSQL_LCID environment variable to specify your language choice.

   ```bash
   sudo MSSQL_LCID=<LcidValue> /opt/mssql/bin/mssql-conf setup
   ```

#### Full-Text Search
- Not all filters are available with this release, including filters for Office documents. For a list of supported filters, see [Install SQL Server Full-Text Search on Linux](sql-server-linux-setup-full-text-search.md#filters).

#### SQL Server Integration Services (SSIS)
You can run SSIS packages on Linux. For more info, see the following articles:
-   [Blog post announcing SSIS support for Linux](https://blogs.msdn.microsoft.com/ssis/2017/05/17/ssis-helsinki-is-available-in-sql-server-vnext-ctp2-1/).
-   [Install SQL Server Integration Services (SSIS) on Linux](sql-server-linux-setup-ssis.md)
-   [Extract, transform, and load data on Linux with SSIS](sql-server-linux-migrate-ssis.md)

Please note the following known issues with this release.

- The **mssql-server-is** package is supported on Ubuntu and Red Hat Enterprise Linux (RHEL) in this release.

- With SSIS on Linux CTP 2.1 Refresh and later, SSIS packages can use ODBC connections on Linux. This functionality has been tested with the SQL Server and the MySQL ODBC drivers, but is also expected to work with any Unicode ODBC driver that observes the ODBC specification. At design time, you can provide either a DSN or a connection string to connect to the ODBC data; you can also use Windows authentication. For more info, see the [blog post announcing ODBC support on Linux](https://blogs.msdn.microsoft.com/ssis/2017/06/16/odbc-is-supported-in-ssis-on-linux-ssis-helsinki-ctp2-1-refresh/).

- The following features are not supported in this release when you run SSIS packages on Linux:
  - SSIS Catalog database
  - Scheduled package execution by SQL Agent
  - Windows Authentication
  - Third-party components
  - Change Data Capture (CDC)
  - SSIS Scale Out
  - Azure Feature Pack for SSIS
  - Hadoop and HDFS support
  - Microsoft Connector for SAP BW

#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS are not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- Number of log files to retain cannot be modified.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="RC1"></a> RC1 (July 2017)
The SQL Server engine version for this release is 14.0.800.90.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.3 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| SUSE Enterprise Linux Server v12 SP2 | EXT4 | [Installation guide](quickstart-install-connect-suse.md) |
| Ubuntu 16.04LTS | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE]
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has been tested up to 1 TB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](sql-server-linux-setup.md)
- [Install Full-text Search package](sql-server-linux-setup-full-text-search.md)
- [Install SQL Server Agent package](sql-server-linux-setup-sql-agent.md)

| Package | Package version | Downloads |
|-----|-----|-----|
| Red Hat RPM package | 14.0.800.90-2 | [Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.800.90-2.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.800.90-2.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-fts-14.0.800.90-2.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.800.90-2.x86_64.rpm) | 
| SLES RPM package | 14.0.800.90-2 | [mssql-server Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-14.0.800.90-2.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-ha-14.0.800.90-2.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-fts-14.0.800.90-2.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.800.90-2.x86_64.rpm) | 
| Ubuntu 16.04 Debian package | 14.0.800.90-2 | [Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.800.90-2_amd64.deb)</br>[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.800.90-2_amd64.deb)</br>[Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.800.90-2_amd64.deb)</br>[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.800.90-2_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows](https://go.microsoft.com/fwlink/?linkid=847722) | 17.0 |
| [SQL Server Data Tools for Visual Studio](https://go.microsoft.com/fwlink/?linkid=846626) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest |

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Transactional replication |
| &nbsp; | Merge replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | Machine Learning Services |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **SQL Server Agent** |  Subsystems: CmdExec, PowerShell, Queue Reader, SSIS, SSAS, SSRS |
| &nbsp; | Alerts |
| &nbsp; | Log Reader Agent |
| &nbsp; | Change Data Capture |
| &nbsp; | Managed Backup |
| **High Availability** | Database mirroring  |
| &nbsp; | Availability group rolling upgrade |
| **Security** | Extensible Key Management |
| **Services** | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 RC1 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- The default language of the **sa** login is English.

    - **Resolution**: Change the language of the **sa** login with the **ALTER LOGIN** statement.

#### Databases

- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

#### Remote database files

- Hosting database files on a NFS server is not supported in this release. This includes using NFS for shared disk failover clustering as well as databases on non-clustered instances. We are working on enabling NFS server support in the upcoming releases.

#### Cross platform availability groups and distributed availability groups

- Due to a known issue, creating availability groups with replicas on instances hosted on both Windows and Linux is not working in this release. This includes distributed availability groups. The fix will be available in the upcoming release candidate build. 

#### Server Collation

- When using the MSSQL_COLLATION override, OR when doing a localized (non English) install, it is possible SQL Server will hit a deadlock when trying to set the server collation, which generates a dump. Setup does complete successfully, however the server collation will not have been set. The workaround is to simply run ./mssql-conf set-collation and enter the collation name desired when prompted (the collation name can be found in the errorlog at the line: “Attempting to change default collation to …”). 
 
#### Localization

- If your locale is not English (en_us) during setup, you must use UTF-8 encoding in your bash session/terminal. If you use ASCII encoding, you might see an error similar to the following:

   ```
   UnicodeEncodeError: 'ascii' codec can't encode character u'\xf1' in position 8: ordinal not in range(128)
   ```

   If you cannot use UTF-8 encoding, run setup using the MSSQL_LCID environment variable to specify your language choice.

   ```bash
   sudo MSSQL_LCID=<LcidValue> /opt/mssql/bin/mssql-conf setup
   ```

#### <a name = "fci"></a>Shared disk cluster instance upgrade

In RC1 the cluster resource agent sets the virtual server name like it does in a Failover Cluster Instance on Windows. Prior to RC1 `@@servername` on a shared disk cluster returned the specific node name so after failover `@@servername` returned a different value. In RC1 the serverName of the shared disk cluster instance is updated with the resource name when the resource is added to the cluster. Because of this, the cluster will have to restart the SQL Server after the manual failover during the upgrade - as in the following steps:

1. Upgrade secondary (passive) cluster node first.
   - Upgrade **mssql-server** package.
   - Upgrade **mssql-server-ha** package.
1. Manually fail over to the upgraded node.
   `pcs resource move <resourceName>`
   - Resource fails initially because the resource agent checks the actual and expected serverName. The expected serverName will be different.
   - Cluster will restart SQL Server resource on the same node. This will update the server name.
1. Upgrade the other node. 
   - Upgrade **mssql-server** package.
   - Upgrade **mssql-server-ha** package.
1. Remove the constraint added by the manual resource move. See [Failover cluster manually](sql-server-linux-shared-disk-cluster-red-hat-7-operate.md#failManual).
2. If desired, fail back to the original primary node. 

#### Availability group

On Linux, rolling upgrade of SQL Server 2017 CTP 2.1 to RC1 is not supported. After you upgrade the secondary replica, it will disconnect from the primary replica until the primary replica is upgraded. Microsoft is planning to resolve this for a future release.

#### Full-Text Search
- Not all filters are available with this release, including filters for Office documents. For a list of supported filters, see [Install SQL Server Full-Text Search on Linux](sql-server-linux-setup-full-text-search.md#filters).

#### SQL Server Integration Services (SSIS)

- The **mssql-server-is** package is not supported on SUSE in this release. It is currently supported on Ubuntu and on Red Hat Enterprise Linux (RHEL).

- The following features are not supported in this release when you run SSIS packages on Linux:
  - SSIS Catalog database
  - Scheduled package execution by SQL Agent
  - Windows Authentication
  - Third-party components
  - Change Data Capture (CDC)
  - SSIS Scale Out
  - Azure Feature Pack for SSIS
  - Hadoop and HDFS support
  - Microsoft Connector for SAP BW

For more info about SSIS on Linux, see the following articles:
-   [Install SQL Server Integration Services (SSIS) on Linux](sql-server-linux-setup-ssis.md)
-   [Extract, transform, and load data on Linux with SSIS](sql-server-linux-migrate-ssis.md)

#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS are not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- Number of log files to retain cannot be modified.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="ctp21"></a> CTP 2.1 (May 2017)
The SQL Server engine version for this release is 14.0.600.250.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.3 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| SUSE Enterprise Linux Server v12 SP2 | EXT4 | [Installation guide](quickstart-install-connect-suse.md) |
| Ubuntu 16.04LTS | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE]
> You need at least 3.25 GB of memory to run SQL Server on Linux.
> SQL Server Engine has been tested up to 1 TB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. You do not need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](sql-server-linux-setup.md)
- [Install Full-text Search package](sql-server-linux-setup-full-text-search.md)
- [Install SQL Server Agent package](sql-server-linux-setup-sql-agent.md)

| Package | Package version | Downloads |
|-----|-----|-----|
| Red Hat RPM package | 14.0.600.250-2 | [Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.600.250-2.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.600.250-2.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-fts-14.0.600.250-2.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.600.250-2.x86_64.rpm) | 
| SLES RPM package | 14.0.600.250-2 | [mssql-server Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-14.0.600.250-2.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-ha-14.0.600.250-2.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-fts-14.0.600.250-2.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.600.250-2.x86_64.rpm) | 
| Ubuntu 16.04 Debian package | 14.0.600.250-2 | [Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.600.250-2_amd64.deb)</br>[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.600.250-2_amd64.deb)</br>[Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.600.250-2_amd64.deb)</br>[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.600.250-2_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows](https://go.microsoft.com/fwlink/?linkid=847722) | 17.0 |
| [SQL Server Data Tools for Visual Studio](https://go.microsoft.com/fwlink/?linkid=846626) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest (1.12) |

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **High Availability** | Database mirroring  |
| **Security** | Active Directory Authentication |
| &nbsp; | Windows Authentication |
| &nbsp; | Extensible Key Management |
| &nbsp; | Use of user-provided certificate for SSL or TLS |
| **Services** | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 CTP 2.1 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- The default language of the **sa** login is English.

    - **Resolution**: Change the language of the **sa** login with the **ALTER LOGIN** statement.

#### Databases
- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

#### Always On Availability Group
- `sys.fn_hadr_backup_is_preffered_replica` does not work for `CLUSTER_TYPE=NONE` or `CLUSTER_TYPE=EXTERNAL` because it relies on the WSFC-replicated cluster registry key which not available. We are working on providing a similar functionality through a different function. 

#### Full-Text Search
- Not all filters are available with this release, including filters for Office documents. For a list of supported filters, see [Install SQL Server Full-Text Search on Linux](sql-server-linux-setup-full-text-search.md#filters).

#### SQL Agent
- The following components and subsystems of SQL Agent jobs are not currently supported on Linux:

    - Subsystems: CmdExec, PowerShell, Replication Distributor, Snapshot, Merge, Queue Reader, SSIS, SSAS, SSRS
    - Alerts
    - DB Mail
    - Log Reader Agent 
    - Change Data Capture

#### SqlPackage
- Using SqlPackage requires specifying an absolute path for files. Using relative paths will map the files under the "/tmp/sqlpackage.\<code\>/system/system32" folder. 

  - **Resolution**: Use absolute file paths.

- SqlPackage shows the location of files with a "C:\\" prefix.

#### <a name="ssis"></a> SQL Server Integration Services (SSIS)
You can run SSIS packages on Linux. For more info, see the [blog post announcing SSIS support for Linux](https://blogs.msdn.microsoft.com/ssis/2017/05/17/ssis-helsinki-is-available-in-sql-server-vnext-ctp2-1/). Please note the following known issues with this release.

- The **mssql-server-is** package is only supported on Ubuntu at this time.

- The following features are not supported when running SSIS packages on Linux:
  - SSIS Catalog DB
  - Schedule Packages execution by SQL Agent
  - Windows Authentication
  - Third-party components
  - Third-party ODBC drivers
  - ODBC Connection Manager, Source, and Destination (supported with SSIS on Linux CTP 2.1 Refresh)
  - Change Data Capture (CDC)
  - Scale Out
  - Azure Feature Pack
  - Hadoop and HDFS Support
  - Microsoft Connector for SAP BW

With SSIS on Linux CTP 2.1 Refresh, your SSIS packages can use ODBC connections on Linux. For more info, see the [blog post announcing ODBC support on Linux](https://blogs.msdn.microsoft.com/ssis/2017/06/16/odbc-is-supported-in-ssis-on-linux-ssis-helsinki-ctp2-1-refresh/).

#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS are not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- Number of log files to retain cannot be modified.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="ctp20"></a> CTP 2.0 (April 2017)
The SQL Server engine version for this release is 14.0.500.272.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.3 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| SUSE Enterprise Linux Server v12 SP2 | EXT4 | [Installation guide](quickstart-install-connect-suse.md) |
| Ubuntu 16.04LTS and 16.10 | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE] 
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has been tested up to 1 TB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](sql-server-linux-setup.md)
- [Install Full-text Search package](sql-server-linux-setup-full-text-search.md)
- [Install SQL Server Agent package](sql-server-linux-setup-sql-agent.md)

| Package | Package version | Downloads |
|-----|-----|-----|
| Red Hat RPM package | 14.0.500.272-2 | [Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.500.272-2.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.500.272-2.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-fts-14.0.500.272-2.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.500.272-2.x86_64.rpm) | 
| SLES RPM package | 14.0.500.272-2 | [mssql-server Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-14.0.500.272-2.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-ha-14.0.500.272-2.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-fts-14.0.500.272-2.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.500.272-2.x86_64.rpm) | 
| Ubuntu 16.04 Debian package | 14.0.500.272-2 | [Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.500.272-2_amd64.deb)</br>[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.500.272-2_amd64.deb)</br>[Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.500.272-2_amd64.deb)</br>[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.500.272-2_amd64.deb) |
| Ubuntu 16.10 Debian package | 14.0.500.272-2 | [Engine Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.500.272-2_amd64.deb)</br>[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.500.272-2_amd64.deb)</br>[Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.500.272-2_amd64.deb)</br>[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.500.272-2_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows - Release Candidate 2](https://go.microsoft.com/fwlink/?linkid=840957) | 17.0 |
| [SQL Server Data Tools for Visual Studio - Release Candidate 2](https://go.microsoft.com/fwlink/?linkid=837939) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest (0.2.1) |

> [!NOTE] 
> The SQL Server Management Studio and SQL Server Data Tools versions specified above are Release Candidates, hence not recommended for use in production.

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **High Availability** | Database mirroring  |
| **Security** | Active Directory Authentication |
| &nbsp; | Windows Authentication |
| &nbsp; | Extensible Key Management |
| &nbsp; | Use of user-provided certificate for SSL or TLS |
| **Services** | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Integration Services | 
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 CTP 2.0 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- The default language of the **sa** login is English.

    - **Resolution**: Change the language of the **sa** login with the **ALTER LOGIN** statement.

#### Databases
- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

#### Always On Availability Group
- All HA configurations - meaning availability group is added as a resource to a Pacemaker cluster - created with pre CTP2.0 packages are not backwards compatible with the new package. Delete all previously configured clustered resources and create new availability groups with `CLUSTER_TYPE=EXTERNAL`. See [Configure Always On Availability Group for SQL Server on Linux](sql-server-linux-availability-group-configure-ha.md).
- Availability groups created with `CLUSTER_TYPE=NONE` and not added as resources in the cluster will continue working after upgrade. Use for read-scale scenarios. See [Configure read-scale availability group for SQL Server on Linux](sql-server-linux-availability-group-configure-rs.md).
- `sys.fn_hadr_backup_is_preffered_replica` does not work for `CLUSTER_TYPE=NONE` or `CLUSTER_TYPE=EXTERNAL` because it relies on the WSFC-replicated cluster registry key which not available. We are working on providing a similar functionality through a different function. 

#### Full-Text Search
- Not all filters are available with this release, including filters for Office documents. For a list of supported filters, see [Install SQL Server Full-Text Search on Linux](sql-server-linux-setup-full-text-search.md#filters).

- The Korean word breaker takes several seconds to load and generates an error on first use. After this initial error, it should work normally.

#### SQL Agent
- The following components and subsystems of SQL Agent jobs are not currently supported on Linux:

    - Subsystems: CmdExec, PowerShell, Replication Distributor, Snapshot, Merge, Queue Reader, SSIS, SSAS, SSRS
    - Alerts
    - DB Mail
    - Log Reader Agent 
    - Change Data Capture

#### SqlPackage
- Using SqlPackage requires specifying an absolute path for files. Using relative paths will map the files under the "/tmp/sqlpackage.\<code\>/system/system32" folder. 

    - **Resolution**: Use absolute file paths.

- SqlPackage shows the location of files with a "C:\\" prefix.

    
#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS are not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- Number of log files to retain cannot be modified.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="ctp14"></a> CTP 1.4 (March 2017)
The SQL Server engine version for this release is 14.0.405.198.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.3 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| SUSE Enterprise Linux Server v12 SP2 | EXT4 | [Installation guide](quickstart-install-connect-suse.md) |
| Ubuntu 16.04LTS and 16.10 | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE] 
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has been tested up to 1 TB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the installation guides below
-	[Install SQL Server package](sql-server-linux-setup.md)
-	[Install Full-text Search package](sql-server-linux-setup-full-text-search.md)
-	[Install SQL Server Agent package](sql-server-linux-setup-sql-agent.md)

| Package | Package version | Downloads |
|-----|-----|-----|
| Red Hat RPM package | 14.0.405.200-1 | [Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.405.200-1.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.405.200-1.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-fts-14.0.405.200-1.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.405.200-1.x86_64.rpm) | 
| SLES RPM package | 14.0.405.200-1 | [mssql-server Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-14.0.405.200-1.x86_64.rpm)</br>[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-ha-14.0.405.200-1.x86_64.rpm)</br>[Full-text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-fts-14.0.405.200-1.x86_64.rpm)</br>[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-agent-14.0.405.200-1.x86_64.rpm) | 
| Ubuntu 16.04 Debian package | 14.0.405.200-1 | [Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.405.200-1_amd64.deb)</br>[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.405.200-1_amd64.deb)</br>[Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.405.200-1_amd64.deb)</br>[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.405.200-1_amd64.deb) |
| Ubuntu 16.10 Debian package | 14.0.405.200-1 | [Engine Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.405.200-1_amd64.deb)</br>[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.405.200-1_amd64.deb)</br>[Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.405.200-1_amd64.deb)</br>[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.405.200-1_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows - Release Candidate 2](https://go.microsoft.com/fwlink/?linkid=840957) | 17.0 |
| [SQL Server Data Tools for Visual Studio - Release Candidate 2](https://go.microsoft.com/fwlink/?linkid=837939) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest (0.2.1) |

> [!NOTE] 
> The SQL Server Management Studio and SQL Server Data Tools versions specified above are Release Candidates, hence not recommended for use in production.

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **High Availability** | Database mirroring  |
| **Security** | Active Directory Authentication |
| &nbsp; | Windows Authentication |
| &nbsp; | Extensible Key Management |
| &nbsp; | Use of user-provided certificate for SSL or TLS |
| **Services** | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Integration Services | 
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 CTP 1.4 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Do not run the command `ALTER SERVICE MASTER KEY REGENERATE`. There is a known bug that will cause SQL Server to become unstable. If you need to regenerate the Service Master Key, you should back up your database files, uninstall and then re-install SQL Server, and then restore your database files again.

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Some time zone names in Linux don’t map exactly to Windows time zone names.

    - **Resolution**: Use time zone names from TZID column in the ‘Mapping for: Windows’ section table on the [Unicode.org documentation page](http://www.unicode.org/cldr/charts/latest/supplemental/zone_tzid.html).

- SQL Server Engine expects lines in text files to be terminated with CR-LF (Windows-style line formatting).

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- All log files and error logs are encoded in UTF-16.

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- **CREATE ASSEMBLY** will not work when trying to use a file. Use the **FROM \<bits\>** method instead for now. 

#### Databases
- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

#### Always On Availability Group
- Always On Availability Group clustered resources on Linux that were created with CTP 1.3 will fail after you upgrade HA package (mssql-server-ha). 

   - **Resolution**: Before you upgrade the HA package, set the cluster resource parameter `notify=true`. 
   
      - The following example sets the cluster resource parameter on a resource named **ag1** on RHEL or Ubuntu: 

      ```bash
      sudo pcs resource update ag1-master notify=true
      ```

      - For SLES, update availability group resource configuration to add `notify=true`.  

      ```bash
      crm configure edit ms-ag_cluster 
      ```

      Add `notify=true` and save the resource configuration.

- Always On Availability Groups in Linux may be subject to data loss if replicas are in synchronous commit mode. See details as appropriate for your Linux distribution. 

   - [RHEL](sql-server-linux-availability-group-cluster-rhel.md)
   - [SLES](sql-server-linux-availability-group-cluster-sles.md)
   - [Ubuntu](sql-server-linux-availability-group-cluster-ubuntu.md)

#### Full-Text Search
- Not all filters are available with this release, including filters for Office documents. For a list of supported filters, see [Install SQL Server Full-Text Search on Linux](sql-server-linux-setup-full-text-search.md#filters).

- The Korean word breaker takes several seconds to load and generates an error on first use. After this initial error, it should work normally.

#### SQL Agent
- The following components and subsystems of SQL Agent jobs are not currently supported on Linux:
    - Subsystems: CmdExec, PowerShell, Replication Distributor, Snapshot, Merge, Queue Reader, SSIS, SSAS, SSRS
    - Alerts
    - DB Mail
    - Log Shipping
    - Log Reader Agent 
    - Change Data Capture

#### In-Memory OLTP
- In-Memory OLTP databases can only be created in the /var/opt/mssql directory. For more information, visit the [In-memory OLTP Topic](sql-server-linux-performance-get-started.md#use-in-memory-oltp).

#### SqlPackage
- Using SqlPackage requires specifying an absolute path for files. Using relative paths will map the files under the "/tmp/sqlpackage.\<code\>/system/system32" folder. 

    - **Resolution**: Use absolute file paths.

- SqlPackage shows the location of files with a "C:\\" prefix.

    
#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS is not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- The file browser is restricted to the  "C:\\" scope, which resolves to /var/opt/mssql/ on Linux. To use other paths, generate scripts of the UI operation and replace the C:\\ paths with Linux paths. Then execute the script manually in SSMS.

- Number of log files to retain cannot be modified.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="ctp13"></a> CTP 1.3 (February 2017)
The SQL Server engine version for this release is 14.0.304.138.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.3 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| SUSE Enterprise Linux Server v12 SP2 | EXT4 | [Installation guide](quickstart-install-connect-suse.md) |
| Ubuntu 16.04LTS and 16.10 | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE] 
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has been tested up to 1 TB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the [installation guides](sql-server-linux-setup.md).

| Package | Package version | Downloads |
|-----|-----|-----|
| Red Hat RPM package | 14.0.304.138-1 | [mssql-server Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.304.138-1.x86_64.rpm)</br>[mssql-server-ha High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.304.138-1.x86_64.rpm)</br>[mssql-server-fts Full-text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-fts-14.0.304.138-1.x86_64.rpm) | 
| SLES RPM package | 14.0.304.138-1 | [mssql-server Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-14.0.304.138-1.x86_64.rpm)</br>[mssql-server-ha High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-ha-14.0.304.138-1.x86_64.rpm)</br>[mssql-server-fts Full-text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server/mssql-server-fts-14.0.304.138-1.x86_64.rpm) | 
| Ubuntu 16.04 Debian package | 14.0.304.138-1 | [mssql-server Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.304.138-1_amd64.deb)</br>[mssql-server-ha High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.304.138-1_amd64.deb)</br>[mssql-server-fts Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.304.138-1_amd64.deb) |
| Ubuntu 16.10 Debian package | 14.0.304.138-1 | [mssql-server Engine Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.304.138-1_amd64.deb)</br>[mssql-server-ha High Availability Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.304.138-1_amd64.deb)</br>[mssql-server-fts Full-text Search Debian package](https://packages.microsoft.com/ubuntu/16.10/mssql-server/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.304.138-1_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows - Release Candidate 2](https://go.microsoft.com/fwlink/?linkid=840957) | 17.0 |
| [SQL Server Data Tools for Visual Studio - Release Candidate 2](https://go.microsoft.com/fwlink/?linkid=837939) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest (0.2.1) |

> [!NOTE] 
> The SQL Server Management Studio and SQL Server Data Tools versions specified above are Release Candidates, hence not recommended for use in production.

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **High Availability** | Database mirroring  |
| **Security** | Active Directory Authentication |
| &nbsp; | Windows Authentication |
| &nbsp; | Extensible Key Management |
| &nbsp; | Use of user-provided certificate for SSL or TLS |
| **Services** | SQL Server Agent |
| &nbsp; | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Integration Services | 
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 CTP 1.3 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Do not run the command `ALTER SERVICE MASTER KEY REGENERATE`. There is a known bug that will cause SQL Server to become unstable. If you need to regenerate the Service Master Key, you should back up your database files, uninstall and then re-install SQL Server, and then restore your database files again.

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Some time zone names in Linux don’t map exactly to Windows time zone names.

    - **Resolution**: Use time zone names from TZID column in the ‘Mapping for: Windows’ section table on the [Unicode.org documentation page](http://www.unicode.org/cldr/charts/latest/supplemental/zone_tzid.html).

- SQL Server Engine expects lines in text files to be terminated with CR-LF (Windows-style line formatting).

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- All log files and error logs are encoded in UTF-16.

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- **CREATE ASSEMBLY** will not work when trying to use a file. Use the **FROM \<bits\>** method instead for now. 

#### Databases
- Changing the locations of TempDB data and log files is not supported.

- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

- Always On Availability Groups in Linux may be subject to data loss if replicas are in synchronous commit mode. See 
 
   - [RHEL](sql-server-linux-availability-group-cluster-rhel.md)
   - [SLES](sql-server-linux-availability-group-cluster-sles.md)
   - [Ubuntu](sql-server-linux-availability-group-cluster-ubuntu.md)

   
#### Full-Text Search
- Not all filters are available with this release, including filters for Office documents. For a list of supported filters, see [Install SQL Server Full-Text Search on Linux](sql-server-linux-setup-full-text-search.md#filters).

- The Korean word breaker takes several seconds to load and generates an error on first use. After this initial error, it should work normally.

#### In-Memory OLTP
- In-Memory OLTP databases can only be created in the /var/opt/mssql directory. For more information, visit the [In-memory OLTP Topic](sql-server-linux-performance-get-started.md#use-in-memory-oltp).  

#### SqlPackage
- Using SqlPackage requires specifying an absolute path for files. Using relative paths will map the files under the "/tmp/sqlpackage./<code/>/system/system32" folder. 

    - **Resolution**: Use absolute file paths.

- SqlPackage shows the location of files with a "C:\\" prefix.

#### Sqlcmd/BCP & ODBC 
- SQL Server Command Line tools (mssql-tools) and the ODBC Driver (msodbcsql) depends on a custom unixODBC Driver Manager. This causes conflicts if you have a previously installed unixODBC Driver Manager. 

    - **Resolution**: On Ubuntu, the conflict will be resolved automatically. When prompted if you would like to uninstall the existing unixODBC Driver Manager, type 'y' and proceed with the installation. On RedHat, you will have to remove the existing unixODBC Driver Manager manually using `yum remove unixODBC`. We are working on fixing this limitation for RHEL and SUSE and should have an update for you soon.  
    
#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS is not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- The SQL Server Agent is not supported yet. Therefore, SQL Server Agent functionality in SSMS does not work on Linux at the moment.

- The file browser is restricted to the  "C:\\" scope, which resolves to /var/opt/mssql/ on Linux. To use other paths, generate scripts of the UI operation and replace the C:\\ paths with Linux paths. Then execute the script manually in SSMS.

- Number of log files to retain cannot be modified.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="ctp12"> CTP 1.2 (January 2017)
The SQL Server engine version for this release is 14.0.200.24.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.3 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| SUSE Enterprise Linux Server v12 SP2 | EXT4 | [Installation guide](quickstart-install-connect-suse.md) |
| Ubuntu 16.04LTS and 16.10 | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE] 
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has only been tested up to 256GB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the [installation guides](sql-server-linux-setup.md).

| Package | Package version | Downloads |
|-----|-----|-----|
| RPM package | 14.0.200.24-2 | [mssql-server 14.0.200.24-2 Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.200.24-2.x86_64.rpm)</br>[mssql-server 14.0.200.24-2 High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.200.24-2.x86_64.rpm) | 
| Debian package | 14.0.200.24-2 | [mssql-server 14.0.200.24-2 Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.200.24-2_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows - Release Candidate 1](https://go.microsoft.com/fwlink/?LinkID=835608) | 17.0 |
| [SQL Server Data Tools for Visual Studio - Release Candidate 1](https://go.microsoft.com/fwlink/?LinkID=835150) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest (0.2) |

> [!NOTE] 
> The SQL Server Management Studio and SQL Server Data Tools versions specified above are Release Candidates, hence not recommended for use in production.

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Full-text Search |
| &nbsp; | Replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **High Availability** | Always On Availability Groups |
| &nbsp; | Database mirroring  |
| **Security** | Active Directory Authentication |
| &nbsp; | Windows Authentication |
| &nbsp; | Extensible Key Management |
| &nbsp; | Use of user-provided certificate for SSL or TLS |
| **Services** | SQL Server Agent |
| &nbsp; | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Integration Services | 
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 CTP 1.2 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Do not run the command `ALTER SERVICE MASTER KEY REGENERATE`. There is a known bug that will cause SQL Server to become unstable. If you need to regenerate the Service Master Key, you should back up your database files, uninstall and then re-install SQL Server, and then restore your database files again.

- Resource name for SQL resource changed from ocf:sql:fci to ocf:mssql:fci. More details about configuring a shared disk failover cluster you can find [here](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-shared-disk-cluster-red-hat-7-configure).

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Some time zone names in Linux don’t map exactly to Windows time zone names.

    - **Resolution**: Use time zone names from TZID column in the ‘Mapping for: Windows’ section table on the [Unicode.org documentation page](http://www.unicode.org/cldr/charts/latest/supplemental/zone_tzid.html).

- SQL Server Engine expects lines in text files to be terminated with CR-LF (Windows-style line formatting).

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- All log files and error logs are encoded in UTF-16.

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- **CREATE ASSEMBLY** will not work when trying to use a file. Use the **FROM \<bits\>** method instead for now. 

#### Databases
- Changing the locations of TempDB data and log files is not supported.

- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

#### In-Memory OLTP
- In-Memory OLTP databases can only be created in the /var/opt/mssql directory. These databases also need to have the "C:\\" notation when referred. For more information, visit the [In-memory OLTP Topic](sql-server-linux-performance-get-started.md#use-in-memory-oltp).  

#### SqlPackage
- Using SqlPackage requires specifying an absolute path for files. Using relative paths will map the files under the “/tmp/sqlpackage.\<code\>/system/system32” folder. 

    - **Resolution**: Use absolute file paths.

- SqlPackage shows the location of files with a "C:\\" prefix.

#### Sqlcmd/BCP & ODBC 
- If you have an older version of SQL Server Command Line tools (mssql-tools) and the ODBC Driver (msodbcsql), you might have installed a custom unixODBC Driver Manager (unixODBC-utf16). This could cause a potential conflict as we no longer use a custom driver manager. 

    - **Resolution**: On Ubuntu and SLES, the conflict will be resolved automatically. When prompted if you would like to uninstall the existing unixODBC Driver Manager, type 'y' and proceed with the installation. On RedHat, you will have to remove the existing unixODBC Driver Manager manually using `yum remove unixODBC-utf16 unixODBC-utf16-devel` and retry the install.
    
#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS is not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- The SQL Server Agent is not supported yet. Therefore, SQL Server Agent functionality in SSMS does not work on Linux at the moment.

- The file browser is restricted to the  "C:\\" scope, which resolves to /var/opt/mssql/ on Linux. To use other paths, generate scripts of the UI operation and replace the C:\\ paths with Linux paths. Then execute the script manually in SSMS.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="ctp11"> CTP 1.1 (December 2016)
The SQL Server engine version for this release is 14.0.100.187.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| Ubuntu 16.04LTS and 16.10 | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE] 
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has only been tested up to 256GB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the [installation guides](sql-server-linux-setup.md).

| Package | Package version | Downloads |
|-----|-----|-----|
| RPM package | 14.0.100.187-1 | [mssql-server 14.0.100.187-1 Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.100.187-1.x86_64.rpm)</br>[mssql-server 14.0.100.187-1 High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.100.187-1.x86_64.rpm) | 
| Debian package | 14.0.100.187-1 | [mssql-server 14.0.100.187-1 Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.100.187-1_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows - Release Candidate 1](https://go.microsoft.com/fwlink/?LinkID=835608) | 17.0 |
| [SQL Server Data Tools for Visual Studio - Release Candidate 1](https://go.microsoft.com/fwlink/?LinkID=835150) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest (0.2) |

> [!NOTE] 
> The SQL Server Management Studio and SQL Server Data Tools versions specified above are Release Candidates, hence not recommended for use in production.

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Full-text Search |
| &nbsp; | Replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **High Availability** | Always On Availability Groups |
| &nbsp; | Database mirroring  |
| **Security** | Active Directory Authentication |
| &nbsp; | Windows Authentication |
| &nbsp; | Extensible Key Management |
| &nbsp; | Use of user-provided certificate for SSL or TLS |
| **Services** | SQL Server Agent |
| &nbsp; | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Integration Services | 
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 CTP 1.1 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Do not run the command `ALTER SERVICE MASTER KEY REGENERATE`. There is a known bug that will cause SQL Server to become unstable. If you need to regenerate the Service Master Key, you should back up your database files, uninstall and then re-install SQL Server, and then restore your database files again.

- Resource name for SQL resource changed from ocf:sql:fci to ocf:mssql:fci. More details about configuring a shared disk failover cluster you can find [here](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-shared-disk-cluster-red-hat-7-configure).

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Some time zone names in Linux don’t map exactly to Windows time zone names.

    - **Resolution**: Use time zone names from TZID column in the ‘Mapping for: Windows’ section table on the [Unicode.org documentation page](http://www.unicode.org/cldr/charts/latest/supplemental/zone_tzid.html).

- SQL Server Engine expects lines in text files to be terminated with CR-LF (Windows-style line formatting).

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- All log files and error logs are encoded in UTF-16.

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- **CREATE ASSEMBLY** will not work when trying to use a file. Use the **FROM \<bits\>** method instead for now. 

#### Databases
- Changing the locations of TempDB data and log files is not supported.

- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

#### In-Memory OLTP
- In-Memory OLTP databases can only be created in the /var/opt/mssql directory. These databases also need to have the "C:\" notation when referred. For more information, visit the [In-memory OLTP Topic](sql-server-linux-performance-get-started.md#use-in-memory-oltp).  

#### SqlPackage
- Using SqlPackage requires specifying an absolute path for files. Using relative paths will map the files under the "/tmp/sqlpackage.\<code\>/system/system32" folder. 

    - **Resolution**: Use absolute file paths.

- SqlPackage shows the location of files with a "C:\\" prefix.

#### Sqlcmd/BCP & ODBC 
- SQL Server Command Line tools (mssql-tools) and the ODBC Driver (msodbcsql) depends on a custom unixODBC Driver Manager. This causes conflicts if you have a previously installed unixODBC Driver Manager. 

    - **Resolution**: On Ubuntu, the conflict will be resolved automatically. When prompted if you would like to uninstall the existing unixODBC Driver Manager, type 'y' and proceed with the installation. On RedHat, you will have to remove the existing unixODBC Driver Manager manually using `yum remove unixODBC`. We are working on fixing this limitation for RHEL and SUSE and should have an update for you soon.  
    
#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS is not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- The SQL Server Agent is not supported yet. Therefore, SQL Server Agent functionality in SSMS does not work on Linux at the moment.

- The file browser is restricted to the  "C:\\" scope, which resolves to /var/opt/mssql/ on Linux. To use other paths, generate scripts of the UI operation and replace the C:\\ paths with Linux paths. Then execute the script manually in SSMS.

v

![Separation bar graphic](./media/sql-server-linux-release-notes/seperationbar3.png)

## <a id="ctp10"> CTP 1.0 (November 2016)
The SQL Server engine version for this release is 14.0.1.246.

### Supported platforms 

| Platform | File System | Installation Guide |
|-----|-----|-----|
| Red Hat Enterprise Linux 7.2 Workstation, Server, and Desktop | XFS or EXT4 | [Installation guide](quickstart-install-connect-red-hat.md) | 
| Ubuntu 16.04LTS | EXT4 | [Installation guide](quickstart-install-connect-ubuntu.md) | 
| Docker Engine 1.8+ on Windows, Mac, or Linux | N/A | [Installation guide](quickstart-install-connect-docker.md) | 

> [!NOTE] 
> You need at least 3.25GB of memory to run SQL Server on Linux.
> SQL Server Engine has only been tested up to 256GB of memory at this time.

### Package details
Package details and download locations for the RPM and Debian packages are listed in the following table. Note that you do not need to download these packages directly if you use the steps in the [installation guides](sql-server-linux-setup.md).

| Package | Package version | Downloads |
|-----|-----|-----|
| RPM package | 14.0.1.246-6 | [mssql-server 14.0.1.246-6 Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-14.0.1.246-6.x86_64.rpm)</br>[mssql-server 14.0.1.246-6 High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server/mssql-server-ha-14.0.1.246-6.x86_64.rpm) | 
| Debian package | 14.0.1.246-6 | [mssql-server 14.0.1.246-6 Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_14.0.1.246-6_amd64.deb) |

### Supported client tools

| Tool | Minimum version |
|-----|-----|
| [SQL Server Management Studio (SSMS) for Windows - Release Candidate 1](https://go.microsoft.com/fwlink/?LinkID=835608) | 17.0 |
| [SQL Server Data Tools for Visual Studio - Release Candidate 1](https://go.microsoft.com/fwlink/?LinkID=835150) | 17.0 |
| [Visual Studio Code](https://code.visualstudio.com) with the [mssql extension](https://aka.ms/mssql-marketplace) | Latest (0.1.5) |

> [!NOTE] 
> The SQL Server Management Studio and SQL Server Data Tools versions specified above are Release Candidates, hence not recommended for use in production.

### Unsupported features and services
The following features and services are not available on Linux at this time. The support of these features will be increasingly enabled during the monthly updates cadence of the preview program.

| Area | Unsupported feature or service |
|-----|-----|
| **Database engine** | Full-text Search |
| &nbsp; | Replication |
| &nbsp; | Stretch DB |
| &nbsp; | Polybase |
| &nbsp; | Distributed Query |
| &nbsp; | System extended stored procedures (XP_CMDSHELL, etc.) |
| &nbsp; | Filetable |
| &nbsp; | CLR assemblies with the EXTERNAL_ACCESS or UNSAFE permission set |
| **High Availability** | Always On Availability Groups |
| &nbsp; | Database mirroring  |
| **Security** | Active Directory authentication |
| &nbsp; | Windows Authentication |
| &nbsp; | Extensible Key Management |
| &nbsp; | Use of user-provided certificate for SSL or TLS |
| **Services** | SQL Server Agent |
| &nbsp; | SQL Server Browser |
| &nbsp; | SQL Server R services |
| &nbsp; | StreamInsight |
| &nbsp; | Analysis Services |
| &nbsp; | Reporting Services |
| &nbsp; | Integration Services | 
| &nbsp; | Data Quality Services |
| &nbsp; | Master Data Services |

### Known issues
The following sections describe known issues with this release of SQL Server 2017 CTP1 on Linux.

#### General
- The length of the hostname where SQL Server is installed needs to be 15 characters or less. 

    - **Resolution**: Change the name in /etc/hostname to something 15 characters long or less.

- Manually setting the system time backwards in time will cause SQL Server to stop updating the internal system time within SQL Server.

    - **Resolution**: Restart SQL Server.

- Some time zone names in Linux don’t map exactly to Windows time zone names.

    - **Resolution**: Use time zone names from TZID column in the ‘Mapping for: Windows’ section table on the [Unicode.org documentation page](http://www.unicode.org/cldr/charts/latest/supplemental/zone_tzid.html).

- SQL Server Engine expects lines in text files to be terminated with CR-LF (Windows-style line formatting).

- Only single instance installations are supported.

    - **Resolution**: If you want to have more than one instance on a given host, consider using VMs or Docker containers. 

- All log files and error logs are encoded in UTF-16.

- SQL Server Configuration Manager can’t connect to SQL Server on Linux.

- **CREATE ASSEMBLY** will not work when trying to use a file. Use the **FROM \<bits\>** method instead for now.

#### Databases
- Changing the locations of TempDB data and log files is not supported.

- System databases cannot be moved with the mssql-conf utility.

- When restoring a database that was backed up on SQL Server on Windows, you must use the **WITH MOVE** clause in the Transact-SQL statement.

- Distributed transactions requiring the Microsoft Distributed Transaction Coordinator service are not supported on SQL Server running on Linux. SQL Server to SQL Server distributed transactions are supported.

#### In-Memory OLTP
- In-Memory OLTP databases can only be created in the /var/opt/mssql directory. These databases also need to have the "C:\\" notation when referred. For more information, visit the [In-memory OLTP Topic](sql-server-linux-performance-get-started.md#use-in-memory-oltp).  

#### SqlPackage
- Using SqlPackage requires to specify an absolute path for files. Using relative paths will map the files under the "/tmp/sqlpackage.\<code\>/system/system32" folder. 

    - **Resolution**: Use absolute file paths.

- SqlPackage shows the location of files with a "C:\\" prefix.

#### Sqlcmd/BCP & ODBC 
- SQL Server Command Line tools (mssql-tools) and the ODBC Driver (msodbcsql) depends on a custom unixODBC Driver Manager. This causes conflicts if you have a previously installed unixODBC Driver Manager. 

    - **Resolution**: On Ubuntu, the conflict will be resolved automatically. When prompted if you would like to uninstall the existing unixODBC Driver Manager, type 'y' and proceed with the installation. On RedHat, you will have to remove the existing unixODBC Driver Manager manually using `yum remove unixODBC`. We are working on fixing this limitation for RHEL and SUSE and should have an update for you soon.  
    
#### SQL Server Management Studio (SSMS)
The following limitations apply to SSMS on Windows connected to SQL Server on Linux.

- Maintenance plans are not supported.

- Management Data Warehouse (MDW) and the data collector in SSMS is not supported. 

- SSMS UI components that have Windows Authentication or Windows event log options do not work with Linux. You can still use these features with other options, such as SQL logins. 

- The SQL Server Agent is not supported yet. Therefore, SQL Server Agent functionality in SSMS does not work on Linux at the moment.

- The file browser is restricted to the  "C:\\" scope, which resolves to /var/opt/mssql/ on Linux. To use other paths, generate scripts of the UI operation and replace the C:\\ paths with Linux paths. Then execute the script manually in SSMS.

### Next steps

To get started, see the following quick start tutorials:

- [Install on Red Hat Enterprise Linux](quickstart-install-connect-red-hat.md)
- [Install on SUSE Linux Enterprise Server](quickstart-install-connect-suse.md)
- [Install on Ubuntu](quickstart-install-connect-ubuntu.md)
- [Run on Docker](quickstart-install-connect-ubuntu.md)
<br/>
<br/>
