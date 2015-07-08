using System;
using System.Security.Permissions;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Utilities;
using Microsoft.SharePoint.Workflow;
using System.IO;
using System.Web;
using System.Text;
using SPS.MFiles.Common;
using SPS.MFiles.BO;

namespace SPS.MFiles.DownloaderReceiver
{
    /// <summary>
    /// List Item Events
    /// </summary>
    public class DownloaderReceiver : SPItemEventReceiver
    {
        HttpContext currentContext;
        public DownloaderReceiver()
        {
            currentContext = HttpContext.Current;
        }
        /// <summary>
        /// An item is being added.
        /// </summary>
        public override void ItemAdding(SPItemEventProperties properties)
        {
            CheckFile(properties);
        }

        /// <summary>
        /// An attachment is being added to the item.
        /// </summary>
        public override void ItemAttachmentAdding(SPItemEventProperties properties)
        {
            CheckFile(properties);
        }
        private void CheckFile(SPItemEventProperties properties)
        {
            string url = properties.WebUrl + "/_layouts/SPS.MFiles/ErrorDownload.aspx";
            if (currentContext.Request.Files.Count > 0)
            {
                for (int i = 0; i < currentContext.Request.Files.Count; i++)
                {
                    HttpPostedFile file = currentContext.Request.Files[i];
                    string ext = Path.GetExtension(file.FileName);
                    DownloadType type = DownloadManager.Instance.Find(ext);
                    if (type != null)
                        if (file.ContentLength > type.Size)
                        {
                            url = url + string.Format("?file={0}&size={1}&limitsize={2}",
                                HttpUtility.UrlEncode(Path.GetFileName(file.FileName), Encoding.UTF8),
                                file.ContentLength.ToString(),
                                type.Size.ToString());
                            properties.Status = SPEventReceiverStatus.CancelWithRedirectUrl;
                            properties.RedirectUrl = url;
                            break;
                        }
                }
            }
        }
    }
}