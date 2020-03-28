# ADSKLincensingModifiy

Modifies License Information for Autodesk Products 2020+

If you ever had the challenge to switch the licensing typ of a Autodesk product that does no longer start, then you know exactly why this tool saves a lot of time.
As a CAD-Admin you might have to do this multiple times per week.

For Autodesk 2020 product this means, you have to use AdskLicensingInstHelper.exe and some parameters. This takes time and knowledge.

ADSKLicensingModify is GUI for this exe and makes this task easy.

> Note: If you want to check out the manual way by autodesk, feel free to use this link: [Autodesk Knowledge](https://knowledge.autodesk.com/search-result/caas/sfdcarticles/sfdcarticles/How-to-change-or-reset-licensing-on-your-Autodesk-software.html)

Table of Contents

- [ADSKLincensingModifiy](#adsklincensingmodifiy)
- [Function Demo](#function-demo)
- [Installation](#installation)
- [Start](#start)
- [Select Product](#select-product)

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

# Select Product

On the left you need to select a product that you want to change in any way. This list is based on the official product key list from autodesk. Use the search function to find your product.

![](/docs/adskm_selectproduct.gif)
