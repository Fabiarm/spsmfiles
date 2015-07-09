using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using SPS.MFiles.BO;
using System.Text;
using SPS.MFiles.Common;
using System.Web.UI;

namespace SPS.MFiles.Layouts.SPS.MFiles
{
    public partial class AddNewExtension : LayoutsPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnAddDownload_Click(object sender, EventArgs e)
        {
            DownloadType type = new DownloadType(txtExtension.Text, Convert.ToInt32(txtSize.Text), chbActive.Checked);
            ExtState state = DownloadManager.Instance.Add(type);
            switch (state)
            {
                case ExtState.Failed:
                    Helper.AddSPNotification(updSettings, hdnFailed.Value, false);
                    break;
                case ExtState.Success:
                    Helper.AddSPNotification(updSettings, hdnSuccess.Value, true);
                    break;
                case ExtState.IsExists:
                    Helper.AddSPNotification(updSettings, string.Format(hdnIsExists.Value, type.Extension), false);
                    break;
            }
        }
    }
}
