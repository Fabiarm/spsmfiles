using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SharePoint;
using System.Web;
using System.Threading;
using Microsoft.SharePoint.Utilities;

namespace SPS.MFiles.Common
{
    public delegate void CodeToRunElevated(SPWeb elevatedWeb);
    public class Helper
    {
        public static void RunElevated(Guid siteId, Guid webId, CodeToRunElevated secureCode)
        {
            SPSecurity.RunWithElevatedPrivileges(() =>
            {
                using (SPSite site = new SPSite(siteId))
                {
                    using (SPWeb elevatedWeb = site.OpenWeb(webId))
                    {
                        secureCode(elevatedWeb);
                    }
                }
            });
        }
        public static void AddOrUpdateBagProperty(SPWeb web, string spkey, string spvalue)
        {
            if (web.Properties.ContainsKey(spkey) == false)
            {
                web.Properties.Add(spkey, spvalue);
                web.Properties.Update();
            }
            else
            {
                web.Properties[spkey] = spvalue;
                web.Properties.Update();
            }
        }
        public static void RemoveBagProperty(SPWeb web, string spkey)
        {
            if (web.Properties.ContainsKey(spkey) == true)
            {
                web.Properties.Remove(spkey);
                web.Properties.Update();
            }
        }
    }
}
