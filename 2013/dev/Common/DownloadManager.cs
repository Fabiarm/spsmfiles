using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Utilities;
using SPS.MFiles.BO;

namespace SPS.MFiles.Common
{
    public sealed class DownloadManager
    {
        private static volatile DownloadManager instance;
        private static object syncRoot = new Object();
        List<DownloadType> downloadTypes = new List<DownloadType>();
        public List<DownloadType> DownloadTypes
        {
            get
            {
                return downloadTypes;
            }
        }
        private DownloadManager()
        {
            GetDownloadTypes();
        }
        public static DownloadManager Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (syncRoot)
                    {
                        if (instance == null)
                            instance = new DownloadManager();
                    }
                }
                return instance;
            }
        }
        public void RefreshCashe()
        {
            instance = new DownloadManager();
        }
        public DownloadType Find(string extension)
        {
            return DownloadTypes.Find(a => String.Equals(a.Extension, extension, StringComparison.OrdinalIgnoreCase) && a.Active == true);
        }
        public ExtState Add(DownloadType type)
        {
            ExtState state = ExtState.Failed;
            if (!downloadTypes.Contains(type, new DownloadTypeEqualComparer()))
            {
                downloadTypes.Add(type);
                state = Save(downloadTypes);
            }
            else
                state = ExtState.IsExists;
            return state;
        }
        public ExtState Save(List<DownloadType> types)
        {
            ExtState state = ExtState.Failed;
            if (types == null) return state;
            Helper.RunElevated(SPContext.Current.Site.ID, SPContext.Current.Site.RootWeb.ID, delegate(SPWeb elevatedWeb)
            {
                string fileTypes = string.Empty;
                string fileSizes = string.Empty;
                string actives = string.Empty;
                foreach (DownloadType type in types)
                {
                    fileTypes += type.Extension + ";";
                    fileSizes += type.Size + ";";
                    actives += type.Active + ";";
                }
                elevatedWeb.AllowUnsafeUpdates = true;
                elevatedWeb.Properties[Content.SPFileTypes] = fileTypes;
                elevatedWeb.Properties[Content.SPFileSizes] = fileSizes;
                elevatedWeb.Properties[Content.SPFileTypesActive] = actives;
                elevatedWeb.Properties.Update();
                elevatedWeb.AllowUnsafeUpdates = false;
                state = ExtState.Success;
            });
            return state;
        }
        private void GetDownloadTypes()
        {
            List<DownloadType> types = new List<DownloadType>();
            Helper.RunElevated(SPContext.Current.Site.ID, SPContext.Current.Site.RootWeb.ID, delegate(SPWeb elevatedWeb)
            {
                try
                {
                    string[] fileTypes = elevatedWeb.Properties[Content.SPFileTypes].ToLower().Split(';');
                    string[] fileSizes = elevatedWeb.Properties[Content.SPFileSizes].ToLower().Split(';');
                    string[] actives = elevatedWeb.Properties[Content.SPFileTypesActive].ToLower().Split(';');
                    if (fileSizes != null && fileTypes != null)
                        if (fileTypes.Length == fileSizes.Length)
                            for (int i = 0; i < fileTypes.Length - 1; i++)
                            {
                                DownloadType file = new DownloadType(fileTypes[i], Convert.ToInt32(fileSizes[i]), Convert.ToBoolean(actives[i]));
                                if (!types.Contains(file, new DownloadTypeEqualComparer()))
                                    types.Add(file);
                            }
                }
                catch (Exception ex)
                {
                }
            });
            if (types.Count > 0)
            {
                downloadTypes.Clear();
                downloadTypes.AddRange(types);
            }
        }
    }
}
