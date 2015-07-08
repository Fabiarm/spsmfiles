<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddNewExtension.aspx.cs" Inherits="SPS.MFiles.Layouts.SPS.MFiles.AddNewExtension" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <script type="text/javascript">
        function bytesToSize(control) {
            var bytes = control.value;
            var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
            if (bytes == 0) return 'n/a';
            var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
            var divControl = document.getElementById(control.id + '_span');
            control.title = Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
            divControl.innerHTML = Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
        };
    </script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <asp:UpdatePanel runat="server" ID="updSettings">
        <ContentTemplate>
            <asp:HiddenField ID="hdnSuccess" runat="server" Value="<%$Resources:SPS.MFiles,SettingPage_Success%>" />
            <asp:HiddenField ID="hdnFailed" runat="server" Value="<%$Resources:SPS.MFiles,SettingPage_Failed%>" />
            <asp:HiddenField ID="hdnIsExists" runat="server" Value="<%$Resources:SPS.MFiles,SettingPage_IsExists%>" />
            <div id="contentDiv">
                <table cellpadding="0" width="100%" cellspacing="0" border="0">
                    <tr class="ms-viewheadertr">
                        <th class="ms-vh2" style="width: 40px;">
                            <SharePoint:EncodedLiteral ID="ltlFileType" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_FileType%>"
                                EncodeMethod='HtmlEncode' />
                        </th>
                        <th class="ms-vh2" style="width: 40px;">
                            <SharePoint:EncodedLiteral ID="ltlMaxSize" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_MaxSize%>"
                                EncodeMethod='HtmlEncode' />
                        </th>
                        <th class="ms-vh2" style="width: 50px;">&nbsp;
                        </th>
                        <th class="ms-vh2" style="width: 20px;">
                            <SharePoint:EncodedLiteral ID="ltlActive" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_Active%>"
                                EncodeMethod='HtmlEncode' />
                        </th>
                        <th class="ms-vh2">&nbsp;
                        </th>
                    </tr>
                    <tr class="ms-tableRow">
                        <td class="ms-formbody-new" style="width: 40px;">
                            <asp:TextBox ID="txtExtension" runat="server" Enabled="true" Width="90%" CssClass="ms-long"
                                Text='<%# Eval("Extension") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="vldRegExtension" runat="server" ControlToValidate="txtExtension"
                                EnableClientScript="true" SetFocusOnError="true" ValidationExpression="\.\w+"
                                ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_RegExtension%>"
                                Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="vldReqExtension" runat="server" ControlToValidate="txtExtension"
                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_ReqExtension%>"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                        <td class="ms-formbody-new" style="width: 20px;">
                            <asp:TextBox ID="txtSize" runat="server" Width="90%" onchange="javascript:bytesToSize(this);"
                                ToolTip="" CssClass="ms-input" Text='<%# Eval("Size") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="vldReqSize" runat="server" ControlToValidate="txtSize"
                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_ReqSize%>"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ControlToValidate="txtSize" ErrorMessage="vldRangeSize" ID="vldRangeSize"
                                EnableClientScript="true" SetFocusOnError="true" MaximumValue="99999999" MinimumValue="1"
                                runat="server" Type="Integer" Display="Dynamic">
                                <SharePoint:EncodedLiteral ID="ltlValRangeSize" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_Validator_RangeSize%>"
                                    EncodeMethod='HtmlEncode' />
                            </asp:RangeValidator>
                        </td>
                        <td class="ms-formbody-new" style="width: 20px;">
                            <span id="<%=txtSize.ClientID %>_span"></span>
                        </td>
                        <td class="ms-formbody-new" align="center" style="width: 20px;">
                            <asp:CheckBox ID="chbActive" runat="server" AutoPostBack="false" Text="" Checked="false" />
                        </td>
                        <td class="ms-formbody-new" style="width: 20px;">
                            <asp:Button ID="btnAddDownload" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_AddNewType%>"
                                CssClass="ms-ButtonHeightWidth" Enabled="true" OnClick="btnAddDownload_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    Application Page
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    My Application Page
</asp:Content>
