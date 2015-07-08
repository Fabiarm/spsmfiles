using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.Web;
using System.Text;

namespace SPS.MFiles.Layouts.SPS.MFiles
{
    public partial class ErrorDownload : LayoutsPageBase
    {
        string size = "size";
        string limitSize = "limitsize";
        string file = "file";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString[size] != null &&
                Request.QueryString[limitSize] != null &&
                Request.QueryString[file] != null)
            {
                lblMessage.Text = hdfMessage.Value;
                lblMessage.Text = lblMessage.Text.Replace("{file}", HttpUtility.UrlDecode(Request.QueryString[file].ToString(), Encoding.UTF8));
                lblMessage.Text = lblMessage.Text.Replace("{size}", Request.QueryString[size].ToString());
                lblMessage.Text = lblMessage.Text.Replace("{limitsize}", Request.QueryString[limitSize].ToString());
            }
        }
    }
}
