# spsmfiles

**Manage upload files for SP 2010/2013** is a feature is responsible for management upload file size for specific extensions. The administrator can manage extensions (add/remove/edit) and control upload sizes. 
The feature will be installed on site collection only and can manage upload size files. 

**How does it work?**
* Open site collection as user who can manage web
* Add extension and maximum file size

![](https://raw.githubusercontent.com/wiki/Fabiarm/spsmfiles/img/img05.PNG)

* Save changes
* A user couldn't upload files with big size, so the user got message

![](https://raw.githubusercontent.com/wiki/Fabiarm/spsmfiles/img/img10.PNG)

So it works for multiuploading and drag and drop

![](https://raw.githubusercontent.com/wiki/Fabiarm/spsmfiles/img/img11.PNG)

**Version 1.0.0:**
* Manage file sizes and extensions for all web into site collection;
* Protected;
* use library jQuery 2.1.1;
* support IE 10+, Chrome 30+, FF 30+;
* working platforms (SharePoint Foundation 2013, Sharepoint Server 2013 (Standard, Enterprise)); 
* localization (English, Russian); 
