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
                    AddSPNotification(hdnFailed.Value, false);
                    break;
                case ExtState.Success:
                    AddSPNotification(hdnSuccess.Value, true);
                    break;
                case ExtState.IsExists:
                    AddSPNotification(string.Format(hdnIsExists.Value, type.Extension), false);
                    break;
            }
        }
        public void AddSPNotification(string text, bool isRefresh)
        {
            if (String.IsNullOrEmpty(text) == false)
            {
                StringBuilder stringBuilder = new StringBuilder();
                stringBuilder.AppendLine(string.Format("SP.UI.Notify.addNotification(\"{0}\");", text));
                if (isRefresh == true)
                    stringBuilder.AppendLine("SP.UI.ModalDialog.RefreshPage(SP.UI.DialogResult.OK);");
                ScriptManager.RegisterClientScriptBlock(updSettings, updSettings.GetType(), Guid.NewGuid().ToString(), stringBuilder.ToString(), true);
            }
        }
    }
}
