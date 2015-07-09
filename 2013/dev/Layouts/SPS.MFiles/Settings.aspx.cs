using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using SPS.MFiles.Common;
using System.Web.UI.WebControls;
using System.Web.UI;
using SPS.MFiles.BO;
using System.Collections.Generic;
using System.Text;
using Microsoft.SharePoint.Utilities;

namespace SPS.MFiles.Layouts.SPS.MFiles
{
    public partial class Settings : LayoutsPageBase
    {
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (!Page.IsPostBack)
                Refresh();
        }
        protected void Refresh()
        {
            DownloadManager.Instance.RefreshCashe();
            spgvSettings.DataSource = DownloadManager.Instance.DownloadTypes;
            spgvSettings.DataBind();
        }
        protected void spgvSettings_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex == -1) return;
            ((TextBox)e.Row.Cells[0].FindControl("txtExtension")).Text = DataBinder.Eval(e.Row.DataItem, "Extension").ToString();
            ((TextBox)e.Row.Cells[1].FindControl("txtSize")).Text = DataBinder.Eval(e.Row.DataItem, "Size").ToString();
            ((CheckBox)e.Row.Cells[2].FindControl("chbActive")).Checked = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "Active").ToString());
        }
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            List<DownloadType> types = new List<DownloadType>();
            foreach (GridViewRow row in spgvSettings.Rows)
            {
                bool flag = ((CheckBox)row.Cells[3].FindControl("chbDelete")).Checked;
                if (flag == false)
                {
                    string ext = ((TextBox)row.Cells[0].FindControl("txtExtension")).Text;
                    int size = Convert.ToInt32(((TextBox)row.Cells[1].FindControl("txtSize")).Text);
                    bool active = ((CheckBox)row.Cells[2].FindControl("chbActive")).Checked;
                    DownloadType file = new DownloadType(ext, size, active);
                    if (!types.Contains(file))
                        types.Add(file);
                }
            }
            if (types != null)
            {
                ExtState state = DownloadManager.Instance.Save(types);
                switch (state)
                {
                    case ExtState.Failed:
                        AddSPNotification(hdnFailed.Value);
                        break;
                    case ExtState.Success:
                        AddSPNotification(hdnSuccess.Value);
                        Refresh();
                        break;
                }
            }
            Refresh();
        }
        public void AddSPNotification(string text)
        {
            if (String.IsNullOrEmpty(text) == false)
            {
                StringBuilder stringBuilder = new StringBuilder();
                stringBuilder.AppendLine(string.Format("SP.UI.Notify.addNotification(\"{0}\");", text));
                ScriptManager.RegisterClientScriptBlock(updSettings, updSettings.GetType(), Guid.NewGuid().ToString(), stringBuilder.ToString(), true);
            }
        }
    }
}
