using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SharePoint;
using System.Web;
using System.Threading;
using Microsoft.SharePoint.Utilities;
using System.Web.UI;

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
        public static void AddSPNotification(UpdatePanel updSettings, string text, bool isRefresh)
        {
            if (String.IsNullOrEmpty(text) == false)
            {
                StringBuilder stringBuilder = new StringBuilder();
                stringBuilder.AppendLine(string.Format("SP.UI.Notify.addNotification(\"{0}\");", text));
                if (isRefresh == true)
                {
                    stringBuilder.AppendLine("SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, 1);");
                    stringBuilder.AppendLine("window.frameElement.commitPopup();");
                }
                ScriptManager.RegisterClientScriptBlock(updSettings, updSettings.GetType(), Guid.NewGuid().ToString(), stringBuilder.ToString(), true);
            }
        }
    }
}
