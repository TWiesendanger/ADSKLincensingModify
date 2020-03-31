# ADSKLincensingModify

Modifies License Information for Autodesk Products 2020+

If you ever had the challenge to switch the licensing typ of a Autodesk product that does no longer start, then you know exactly why this tool saves a lot of time.
As a CAD-Admin you might have to do this multiple times per week.

For Autodesk 2020 product this means, you have to use AdskLicensingInstHelper.exe and some parameters. This takes time and knowledge.

ADSKLicensingModify is a GUI for this exe and makes this task easy.

> Note: If you want to check out the manual way by autodesk, feel free to use this link: [Autodesk Knowledge](https://knowledge.autodesk.com/search-result/caas/sfdcarticles/sfdcarticles/How-to-change-or-reset-licensing-on-your-Autodesk-software.html)

Table of Contents

- [ADSKLincensingModify](#adsklincensingmodify)
- [Function Demo](#function-demo)
- [Installation](#installation)
- [Start](#start)
- [Print List](#print-list)
- [Select Product](#select-product)
- [Select License](#select-license)
  - [Network Licensing](#network-licensing)
  - [Standalone Licensing](#standalone-licensing)
  - [User Licensing](#user-licensing)
  - [Reset](#reset)
- [Generate / Copy](#generate--copy)
- [Run](#run)
- [Help](#help)
- [Settings](#settings)
  - [Dark Theme](#dark-theme)
  - [Other](#other)
    - [Open LoginStatePath](#open-loginstatepath)
    - [Open AdskLicensingPath](#open-adsklicensingpath)
    - [Service](#service)
- [Errors / Problems](#errors--problems)
  - [Nothing happens](#nothing-happens)
  - [Invalid character \x00](#invalid-character-x00)
  - [AdskLicensingService is not running](#adsklicensingservice-is-not-running)
- [License](#license)

# Function Demo

# Installation

There is no real installation needed. So even if you cannot install anything on your machine, you should be able to unzip the release and use it.
The only condition is, that you keep the folder structure.

![](/docs/adskm_install_structure.png)

If you need a desktop Icon, create one.

![](/docs/adskm_shortcut.gif)

# Start

To get started you need to click on check path. This makes sure that the needed exe is available. If the check fails you wont be able to do anything.
You can check the path for yourself.

`C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\Current\helper`

![](/docs/adskm_checkpath.gif)

> Note: This exe isn't delivered by this tool. You get it by installing any Autodesk 2020 product. It also get's updated from time to time, which makes it difficult to ship.

# Print List

This creates a json file an tries to open it. If it fails make sure you have a tool to open such files. It show alot of infos about every licenses product on the machine this command was used.

Make sure to check the Autodesk Knowledge article:
[Autodesk Knowledge](https://knowledge.autodesk.com/support/autocad/troubleshooting/caas/sfdcarticles/sfdcarticles/Use-Installer-Helper.html)

| value |      license method      |
| ----- | :----------------------: |
| 0     | Unknown licensing method |
| 1     |    Network licensing     |
| 2     |   Standalone licensing   |
| 3     |          (MSSA)          |
| 4     |      User Licensing      |

| value |     server type     |
| ----- | :-----------------: |
| 0     | Unknown server type |
| 1     |    Single server    |
| 2     |  Redundant servers  |
| 3     | Distributed servers |

# Select Product

On the left you need to select a product that you want to change in any way. This list is based on the official product key list from autodesk. Use the search function to find your product. Press "Enter" after typing.

![](/docs/adskm_selectproduct.gif)

# Select License

## Network Licensing

After selecting a product you need to decide what to do with it. If you want to change it to "Network Licensing" select it. You need to also select a license type and provide at least one servername depending on the option you choose.

Make sure to prefix your servername with @.

If you use Redundant Server you can type in all servers like this:

@server1, @server2, @server3

![](/docs/adskm_networklicensing.gif)

## Standalone Licensing

This is used for the old licensing system. Use this only if you are still using an old license with maintenance.

## User Licensing

If you have a subscription based license, this is the option you need. Changing to this will ask you for your autodesk login the next time you open the product.

## Reset

Choose this option if you dont want to set any license type but instead let the user choose the next time they open the product.

![](/docs/adskm_startscreen.png)

# Generate / Copy

If you want to copy the generated command click this button. This allows you to paste it in a cmd file. Maybe you have a remote connection open and dont want do send this tool. Just start a cmd shell on the target system and paste it.

If you want to you can also edit the command.

![](/docs/adskm_command.png)

# Run

If you click run it will run the command after asking you one last time. If you then click yes it will run the command.

![](/docs/adskm_confirmation.png)

# Help

Opens this website if you click on it.

![](/docs/adskm_helpfile.png)

# Settings

There are a few settings and some shortcuts you can use from this flyout.

## Dark Theme

If you prefere a dark theme you can set this here by clicking on the toggle button. This setting is saved between sessions.

![](/docs/adskm_darktheme.png)

## Other

### Open LoginStatePath

The user based licensing uses a token sytem. This token gets saved to a file called "LoginState.xml". If you want to reset this information you can do this manually. This files gets recreated if you start a product that is licensed by subscription.

This file also gets deleted if you click on run.

### Open AdskLicensingPath

This button provides a fast way to open "C:\ProgramData\Autodesk\AdskLicensingService".

### Service

Check here to see if AdskLicensingService is running. This service is essential for the licensing to work properly.

![](/docs/adskm_service.png)

# Errors / Problems

## Nothing happens

Use Generate / Copy and paste the command into a cmd shell. This way you can see if the command is actually working. If there is an error look here for any help.

## Invalid character \x00

If this error shows, then there is a problem with the licensing system on this machine. You can try to fix it by renaming AdskLicensingService.data.

Click on Settings and choose "Open AdskLicensing Path" it opens windows explorer with the right path for you.
After this make sure that the AdskLicensingService is started. You can do this from the flyout if you want to. 

## AdskLicensingService is not running

This service is needed to run the Autodesk Licensing system. If it is not running you will run into some problems. Try to start the service from the Settings flyout.

![](/docs/adskm_service.png)


# License
MIT License

Copyright (c) 2020 Tobias Wiesendanger

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.