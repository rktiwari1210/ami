# BPS Ventura Gold Image

## Build Status

[![Date](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=date&style=plastic&build=lastCompleted)](https://jenkins.dxc.com/job/BPSCloudOps/job/iac-ventura-gold-image/job/master/lastBuild/display/redirect/)
[![amiiname](https://jenkins.dxc.com/buildStatus/icon?&style=plastic&job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=build&style=plastic&build=lastCompleted)](https://jenkins.dxc.com/job/BPSCloudOps/job/iac-ventura-gold-image/job/master/lastBuild/display/redirect/)
[![Amiid](https://jenkins.dxc.com/buildStatus/icon?&style=plastic&job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=amiid&style=plastic&build=lastCompleted)](https://jenkins.dxc.com/job/BPSCloudOps/job/iac-ventura-gold-image/job/master/lastBuild/display/redirect/)

Latest Changes are listed in [CHANGELOG.md](CHANGELOG.md)

## Release Train

| Version | Date | AMI NAME | AMI ID | 
| :-----: | :--: | :------: | :----: |
N-1 | [![DATE n-1](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=date&style=plastic&build=-1)]() | [![AMI NAME n-1](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=build&style=plastic&build=-1)]() | [![AMIID n-1](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=amiid&style=plastic&build=-1)]()
N-2 | [![DATE n-2](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=date&style=plastic&build=-2)]() | [![AMI NAME n-2](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=build&style=plastic&build=-2)]()| [![AMIID n-2](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=amiid&style=plastic&build=-2)]()
N-3 | [![DATE n-3](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=date&style=plastic&build=-3)]() | [![AMI NAME n-3](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-ventura-gold-image%2Fmaster&config=build&style=plastic&build=-3)]() | [![AMIID n-1](https://jenkins.dxc.com/buildStatus/icon?job=BPSCloudOps%2Fiac-sgold-image%2Fmaster&config=amiid&style=plastic&build=-3)]()

## Manifest

### Core

* Curl
* UAC (disabled)
* Amazon CloudWatch Agent
* Symantec Cloud Workload Protection
* AWS Powershell Tools

### Component

* Windows Features
  * IIS 10
  * .NET framework Version 4.8
  * .NET Core 3.1 Desktop Runtime (v3.1.4) - Windows x64
  * jboss-5.1.0.GA-jdk6.zip   (https://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/)
  * Java 7 (jdk-7u79-windows-x64.exe)
  * Sql server command line utils (MsSqlCmdLnUtils v14.msi)
  * Sql odbc (msodbcsql v13.1.msi)

## BPS Platforms Making use of Ventura Gold Image

| Job | Customer | Repo | 
| :-: | ------ | -- |
1 | Cushman Wakefield (CW) | [BPSCloudOps/iac-ven-job1][iac-ven-job1]
2 | ? | [BPSCloudOps/iac-ven-job1][iac-ven-job2]

<!--- External Links --->
[iac-ven-job1]: https://github.dxc.com/BPSCloudOps/iac-ven-job1 "Ventura Cushman Wakefield"
[iac-ven-job2]: https://github.dxc.com/BPSCloudOps/iac-ven-job2 "Ventura Job2"