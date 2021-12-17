# iac-ventura-gold-image
This repository houses the code to build the Gold Ami for Portal PreProcessor.

* **Contributor:** Add new version for your pull request by incrementing the current version +1. Add list of changes annotated with the most appropriate keyword describing your change (`ADDED`, `CHANGED`, `BUGFIX`, `SECURITY`, `PERFORMANCE`, `DOCUMENTATION`, `PIPELINE`).
When incrementing the version number consider the following:

    1. MAJOR version when you make incompatible API changes,
    2. MINOR version when you add functionality in a backwards-compatible manner, and
    3. PATCH version when you make backwards-compatible bug fixes.

<!-- Keywords:
 ADDED - Introduction of a new feature or aspect that did not previously exist.
 CHANGED - Enhancement or change to an existing feature.
 FIXED - Fixing of an existing bug without changing functionality.
 SECURITY - Relating to any security enhancement, closure of vulnerability, etc.
 PERFORMANCE - Performance enhancement, that doesn't explicitly change functionality.
 DOCUMENTATION - A documentation only change
 PIPELINE - A change to a component's own CI/CD pipeline
 -->

* **Reviewer:** Check the changes in the code against the entries in the changelog. Are all changes listed? Does the new version make sense in terms of:

    1. MAJOR :skull::skull_and_crossbones: version when you make incompatible API changes,
    2. MINOR :warning::interrobang: version when you add functionality in a backwards-compatible manner, and
    3. PATCH :beetle::bug: version when you make backwards-compatible bug  fixes.

<!-- Add new versions below here -->
## [1.2.4]
 * [CHANGED] SD1853 November Gold Image Build incorporating new AWS New AMIs dated 2021.11.10

## [1.2.3]
 * [CHANGED] SD1758 October Gold Image Build incorporating new AWS New AMIs dated 2021.10.13

## [1.2.2]
 * [CHANGED] SD1669 September Gold Image Build incorporating new AWS New AMIs dated 2021.09.15

## [1.2.1]
 * [CHANGED] SD1574 August Gold Image Build incorporating new AWS New AMIs dated 2021.08.11
 * [CHANGED] SD1573 SSM agent upgrade 3.1.127.0
 
## [1.2.0]
 * [CHANGED] SD1476 July Gold Image Build incorporating new AWS New AMIs dated 2021.07.14

## [1.1.16]
 * [CHANGED] SD1441 Add SSM Agent Updater

## [1.1.15]
 * [CHANGED] SD1431 updated to Packer Version 1.7.2

## [1.1.14]
 * [SECURITY] SD1392 CWP version 6.8.2.67
 * [ADDED] SD1393 Implement AWSCLI
 * [SECURITY] SD1401 June 2021 Security Patches

## [1.1.13]
 * [SECURITY] SD1322 May 2021 Security Patches

## [1.1.12]
 * [SECURITY] SD1229 April 2021 Security Patches

## [1.1.11]
 * [SECURITY] SD1108 March 2021 Security Patches
 * [PIPELINE] SD1085 Retrieve Docker Images from Artifactory instead of docker.com 

## [1.1.10]
 * [SECURITY] SD1014 February 2021 Security Patches.

## [1.1.9]
 * [SECURITY] SD931 January 2021 Security Patches.
 
## [1.1.8]
 * [SECURITY] SD873 December 2020 Security Patches.
 * [PIPELINE] Check for PR-*
 * [PIPELINE] Teams Notification only on Build
 * [CHANGED] SD901 Disable Windows Defender FW and AV

## [1.1.7]
 * [PIPELINE] Assumerole.

## [1.1.6]
 * [ADDED] Trufflehog.
 * [SECURITY] October 2020 Security Patches.

## [1.1.5]
 * remove jboss as this will be implemented at the component level

## [1.1.4]
 * [SECURITY] Install September 2020 Security Patches
 * [ADDED] CWP version 6.8.1.207
 * [ADDED] Windows Features NET-Framework 45 Features/Core/ASPNET
 * [CHANGED] version of awscli updated to 1.18.140
 
## [1.1.3]
 * [SECURITY] Install August Security Patches.

## [1.1.2]
 * [SECURITY] Install Powershell Core 7
 * [PIPELINE] Install LogRotator

## [1.1.1]
 * [SECURITY] July 2020 Security Patches. Up to 2020-07-14

## [1.1.0]
 * [CHANGED] Alpine Linux Docker and Python3
 * [ADDED] Java and JBOSS

## [1.0.0]
 * [ADDED] New Repository for Ventura Gold Image.
 * [ADDED] Reboot