<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Register TagPrefix="wssuc" TagName="InputFormControl" Src="~/_controltemplates/InputFormControl.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="InputFormSection" Src="~/_controltemplates/InputFormSection.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="ButtonSection" Src="~/_controltemplates/ButtonSection.ascx" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="SP2010.Manage.FileTypes.Layouts.SP2010.Manage.FileTypes.Settings"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <style type="text/css">
        .ms-image
        {
            border: 0px none transparent;
        }
        .ms-descriptiontext
        {
            min-width: 450px;
            width: 450px !important;
        }
        .ms-tableRow td.ms-formlabel, .ms-tableRow td.ms-formbody
        {
            border-bottom: 1px solid #d8d8d8;
            border-top: 1px solid #d8d8d8;
            border-right: 1px solid #d8d8d8;
        }
        .ms-tableRow td.ms-formbody
        {
            vertical-align: top;
        }
        .ms-viewheadertr th.ms-vh2-gridview
        {
            background-color: transparent;
        }
        .ms-input
        {
            float: left;
            margin: 3px;
        }
        .ms-div
        {
            overflow: auto;
            border: none;
            width: 99%;
            border: none;
            margin-left: 5px;
            margin-right: 5px;
        }
        .ms-ButtonHeightWidth
        {
            float: right;
            margin: 5px 0px 5px 5px;
        }
    </style>
    <script type="text/javascript">
        function toggle(showHideDiv, switchImgTag) {
            var ele = document.getElementById(showHideDiv);
            var imageEle = document.getElementById(switchImgTag);
            if (ele.style.display == "block") {
                ele.style.display = "none";
                imageEle.innerHTML = '<img class="ms-image" src="/_layouts/images/plus.gif">&nbsp;<%=GetGlobalResourceObject("SPManageFileTypes", "SettingPage_AddNewType") %>';
            }
            else {
                ele.style.display = "block";
                imageEle.innerHTML = '<img class="ms-image" src="/_layouts/images/minus.gif">&nbsp;<%=GetGlobalResourceObject("SPManageFileTypes", "SettingPage_AddNewType") %>';
            }
        }
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
            <asp:HiddenField ID="hdnSuccess" runat="server" Value="<%$Resources:SPManageFileTypes,SettingPage_Success%>" />
            <asp:HiddenField ID="hdnFailed" runat="server" Value="<%$Resources:SPManageFileTypes,SettingPage_Failed%>" />
            <asp:HiddenField ID="hdnIsExists" runat="server" Value="<%$Resources:SPManageFileTypes,SettingPage_IsExists%>" />
            <div class="ms-div">
                <table cellpadding="0" width="100%" cellspacing="0" border="0">
                    <wssuc:InputFormSection ID="InputFormSection1" Collapsible="false" runat="server">
                        <Template_Title>
                            <SharePoint:EncodedLiteral ID="ltlTitle" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_TemplateTitle%>"
                                EncodeMethod='HtmlEncode' />
                        </Template_Title>
                        <Template_Description>
                            <SharePoint:EncodedLiteral ID="ltlTemplateDescription" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_TemplateDescription%>"
                                EncodeMethod='HtmlEncode' />
                        </Template_Description>
                        <Template_InputFormControls>
                            <SharePoint:SPGridView runat="server" CellPadding="0" CellSpacing="0" ID="spgvSettings"
                                AlternatingRowStyle-CssClass="ms-tableRow" OnRowDataBound="spgvSettings_RowDataBound"
                                RowStyle-CssClass="ms-tableRow" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="40px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderText="<%$Resources:SPManageFileTypes,SettingPage_FileType%>">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtExtension" runat="server" Enabled="true" Width="90%" CssClass="ms-input"
                                                Text='<%# Eval("Extension") %>'></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="vldRegExtension" runat="server" ControlToValidate="txtExtension"
                                                EnableClientScript="true" SetFocusOnError="true" ValidationExpression="\.\w+"
                                                ErrorMessage="<%$Resources:SPManageFileTypes,SettingPage_Validator_RegExtension%>"
                                                Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="vldReqExtension" runat="server" ControlToValidate="txtExtension"
                                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPManageFileTypes,SettingPage_Validator_ReqExtension%>"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="40px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderStyle-Wrap="false"
                                        HeaderText="<%$Resources:SPManageFileTypes,SettingPage_MaxSize%>">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtSize" runat="server" Width="90%" onchange="javascript:bytesToSize(this);"
                                                ToolTip="" CssClass="ms-input" Text='<%# Eval("Size") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="vldReqSize" runat="server" ControlToValidate="txtSize"
                                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPManageFileTypes,SettingPage_Validator_ReqSize%>"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ControlToValidate="txtSize" ErrorMessage="vldRangeSize" ID="vldRangeSize"
                                                EnableClientScript="true" SetFocusOnError="true" MaximumValue="99999999" MinimumValue="1"
                                                runat="server" Type="Integer" Display="Dynamic">
                                                <SharePoint:EncodedLiteral ID="ltlValRangeSize" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_Validator_RangeSize%>"
                                                    EncodeMethod='HtmlEncode' /></asp:RangeValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField ItemStyle-Width="20px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderText="<%$Resources:SPManageFileTypes,SettingPage_Active%>">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbActive" runat="server" AutoPostBack="false" Text="" Checked="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="20px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderText="<%$Resources:SPManageFileTypes,SettingPage_Delete%>">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbDelete" runat="server" AutoPostBack="false" Text="" Checked="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <SharePoint:EncodedLiteral ID="ltlGridNoItems" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_Grid_NoItems%>"
                                        EncodeMethod='HtmlEncode' />
                                </EmptyDataTemplate>
                                <FooterStyle CssClass="ms-formline" />
                            </SharePoint:SPGridView>
                            <a id="imgDivLink" href="javascript:toggle('contentDiv', 'imgDivLink');">
                                <img class="ms-image" src="/_layouts/images/plus.gif">&nbsp;<SharePoint:EncodedLiteral
                                    ID="ltlAddNew" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_AddNewType%>"
                                    EncodeMethod='HtmlEncode' /></a>
                            <div id="contentDiv" style="display: none;">
                                <table cellpadding="0" width="100%" cellspacing="0" border="0">
                                    <tr class="ms-viewheadertr">
                                        <th class="ms-vh2-nofilter ms-vh2-gridview" style="width: 40px;">
                                            <SharePoint:EncodedLiteral ID="ltlFileType" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_FileType%>"
                                                EncodeMethod='HtmlEncode' />
                                        </th>
                                        <th class="ms-vh2-nofilter ms-vh2-gridview" style="width: 40px;">
                                            <SharePoint:EncodedLiteral ID="ltlMaxSize" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_MaxSize%>"
                                                EncodeMethod='HtmlEncode' />
                                        </th>
                                        <th class="ms-vh2-nofilter ms-vh2-gridview" style="width: 50px;">
                                        &nbsp;
                                        </th>
                                        <th class="ms-vh2-nofilter ms-vh2-gridview" style="width: 20px;">
                                            <SharePoint:EncodedLiteral ID="ltlActive" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_Active%>"
                                                EncodeMethod='HtmlEncode' />
                                        </th>
                                        <th class="ms-vh2-nofilter ms-vh2-gridview">
                                            &nbsp;
                                        </th>
                                    </tr>
                                    <tr class="ms-tableRow">
                                        <td class="ms-formbody">
                                            <asp:TextBox ID="txtExtension" runat="server" Enabled="true" Width="90%" CssClass="ms-input"
                                                Text='<%# Eval("Extension") %>'></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="vldRegExtension" runat="server" ControlToValidate="txtExtension"
                                                EnableClientScript="true" SetFocusOnError="true" ValidationExpression="\.\w+"
                                                ErrorMessage="<%$Resources:SPManageFileTypes,SettingPage_Validator_RegExtension%>"
                                                Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="vldReqExtension" runat="server" ControlToValidate="txtExtension"
                                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPManageFileTypes,SettingPage_Validator_ReqExtension%>"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </td>
                                        <td class="ms-formbody">
                                            <asp:TextBox ID="txtSize" runat="server" Width="90%" onchange="javascript:bytesToSize(this);"
                                                ToolTip="" CssClass="ms-input" Text='<%# Eval("Size") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="vldReqSize" runat="server" ControlToValidate="txtSize"
                                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPManageFileTypes,SettingPage_Validator_ReqSize%>"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ControlToValidate="txtSize" ErrorMessage="vldRangeSize" ID="vldRangeSize"
                                                EnableClientScript="true" SetFocusOnError="true" MaximumValue="99999999" MinimumValue="1"
                                                runat="server" Type="Integer" Display="Dynamic">
                                                <SharePoint:EncodedLiteral ID="ltlValRangeSize" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_Validator_RangeSize%>"
                                                    EncodeMethod='HtmlEncode' /></asp:RangeValidator>
                                        </td>
                                        <td class="ms-formbody">
                                            <span id="<%=txtSize.ClientID %>_span"></span>
                                        </td>
                                        <td class="ms-formbody" align="center">
                                            <asp:CheckBox ID="chbActive" runat="server" AutoPostBack="false" Text="" Checked="false" />
                                        </td>
                                        <td class="ms-formbody">
                                            <asp:Button ID="btnAddDownload" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_AddNewType%>"
                                                CssClass="ms-ButtonHeightWidth" Enabled="true" OnClick="btnAddDownload_Click"
                                                OnClientClick="<%$Resources:SPManageFileTypes,SettingPage_AddNewType_Confirm%>" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:Button ID="btnSaveSettings" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_SaveSettings%>"
                                CssClass="ms-ButtonHeightWidth" Enabled="true" OnClick="btnSaveSettings_Click"
                                OnClientClick="<%$Resources:SPManageFileTypes,SettingPage_SaveSettings_Confirm%>" />
                        </Template_InputFormControls>
                    </wssuc:InputFormSection>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    <SharePoint:EncodedLiteral ID="ltlPageTitle" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_PageTitle%>"
        EncodeMethod='HtmlEncode' />
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    <SharePoint:EncodedLiteral ID="ltlPageTitleInTitleArea" runat="server" Text="<%$Resources:SPManageFileTypes,SettingPage_PageTitleInTitleArea%>"
        EncodeMethod='HtmlEncode' />
</asp:Content>
